require("gba_lib")

testerrorcount = 0

gba_clear_saves = false
gba_loadsavegame = false
gba_savegame_path = "C:\\Users\\FPGADev\\Desktop\\gba_saves\\"

wait_ns(220000)

-- 200/200 vertical
reg_set(400, gpu.Reg_Framebuffer_PosX )
reg_set( 20, gpu.Reg_Framebuffer_PosY )
reg_set(240, gpu.Reg_Framebuffer_SizeX)
reg_set(160, gpu.Reg_Framebuffer_SizeY)
reg_set(2  , gpu.Reg_Framebuffer_Scale)
reg_set(0  , gpu.Reg_Framebuffer_LCD)

reg_set(400, gpu.Reg_Framebuffer2_PosX )
reg_set(380, gpu.Reg_Framebuffer2_PosY )
reg_set(240, gpu.Reg_Framebuffer2_SizeX)
reg_set(160, gpu.Reg_Framebuffer2_SizeY)
reg_set(2  , gpu.Reg_Framebuffer2_Scale)
reg_set(0  , gpu.Reg_Framebuffer2_LCD)

-- to be tested
--transmit_rom("C:\\Projekte\\GBA_MiSTer\\sim\\tests\\armwrestler.gba", ddrram.Softmap_GBA_Gamerom, nil)
--transmit_rom("C:\\Users\\FPGADev\\suite\\suite_full.gba", ddrram.Softmap_GBA_Gamerom, nil)
--transmit_rom("C:\\Users\\FPGADev\\Desktop\\gba-suite jsmolka\\arm\\arm.gba", ddrram.Softmap_GBA_Gamerom, nil)
--transmit_rom("C:\\Users\\FPGADev\\Desktop\\gba-suite jsmolka\\thumb\\thumb.gba", ddrram.Softmap_GBA_Gamerom, nil)

--transmit_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Game Boy Advance\\test_roms\\directaudiotest.gba", ddrram.Softmap_GBA_Gamerom, nil)
--transmit_rom("P:\\Emu\\GBA\\Super Mario Advance 2 - Super Mario World (Europe) (En,Fr,De,Es).gba", ddrram.Softmap_GBA_Gamerom, nil)
--transmit_rom("P:\\Emu\\GBA\\Mario Kart Super Circuit (E) [h3].gba", ddrram.Softmap_GBA_Gamerom, nil)
transmit_rom("P:\\Emu\\GBA\\Kirby & The Amazing Mirror (E) (M5).gba", ddrram.Softmap_GBA_Gamerom, nil)

print("Game transfered")

--reg_set_file("C:\\Users\\FPGADev\\Desktop\\savestates\\armwrestler.sst", ddrram.Softmap_GBA_SaveState, 0, 0)

print("Savestate transfered")

reg_set(100, gameboy.Reg_GBA_CyclePrecalc)
reg_set(0, gameboy.Reg_GBA_lockspeed)
reg_set(0, gameboy.Reg_GBA_cputurbo)
reg_set(1, gameboy.Reg_GBA_on)
reg_set(3, audio.REG_Audio_Source)

--reg_set(1, gameboy.Reg_GBA_LoadState)

--reg_set(1, gameboy.Reg_GBA_KeyA)

print("GBA ON")

brk()
--wait_ns(1000000)
--wait_ns(40000000)