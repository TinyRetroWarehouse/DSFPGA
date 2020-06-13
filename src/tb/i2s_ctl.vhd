library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2s_ctl is
   generic (
      C_DATA_WIDTH: integer := 24
   );
   port (
      CLK_I       : in  std_logic; -- System clock (100 MHz)
      RST_I       : in  std_logic; -- System reset		 
      EN_TX_I     : in  std_logic; -- Transmit enable
      EN_RX_I     : in  std_logic; -- Receive enable
		MM_I    		: in  std_logic; -- Audio controler Master Mode delcetor
		D_L_I       : in  std_logic_vector(C_DATA_WIDTH-1 downto 0); -- Left channel data
      D_R_I       : in  std_logic_vector(C_DATA_WIDTH-1 downto 0); -- Right channel data
--      OE_L_O      : out std_logic; -- Left channel data output enable pulse
--      OE_R_O      : out std_logic; -- Right channel data output enable pulse
--      WE_L_O      : out std_logic; -- Left channel data write enable pulse
--      WE_R_O      : out std_logic; -- Right channel data write enable pulse     
      D_L_O       : out std_logic_vector(C_DATA_WIDTH-1 downto 0); -- Left channel data
      D_R_O       : out std_logic_vector(C_DATA_WIDTH-1 downto 0); -- Right channel data
      BCLK_O      : out std_logic; -- serial CLK
		LRCLK_O     : out std_logic; -- channel CLK
      SDATA_O     : out std_logic; -- Output serial data
      SDATA_I     : in  std_logic  -- Input serial data
   );
end i2s_ctl;

architecture Behavioral of i2s_ctl is

begin

end Behavioral;

