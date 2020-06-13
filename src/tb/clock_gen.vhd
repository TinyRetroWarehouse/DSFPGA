-- for 720p only

library ieee;
use ieee.std_logic_1164.all;

entity clock_gen is
    generic (
        CLKIN_PERIOD :    real := 8.000;  -- input clock period (8ns)
        CLK_MULTIPLY : integer := 8;      -- multiplier
        CLK_DIVIDE   : integer := 1;      -- divider
        CLKOUT0_DIV  : integer := 8;      -- serial clock divider
        CLKOUT1_DIV  : integer := 40      -- pixel clock divider
    );
    port(
        clk_i  : in  std_logic; --  input clock
        clk0_o : out std_logic; -- serial clock
        clk1_o : out std_logic  --  pixel clock
    );
end clock_gen;

architecture rtl of clock_gen is

   signal clk0 : std_logic := '0';
   signal clk1 : std_logic := '0';

begin

   clk0 <= not clk0 after 2712 ps;
   clk1 <= not clk1 after 6779 ps;
   
   clk0_o <= clk0;
   clk1_o <= clk1;

end rtl;
