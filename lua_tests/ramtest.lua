package.path = package.path .. ";./../lualib/?.lua"
require("vsim_comm")
require("luareg")

print ("Test")

testerrorcount = 0

wait_ns(1000)

-- fast initial test
for i = 0, 15 do
   reg_set_connection(i * 10, ddrram.Reg_Data, i) 
end
for i = 0, 15 do
   compare_reg(i * 10, ddrram.Reg_Data, i) 
end

-- test full range
stepwdith = 134217728 / 128
for i = 0, (134217728 - 1), stepwdith do
   reg_set_connection(i, ddrram.Reg_Data, i) 
end
for i = 0, (134217728 - 1), stepwdith do
   compare_reg(i, ddrram.Reg_Data, i) 
end

wait_ns(1000)

print (testerrorcount.." Errors found")

return (testerrorcount)