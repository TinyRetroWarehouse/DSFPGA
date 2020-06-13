require("ds_lib")

-- fails with luajit!

testerrorcount = 0

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on) 
reg_set(0, ds.Reg_DS_on)

reg_set_connection(0xA7C71000, ds.Reg_DS_TouchX)

wait_ns(10000)

write_dsbus_16bit(0x0A01, 0x040001C0)  -- control : speed 1, Device 2, hold on, irq off, ena off(?)
compare_dsbus_8bit(0x00, 0x040001C2)

-- select each touchscreen reg and readback both values
-- temperature 1
write_dsbus_8bit(0x00, 0x040001C2) 
compare_dsbus_8bit(0x60, 0x040001C2)
write_dsbus_8bit(0x00, 0x040001C2) 
compare_dsbus_8bit(0x16, 0x040001C2)

-- y pos
write_dsbus_8bit(0x10, 0x040001C2) 
compare_dsbus_8bit(0x80, 0x040001C2)
write_dsbus_8bit(0x10, 0x040001C2) 
compare_dsbus_8bit(0x53, 0x040001C2)

-- battery voltage
write_dsbus_8bit(0x20, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)
write_dsbus_8bit(0x20, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)

-- Touchscreen Z1
write_dsbus_8bit(0x30, 0x040001C2) 
compare_dsbus_8bit(0x38, 0x040001C2)
write_dsbus_8bit(0x30, 0x040001C2) 
compare_dsbus_8bit(0x2B, 0x040001C2)

-- Touchscreen Z2
write_dsbus_8bit(0x40, 0x040001C2) 
compare_dsbus_8bit(0x38, 0x040001C2)
write_dsbus_8bit(0x40, 0x040001C2) 
compare_dsbus_8bit(0x2B, 0x040001C2)

-- x pos
write_dsbus_8bit(0x50, 0x040001C2) 
compare_dsbus_8bit(0x80, 0x040001C2)
write_dsbus_8bit(0x50, 0x040001C2) 
compare_dsbus_8bit(0x63, 0x040001C2)

-- aux input (microphone)
write_dsbus_8bit(0x60, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)
write_dsbus_8bit(0x60, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)

-- temperature 2
write_dsbus_8bit(0x70, 0x040001C2) 
compare_dsbus_8bit(0x08, 0x040001C2)
write_dsbus_8bit(0x70, 0x040001C2) 
compare_dsbus_8bit(0x1B, 0x040001C2)


-- test z1/z2 without touch
reg_set_connection(0xA7C70000, ds.Reg_DS_TouchX)

-- Touchscreen Z1
write_dsbus_8bit(0x30, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)
write_dsbus_8bit(0x30, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)

-- Touchscreen Z2
write_dsbus_8bit(0x40, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)
write_dsbus_8bit(0x40, 0x040001C2) 
compare_dsbus_8bit(0x00, 0x040001C2)

reg_set_connection(0x0000000, ds.Reg_DS_TouchX)

print (testerrorcount.." Errors found")

return (testerrorcount)



