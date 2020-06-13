require("ds_cpu_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(1, ds.Reg_DS_freerunclock)
reg_set(1, ds.Reg_DS_enablecpu)

-- ARM7
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

DSCPU_idle_only(false)

-- ARM9
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

-- set away from address 0x0 so DTCM REGION so ITCM is accesible
DSCPU_clear_instructions()
DSCPU_DTCMREGION_TOx01000000()
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)
reg_set(1, ds.Reg_DS_on)
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

DSCPU_clear_instructions()
-- program: halt, irq out and write back memory to test, register 0 should not be overwritten, as "R14_irq = address of next instruction to be executed + 4"
DSCPU_LOAD(0, 20)
DSCPU_HALT9()
DSCPU_LOAD(0, 10)
DSCPU_LOAD(1, 11)
DSCPU_LOAD(2, 12)
DSCPU_LOAD(3, 0)

DSCPU_WRITE_DATA32( 0, 3, 0)
DSCPU_WRITE_DATA32( 1, 3, 4)
DSCPU_WRITE_DATA32( 2, 3, 8)

DSCPU_self_loop()
-- endprogram0
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)

write_dsbus_32bit(0xE120003E, 0x18)

-- test
write_dsbus_32bit(0xFF, 0x00000000)
write_dsbus_32bit(0xFF, 0x00000004)
write_dsbus_32bit(0xFF, 0x00000008)

reg_set(1, ds.Reg_DS_on)
wait_ns(10000)

-- clear irq
write_dsbus_32bit(0xFFFFFFFF, 0x04000214)
compare_dsbus_32bit(0x00000000, 0x04000214)

-- enable joypad irq and trigger it
write_dsbus_32bit(0x00000001, 0x04000208) -- IME
write_dsbus_32bit(0x00001000, 0x04000210) -- IE
write_dsbus_16bit(0x4001, 0x04000132)
reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)
reg_set_connection(0x00000FFF, ds.Reg_DS_KeyUp)

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

compare_dsbus_32bit(20, 0x00000000)
compare_dsbus_32bit(11, 0x00000004)
compare_dsbus_32bit(12, 0x00000008)

-- disable irq
write_dsbus_32bit(0x00000000, 0x04000208) -- IME
write_dsbus_32bit(0x00000000, 0x04000210) -- IE
write_dsbus_16bit(0x0000, 0x04000132)
reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)

print (testerrorcount.." Errors found")

return (testerrorcount)



