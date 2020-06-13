require("ds_lib")

testerrorcount = 0

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)

CONTROL_A = 0x240
CONTROL_B = 0x241
CONTROL_C = 0x242
CONTROL_D = 0x243
CONTROL_E = 0x244
CONTROL_F = 0x245
CONTROL_G = 0x246
CONTROL_H = 0x248
CONTROL_I = 0x249

function test_vram_access(setting_reg, MST, OFS, baseaddr)

   value = 0x80 -- enable
   value = value + MST
   value = value + OFS * 8

   write_dsbus_8bit(value, 0x04000000 + setting_reg)

   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   write_dsbus_32bit(0xDEADBEEF, baseaddr + 4)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xDEADBEEF, baseaddr + 4)
   
   write_dsbus_8bit(0, 0x04000000 + setting_reg)
   
end

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

-- all vram off
write_dsbus_32bit(0, 0x04000240)
write_dsbus_32bit(0, 0x04000244)
write_dsbus_32bit(0, 0x04000248)

--                VRAM     MST OFS
test_vram_access(CONTROL_A, 0, 0, 0x6800000)
test_vram_access(CONTROL_A, 1, 0, 0x6000000)
test_vram_access(CONTROL_A, 1, 1, 0x6020000)
test_vram_access(CONTROL_A, 1, 2, 0x6040000)
test_vram_access(CONTROL_A, 1, 3, 0x6060000)
test_vram_access(CONTROL_A, 2, 0, 0x6400000)
test_vram_access(CONTROL_A, 2, 1, 0x6420000)

test_vram_access(CONTROL_B, 0, 0, 0x6820000)
test_vram_access(CONTROL_B, 1, 0, 0x6000000)
test_vram_access(CONTROL_B, 1, 1, 0x6020000)
test_vram_access(CONTROL_B, 1, 2, 0x6040000)
test_vram_access(CONTROL_B, 1, 3, 0x6060000)
test_vram_access(CONTROL_B, 2, 0, 0x6400000)
test_vram_access(CONTROL_B, 2, 1, 0x6420000)

test_vram_access(CONTROL_C, 0, 0, 0x6840000)
test_vram_access(CONTROL_C, 1, 0, 0x6000000)
test_vram_access(CONTROL_C, 1, 1, 0x6020000)
test_vram_access(CONTROL_C, 1, 2, 0x6040000)
test_vram_access(CONTROL_C, 1, 3, 0x6060000)
test_vram_access(CONTROL_C, 4, 0, 0x6200000)

test_vram_access(CONTROL_D, 0, 0, 0x6860000)
test_vram_access(CONTROL_D, 1, 0, 0x6000000)
test_vram_access(CONTROL_D, 1, 1, 0x6020000)
test_vram_access(CONTROL_D, 1, 2, 0x6040000)
test_vram_access(CONTROL_D, 1, 3, 0x6060000)
test_vram_access(CONTROL_D, 4, 0, 0x6600000)

test_vram_access(CONTROL_E, 0, 0, 0x6880000)
test_vram_access(CONTROL_E, 1, 0, 0x6000000)
test_vram_access(CONTROL_E, 2, 0, 0x6400000)

test_vram_access(CONTROL_F, 0, 0, 0x6890000)
test_vram_access(CONTROL_F, 1, 0, 0x6000000)
test_vram_access(CONTROL_F, 1, 1, 0x6004000)
test_vram_access(CONTROL_F, 1, 2, 0x6010000)
test_vram_access(CONTROL_F, 1, 3, 0x6014000)
test_vram_access(CONTROL_F, 2, 0, 0x6400000)
test_vram_access(CONTROL_F, 2, 1, 0x6404000)
test_vram_access(CONTROL_F, 2, 2, 0x6410000)
test_vram_access(CONTROL_F, 2, 3, 0x6414000)

test_vram_access(CONTROL_G, 0, 0, 0x6894000)
test_vram_access(CONTROL_G, 1, 0, 0x6000000)
test_vram_access(CONTROL_G, 1, 1, 0x6004000)
test_vram_access(CONTROL_G, 1, 2, 0x6010000)
test_vram_access(CONTROL_G, 1, 3, 0x6014000)
test_vram_access(CONTROL_G, 2, 0, 0x6400000)
test_vram_access(CONTROL_G, 2, 1, 0x6404000)
test_vram_access(CONTROL_G, 2, 2, 0x6410000)
test_vram_access(CONTROL_G, 2, 3, 0x6414000)

test_vram_access(CONTROL_H, 0, 0, 0x6898000)
test_vram_access(CONTROL_H, 1, 0, 0x6200000)

test_vram_access(CONTROL_I, 0, 0, 0x68A0000)
test_vram_access(CONTROL_I, 1, 0, 0x6208000)
test_vram_access(CONTROL_I, 2, 0, 0x6600000)

print (testerrorcount.." Errors found")

return (testerrorcount)



