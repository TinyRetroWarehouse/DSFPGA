library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_Audio is

   -- range 8192 .. 9216

   --   (                                              adr   upper    lower   size    default   accesstype)     
   -- external domain                                   
   constant REG_Audio_Source       : regmap_type := ( 8980,      1,      0,    1,         0,    readwrite); -- 0 = off, 1 = register, 2 = square, 3 = console
   constant REG_Audio_Value        : regmap_type := ( 8981,     15,      0,    1,         0,    readwrite); -- mono only
   constant REG_Audio_SquarePeriod : regmap_type := ( 8982,     23,      0,    1,         0,    readwrite); -- switching maxampl every 83,3ns * n
   
end package;
