library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_gpu is

   -- range 16384 .. 262143

   --   (                                                adr   upper    lower   size    default   accesstype)
   -- framebuffer
   constant Reg_Framebuffer_PosX    : regmap_type := ( 16410,     9,      0,     1,         0,    readwrite);  -- startpos of embedded image
   constant Reg_Framebuffer_PosY    : regmap_type := ( 16410,    25,     16,     1,         0,    readwrite);  -- startpos of embedded image
   constant Reg_Framebuffer_SizeX   : regmap_type := ( 16411,     8,      0,     1,         0,    readwrite);  -- size of data in framebuffer
   constant Reg_Framebuffer_SizeY   : regmap_type := ( 16411,    16,      9,     1,         0,    readwrite);  -- size of data in framebuffer
   constant Reg_Framebuffer_Scale   : regmap_type := ( 16411,    20,     17,     1,         0,    readwrite);  -- scale factor
   constant Reg_Framebuffer_LCD     : regmap_type := ( 16411,    21,     21,     1,         0,    readwrite);  -- LDC effect
   
   constant Reg_Framebuffer2_PosX   : regmap_type := ( 16420,     9,      0,     1,         0,    readwrite);  -- startpos of embedded image
   constant Reg_Framebuffer2_PosY   : regmap_type := ( 16420,    25,     16,     1,         0,    readwrite);  -- startpos of embedded image
   constant Reg_Framebuffer2_SizeX  : regmap_type := ( 16421,     8,      0,     1,         0,    readwrite);  -- size of data in framebuffer
   constant Reg_Framebuffer2_SizeY  : regmap_type := ( 16421,    16,      9,     1,         0,    readwrite);  -- size of data in framebuffer
   constant Reg_Framebuffer2_Scale  : regmap_type := ( 16421,    20,     17,     1,         0,    readwrite);  -- scale factor
   constant Reg_Framebuffer2_LCD    : regmap_type := ( 16421,    21,     21,     1,         0,    readwrite);  -- LDC effect
   
end package;
