require("ds_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)

for i = 0, 15 do
   DSBusWData = ds.Reg_DS_Bus9WriteData
   DSBusRData = ds.Reg_DS_Bus9ReadData
   DSBusAddr  = ds.Reg_DS_Bus9Addr
   write_dsbus_8bit(i, 0x04000181)
   
   DSBusWData = ds.Reg_DS_Bus7WriteData
   DSBusRData = ds.Reg_DS_Bus7ReadData
   DSBusAddr  = ds.Reg_DS_Bus7Addr
   compare_dsbus_8bit(i, 0x04000180)
end

for i = 0, 15 do
   DSBusWData = ds.Reg_DS_Bus7WriteData
   DSBusRData = ds.Reg_DS_Bus7ReadData
   DSBusAddr  = ds.Reg_DS_Bus7Addr
   write_dsbus_8bit(i, 0x04000181)
   
   DSBusWData = ds.Reg_DS_Bus9WriteData
   DSBusRData = ds.Reg_DS_Bus9ReadData
   DSBusAddr  = ds.Reg_DS_Bus9Addr
   compare_dsbus_8bit(i, 0x04000180)
end

reg_set(1, ds.Reg_DS_on)

print("reset all irq then set irq")
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)

-- enable remote irq
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_8bit(0x40, 0x04000181)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_8bit(0x40, 0x04000181)

-- test remote irqs
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_8bit(0x60, 0x04000181)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_32bit(0x00010000, 0x04000214)

write_dsbus_8bit(0x60, 0x04000181)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_32bit(0x00010000, 0x04000214)

-- disable remote irq
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_8bit(0x00, 0x04000181)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_8bit(0x00, 0x04000181)

-- reset irq
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)

reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

print (testerrorcount.." Errors found")

return (testerrorcount)



