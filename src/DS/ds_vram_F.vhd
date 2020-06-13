library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

entity ds_vram_F is
   port 
   (
      clk100               : in  std_logic; 

      ENABLE               : in  std_logic;
      MST                  : in  std_logic_vector(2 downto 0);
      OFS                  : in  std_logic_vector(1 downto 0);
      
      VRam_cpu9_addr       : in  std_logic_vector(23 downto 0);
      VRam_cpu9_datain     : in  std_logic_vector(31 downto 0);
      VRam_cpu9_dataout    : out std_logic_vector(31 downto 0);
      VRam_cpu9_we         : in  std_logic;
      VRam_cpu9_be         : in  std_logic_vector(3 downto 0);
      VRam_cpu9_active     : out std_logic;
      
      VRam_req             : in  std_logic;
      VRam_addr            : in  std_logic_vector(13 downto 0);
      VRam_dataout         : out std_logic_vector(31 downto 0);
      Vram_valid           : out std_logic := '0'
   );
end entity;

architecture arch of ds_vram_F is

   -- cpu side

   signal cpu_addr       : integer range 0 to (2**12)-1;
   signal cpu_datain     : std_logic_vector(31 downto 0);
   signal cpu_dataout    : std_logic_vector(31 downto 0);
   signal cpu_we         : std_logic;
   signal cpu_be         : std_logic_vector(3 downto 0);

   signal cpu9_ena       : std_logic;

   -- gpu side
   signal gpu_addr       : integer range 0 to (2**12)-1;
   
begin 

   iram : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 12
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => cpu_addr,   
      datain_a0  => cpu_datain( 7 downto  0), 
      datain_a1  => cpu_datain(15 downto  8),
      datain_a2  => cpu_datain(23 downto 16),
      datain_a3  => cpu_datain(31 downto 24),
      dataout_a  => cpu_dataout,
      we_a       => cpu_we,    
      be_a       => cpu_be,     
		           
      addr_b     => gpu_addr,   
      datain_b0  => x"00", 
      datain_b1  => x"00",
      datain_b2  => x"00",
      datain_b3  => x"00",
      dataout_b  => VRam_dataout,
      we_b       => '0',    
      be_b       => "1111"   
   );
   
   cpu9_ena <= ENABLE when (MST = "000" and unsigned(VRam_cpu9_addr) >= x"890000" and unsigned(VRam_cpu9_addr) < x"894000") else
               ENABLE when (MST = "001" and OFS = "00" and unsigned(VRam_cpu9_addr) >= x"000000" and unsigned(VRam_cpu9_addr) < x"004000") else
               ENABLE when (MST = "001" and OFS = "01" and unsigned(VRam_cpu9_addr) >= x"004000" and unsigned(VRam_cpu9_addr) < x"008000") else
               ENABLE when (MST = "001" and OFS = "10" and unsigned(VRam_cpu9_addr) >= x"010000" and unsigned(VRam_cpu9_addr) < x"014000") else
               ENABLE when (MST = "001" and OFS = "11" and unsigned(VRam_cpu9_addr) >= x"014000" and unsigned(VRam_cpu9_addr) < x"018000") else
               ENABLE when (MST = "010" and OFS = "00" and unsigned(VRam_cpu9_addr) >= x"400000" and unsigned(VRam_cpu9_addr) < x"404000") else
               ENABLE when (MST = "010" and OFS = "01" and unsigned(VRam_cpu9_addr) >= x"404000" and unsigned(VRam_cpu9_addr) < x"408000") else
               ENABLE when (MST = "010" and OFS = "10" and unsigned(VRam_cpu9_addr) >= x"410000" and unsigned(VRam_cpu9_addr) < x"414000") else
               ENABLE when (MST = "010" and OFS = "11" and unsigned(VRam_cpu9_addr) >= x"414000" and unsigned(VRam_cpu9_addr) < x"418000") else
               '0';
   
   cpu_addr     <= to_integer(unsigned(VRam_cpu9_addr(13 downto 2)));
   cpu_datain   <= VRam_cpu9_datain;
   cpu_we       <= VRam_cpu9_we when cpu9_ena = '1' else '0';
   cpu_be       <= VRam_cpu9_be;
   
   VRam_cpu9_dataout <= cpu_dataout;
   VRam_cpu9_active  <= cpu9_ena;
   
   gpu_addr <= to_integer(unsigned(VRam_addr(13 downto 2)));

   process (clk100)
   begin
      if rising_edge(clk100) then
         Vram_valid <= VRam_req;
      end if;
   end process;

end architecture;





