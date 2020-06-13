local total_errors = 0
local single_error = 0

testlist = {}
errorlist = {}

testlist[#testlist + 1] = "ds_sqrt.lua"
testlist[#testlist + 1] = "ds_divider.lua"
testlist[#testlist + 1] = "ds_IPCSync.lua"
testlist[#testlist + 1] = "ds_IPCFifo.lua"
testlist[#testlist + 1] = "ds_dma.lua"
testlist[#testlist + 1] = "ds_vram9.lua"
testlist[#testlist + 1] = "ds_vram7.lua"
testlist[#testlist + 1] = "ds_spi_powerman.lua"
testlist[#testlist + 1] = "ds_spi_touchscreen.lua"
testlist[#testlist + 1] = "ds_spi_firmware.lua"
testlist[#testlist + 1] = "ds_joypad.lua"
testlist[#testlist + 1] = "ds_irq9halt.lua"
testlist[#testlist + 1] = "ds_irq7halt.lua"
testlist[#testlist + 1] = "ds_gamecard_chipID.lua"
testlist[#testlist + 1] = "ds_gamecard_romdata.lua"
testlist[#testlist + 1] = "ds_gamecard_romdma.lua"
testlist[#testlist + 1] = "ds_gamecard_saveram.lua"
testlist[#testlist + 1] = "ds_buswidth.lua"

testlist[#testlist + 1] = "ds_cpu_add.lua"
testlist[#testlist + 1] = "ds_cpu_blx1.lua"
testlist[#testlist + 1] = "ds_cpu_blx2.lua"
testlist[#testlist + 1] = "ds_cpu_blx1thumb.lua"
testlist[#testlist + 1] = "ds_cpu_blx2thumb.lua"
testlist[#testlist + 1] = "ds_cpu_clz.lua"
testlist[#testlist + 1] = "ds_cpu_qadd.lua"
testlist[#testlist + 1] = "ds_cpu_qdadd.lua"
testlist[#testlist + 1] = "ds_cpu_qsub.lua"
testlist[#testlist + 1] = "ds_cpu_qdsub.lua"
testlist[#testlist + 1] = "ds_cpu_smulxy.lua"
testlist[#testlist + 1] = "ds_cpu_smulwy.lua"
testlist[#testlist + 1] = "ds_cpu_smlaxy.lua"
testlist[#testlist + 1] = "ds_cpu_smlawy.lua"
testlist[#testlist + 1] = "ds_cpu_smlalxy.lua"
testlist[#testlist + 1] = "ds_cpu_ldrd.lua"
testlist[#testlist + 1] = "ds_cpu_strd.lua"

for i = 1, #testlist do
   print("Now Testing", testlist[i])
   single_error = dofile(testlist[i])
   errorlist[i] = single_error;
   total_errors = total_errors + single_error
end

print("###########################################")
print("####          Summary               #######")
print("###########################################")

for i = 1, #testlist do
   print(testlist[i].." - "..errorlist[i].." errors")
end
   
print("###########################################")
   
print ("Total errors = "..total_errors)