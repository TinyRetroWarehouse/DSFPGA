require("ds_lib")

function test_gamecard_chipID()

   write_dsbus_32bit(0x000000B8, 0x040001A8) -- Gamecard_bus_Command_1
   write_dsbus_32bit(0x00000000, 0x040001AC) -- Gamecard_bus_Command_2
   write_dsbus_32bit(0x80000000, 0x040001A4) -- ROMCTRL

   compare_dsbus_32bit(0x0000ffc2, 0x04100010)

end

testerrorcount = 0

wait_ns(10000)

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)
-- load game
load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\touch.srl")
reg_set(1, ds.Reg_DS_on) 
reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

test_gamecard_chipID()

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

test_gamecard_chipID()

print (testerrorcount.." Errors found")

return (testerrorcount)



