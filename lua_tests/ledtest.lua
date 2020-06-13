package.path = package.path .. ";./../lualib/?.lua"
require("vsim_comm")
require("luareg")

print ("Test")

testerrorcount = 0

wait_ns(1000)

reg_set_connection(0xAA, external.Reg_LED) 
wait_ns(1000)
compare_reg(0xAA, external.Reg_LED) 
wait_ns(1000)

reg_set_connection(0x12345678, test.Reg_Testreg) 
wait_ns(1000)
compare_reg(0x12345678, test.Reg_Testreg) 
wait_ns(1000)

print (testerrorcount.." Errors found")

return (testerrorcount)