require("ds_cpu_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(3, audio.REG_Audio_Source)

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_enablecpu)
reg_set(1, ds.Reg_DS_on) 

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

write_dsbus_16bit(0x4000, 0x02020000)
write_dsbus_8bit(0x20, 0x02020002)

for i = 0, 15 do
   write_dsbus_8bit(i + i * 16, 0x02020004 + i)
end

write_dsbus_32bit(0x0000807f, 0x04000500) --SOUNDCNT
write_dsbus_32bit(0x02020000, 0x04000444) --SOUND4SAD
write_dsbus_16bit(    0xFF00, 0x04000448) --SOUND4TMR
write_dsbus_16bit(    0x0001, 0x0400044A) --SOUND4PNT
write_dsbus_32bit(0x00000002, 0x0400044C) --SOUND4LEN
write_dsbus_32bit(0xC840007f, 0x04000440) --SOUND4CNT

reg_set(1, ds.Reg_DS_enablecpu)

brk()

print (testerrorcount.." Errors found")

return (testerrorcount)



