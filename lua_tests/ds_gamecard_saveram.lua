require("ds_lib")

function gamecard_saveram_reset()

   write_dsbus_16bit(0x0000, 0x040001A0)
   write_dsbus_16bit(0x8040, 0x040001A0)
   write_dsbus_8bit(0x00, 0x040001A2)

end

function test_gamecard_saveram(isArm9)

   target = 0x55
   if (isArm9) then
      target = 0x66
   end

   gamecard_saveram_reset()
   write_dsbus_8bit(0x06, 0x040001A2) -- set writeenable

   gamecard_saveram_reset()
   write_dsbus_8bit(0x03, 0x040001A2) -- dummy read for size detect
   write_dsbus_8bit(0x00, 0x040001A2)

   gamecard_saveram_reset()
   write_dsbus_8bit(0x02, 0x040001A2) -- write data 0xBB to address target
   write_dsbus_8bit(target, 0x040001A2)
   write_dsbus_8bit(0xBB, 0x040001A2)
   
   gamecard_saveram_reset()
   write_dsbus_8bit(0x03, 0x040001A2) -- read data 0xBB from address target
   write_dsbus_8bit(target, 0x040001A2)
   write_dsbus_8bit(0x00, 0x040001A2)
   
   compare_dsbus_8bit(0xBB, 0x040001A2)
   
end

testerrorcount = 0

wait_ns(10000)

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_enablecpu)
reg_set(1, ds.Reg_DS_on) 
reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

test_gamecard_saveram(false)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

test_gamecard_saveram(true)

print (testerrorcount.." Errors found")

return (testerrorcount)



