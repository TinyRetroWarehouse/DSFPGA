library ieee;
use ieee.std_logic_1164.all;

entity SyncRamByteEnable is
   generic 
   (
      BYTE_WIDTH : natural := 8;
      ADDR_WIDTH : natural;
      BYTES      : natural := 4
   );
   port 
   (
      clk      : in  std_logic;
      
      addr     : in  natural range 0 to 2**ADDR_WIDTH - 1;
      datain0  : in  std_logic_vector((BYTE_WIDTH-1) downto 0);
      datain1  : in  std_logic_vector((BYTE_WIDTH-1) downto 0);
      datain2  : in  std_logic_vector((BYTE_WIDTH-1) downto 0);
      datain3  : in  std_logic_vector((BYTE_WIDTH-1) downto 0);
      dataout  : out std_logic_vector((BYTES*BYTE_WIDTH-1) downto 0);
      we       : in  std_logic := '0';
      be       : in  std_logic_vector (BYTES - 1 downto 0)
   );
end;

architecture rtl of SyncRamByteEnable is

	type ram_t is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(BYTE_WIDTH-1 downto 0);
	signal ram0 : ram_t := (others => (others => '0'));
	signal ram1 : ram_t := (others => (others => '0'));
	signal ram2 : ram_t := (others => (others => '0'));
	signal ram3 : ram_t := (others => (others => '0'));

begin 
        
   process(clk)
   begin
      if(rising_edge(clk)) then 
         if(we = '1') then
            -- edit this code if using other than four bytes per word
            if(be(0) = '1') then
               ram0(addr) <= datain0;
            end if;
            if be(1) = '1' then
               ram1(addr) <= datain1;
            end if;
            if be(2) = '1' then
               ram2(addr) <= datain2;
            end if;
            if be(3) = '1' then
               ram3(addr) <= datain3;
            end if;
         end if;
         dataout <= ram3(addr) & ram2(addr) & ram1(addr) & ram0(addr);
      end if;
   end process; 
  
end rtl;