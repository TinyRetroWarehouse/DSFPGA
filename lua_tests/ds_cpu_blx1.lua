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

thumbmul_0_1 = 0x4000
thumbmul_0_1 = thumbmul_0_1 + 0xD * (2^6) -- opcode mul
thumbmul_0_1 = thumbmul_0_1 + 1 * (2^3) -- source2
thumbmul_0_1 = thumbmul_0_1 + 0 -- source1/dest

thumbmul_ret = 0x4740 -- opcode hi register operations/branch exchange
thumbmul_ret = thumbmul_ret + 6 * (2^3) -- Register 14

for h_bit = 0, 1 do
   DSCPU_clear_instructions()
   -- program: load number then branch to thumbroutine with various mul*2, where only 1 should be executed, then return, then write to memory
   DSCPU_LOAD(0, 21)
   DSCPU_LOAD(1, 2)
   DSCPU_LOAD(2, 0)
   
   DSCPU_BLX1(0x100, h_bit)
   
   DSCPU_WRITE_DATA32(0, 2, 0)
   
   DSCPU_self_loop()
   -- endprogram0
   DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)
   
   for i = 0xD0, 0x120 do
      write_dsbus_16bit(thumbmul_0_1, 0x02000000 + i)
   end
   write_dsbus_16bit(thumbmul_ret, 0x02000000 + 0x102 + h_bit * 2)
   
   -- test
   write_dsbus_32bit(10, 0x00000000)
   
   reg_set(1, ds.Reg_DS_on)
   wait_ns(10000)
   reg_set(0, ds.Reg_DS_on)
   
   compare_dsbus_32bit(42, 0x00000000)
end


print (testerrorcount.." Errors found")

return (testerrorcount)



