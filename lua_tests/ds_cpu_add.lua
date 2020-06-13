require("ds_cpu_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(1, ds.Reg_DS_freerunclock)
reg_set(1, ds.Reg_DS_enablecpu)

-- ARM9
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

DSCPU_clear_instructions()
-- program: add some numbers and write to memory -> compare if correct number written
DSCPU_LOAD(0, 5)
DSCPU_LOAD(1, 10)
DSCPU_LOAD(2, 20)
DSCPU_LOAD(3, 0)

DSCPU_ADD(0, 1, 2) -- 30
DSCPU_ADDI(0, 0, 7) -- 37

DSCPU_SHIFTLEFT(0, 2) -- 148
DSCPU_SHIFTRIGHT(0, 1) -- 74

DSCPU_WRITE_DATA32(0, 3, 0)

DSCPU_self_loop()
-- endprogram
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)

-- ARM7
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

DSCPU_idle_only(false)

-- test
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

write_dsbus_32bit(10, 0x00000000)

reg_set(1, ds.Reg_DS_on)
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit(74, 0x00000000)

print (testerrorcount.." Errors found")

return (testerrorcount)



