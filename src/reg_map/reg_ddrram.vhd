library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_ddrram is

   -- range 134217728..268435455

   --   (                                                        adr      upper   lower   size     default    accesstype)               
   constant Reg_Data               : regmap_type := (           134217728,     31,    0, 134217728,       0,    readwrite);   -- whole ram, memory mapped
  
   constant Softmap_DS_WRAM        : regmap_type := (           134217728,     31,    0,   1048576,       0,    readwrite);   -- 4   Mbyte Data for WRam   
   constant Softmap_DS_Firmware    : regmap_type := (           136314880,     31,    0,     65536,       0,    readwrite);   -- 256Kbyte for Firmware
   constant Softmap_DS_SaveRam     : regmap_type := (           138412032,     31,    0,   1048576,       0,    readwrite);   -- 1Mbyte largest flash except Art Academy (8Mbyte)  
   constant Softmap_DS_SaveState   : regmap_type := (           140509184,     31,    0,   2097152,       0,    readwrite);   -- 8 Mbyte Data for Savestate
   constant Softmap_DS_Gamerom     : regmap_type := (           201326592,     31,    0,  67108864,       0,    readwrite);   -- 256 Mbyte Data for GameRom   
                                                      
   constant Softmap_Exchange       : regmap_type := (134217728 + 58720256,     31,    0,   4194304,       0,    readwrite);   -- 16 Mbyte Data Exchange to PC, starting at MB96, Format: DW0: req DW1: Data Length(without Filename), DW2..n: Filename(null terminated), DWn+1..: Data
   
end package;
