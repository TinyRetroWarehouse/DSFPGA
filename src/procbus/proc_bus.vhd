-----------------------------------------------------------------
--------------- Proc Bus Package --------------------------------
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

package pProc_bus is

   constant proc_buswidth : integer := 32;
   constant proc_busadr   : integer := 28;
   
   constant proc_buscount : integer := 15;
   
   constant proc_mpu_bits : integer := 16;
   
   type proc_bus_intype is record
      Din  : std_logic_vector(proc_buswidth-1 downto 0);
      Adr  : std_logic_vector(proc_busadr-1 downto 0);
      rnw  : std_logic;
      ena  : std_logic;
   end record;
   
   type tBusArray_Din  is array(0 to proc_buscount - 1) of std_logic_vector(proc_buswidth-1 downto 0);
   type tBusArray_Dout is array(0 to proc_buscount - 1) of std_logic_vector(proc_buswidth-1 downto 0);
   type tBusArray_Adr  is array(0 to proc_buscount - 1) of std_logic_vector(proc_busadr-1 downto 0);
   type tBusArray_rnw  is array(0 to proc_buscount - 1) of std_logic;
   type tBusArray_ena  is array(0 to proc_buscount - 1) of std_logic;
   type tBusArray_done is array(0 to proc_buscount - 1) of std_logic;
   
   type tMPUArray      is array(0 to proc_buscount - 1) of std_logic_vector(proc_mpu_bits-1 downto 0);

end package;


-----------------------------------------------------------------
--------------- Reg Map Package --------------------------------
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library work;
use work.pProc_bus.all;

package pRegmap is

   type regaccess_type is
   (
      readwrite,
      readonly,
      pulse,
      writeonly
   );

   type regmap_type is record
      Adr         : integer range 0 to (2**proc_busadr)-1;
      upper       : integer range 0 to proc_buswidth-1;
      lower       : integer range 0 to proc_buswidth-1;
      size        : integer range 0 to (2**proc_busadr)-1;
      default     : integer;
      acccesstype : regaccess_type;
   end record;
   
end package;


-----------------------------------------------------------------
--------------- Reg Interface -----------------------------------
-----------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;  

library work;
use work.pProc_bus.all;
use work.pRegmap.all;

entity eProcReg  is
   generic
   (
      Reg       : regmap_type;
      index     : integer := 0
   );
   port 
   (
      clk          : in  std_logic;
      bus_in       : in  proc_bus_intype;
      bus_Dout     : out std_logic_vector(proc_buswidth-1 downto 0);
      bus_done     : out std_logic;
      Din          : in  std_logic_vector(Reg.upper downto Reg.lower);
      Dout         : out std_logic_vector(Reg.upper downto Reg.lower);
      written      : out std_logic := '0'
   );
end entity;

architecture arch of eProcReg is

   signal Dout_buffer : std_logic_vector(Reg.upper downto Reg.lower) := std_logic_vector(to_unsigned(Reg.default,Reg.upper-Reg.lower+1));
    
   signal Adr : std_logic_vector(bus_in.adr'left downto 0);
    
begin

   Adr <= std_logic_vector(to_unsigned(Reg.Adr + index, bus_in.adr'length));

   greadwrite : if (Reg.acccesstype = readwrite or Reg.acccesstype = writeonly) generate
   begin
   
      process (clk)
      begin
         if rising_edge(clk) then
         
            if (bus_in.Adr = Adr and bus_in.rnw = '0' and bus_in.ena = '1') then
               Dout_buffer <= bus_in.Din(Reg.upper downto Reg.lower);  
               written <= '1';
            else
               written <= '0';
            end if;
            
         end if;
      end process;
   end generate;
   
   gpulse : if (Reg.acccesstype = pulse) generate
   begin
   
      process (clk)
      begin
         if rising_edge(clk) then
         
            Dout_buffer <= (others => '0');
            if (bus_in.Adr = Adr and bus_in.rnw = '0' and bus_in.ena = '1') then
               Dout_buffer <= bus_in.Din(Reg.upper downto Reg.lower); 
               written <= '1';
            else
               written <= '0';
            end if;
            
         end if;
      end process;
   end generate;
   
   Dout <= Dout_buffer;

   goutput : if (Reg.acccesstype = readwrite or Reg.acccesstype = readonly) generate
   begin
      bus_Dout(Reg.upper downto Reg.lower) <= Din when bus_in.Adr = Adr else (others => 'Z');
   end generate;
   
   bus_done <= '1' when bus_in.Adr = Adr else 'Z'; 
   
end architecture;
