require("ds_cpu_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(1, ds.Reg_DS_freerunclock)
reg_set(1, ds.Reg_DS_enablecpu)

-- ARM9
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

DSCPU_idle_only(false)

-- ARM7
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

DSCPU_clear_instructions()
-- program: halt, irq out and write back memory to test, register 0 should not be overwritten, as "R14_irq = address of next instruction to be executed + 4"
DSCPU_LOAD(0, 20)

-- write 0x8000 to 0x4000300
DSCPU_LOAD(10, 4)
DSCPU_SHIFTLEFT(10, 24)
DSCPU_LOAD(11, 3)
DSCPU_SHIFTLEFT(11, 8)
DSCPU_ADD(10, 10, 11)

DSCPU_LOAD(11, 1)
DSCPU_SHIFTLEFT(11, 15)

DSCPU_LOAD(12, 2)
DSCPU_SHIFTLEFT(12, 24)
DSCPU_ADDI(12, 12, 54)

DSCPU_WRITE_DATA32(11, 10, 0)

DSCPU_LOAD(0, 10)
DSCPU_LOAD(1, 11)
DSCPU_LOAD(2, 12)
DSCPU_LOAD(3, 2)
DSCPU_SHIFTLEFT(3, 24)

DSCPU_WRITE_DATA32( 0, 3, 0)
DSCPU_WRITE_DATA32( 1, 3, 4)
DSCPU_WRITE_DATA32( 2, 3, 8)

DSCPU_self_loop()
-- endprogram0
DSCPU_transmit(false, DSCPU_INSTR_LIST, 0)

write_dsbus_32bit(0x03FF8000, 0x03FFFFFC) -- adress of irq routine
write_dsbus_32bit(0xE12FFF1C, 0x03FF8000) -- branch pointer in r12

-- test
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

compare_dsbus_32bit(0x4000000, 0x02000000) -- written to reg0 from BIOS
compare_dsbus_32bit(11, 0x02000004)
compare_dsbus_32bit(12, 0x02000008)

-- disable irq
write_dsbus_32bit(0x00000000, 0x04000208) -- IME
write_dsbus_32bit(0x00000000, 0x04000210) -- IE
write_dsbus_16bit(0x0000, 0x04000132)
reg_set_connection(0x00000000, ds.Reg_DS_KeyUp)

print (testerrorcount.." Errors found")

return (testerrorcount)



