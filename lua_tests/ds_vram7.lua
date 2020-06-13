require("ds_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)

CONTROL_C = 0x242
CONTROL_D = 0x243

function test_vram_access(setting_reg, MST, OFS, baseaddr)

   value = 0x80 -- enable
   value = value + MST
   value = value + OFS * 8

   write_dsbus_8bit(value, 0x04000000 + setting_reg)
   
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   write_dsbus_32bit(0xDEADBEEF, baseaddr + 4)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xDEADBEEF, baseaddr + 4)
DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
   
   write_dsbus_8bit(0, 0x04000000 + setting_reg)
   
end

-- all vram off
write_dsbus_32bit(0, 0x04000240)
write_dsbus_32bit(0, 0x04000244)
write_dsbus_32bit(0, 0x04000248)

--                VRAM     MST OFS
test_vram_access(CONTROL_C, 2, 0, 0x6000000)
test_vram_access(CONTROL_C, 2, 1, 0x6020000)

test_vram_access(CONTROL_D, 2, 0, 0x6000000)
test_vram_access(CONTROL_D, 2, 1, 0x6020000)

print (testerrorcount.." Errors found")

return (testerrorcount)



