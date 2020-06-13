require("ds_lib")

wait_ns(10000)

WITHCPU = 0

reg_set(0, ds.Reg_DS_on)
reg_set(WITHCPU, ds.Reg_DS_enablecpu)
reg_set(3, audio.REG_Audio_Source)

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

--testroms
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_1.nds") -- ok

-- savestates
--reg_set_file("lua_tests\\savestates\\2D_CharBg_1.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_CharBg_8.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_CharBg_256BMP.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_CharBg_BankEx.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_CharBg_256_16.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_CharBg_Direct.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_Oam_1.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_Oam_256_16.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_Oam_Bmp1D.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\2D_Oam_Direct.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\ClearImage.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\ClearColor.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Master_Bright.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\touch.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\touch2.sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Game & Watch Collection (USA) (Club Nintendo).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Legend of Zelda, The - Twilight Princess - Preview Trailer (USA).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\50 Classic Games (Europe) (En,Fr,De,Es,It,Nl).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Kirby Super Star Ultra (Europe) (En,Fr,De,Es,It).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Age of Empires - The Age of Kings (Europe) (En,Fr,De).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Best of Card Games DS (Europe) (En,Fr,De,Es,It,Nl).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\Chrono Trigger (Europe) (En,Fr).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\B Team - Metal Cartoon Squad (Europe) (En,Fr,De,Es,It).sst", ddrram.Softmap_DS_SaveState, 0, 0)
--reg_set_file("lua_tests\\savestates\\123 Sesame Street - Cookie's Counting Carnival - The Videogame (USA).sst", ddrram.Softmap_DS_SaveState, 0, 0)
reg_set_file("lua_tests\\savestates\\Atlantic Quest (Europe) (Fr,De).sst", ddrram.Softmap_DS_SaveState, 0, 0)

--reg_set(1, ds.Reg_DS_Touch)
--reg_set(255, ds.Reg_DS_TouchX)
--reg_set(191, ds.Reg_DS_TouchY)

reg_set(0, ds.Reg_DS_bootloader)
reg_set(1, ds.Reg_DS_freerunclock)
reg_set(0, ds.Reg_DS_lockspeed)
reg_set(1, ds.Reg_DS_on)

reg_set(1, ds.Reg_DS_LoadState)

print("DS ON")

brk()
