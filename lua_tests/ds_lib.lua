package.path = package.path .. ";./../lualib/?.lua"
package.path = package.path .. ";./../luatools/?.lua"
require("vsim_comm")
require("luareg")

function SplitFilename(strFilename)
   -- Returns the Path, Filename, and Extension as 3 values
   return string.match(strFilename, "(.-)([^\\]-([^\\%.]+))$")
end

function FindArray(array, pattern_in)

   pattern = {}

   for i = 1, #pattern_in do
      pattern[i] = string.sub(pattern_in, i, i)
   end

   local success = 0
   for i = 1, #array do
      if (array[i] == pattern[success + 1]) then
         success = success + 1
      else
         success = 0
      end
  
      if (#pattern == success) then
         return true
      end
   end
   
   return false
end

function writebytes(file,value)
   local b4=string.char(value % 256) value = ( value - value % 256)/256
   local b3=string.char(value % 256) value = ( value - value % 256)/256
   local b2=string.char(value % 256) value = ( value - value % 256)/256
   local b1=string.char(value % 256) value = ( value - value % 256)/256
   file:write(b4,b3,b2,b1)
end

function save_array_binary(arr, filename)

   local outfile=io.open(filename,"wb")
   for i = 0, #arr do            
      writebytes(outfile, arr[i])
   end
   io.close(outfile)

end

ds_savegame_path = ""
ds_loadsavegame = false

function load_rom(filename)
  
   -- load filecontent as binary
   local filecontent_char = {}

   local filecontent = {}
   local index = 0
   local input = io.open(filename, "rb")
   local dwordsum = 0
   local dwordpos = 0
   local byteindex = 0
   --while true do
   for i = 0, 0x200 do
      local byte = input:read(1)
      if not byte then 
            if (dwordpos > 0) then
               filecontent[index] = dwordsum
            end
         break 
      end
      filecontent_char[#filecontent_char + 1] = string.char(string.byte(byte))
      --dwordsum = dwordsum + (string.byte(byte) * (2^((3 - dwordpos) * 8)))  -- little endian
      dwordsum = dwordsum + (string.byte(byte) * (2^((dwordpos) * 8))) -- big endian
      dwordpos = dwordpos + 1
      byteindex = byteindex + 1
      if (dwordpos == 4) then
         filecontent[index] = dwordsum
         index = index + 1
         dwordpos = 0
         dwordsum = 0
      end
   end
   input:close()
   
   -- load firmware
   reg_set_file("lua_tests\\firmware.bin", ddrram.Softmap_DS_Firmware, 0, 0)
   
   --clean wram
   --wram_data = {}
   --for i = 0, 1048575 do
	--	wram_data[i] = 0;
	--end
   --save_array_binary(wram_data, "..\\wram_data_clean.bin")
   reg_set_file("wram_data_clean.bin", ddrram.Softmap_DS_WRAM, 0, 0)
   
   --clean saveram
   --saveram_data = {}
   --for i = 0, 1048575 do
	--	saveram_data[i] = 0xFFFFFFFF;
	--end
   --save_array_binary(saveram_data, "..\\saveram_clean.bin")
   reg_set_file("saveram_clean.bin", ddrram.Softmap_DS_SaveRam, 0, 0)

   print("Transmitting ROM: "..filename)
 
   reg_set_file(filename, ddrram.Softmap_DS_Gamerom, 0, 0)
  
   -- analyze rom
   ARM9_CODE_SRC  = filecontent[0x20 / 4] -- ARM9 rom_offset(4000h and up, align 1000h)
   ARM9_CODE_PC   = filecontent[0x24 / 4] -- ARM9 entry_address(2000000h..23BFE00h)
   ARM9_CODE_DST  = filecontent[0x28 / 4] -- ARM9 ram_address(2000000h..23BFE00h)
   ARM9_CODE_SIZE = filecontent[0x2C / 4] -- ARM9 size(max 3BFE00h) (3839.5KB)
   ARM7_CODE_SRC  = filecontent[0x30 / 4] -- ARM7 rom_offset(8000h and up)
   ARM7_CODE_PC   = filecontent[0x34 / 4] -- ARM7 entry_address(2000000h..23BFE00h, or 37F8000h..3807E00h)
   ARM7_CODE_DST  = filecontent[0x38 / 4] -- ARM7 ram_address(2000000h..23BFE00h, or 37F8000h..3807E00h)
   ARM7_CODE_SIZE = filecontent[0x3C / 4] -- ARM7 size(max 3BFE00h, or FE00h) (3839.5KB, 63.5KB)

   --if (ARM7_CODE_DST >= 0x03000000) then
   --   print("Setting wram small from bootloader not implemented, giving up!")
   --   return
   --end
   
   cardSize =  binary_and(filecontent[0x14 / 4], 0xFFFF);
	chipID = 0xC2;
	chipID = binary_or(chipID,((((128 * 2^cardSize) / 1024) - 1) * 2^8)); -- Chip size in megabytes minus 1 (07h = 8MB, 0Fh = 16MB, 1Fh = 32MB, 3Fh = 64MB, 7Fh = 128MB)

--   -- copy arm9 gamedata to wram
--   arm9_data = {}
--   for i = 0, ARM9_CODE_SIZE - 1, 4 do
--		arm9_data[i / 4] = filecontent[(ARM9_CODE_SRC + i) / 4];
--	end
--   save_array_binary(arm9_data, "..\\arm9_data.bin")
--   reg_set_file("arm9_data.bin", ddrram.Softmap_DS_WRAM, (ARM9_CODE_DST - 0x02000000) / 4, 0)
--   
--   -- copy arm7 gamedata to wram
--   arm7_data = {}
--   for i = 0, ARM7_CODE_SIZE - 1, 4 do
--		arm7_data[i / 4] = filecontent[(ARM7_CODE_SRC + i) / 4];
--	end
--   save_array_binary(arm7_data, "..\\arm7_data.bin")
--   reg_set_file("arm7_data.bin", ddrram.Softmap_DS_WRAM, (ARM7_CODE_DST - 0x02000000) / 4, 0)
   
   -- copy header
   headerblock = {}
   for i = 0, 0x170, 4 do
		headerblock[i / 4] = filecontent[i / 4];
   end
   reg_set_block(headerblock, ddrram.Softmap_DS_WRAM, 0x3FFE00 / 4)

   -- firmware user to memory
   reg_set_file("lua_tests\\firmware_user.bin", ddrram.Softmap_DS_WRAM, 0x3FFC80 / 4, 0)
   
   -- init further memory
	reg_set(0x1   , ddrram.Softmap_DS_WRAM, 0x3FFC40 / 4);
                                           
	reg_set(chipID, ddrram.Softmap_DS_WRAM, 0x3FF800 / 4);
	reg_set(chipID, ddrram.Softmap_DS_WRAM, 0x3FF804 / 4);
	reg_set(chipID, ddrram.Softmap_DS_WRAM, 0x3FFC00 / 4);
                                          
	reg_set(0x6ee6, ddrram.Softmap_DS_WRAM, 0x3FF808 / 4); -- header checksum crc16
   
   -- set entry point for both CPU
   reg_set(ARM9_CODE_PC, ds.Reg_DS_PC9Entry);
   reg_set(ARM7_CODE_PC, ds.Reg_DS_PC7Entry);
   
   reg_set(chipID, ds.Reg_DS_ChipID);
 
end


DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
--checkcommandnr = 0

function write_dsbus_32bit(data, address)

   reg_set_connection(data, DSBusWData)
   reg_set_connection(address + 0x40000000, DSBusAddr) 
   
end
function read_dsbus_32bit(address)

   reg_set_connection(address + 0x50000000, DSBusAddr)
   return reg_get(DSBusRData)
   
end
function compare_dsbus_32bit(comparevalue, address)

   reg_set_connection(address + 0x50000000, DSBusAddr)
   local value = reg_get(DSBusRData)
   comparevalue = conv_neg(comparevalue)
   --print(value.."#"..comparevalue)
   if (value == comparevalue) then
      print ("Address 0x"..string.format("%X", address).." = "..string.format("%X", value).." - OK")
   else
      testerrorcount = testerrorcount + 1
      print ("Address 0x"..string.format("%X", address).." = 0x"..string.format("%X", value).." | should be = 0x"..string.format("%X", comparevalue).." - ERROR")
   end
   
end

function write_dsbus_16bit(data, address)

   reg_set_connection(data, DSBusWData)
   reg_set_connection(address + 0x20000000, DSBusAddr) 
   
end
function read_dsbus_16bit(address)

   reg_set_connection(address + 0x30000000, DSBusAddr)
   return reg_get(DSBusRData)
   
end
function compare_dsbus_16bit(comparevalue, address)

   reg_set_connection(address + 0x30000000, DSBusAddr)
   local value = reg_get(DSBusRData)
   value = value % 0x10000
   if (value == comparevalue) then
      print ("Address 0x"..string.format("%X", address).." = "..string.format("%X", value).." - OK")
   else
      testerrorcount = testerrorcount + 1
      print ("Address 0x"..string.format("%X", address).." = 0x"..string.format("%X", value).." | should be = 0x"..string.format("%X", comparevalue).." - ERROR")
   end
   
end
function compare_dsbus_1632bit(comparevalue, address)

   reg_set_connection(address + 0x30000000, DSBusAddr)
   local value = reg_get(DSBusRData)
   if (value == comparevalue) then
      print ("Address 0x"..string.format("%X", address).." = "..string.format("%X", value).." - OK")
   else
      testerrorcount = testerrorcount + 1
      print ("Address 0x"..string.format("%X", address).." = 0x"..string.format("%X", value).." | should be = 0x"..string.format("%X", comparevalue).." - ERROR")
   end
   
end

function write_dsbus_8bit(data, address)

   reg_set_connection(data, DSBusWData)
   reg_set_connection(address + 0x00000000, DSBusAddr) 
   
end
function read_dsbus_8bit(address)

   reg_set_connection(address + 0x10000000, DSBusAddr)
   return reg_get(DSBusRData)
   
end
function compare_dsbus_8bit(comparevalue, address)

   reg_set_connection(address + 0x10000000, DSBusAddr)
   local value = reg_get(DSBusRData)
   value = value % 0x100
   if (value == comparevalue) then
      print ("Address 0x"..string.format("%X", address).." = "..value.." - OK")
   else
      testerrorcount = testerrorcount + 1
      print ("Address 0x"..string.format("%X", address).." = 0x"..string.format("%X", value).." | should be = 0x"..string.format("%X", comparevalue).." - ERROR")
      --print ("Address 0x"..string.format("%X", address).." = 0x"..string.format("%X", value).." | should be = 0x"..string.format("%X", comparevalue).." - ERROR".." - Check "..checkcommandnr)
      --os.exit()
   end
   --checkcommandnr = checkcommandnr + 1;
   
end