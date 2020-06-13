library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_ds is

   -- range 1048576 .. 2097151

   --   (                                          adr      upper    lower    size  default   accesstype)                                 
   constant Reg_DS_on            : regmap_type := (1064960,   0,      0,        1,       0,   readwrite); -- on = 1
   
   constant Reg_DS_lockspeed     : regmap_type := (1064961,   0,      0,        1,       0,   readwrite); -- 1 = 100% speed
   constant Reg_DS_freerunclock  : regmap_type := (1064962,   0,      0,        1,       0,   readwrite); -- 1 = 66mhz internal with no halts
   constant Reg_DS_enablecpu     : regmap_type := (1064963,   0,      0,        1,       0,   readwrite);
   constant Reg_DS_bootloader    : regmap_type := (1064964,   0,      0,        1,       0,   readwrite);
   
   constant Reg_DS_PC9Entry      : regmap_type := (1064965,  31,      0,        1,       0,   readwrite);
   constant Reg_DS_PC7Entry      : regmap_type := (1064966,  31,      0,        1,       0,   readwrite);
   constant Reg_DS_ChipID        : regmap_type := (1064967,  31,      0,        1,       0,   readwrite);

   constant Reg_DS_CyclePrecalc  : regmap_type := (1064971,  15,      0,        1,     100,   readwrite);  
   constant Reg_DS_CyclesMissing : regmap_type := (1064972,  31,      0,        1,       0,   readonly);  
                                  
   constant Reg_DS_Bus9Addr      : regmap_type := (1064980,  27,      0,        1,       0,   readwrite);
   constant Reg_DS_Bus9RnW       : regmap_type := (1064980,  28,     28,        1,       0,   readwrite);
   constant Reg_DS_Bus9ACC       : regmap_type := (1064980,  30,     29,        1,       0,   readwrite);
   constant Reg_DS_Bus9WriteData : regmap_type := (1064981,  31,      0,        1,       0,   readwrite);
   constant Reg_DS_Bus9ReadData  : regmap_type := (1064982,  31,      0,        1,       0,   readonly);
   
   constant Reg_DS_Bus7Addr      : regmap_type := (1064983,  27,      0,        1,       0,   readwrite);
   constant Reg_DS_Bus7RnW       : regmap_type := (1064983,  28,     28,        1,       0,   readwrite);
   constant Reg_DS_Bus7ACC       : regmap_type := (1064983,  30,     29,        1,       0,   readwrite);
   constant Reg_DS_Bus7WriteData : regmap_type := (1064984,  31,      0,        1,       0,   readwrite);
   constant Reg_DS_Bus7ReadData  : regmap_type := (1064985,  31,      0,        1,       0,   readonly);
   
   constant Reg_DS_VsyncSpeed9   : regmap_type := (1064986,  31,      0,        1,       0,   readwrite);                        
   constant Reg_DS_VsyncSpeed7   : regmap_type := (1064987,  31,      0,        1,       0,   readwrite);   
   constant Reg_DS_VsyncIdle9    : regmap_type := (1064988,  31,      0,        1,       0,   readwrite);                        
   constant Reg_DS_VsyncIdle7    : regmap_type := (1064989,  31,      0,        1,       0,   readwrite);       
                                  
      -- joypad                          
   constant Reg_DS_KeyUp         : regmap_type := (1064990,   0,      0,        1,       0,   readwrite); 
   constant Reg_DS_KeyDown       : regmap_type := (1064990,   1,      1,        1,       0,   readwrite); 
   constant Reg_DS_KeyLeft       : regmap_type := (1064990,   2,      2,        1,       0,   readwrite); 
   constant Reg_DS_KeyRight      : regmap_type := (1064990,   3,      3,        1,       0,   readwrite); 
   constant Reg_DS_KeyA          : regmap_type := (1064990,   4,      4,        1,       0,   readwrite); 
   constant Reg_DS_KeyB          : regmap_type := (1064990,   5,      5,        1,       0,   readwrite); 
   constant Reg_DS_KeyL          : regmap_type := (1064990,   6,      6,        1,       0,   readwrite); 
   constant Reg_DS_KeyR          : regmap_type := (1064990,   7,      7,        1,       0,   readwrite); 
   constant Reg_DS_KeyStart      : regmap_type := (1064990,   8,      8,        1,       0,   readwrite); 
   constant Reg_DS_KeySelect     : regmap_type := (1064990,   9,      9,        1,       0,   readwrite); 
   constant Reg_DS_KeyX          : regmap_type := (1064990,  10,     10,        1,       0,   readwrite); 
   constant Reg_DS_KeyY          : regmap_type := (1064990,  11,     11,        1,       0,   readwrite); 
   constant Reg_DS_Touch         : regmap_type := (1064990,  12,     12,        1,       0,   readwrite); 
   constant Reg_DS_TouchX        : regmap_type := (1064990,  23,     16,        1,       0,   readwrite); 
   constant Reg_DS_TouchY        : regmap_type := (1064990,  31,     24,        1,       0,   readwrite); 
   
   -- special settings
   constant Reg_DS_cputurbo      : regmap_type := (1064995,   0,      0,        1,       0,   readwrite); -- 1 = cpu free running
   constant Reg_DS_SaveState     : regmap_type := (1064996,   0,      0,        1,       0,   Pulse); 
   constant Reg_DS_LoadState     : regmap_type := (1064997,   0,      0,        1,       0,   Pulse); 
   
   -- debug
   constant Reg_DS_DebugCycling  : regmap_type := (1065000,  31,      0,        1,       0,   readonly);
   constant Reg_DS_DebugCPU9     : regmap_type := (1065001,  31,      0,        1,       0,   readonly);
   constant Reg_DS_DebugCPU7     : regmap_type := (1065002,  31,      0,        1,       0,   readonly);
   constant Reg_DS_DebugDMA9     : regmap_type := (1065003,  31,      0,        1,       0,   readonly);
   constant Reg_DS_DebugDMA7     : regmap_type := (1065004,  31,      0,        1,       0,   readonly);
   
end package;
