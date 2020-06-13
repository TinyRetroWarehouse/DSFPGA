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
-- program: various smlaxy with result in 1-4 and q flag in 11-14
DSCPU_LOAD(0, 0)     -- base address for writeback

-- 0x7FFF * 0x8000 in low -> 0xC0008000 + 0x4000 = 0xC000C000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 14)
DSCPU_SMLAXY(1, 8, 9, 10, 0, 0)
DSCPU_MRS_USER(11)
DSCPU_MRS_CLEARFLAGS()

-- 0x7FFF * 0x8000 in low -> 0xC0008000 + 0x8000000 = 0x40008000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 31)
DSCPU_SMLAXY(2, 8, 9, 10, 0, 0)
DSCPU_MRS_USER(12)
DSCPU_MRS_CLEARFLAGS()

-- 0x7000 * 0x7000 in low -> 0x31000000 + 0x10000000 = 0x41000000
DSCPU_LOAD(8, 7)
DSCPU_SHIFTLEFT(8, 12)
DSCPU_LOAD(9, 7)
DSCPU_SHIFTLEFT(9, 12)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 28)
DSCPU_SMLAXY(3, 8, 9, 10, 0, 0)
DSCPU_MRS_USER(13)
DSCPU_MRS_CLEARFLAGS()

-- 0x7000 * 0x7000 in low -> 0x31000000 + 0x70000000 = 0xA1000000
DSCPU_LOAD(8, 7)
DSCPU_SHIFTLEFT(8, 12)
DSCPU_LOAD(9, 7)
DSCPU_SHIFTLEFT(9, 12)
DSCPU_LOAD(10, 7)
DSCPU_SHIFTLEFT(10, 28)
DSCPU_SMLAXY(4, 8, 9, 10, 0, 0)
DSCPU_MRS_USER(14)
DSCPU_MRS_CLEARFLAGS()

-- test x/y without flags

-- 0x7FFF * 0x8000 in low/low -> 0xC0008000 + 0x4000 = 0xC000C000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 14)
DSCPU_SMLAXY(5, 8, 9, 10, 0, 0)

-- 0x7FFF * 0x8000 in low/high -> 0xC0008000 + 0x4000 = 0xC000C000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 31)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 14)
DSCPU_SMLAXY(6, 8, 9, 10, 0, 1)

-- 0x7FFF * 0x8000 in high/low -> 0xC0008000 + 0x4000 = 0xC000C000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_SHIFTLEFT(8, 16)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 15)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 14)
DSCPU_SMLAXY(7, 8, 9, 10, 1, 0)

-- 0x7FFF * 0x8000 in high/high -> 0xC0008000 + 0x4000 = 0xC000C000
DSCPU_LOAD(8, 1)
DSCPU_SHIFTLEFT(8, 15)
DSCPU_SUBI(8, 8, 1)
DSCPU_SHIFTLEFT(8, 16)
DSCPU_LOAD(9, 1)
DSCPU_SHIFTLEFT(9, 31)
DSCPU_LOAD(10, 1)
DSCPU_SHIFTLEFT(10, 14)
DSCPU_SMLAXY(8, 8, 9, 10, 1, 1)


-- write all data
for i = 1, 14 do
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

compare_dsbus_32bit(0xC000C000,  1 * 4)
compare_dsbus_32bit(0x0000001F, 11 * 4)

compare_dsbus_32bit(0x40008000,  2 * 4)
compare_dsbus_32bit(0x0800001F, 12 * 4)

compare_dsbus_32bit(0x41000000,  3 * 4)
compare_dsbus_32bit(0x0000001F, 13 * 4)

compare_dsbus_32bit(0xA1000000,  4 * 4)
compare_dsbus_32bit(0x0800001F, 14 * 4)

compare_dsbus_32bit(0xC000C000, 5 * 4)
compare_dsbus_32bit(0xC000C000, 6 * 4)
compare_dsbus_32bit(0xC000C000, 7 * 4)
compare_dsbus_32bit(0xC000C000, 8 * 4)


print (testerrorcount.." Errors found")

return (testerrorcount)



