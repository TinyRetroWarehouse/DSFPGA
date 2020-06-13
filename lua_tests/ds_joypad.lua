require("ds_lib")

-- fails with luajit!

testerrorcount = 0

wait_ns(10000)

-- reset
reg_set(0, ds.Reg_DS_enablecpu)
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)

wait_ns(10000)

-- first test with all keys off
reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

compare_dsbus_16bit(0x03FF, 0x04000130)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

compare_dsbus_16bit(0x03FF, 0x04000130)
compare_dsbus_8bit(0x7F, 0x04000136)

-- second test with all keys pressed -> also enable irq in arm9
wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x4001, 0x04000132)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x0000, 0x04000132)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)
reg_set_connection(0x00000FFF, ds.Reg_DS_KeyUp)

compare_dsbus_16bit(0x0000, 0x04000130)
compare_dsbus_32bit(0x00001000, 0x04000214)
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

compare_dsbus_16bit(0x0000, 0x04000130)
compare_dsbus_8bit(0x7C, 0x04000136)
compare_dsbus_32bit(0x00000000, 0x04000214)

-- third test with all keys pressed -> also enable irq in arm7
wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x0000, 0x04000132)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x4001, 0x04000132)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_16bit(0x4001, 0x04000132)

reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)
reg_set_connection(0x00000FFF, ds.Reg_DS_KeyUp)

compare_dsbus_16bit(0x0000, 0x04000130)
compare_dsbus_32bit(0x00001000, 0x04000214)
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

compare_dsbus_16bit(0x0000, 0x04000130)
compare_dsbus_32bit(0x00000000, 0x04000214)

-- disable keypad irq register
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x0000, 0x04000132)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)
write_dsbus_16bit(0x0000, 0x04000132)

reg_set(0, ds.Reg_DS_on)

print (testerrorcount.." Errors found")

return (testerrorcount)



