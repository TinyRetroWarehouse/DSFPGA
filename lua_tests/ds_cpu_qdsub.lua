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
-- program: various qadd with and without saturation, result in 1-4, check q bit in 11-14
DSCPU_LOAD(0, 0)     -- base address for writeback

-- qsub 0x00000000 - 2 * 0x30000000 - 2 * 0x30000000 -> must saturate to 0x80000000
DSCPU_LOAD(1, 0)
DSCPU_LOAD(2, 3)
DSCPU_SHIFTLEFT(2, 28)
DSCPU_QDSUB(1, 1, 2)
DSCPU_QDSUB(1, 1, 2)
DSCPU_MRS_USER(11)
DSCPU_MRS_CLEARFLAGS()

-- qsub 0x00000000 - 2 * 0x20000000 - 2 * 0x20000000 -> 0x80000000 without saturate
DSCPU_LOAD(2, 0)
DSCPU_LOAD(3, 1)
DSCPU_SHIFTLEFT(3, 29)
DSCPU_QDSUB(2, 2, 3)
DSCPU_QDSUB(2, 2, 3)
DSCPU_MRS_USER(12)
DSCPU_MRS_CLEARFLAGS()

-- qsub 0x00000000 - 2 * 0xE0000000 -> 0x40000000 without saturate
DSCPU_LOAD(3, 0)
DSCPU_LOAD(4, 7)
DSCPU_SHIFTLEFT(4, 29)
DSCPU_QDSUB(3, 3, 4)
DSCPU_MRS_USER(13)
DSCPU_MRS_CLEARFLAGS()

-- qsub 0x00000000 - 2 * 0xC0000000 -> must saturate to 0x7FFFFFFF
DSCPU_LOAD(4, 0)
DSCPU_LOAD(5, 3)
DSCPU_SHIFTLEFT(5, 30)
DSCPU_QDSUB(4, 4, 5)
DSCPU_MRS_USER(14)
DSCPU_MRS_CLEARFLAGS()


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
wait_ns(10000)
reg_set(0, ds.Reg_DS_on)

compare_dsbus_32bit(0x80000000,  1 * 4)
compare_dsbus_32bit(0x0800001F, 11 * 4)

compare_dsbus_32bit(0x80000000,  2 * 4)
compare_dsbus_32bit(0x0000001F, 12 * 4)

compare_dsbus_32bit(0x40000000,  3 * 4)
compare_dsbus_32bit(0x0000001F, 13 * 4)

compare_dsbus_32bit(0x7FFFFFFF,  4 * 4)
compare_dsbus_32bit(0x0800001F, 14 * 4)

print (testerrorcount.." Errors found")

return (testerrorcount)



