library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity audio_init is
   port (
      clk       : in    std_logic;
      rst       : in    std_logic;
      sda       : inout std_logic;
      scl       : inout std_logic
   );
end audio_init;

architecture Behavioral of audio_init is

begin

end Behavioral;