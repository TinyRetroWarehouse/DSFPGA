require("ds_lib")

testerrorcount = 0

wait_ns(10000)


function test_different_rw_accesses(baseaddr, do_8bit)

   print("#### Now testing address: 0x"..string.format("%X", baseaddr))

   print("32 bit write")
   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   
   print("32 bit write, addr + x") -- -> dont rotate writedata with write addr not aligned ?
   write_dsbus_32bit(0xBADEAFFE, baseaddr + 1)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   write_dsbus_32bit(0xBADEAFFE, baseaddr + 2)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   write_dsbus_32bit(0xBADEAFFE, baseaddr + 3)
   compare_dsbus_32bit(0xBADEAFFE, baseaddr)
   
   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xFEBADEAF, baseaddr + 1)
   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xAFFEBADE, baseaddr + 2)
   write_dsbus_32bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0xDEAFFEBA, baseaddr + 3)
   
   print("16 bit")
   -- 16 bit write, first word
   write_dsbus_32bit(0, baseaddr)
   compare_dsbus_32bit(0, baseaddr)
   write_dsbus_16bit(0xBADEAFFE, baseaddr)
   compare_dsbus_32bit(0x0000AFFE, baseaddr)
   
   -- 16 bit write, second word
   write_dsbus_32bit(0, baseaddr)
   compare_dsbus_32bit(0, baseaddr)
   write_dsbus_16bit(0xAFFEBADE, baseaddr + 2)
   compare_dsbus_32bit(0xBADE0000, baseaddr)
   
   -- 16 bit write, addr + x -> dont rotate writedata with write addr not aligned ?
   write_dsbus_32bit(0, baseaddr)
   compare_dsbus_32bit(0, baseaddr)
   
   write_dsbus_16bit(0xAFFE, baseaddr + 1)
   compare_dsbus_16bit(0xAFFE, baseaddr)
   
   write_dsbus_16bit(0xAFFE, baseaddr)
   compare_dsbus_16bit(0x00AF, baseaddr + 1)
   compare_dsbus_32bit(0xFE0000AF, baseaddr + 1)
   
   if (do_8bit) then
      print("8 Bit")
      -- 8 bit write, first byte
      write_dsbus_32bit(0, baseaddr)
      compare_dsbus_32bit(0, baseaddr)
      write_dsbus_8bit(0xBADEAFFE, baseaddr)
      compare_dsbus_32bit(0x000000FE, baseaddr)
      
      -- 8 bit write, second byte
      write_dsbus_32bit(0, baseaddr)
      compare_dsbus_32bit(0, baseaddr)
      write_dsbus_8bit(0xFEBADEAF, baseaddr + 1)
      compare_dsbus_32bit(0x0000AF00, baseaddr)
      
      -- 8 bit write, third byte
      write_dsbus_32bit(0, baseaddr)
      compare_dsbus_32bit(0, baseaddr)
      write_dsbus_8bit(0xAFFEBADE, baseaddr + 2)
      compare_dsbus_32bit(0x00DE0000, baseaddr)
      
      -- 8 bit write, fourth byte
      write_dsbus_32bit(0, baseaddr)
      compare_dsbus_32bit(0, baseaddr)
      write_dsbus_8bit(0xDEAFFEBA, baseaddr + 3)
      compare_dsbus_32bit(0xBA000000, baseaddr)
   end
   
   print("testing 32/16/8bit alignment")
   write_dsbus_32bit(0xDEADBEEF, baseaddr)
   write_dsbus_32bit(0x12345678, baseaddr + 4)
   
   compare_dsbus_32bit(0xDEADBEEF, baseaddr)
   compare_dsbus_1632bit(0x0000BEEF, baseaddr)
   compare_dsbus_8bit(0xEF, baseaddr)
   
   compare_dsbus_32bit(0xEFDEADBE, baseaddr + 1)
   compare_dsbus_1632bit(0xEF0000BE, baseaddr + 1)
   compare_dsbus_8bit(0xBE, baseaddr + 1)
   
   compare_dsbus_32bit(0xBEEFDEAD, baseaddr + 2)
   compare_dsbus_1632bit(0x0000DEAD, baseaddr + 2)
   compare_dsbus_8bit(0xAD, baseaddr + 2)
   
   compare_dsbus_32bit(0xADBEEFDE, baseaddr + 3)
   compare_dsbus_1632bit(0xAD0000DE, baseaddr + 3)
   compare_dsbus_8bit(0xDE, baseaddr + 3)
   
end

function test_wram_small_9(muxsetting, mirroring, dead)

   print ("Test ARM9 WramSmall with Mux "..muxsetting)
   write_dsbus_8bit(muxsetting, 0x04000247)
   compare_dsbus_8bit(muxsetting, 0x04000247)
   
   if (dead) then
      write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
      compare_dsbus_32bit(0, 0x03000000)
   else
   
      test_different_rw_accesses(0x03000000, true)

      if (mirroring) then
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         write_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03000000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         compare_dsbus_32bit(0xAAAAAAAA, 0x03004000)
      else
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         write_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         compare_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03004000)
      end

   end
end

