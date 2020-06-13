require("ds_lib")

function test_gamecard_romdma(isArm9)

   -- clear target mem
   write_dsbus_32bit(0, 0x02000000)
   write_dsbus_32bit(0, 0x02000004)

   -- set up dma
   write_dsbus_32bit(0x04100010, 0x040000B0)
   write_dsbus_32bit(0x02000000, 0x040000B4)
   
   settings = 1 -- cnt
   settings = settings + 0 * 2^21 -- Dest_Addr_Control
   settings = settings + 2 * 2^23 -- Source_Adr_Control
   settings = settings + 1 * 2^26 -- DW_Transfer
   if (isArm9) then
      settings = settings + 5 * 2^27 -- start timing
   else
      settings = settings + 2 * 2^28 -- start timing
   end
   settings = settings + 1 * 2^31 -- enable
   write_dsbus_32bit(settings, 0x040000B8)
   
   -- set up gamecard
   write_dsbus_32bit(0x000100B7, 0x040001A8) -- Gamecard_bus_Command_1
   write_dsbus_32bit(0x00000000, 0x040001AC) -- Gamecard_bus_Command_2
   write_dsbus_32bit(0x80000000, 0x040001A4) -- ROMCTRL
   
   wait_ns(100000)

   compare_dsbus_32bit(0x1afffffc, 0x02000000)
   compare_dsbus_32bit(0xe1a01033, 0x02000004)

end

testerrorcount = 0

wait_ns(10000)

-- reset
reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_enablecpu)
-- load game
load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\touch.srl")
reg_set(1, ds.Reg_DS_on) 
reg_set(0, ds.Reg_DS_on)

wait_ns(10000)

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

test_gamecard_romdma(false)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

test_gamecard_romdma(true)

print (testerrorcount.." Errors found")

return (testerrorcount)



