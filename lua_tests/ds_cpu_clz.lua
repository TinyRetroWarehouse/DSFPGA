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

for i = 0, 32 do
   DSCPU_clear_instructions()
   -- program: load number and count leading zero in it, then write to memory
   if (i == 32) then
      DSCPU_LOAD(0, 0)
   else
      DSCPU_LOAD(0, 1)
      DSCPU_SHIFTLEFT(0, (31 - i))
   end
      
   DSCPU_LOAD(1, 50)
   DSCPU_CLZ(1, 0)
   
   DSCPU_WRITE_DATA32(1, 2, 0)
   
   DSCPU_self_loop()
   -- endprogram
   DSCPU_transmit(true, DSCPU_INSTR_LIST, 0)
   
   -- test
   write_dsbus_32bit(10, 0x00000000)
   
   reg_set(1, ds.Reg_DS_on)
   wait_ns(10000)
   reg_set(0, ds.Reg_DS_on)
   
   compare_dsbus_32bit(i, 0x00000000)
end   


print (testerrorcount.." Errors found")

return (testerrorcount)