function test_wram_small_7(muxsetting, mirroring, use_64k)

   print ("Test ARM7 WramSmall with Mux "..muxsetting)

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr
   write_dsbus_8bit(muxsetting, 0x04000247)
DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr
   
   compare_dsbus_8bit(muxsetting, 0x04000241)
   
   test_different_rw_accesses(0x03000000, true)
   
   if (use_64k) then
      write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
      write_dsbus_32bit(0xBBBBBBBB, 0x03800000)
      compare_dsbus_32bit(0xBBBBBBBB, 0x03000000)
      compare_dsbus_32bit(0xBBBBBBBB, 0x03800000)
      write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
      compare_dsbus_32bit(0xAAAAAAAA, 0x03800000)
   else

      if (mirroring) then
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         write_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03000000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         compare_dsbus_32bit(0xAAAAAAAA, 0x03004000)
      else
         write_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         write_dsbus_32bit(0xBBBBBBBB, 0x03004000)
         compare_dsbus_32bit(0xAAAAAAAA, 0x03000000)
         compare_dsbus_32bit(0xBBBBBBBB, 0x03004000)
      end

   end
end

reg_set(0, ds.Reg_DS_PC9Entry);
reg_set(0, ds.Reg_DS_PC7Entry);

reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on) -- must reset to dtcm region is set to address zero
reg_set(0, ds.Reg_DS_on)

print ("########################")
print ("Test ARM9 access")
print ("########################")

DSBusWData = ds.Reg_DS_Bus9WriteData
DSBusRData = ds.Reg_DS_Bus9ReadData
DSBusAddr  = ds.Reg_DS_Bus9Addr

--compare_dsbus_32bit(0xEA000042, 0xFF000000) -- upper 4 bit not available

test_different_rw_accesses(0x00000000, true) -- dtcm
test_different_rw_accesses(0x01000000, true) -- itcm
test_different_rw_accesses(0x02000000, true)
test_different_rw_accesses(0x04000210, true)

test_wram_small_9(0, false, false)
test_wram_small_9(1, true, false)
test_wram_small_9(2, true, false)
test_wram_small_9(3, false, true)

test_different_rw_accesses(0x05000000, false) -- palette bg  A
test_different_rw_accesses(0x050003FC, false) -- palette oam A
test_different_rw_accesses(0x05000400, false) -- palette bg  B
test_different_rw_accesses(0x050007FC, false) -- palette oam B

print("testing 8 bit writes for palette -> should write 8 bit to 15..8 and 7..0")
write_dsbus_32bit(0, 0x05000000)
compare_dsbus_32bit(0, 0x05000000)
write_dsbus_8bit(0xBADEAFFE, 0x05000000)
compare_dsbus_32bit(0x0000FEFE, 0x05000000)
write_dsbus_32bit(0, 0x05000000)
compare_dsbus_32bit(0, 0x05000000)
write_dsbus_8bit(0xBADEAFFE, 0x05000002)
compare_dsbus_32bit(0xFEFE0000, 0x05000000)

write_dsbus_8bit(0x80, 0x04000240) -- activate vram A for cpu 9
write_dsbus_8bit(0x82, 0x04000242) -- activate vram C for cpu 7
test_different_rw_accesses(0x06800000, false)

print("testing 8 bit writes for vram -> does not write at all")
write_dsbus_32bit(0xBADEAFFE, 0x06800000)
compare_dsbus_32bit(0xBADEAFFE, 0x06800000)
write_dsbus_8bit(0x55555555, 0x06800000)
compare_dsbus_32bit(0xBADEAFFE, 0x06800000)

test_different_rw_accesses(0x070003FC, false)
test_different_rw_accesses(0x070007FC, false)

print("testing 8 bit writes for oam -> does not write at all")
write_dsbus_32bit(0xBADEAFFE, 0x07000000)
compare_dsbus_32bit(0xBADEAFFE, 0x07000000)
write_dsbus_8bit(0x55555555, 0x07000000)
compare_dsbus_32bit(0xBADEAFFE, 0x07000000)

--print("testing halfmapped gbregs")
--write_dsbus_32bit(0x00000000, 0x04000130) -- keypad
--compare_dsbus_32bit(0x000003FF, 0x04000130)
--
--write_dsbus_32bit(0x00000000, 0x04000060) -- sound 0
--compare_dsbus_32bit(0x00000000, 0x04000060)

print ("########################")
print ("Test ARM7 access")
print ("########################")

DSBusWData = ds.Reg_DS_Bus7WriteData
DSBusRData = ds.Reg_DS_Bus7ReadData
DSBusAddr  = ds.Reg_DS_Bus7Addr

compare_dsbus_32bit(0xEA000006, 0x00000000)

test_different_rw_accesses(0x02000000, true)
test_different_rw_accesses(0x04000210, true)

test_wram_small_7(0, false, true)
test_wram_small_7(1, true,  false)
test_wram_small_7(2, true,  false)
test_wram_small_7(3, false, false)

test_different_rw_accesses(0x06000000, true)

compare_dsbus_32bit(0x00000000, 0x07000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x08000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x09000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0A000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0B000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0C000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0D000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0E000000)
compare_dsbus_32bit(0xFFFFFFFF, 0x0F000000)

print (testerrorcount.." Errors found")

return (testerrorcount)



