LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY clk_wiz IS
   PORT
   (
      clk_in1   : IN STD_LOGIC  := '0';
      clk100    : OUT STD_LOGIC;
      clk200    : OUT STD_LOGIC;
      clk12     : OUT STD_LOGIC;
      clk50     : OUT STD_LOGIC
   );
END clk_wiz;


ARCHITECTURE SYN OF clk_wiz IS

   signal c0_buf      : STD_LOGIC := '1';
   signal c1_buf      : STD_LOGIC := '0';
   signal c2_buf      : STD_LOGIC := '0';
   signal c3_buf      : STD_LOGIC := '0';
   

BEGIN

   c0_buf <= not c0_buf after  5 ns;
   c1_buf <= not c1_buf after  2500 ps;
   c2_buf <= not c2_buf after 41666 ps;
   c3_buf <= not c3_buf after 10 ns;

   clk100 <= c0_buf;
   clk200 <= c1_buf;
   clk12  <= c2_buf;
   clk50  <= c3_buf;

END SYN;

