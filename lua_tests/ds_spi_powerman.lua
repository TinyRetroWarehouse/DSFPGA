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

wait_ns(10000)

write_dsbus_16bit(0x0002, 0x040001C0)  -- control : speed 2, Device 0, hold off, irq off, ena off(?)
compare_dsbus_8bit(0x00, 0x040001C2)

-- select each powerman reg and readback default
write_dsbus_8bit(0x80, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2) 
compare_dsbus_8bit(0x0D, 0x040001C2)

write_dsbus_8bit(0x81, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2)
compare_dsbus_8bit(0x00, 0x040001C2)

write_dsbus_8bit(0x82, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2)
compare_dsbus_8bit(0x01, 0x040001C2)

write_dsbus_8bit(0x83, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2)
compare_dsbus_8bit(0x00, 0x040001C2)

write_dsbus_8bit(0x84, 0x040001C2) 
write_dsbus_8bit(0x00, 0x040001C2)
compare_dsbus_8bit(0x03, 0x040001C2)

-- write into each powerman reg and readback
for i = 0, 4 do
   write_dsbus_8bit(0x00 + i, 0x040001C2) 
   write_dsbus_8bit(0x10 + i, 0x040001C2)
end

for i = 0, 4 do
   write_dsbus_8bit(0x80 + i, 0x040001C2) 
   write_dsbus_8bit(0x00, 0x040001C2)
   compare_dsbus_8bit(0x10 + i, 0x040001C2)
end

-- using 5-7 -> must return value from 4
for i = 5, 7 do
   write_dsbus_8bit(0x80 + i, 0x040001C2) 
   write_dsbus_8bit(0x00, 0x040001C2)
   compare_dsbus_8bit(0x14, 0x040001C2)
end

-- using 5-7 -> must set value to 4
for i = 5, 7 do
   write_dsbus_8bit(0x00 + i, 0x040001C2) 
   write_dsbus_8bit(0x10 + i, 0x040001C2)

   write_dsbus_8bit(0x84, 0x040001C2) 
   write_dsbus_8bit(0x00, 0x040001C2)
   compare_dsbus_8bit(0x10 + i, 0x040001C2)
end

print (testerrorcount.." Errors found")

return (testerrorcount)



