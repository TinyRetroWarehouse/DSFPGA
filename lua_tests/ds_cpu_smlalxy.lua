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
-- program: various smlalxy with result in 1-4
DSCPU_LOAD(0, 0)     -- base address for writeback

-- 0x8000 * 0x7FFF in low/low -> 0xFFFFFFFF C0008000 + 0x00000001 00000000 = 0x00000001 C0008000
DSCPU_LOAD(1, 2)
DSCPU_LOAD(2, 0)
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SMLALXY(8, 9, 1, 2, 0, 0)

-- 0x8000 * 0x7FFF in low/high -> 0xFFFFFFFF C0008000 + 0x00000001 00000000 = 0x00000001 C0008000
DSCPU_LOAD(3, 2)
DSCPU_LOAD(4, 0)
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SHIFTLEFT(9, 16)
DSCPU_SMLALXY(8, 9, 3, 4, 0, 1)

-- 0x8000 * 0x7FFF in high/low -> 0xFFFFFFFF C0008000 + 0x00000001 00000000 = 0x00000001 C0008000
DSCPU_LOAD(5, 2)
DSCPU_LOAD(6, 0)
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 31)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_SUBI(9, 9, 1)
DSCPU_SMLALXY(8, 9, 5, 6, 1, 0)

-- 0x8000 * 0x7FFF in high/high -> 0xFFFFFFFF C0008000 + 0x00000001 00000000 = 0x00000001 C0008000
DSCPU_LOAD(7, 2)
DSCPU_LOAD(8, 0)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 31)
DSCPU_LOAD(11, 1)
DSCPU_SHIFTLEFT(11, 15)
DSCPU_SUBI(11, 11, 1)
DSCPU_SHIFTLEFT(11, 16)
DSCPU_SMLALXY(10, 11, 7, 8, 1, 1)

-- write all data
for i = 1, 8 do
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
wait_ns(20000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit(0x00000001,  1 * 4)
compare_dsbus_32bit(0xC0008000,  2 * 4)

compare_dsbus_32bit(0x00000001,  3 * 4)
compare_dsbus_32bit(0xC0008000,  4 * 4)

compare_dsbus_32bit(0x00000001,  5 * 4)
compare_dsbus_32bit(0xC0008000,  6 * 4)

compare_dsbus_32bit(0x00000001,  7 * 4)
compare_dsbus_32bit(0xC0008000,  8 * 4)


print (testerrorcount.." Errors found")

return (testerrorcount)



