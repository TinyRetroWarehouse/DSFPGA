require("ds_cpu_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(3, audio.REG_Audio_Source)

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(0, ds.Reg_DS_freerunclock)

load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\Armwrestler.nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_BmpBg_Vram.nds")

reg_set(0, ds.Reg_DS_enablecpu)
reg_set(1, ds.Reg_DS_bootloader)
reg_set(1, ds.Reg_DS_on) 

wait_ns(6000000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

for i = 0, 11 do
   write_dsbus_16bit(0x1000 + i * 0x1001, 0x02020000 + 2 * i)
end

write_dsbus_32bit(0x0000807f, 0x04000500) --SOUNDCNT
write_dsbus_32bit(0x02020000, 0x04000444) --SOUND4SAD
write_dsbus_16bit(    0xF000, 0x04000448) --SOUND4TMR
write_dsbus_16bit(    0x0002, 0x0400044A) --SOUND4PNT
write_dsbus_32bit(0x00000004, 0x0400044C) --SOUND4LEN
write_dsbus_32bit(0xa840007f, 0x04000440) --SOUND4CNT

reg_set(1, ds.Reg_DS_enablecpu)

brk()

print (testerrorcount.." Errors found")

return (testerrorcount)



