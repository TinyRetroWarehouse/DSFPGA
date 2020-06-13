-- author: Furkan Cayci, 2018
-- description: generate tmds output based on the given rgb values and video timing
--   used for DVI and HDMI signaling

library ieee;
use ieee.std_logic_1164.all;

entity rgb2tmds is
    generic (
        SERIES6 : boolean := false
    );
    port(
        -- reset and clocks
        rst : in std_logic;
        pixelclock : in std_logic;  -- slow pixel clock 1x
        serialclock : in std_logic; -- fast serial clock 5x

        -- video signals
        video_data : in std_logic_vector(23 downto 0);
        video_active  : in std_logic;
        hsync : in std_logic;
        vsync : in std_logic;

        -- tmds output ports
        clk_p : out std_logic;
        clk_n : out std_logic;
        data_p : out std_logic_vector(2 downto 0);
        data_n : out std_logic_vector(2 downto 0)
    );
end rgb2tmds;

architecture rtl of rgb2tmds is

begin

   clk_p  <= '0';
   clk_n  <= '0';
   data_p <= "000";
   data_n <= "000";

   
end rtl;
