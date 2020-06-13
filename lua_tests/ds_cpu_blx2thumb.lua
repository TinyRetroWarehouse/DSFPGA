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
-- program: branch to thumbroutine and return directly to LR then write PC and LR to memory
DSCPU_LOAD(0, 0)
DSCPU_LOAD(1, 5)
DSCPU_LOAD(1, 5)

DSCPU_BLX1(0x100, 0)

DSCPU_LOAD(1, 8)
DSCPU_LOAD(2, 42)

DSCPU_WRITE_DATA32( 1, 0, 0)
DSCPU_WRITE_DATA32( 2, 0, 4)
DSCPU_WRITE_DATA32(14, 0, 8)

DSCPU_self_loop()
-- endprogram0
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)

write_dsbus_16bit(0x47F0, 0x02000100)

-- test
write_dsbus_32bit(1, 0x00000000)
write_dsbus_32bit(2, 0x00000004)
write_dsbus_32bit(3, 0x00000008)

reg_set(1, ds.Reg_DS_on)
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit( 8, 0x00000000)
compare_dsbus_32bit(42, 0x00000004)
compare_dsbus_32bit(0x02000103, 0x00000008)


print (testerrorcount.." Errors found")

return (testerrorcount)



