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
-- program: various smulxy with result in 1-4
DSCPU_LOAD(0, 0)     -- base address for writeback

-- 0x8000 * 0x7FFF in low/low -> 0xC0008000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SMULXY(1, 8, 9, 0, 0)

-- 0x8000 * 0x7FFF in low/high -> 0xC0008000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SHIFTLEFT(9, 16)
DSCPU_SMULXY(2, 8, 9, 0, 1)

-- 0x8000 * 0x7FFF in high/low -> 0xC0008000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 31)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SMULXY(3, 8, 9, 1, 0)

-- 0x8000 * 0x7FFF in high/high -> 0xC0008000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 31)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SHIFTLEFT(9, 16)
DSCPU_SMULXY(4, 8, 9, 1, 1)

-- write all data
for i = 1, 4 do
   DSCPU_WRITE_DATA32(i, 0, i * 4)
end

DSCPU_self_loop()
-- endprogram0
DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)

-- test
for i = 0, 15 do
   write_dsbus_32bit(10, 0x00000000 + i * 4)
end

reg_set(1, ds.Reg_DS_on)
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit(0xC0008000,  1 * 4)
compare_dsbus_32bit(0xC0008000,  2 * 4)
compare_dsbus_32bit(0xC0008000,  3 * 4)
compare_dsbus_32bit(0xC0008000,  4 * 4)


print (testerrorcount.." Errors found")

return (testerrorcount)



