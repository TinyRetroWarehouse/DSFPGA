library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

package pReg_test is

   -- range 0 .. 127

   --   (                                      adr   upper    lower    size  default   accesstype)
                             
                             
   constant Reg_Testreg      : regmap_type := (1,      31,      0,    1,         0,         readwrite); -- 32 bit testregister
   
   constant Reg_Errorflags   : regmap_type := (2,      31,      0,    1,         0,         readonly ); -- Bit0: Bus Timeout
   
   constant Reg_Simu         : regmap_type := (3,       0,      0,    1,         0,         readonly ); -- 1 when in simulation, 0 on HW
   
   constant Reg_DDRLatency   : regmap_type := (16,     15,      0,    1,         0,         readonly ); -- 1 when in simulation, 0 on HW
   
   constant Reg_Testblock    : regmap_type := (128,     0,      0,  128,         0,         readwrite); -- testblock
   
end package;
