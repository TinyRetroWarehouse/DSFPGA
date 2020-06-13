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

DSCPU_clear_instructions()
-- program: pre, up, immidiate, writeback 2,3 => [9] + 0x20
DSCPU_LOAD(0, 0)
DSCPU_LOAD(9, 2)
DSCPU_SHIFTLEFT(9, 24)
DSCPU_ADDI(9, 9, 0x70)
DSCPU_ADDI(9, 9, 0x70)

DSCPU_LDRD(9, 1, 1, 1, 1, 2, 0x20)

DSCPU_WRITE_DATA32(2, 0, 0)
DSCPU_WRITE_DATA32(3, 0, 4)
DSCPU_WRITE_DATA32(9, 0, 8)

DSCPU_self_loop()
-- endprogram
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)

write_dsbus_32bit(0x123, 0x02000100)
write_dsbus_32bit(0x456, 0x02000104)

-- test
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

write_dsbus_32bit(10, 0x00000000)
write_dsbus_32bit(10, 0x00000004)
write_dsbus_32bit(10, 0x00000008)

reg_set(1, ds.Reg_DS_on)
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit(0x123, 0x00000000)
compare_dsbus_32bit(0x456, 0x00000004)
compare_dsbus_32bit(0x02000100, 0x00000008)

print (testerrorcount.." Errors found")

return (testerrorcount)



