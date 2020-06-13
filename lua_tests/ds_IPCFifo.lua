require("ds_lib")

testerrorcount = 0

wait_ns(10000)

function ICPfifo_reset()

   DSBusWData = ds.Reg_DS_Bus9WriteData
   DSBusRData = ds.Reg_DS_Bus9ReadData
   DSBusAddr  = ds.Reg_DS_Bus9Addr
   write_dsbus_16bit(0xC008, 0x04000184) -- clear fifo and reset error and enable
   
   DSBusWData = ds.Reg_DS_Bus7WriteData
   DSBusRData = ds.Reg_DS_Bus7ReadData
   DSBusAddr  = ds.Reg_DS_Bus7Addr
   write_dsbus_16bit(0xC008, 0x04000184) -- clear fifo and reset error and enable

end

reg_set(0, ds.Reg_DS_enablecpu)
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)

ICPfifo_reset()

print("check reading empty FIFO reads zero and sets error flag, reset error flag and check again")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_32bit(0x00000000, 0x04100000)
compare_dsbus_8bit(0xC1, 0x04000185)
write_dsbus_8bit(0xC0, 0x04000185)
compare_dsbus_8bit(0x81, 0x04000185)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_32bit(0x00000000, 0x04100000)
compare_dsbus_8bit(0xC1, 0x04000185)
write_dsbus_8bit(0xC0, 0x04000185)
compare_dsbus_8bit(0x81, 0x04000185)

print("9 to 7 send single data, check not empty anymore, read data and check empty again")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0xDEADBEEF, 0x04000188)
compare_dsbus_8bit(0x00, 0x04000184)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_8bit(0x80, 0x04000185)
compare_dsbus_32bit(0xDEADBEEF, 0x04100000)
compare_dsbus_8bit(0x81, 0x04000185)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_8bit(0x01, 0x04000184)

print("7 to 9 send single data, check not empty anymore, read data and check empty again")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0xDEADBEEF, 0x04000188)
compare_dsbus_8bit(0x00, 0x04000184)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_8bit(0x80, 0x04000185)
compare_dsbus_32bit(0xDEADBEEF, 0x04100000)
compare_dsbus_8bit(0x81, 0x04000185)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_8bit(0x01, 0x04000184)

print("9 to 7 - fill FIFO 16 times, check send is full, no error, then check and read on other side")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
for i = 0, 15 do
   write_dsbus_32bit(0x1000 + i, 0x04000188)
end
compare_dsbus_8bit(0x02, 0x04000184)
compare_dsbus_8bit(0x81, 0x04000185)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_8bit(0x01, 0x04000184)
compare_dsbus_8bit(0x82, 0x04000185)
for i = 0, 15 do
   compare_dsbus_32bit(0x1000 + i, 0x04100000)
end

print("7 to 9 - fill FIFO 16 times, check send is full, no error, then check and read on other side")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
for i = 0, 15 do
   write_dsbus_32bit(0x1000 + i, 0x04000188)
end
compare_dsbus_8bit(0x02, 0x04000184)
compare_dsbus_8bit(0x81, 0x04000185)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_8bit(0x01, 0x04000184)
compare_dsbus_8bit(0x82, 0x04000185)
for i = 0, 15 do
   compare_dsbus_32bit(0x1000 + i, 0x04100000)
end

print("write 17 times and check for error set, then clear error flag and check if cleared")
wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
for i = 0, 16 do
   write_dsbus_32bit(0, 0x04000188)
end
compare_dsbus_8bit(0xC1, 0x04000185)
write_dsbus_8bit(0xC0, 0x04000185)
compare_dsbus_8bit(0x81, 0x04000185)
ICPfifo_reset()

wait_ns(10000)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
for i = 0, 16 do
   write_dsbus_32bit(0, 0x04000188)
end
compare_dsbus_8bit(0xC1, 0x04000185)
write_dsbus_8bit(0xC0, 0x04000185)
compare_dsbus_8bit(0x81, 0x04000185)
ICPfifo_reset()

print("Generate all 4 IRQs")
wait_ns(10000)
-- clear all irq bits
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

--enable irq
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_16bit(0xC40C, 0x04000184) -- clear fifo and reset error and enable and both irq enables
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_16bit(0xC40C, 0x04000184) -- clear fifo and reset error and enable and both irq enables

-- send data 9 to 7 and check rec not empty irq set - irq empty is also set, because of the clear and enable
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
write_dsbus_32bit(0, 0x04000188)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_32bit(0x00060000, 0x04000214)

-- read data and check send empty irq is set
compare_dsbus_32bit(0, 0x04100000)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_32bit(0x00020000, 0x04000214)

-- send data 7 to 9 and check rec not empty irq set
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
write_dsbus_32bit(0, 0x04000188)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
compare_dsbus_32bit(0x00060000, 0x04000214)

-- read data and check send empty irq is set
compare_dsbus_32bit(0, 0x04100000)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
compare_dsbus_32bit(0x00060000, 0x04000214)

-- clear all irq bits
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
wait_ns(1000)

print (testerrorcount.." Errors found")

return (testerrorcount)



