require("ds_lib")

-- fails with luajit!

testerrorcount = 0

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

-- reset
reg_set(0, ds.Reg_DS_on)

-- load firmware
reg_set_file("lua_tests\\firmware.bin", ddrram.Softmap_DS_Firmware, 0, 0)

reg_set(1, ds.Reg_DS_on) 
reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

write_dsbus_16bit(0x0100, 0x040001C0)  -- control : speed 0, Device 1, hold off, irq off, ena off(?)
compare_dsbus_8bit(0x00, 0x040001C2)

-- set read mode
write_dsbus_8bit(0x03, 0x040001C2) 

-- set start address
write_dsbus_8bit(0x00, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2) 
write_dsbus_8bit(0xDB, 0x040001C2) 

-- read and compare some data
dataarray = { 0x45, 0x1D, 0xFA, 0xFF, 0x23 }
for i = 1, #dataarray do
   write_dsbus_8bit(0x00, 0x040001C2) 
   compare_dsbus_8bit(dataarray[i], 0x040001C2)
end


print (testerrorcount.." Errors found")

return (testerrorcount)



