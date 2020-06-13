require("ds_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(3, audio.REG_Audio_Source)

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

write_dsbus_32bit(0x0000807f, 0x04000500) --SOUNDCNT
write_dsbus_32bit(0xe3400040, 0x04000480) --SOUND8CNT
write_dsbus_32bit(0x0000e0bb, 0x04000488) --SOUND8TMR

brk()

print (testerrorcount.." Errors found")

return (testerrorcount)



