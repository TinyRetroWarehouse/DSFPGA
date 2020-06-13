require("ds_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)

DMA_0 = 0xB0
DMA_1 = 0xBC
DMA_2 = 0xC8
DMA_3 = 0xD4

function dma_copy(dma_offset, SAD, DAD, CNT, Dest_Addr_Control, Source_Adr_Control, DW_Transfer)

   write_dsbus_32bit(SAD, 0x04000000 + dma_offset)
   write_dsbus_32bit(DAD, 0x04000004 + dma_offset)
   
   settings = CNT
   settings = settings + Dest_Addr_Control  * 2^21
   settings = settings + Source_Adr_Control * 2^23
   settings = settings + DW_Transfer        * 2^26
   settings = settings + 2^31 -- enable
   
   write_dsbus_32bit(settings, 0x04000008 + dma_offset)
   
   wait_ns(CNT * 100)
   
end

function simple_test_dma(testname, dma_offset)

   print(testname)
   for i = 0, 3 do
      reg_set_connection(0, ddrram.Reg_Data, i) 
   end
   write_dsbus_32bit(0xDEADBEEF, 0x02000000)
   compare_reg(0xDEADBEEF, ddrram.Reg_Data, 0) 
   --       dma_offset   SAD,        DAD,   CNT, Dest_CTRL, Src_CTRL, DW_Transfer
   dma_copy(dma_offset, 0x02000000, 0x02000004, 3,      0,        0,         1)
   compare_reg(0xDEADBEEF, ddrram.Reg_Data, 1) 
   compare_reg(0xDEADBEEF, ddrram.Reg_Data, 2) 
   compare_reg(0xDEADBEEF, ddrram.Reg_Data, 3) 

end

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

simple_test_dma("DMA 9 0", DMA_0)
simple_test_dma("DMA 9 1", DMA_1)
simple_test_dma("DMA 9 2", DMA_2)
simple_test_dma("DMA 9 3", DMA_3)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

simple_test_dma("DMA 7 0", DMA_0)
simple_test_dma("DMA 7 1", DMA_1)
simple_test_dma("DMA 7 2", DMA_2)
simple_test_dma("DMA 7 3", DMA_3)

reg_set(0, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_on)

print (testerrorcount.." Errors found")

return (testerrorcount)



