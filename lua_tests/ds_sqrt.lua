require("ds_lib")

-- fails with luajit!

testerrorcount = 0

wait_ns(10000)

DIVIDEMODE_32_32 = 0
DIVIDEMODE_64_32 = 0
DIVIDEMODE_64_64 = 0

function DS_SQRT(first, mode)

   write_dsbus_16bit(mode, 0x040002B0) -- settings
   
   result_correct = math.floor(math.sqrt(first))
   
   print("Calculating sqrt from ",first, "=", result_correct)
   
   firstlow  = tonumber("0x"..string.format("%X", first))
   firsthigh = math.floor(first / 0x100000000)
   if (first < 0 and firsthigh == 0) then firsthigh = 0xFFFFFFFF end
   
   print("with "..firsthigh.." "..firstlow)
   print("with 0x"..string.format("%X", firsthigh).." "..string.format("%X", firstlow))
   
   write_dsbus_32bit(firstlow, 0x040002B8)   -- param low
   write_dsbus_32bit(firsthigh, 0x040002BC)  -- param high
   
   compare_dsbus_32bit(result_correct, 0x040002B4) -- result
   
end

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

reg_set(0, ds.Reg_DS_enablecpu)
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)

wait_ns(10000)

print("small numbers with all modes")
testvalue = 3
for i = 0, 30 do
   DS_SQRT(testvalue, 0)
   DS_SQRT(testvalue, 1)
   testvalue = testvalue * 2
end

print("large numbers with mode 1")
testvalue = 6442450944
for i = 0, 31 do
   DS_SQRT(testvalue, 1)
   testvalue = testvalue * 2
end

-- not testing uppermost bit much, as lua sqrt is using double so not accurate
math.randomseed(0) 
print("random numbers with mode 1")
DS_SQRT(math.random(0x7FFFFFFF) * 0x100000000 + math.random(0x7FFFFFFF), 1)

for i = 0, 30 do
   DS_SQRT(math.random(0x7FFFFF) * 0x100000000 + math.random(0x7FFFFFFF), 1)
end

print (testerrorcount.." Errors found")

return (testerrorcount)



