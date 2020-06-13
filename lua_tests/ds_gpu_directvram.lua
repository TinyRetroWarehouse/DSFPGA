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


CONTROL_A = 0x240
CONTROL_B = 0x241
CONTROL_C = 0x242
CONTROL_D = 0x243
CONTROL_E = 0x244
CONTROL_F = 0x245
CONTROL_G = 0x246
CONTROL_H = 0x248
CONTROL_I = 0x249

function set_vram_access(setting_reg, MST, OFS)

   value = 0x80 -- enable
   value = value + MST
   value = value + OFS * 8

   write_dsbus_8bit(value, 0x04000000 + setting_reg)
   
end

-- all vram off
write_dsbus_32bit(0, 0x04000240)
write_dsbus_32bit(0, 0x04000244)
write_dsbus_32bit(0, 0x04000248)

--                VRAM    MST OFS
set_vram_access(CONTROL_A, 0, 0)
set_vram_access(CONTROL_B, 0, 0)
set_vram_access(CONTROL_C, 0, 0)
set_vram_access(CONTROL_D, 0, 0)

write_dsbus_32bit(0x00060000, 0x04000000) -- displaymode 2, block 1

-- white dots grid
for y = 0, 191, 16 do
   for x = 0, 255, 16 do
      write_dsbus_16bit(0x7FFF, 0x06820000 + x * 2 + y * 512)
   end
   write_dsbus_16bit(0x7FFF, 0x06820000 + 255 * 2 + y * 512)
end

reg_set(1, ds.Reg_DS_freerunclock)

wait_ns(17000000)