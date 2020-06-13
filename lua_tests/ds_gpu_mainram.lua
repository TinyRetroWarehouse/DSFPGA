require("ds_lib")

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_on)

-- 200/100 vertical
reg_set(384, gpu.Reg_Framebuffer_PosX )
reg_set( 60, gpu.Reg_Framebuffer_PosY )
reg_set(256, gpu.Reg_Framebuffer_SizeX)
reg_set(192, gpu.Reg_Framebuffer_SizeY)
reg_set(2  , gpu.Reg_Framebuffer_Scale)
reg_set(0  , gpu.Reg_Framebuffer_LCD)

reg_set(512, gpu.Reg_Framebuffer2_PosX )
reg_set(450, gpu.Reg_Framebuffer2_PosY )
reg_set(256, gpu.Reg_Framebuffer2_SizeX)
reg_set(192, gpu.Reg_Framebuffer2_SizeY)
reg_set(1  , gpu.Reg_Framebuffer2_Scale)
reg_set(0  , gpu.Reg_Framebuffer2_LCD)

DMA_0 = 0xB0

function dma_copy(dma_offset, SAD, DAD, CNT, Dest_Addr_Control, Source_Adr_Control, DW_Transfer, starttiming, repeatdma)

   write_dsbus_32bit(SAD, 0x04000000 + dma_offset)
   write_dsbus_32bit(DAD, 0x04000004 + dma_offset)
   
   settings = CNT
   settings = settings + Dest_Addr_Control  * 2^21
   settings = settings + Source_Adr_Control * 2^23
   settings = settings + repeatdma          * 2^25
   settings = settings + DW_Transfer        * 2^26
   settings = settings + starttiming        * 2^27
   settings = settings + 2^31 -- enable
   
   write_dsbus_32bit(settings, 0x04000008 + dma_offset)
   
   wait_ns(CNT * 100)
   
end

wram_data = {}
pixelindex = 0
for y = 0, 192 do
   for x = 0, 255 do
      color_red   = x % 32
      color_green = y % 32
      color_blue  = (x + y) % 32
      color = color_blue + color_green * 32 + color_red * 1024
      if (x % 2 == 0) then
         fullcolor = color
      else
         fullcolor = fullcolor + color * 0x10000
         wram_data[pixelindex] = fullcolor
         pixelindex = pixelindex + 1
      end
   end
end
save_array_binary(wram_data, "..\\wram_data_mainramgpu.bin")
reg_set_file("wram_data_mainramgpu.bin", ddrram.Softmap_DS_WRAM, 0, 0)

write_dsbus_32bit(0x00030000, 0x04000000) -- displaymode 3

--       dma_offset   SAD,          DAD,     CNT, Dest_CTRL, Src_CTRL, DW_Transfer starttiming repeatdma
dma_copy(     DMA_0, 0x02000000, 0x04000068,   1,      2,        0,         1,           4,          1)

reg_set(1, ds.Reg_DS_freerunclock)

wait_ns(17000000)