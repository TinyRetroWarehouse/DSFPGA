library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_External is

   -- range 8192 .. 9216

   --   (                                         adr   upper    lower   size    default   accesstype)
                                  
   constant Reg_Switches           : regmap_type := (8192,      7,      0,    1,         0,    readonly);  -- switches on DE2
                                   
   constant Reg_Keys               : regmap_type := (8193,      4,      0,    1,         0,    readonly);  -- keys on DE2
                                   
   constant Reg_LED                : regmap_type := (8200,      7,      0,    1,         0,    readwrite); -- green LEDs on DE2

end package;
