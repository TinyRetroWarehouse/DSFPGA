require("ds_lib")

testerrorcount = 0

wait_ns(10000)

DIVIDEMODE_32_32 = 0
DIVIDEMODE_64_32 = 0
DIVIDEMODE_64_64 = 0

function DS_Divide(first, second, mode)

   write_dsbus_16bit(mode, 0x04000280) -- settings
   
   result_correct = first / second
   if (result_correct >= 0) then
      result_correct = math.floor(result_correct)
   else
      result_correct = math.ceil(result_correct)
   end
   remain_correct = first - (result_correct * second)
   
   print("Calculating ",first, "/", second, "=", result_correct, "Remain", remain_correct)
   
   firstlow  = tonumber("0x"..string.format("%X", first))
   firsthigh = math.floor(first / 0x100000000)
   if (first < 0 and firsthigh == 0) then firsthigh = 0xFFFFFFFF end
   
   secondlow  = tonumber("0x"..string.format("%X", second))
   secondhigh = math.floor(second / 0x100000000)
   if (second < 0 and secondhigh == 0) then secondhigh = 0xFFFFFFFF end
   
   print("with "..firsthigh.." "..firstlow.." / "..secondhigh.." "..secondlow)
   print("with 0x"..string.format("%X", firsthigh).." "..string.format("%X", firstlow).." / 0x"..string.format("%X", secondhigh).." "..string.format("%X", secondlow))
   
   write_dsbus_32bit(firstlow, 0x04000290)   -- numer low
   write_dsbus_32bit(firsthigh, 0x04000294)  -- numer high
   write_dsbus_32bit(secondlow, 0x04000298)  -- denom low
   write_dsbus_32bit(secondhigh, 0x0400029C) -- denom high
   
   resultlow  = tonumber("0x"..string.format("%X", result_correct))
   resulthigh = math.floor(result_correct / 0x100000000)
   if (result_correct < 0 and resulthigh == 0) then resulthigh = 0xFFFFFFFF end
   
   remainlow  = tonumber("0x"..string.format("%X", remain_correct))
   remainhigh = math.floor(remain_correct / 0x100000000)
   if (remain_correct < 0 and remainhigh == 0) then remainhigh = 0xFFFFFFFF end
   
   compare_dsbus_32bit(resultlow, 0x040002A0) -- result low
   compare_dsbus_32bit(resulthigh, 0x040002A4) -- result high
   
   compare_dsbus_32bit(remainlow, 0x040002A8) -- remain low
   compare_dsbus_32bit(remainhigh, 0x040002AC) -- result high
   
end

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

reg_set(0, ds.Reg_DS_enablecpu)
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)

wait_ns(10000)

print("divide by zero set")
DS_Divide(9, 4, 0)
write_dsbus_32bit(0, 0x04000298)  -- denom low
write_dsbus_32bit(0, 0x0400029C) -- denom high
compare_dsbus_16bit(0x4000, 0x04000280)

print("small numbers with all modes")
print("32/32")
DS_Divide(9, 4, 0)
DS_Divide(9, -4, 0)
DS_Divide(-9, 4, 0)
DS_Divide(-9, -4, 0)

print("64/32")
DS_Divide(9, 4, 1)
DS_Divide(9, -4, 1)
DS_Divide(-9, 4, 1)
DS_Divide(-9, -4, 1)

print("64/64")
DS_Divide(9, 4, 2)
DS_Divide(9, -4, 2)
DS_Divide(-9, 4, 2)
DS_Divide(-9, -4, 2)

print("large numer with all mode 1+2")
print("64/32")
DS_Divide(16000000001, 4, 1)
DS_Divide(16000000001, -4, 1)
DS_Divide(-16000000001, 4, 1)
DS_Divide(-16000000001, -4, 1)

DS_Divide(16000000001, 4, 2)
DS_Divide(16000000001, -4, 2)
DS_Divide(-16000000001, 4, 2)
DS_Divide(-16000000001, -4, 2)

print("large numer and denom with mode 2")
print("64/32")
DS_Divide(16000000001, 8000000000, 2)
DS_Divide(16000000001, -8000000000, 2)
DS_Divide(-16000000001, 8000000000, 2)
DS_Divide(-16000000001, -8000000000, 2)

reg_set(0, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_on)
wait_ns(1000)

print (testerrorcount.." Errors found")

return (testerrorcount)



