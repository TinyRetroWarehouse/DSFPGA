-----------------------------------------------------------------
--------------- Proc Bus Package --------------------------------
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

package pProc_bus_ds is

   constant ds_proc_buswidth : integer := 32;
   constant ds_proc_busadr   : integer := 28;
   
   constant ACCESS_8BIT  : std_logic_vector(1 downto 0) := "00";
   constant ACCESS_16BIT : std_logic_vector(1 downto 0) := "01";
   constant ACCESS_32BIT : std_logic_vector(1 downto 0) := "10";
   
   type proc_bus_ds_type is record
      Din  : std_logic_vector(ds_proc_buswidth-1 downto 0);
      Adr  : std_logic_vector(ds_proc_busadr-1 downto 0);
      rnw  : std_logic;
      ena  : std_logic;
      acc  : std_logic_vector(1 downto 0);
      bEna : std_logic_vector(3 downto 0);
      rst  : std_logic;
   end record;
  
end package;


-----------------------------------------------------------------
--------------- Reg Map Package --------------------------------
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library work;
use work.pProc_bus_ds.all;

package pRegmap_ds is

   type regaccess_type is
   (
      readwrite,
      readonly,
      writeonly,
      writeDone -- writeonly, but does send back done, so it is not dead
   );

   type regmap_type is record
      Adr         : integer range 0 to (2**ds_proc_busadr)-1;
      upper       : integer range 0 to ds_proc_buswidth-1;
      lower       : integer range 0 to ds_proc_buswidth-1;
      size        : integer range 0 to (2**ds_proc_busadr)-1;
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
use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

entity eProcReg_ds  is
   generic
   (
      Reg       : regmap_type;
      index     : integer := 0
   );
   port 
   (
      clk       : in    std_logic;
      proc_bus  : in    proc_bus_ds_type;
      wired_out : out   std_logic_vector(ds_proc_buswidth-1 downto 0) := (others => '0');
      Din       : in    std_logic_vector(Reg.upper downto Reg.lower);
      Dout      : out   std_logic_vector(Reg.upper downto Reg.lower);
      written   : out   std_logic := '0'
   );
end entity;

architecture arch of eProcReg_ds is

   signal Dout_buffer : std_logic_vector(Reg.upper downto Reg.lower) := std_logic_vector(to_unsigned(Reg.default,Reg.upper-Reg.lower+1));
    
   signal Adr : std_logic_vector(proc_bus.adr'left downto 0);
    
begin

   Adr <= std_logic_vector(to_unsigned(Reg.Adr + index, proc_bus.adr'length));

   greadwrite : if (Reg.acccesstype = readwrite or Reg.acccesstype = writeonly or Reg.acccesstype = writeDone) generate
   begin
   
      process (clk)
      begin
         if rising_edge(clk) then
         
            written <= '0';
            
            if (proc_bus.rst = '1') then
            
               Dout_buffer <= std_logic_vector(to_unsigned(Reg.default,Reg.upper-Reg.lower+1));
            
            else
         
               if (proc_bus.Adr = Adr and proc_bus.rnw = '0' and proc_bus.ena = '1') then
                  for i in Reg.lower to Reg.upper loop
                     if ((proc_bus.bEna(0) = '1' and i < 8) or 
                     (proc_bus.bEna(1) = '1' and i >= 8 and i < 16) or 
                     (proc_bus.bEna(2) = '1' and i >= 16 and i < 24) or 
                     (proc_bus.bEna(3) = '1' and i >= 24)) then
                        Dout_buffer(i) <= proc_bus.Din(i);  
                        written        <= '1';
                     end if;
                  end loop;
               end if;
             
            end if;
            
         end if;
      end process;
   end generate;
   
   Dout <= Dout_buffer;
   
   goutput : if (Reg.acccesstype = readwrite or Reg.acccesstype = readonly) generate
   begin
      goutputbit: for i in Reg.lower to Reg.upper generate
         wired_out(i) <= Din(i) when proc_bus.Adr = Adr else '0';
      end generate;
      
      glowzero: for i in 0 to Reg.lower - 1 generate
         wired_out(i) <= '0';
      end generate;
      
      ghighzero: for i in Reg.upper + 1 to ds_proc_buswidth-1 generate
         wired_out(i) <= '0';
      end generate;
      
   end generate;
   
end architecture;




