require("ds_lib")

wait_ns(10000)

reg_set(0, ds.Reg_DS_on)
reg_set(1, ds.Reg_DS_enablecpu)
reg_set(0, audio.REG_Audio_Source)

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

-- games

--3D
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Super Mario 64 DS (Europe) (En,Fr,De,Es,It).nds") -- white screen going ingame

-- bugs
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Mega Man ZX (Europe) (En,Ja,Fr,De,Es,It).nds") -- missing graphic, cannot start game

-- drawing timeouts
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\50 Classic Games (Europe) (En,Fr,De,Es,It,Nl).nds") -- unregular
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Mega Man Battle Network 5 - Double Team DS (Europe) (En,Fr,De,Es,It).nds") -- ingame with PET, unregular
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Game & Watch Collection (USA) (Club Nintendo).nds") -- unregular
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Agatha Christie - The ABC Murders (Europe) (En,Fr,De,Es,It).nds") -- touch to start, wrong graphic after creating profile and ingame
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\123 Sesame Street - Cookie's Counting Carnival - The Videogame (USA).nds") -- unregular
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Berlitz - My English Coach (Europe) (En,Fr,De,Es,It).nds") -- unregular

-- instant crashes

-- crashes ingame
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Giana Sisters DS (Europe) (En,Fr,De,Es,It).nds") -- hangs at first logo
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Hasbro Family Game Night (Europe) (En,Fr,De,Nl).nds") -- can't select language
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Age of Empires - The Age of Kings (Europe) (En,Fr,De).nds") -- hangs after defeat first enemy - both cpu running without idle
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Kirby - Mouse Attack (Europe) (En,Fr,De,Es,It).nds") -- hangs ingame, after slow with fire
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Jagged Alliance (USA).nds") -- hangs at title screen
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Benoit Sokal Last King of Africa (Europe) (En,Fr,De,Es,It).nds") -- after taking first item?

-- graphic glitches
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Benjamin Bluemchen - Ein Tag im Zoo (Germany).nds") -- sprites halftransparent
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Atlantic Quest (Europe) (Fr,De).nds") -- sprites with black
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Gilde DS, Die (Europe) (En,Fr,De).nds") -- map black

--flicker
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\1001 Touch Games (Germany).nds") -- flickering ingame
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Asterix - These Romans Are Crazy! (Europe) (En,Fr,De,It,Nl).nds") -- messages flicker
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Might & Magic - Clash of Heroes (Europe) (En,Fr,De,Es,It).nds") -- flicker

-- slow
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Ab durch die Hecke (Germany).nds") -- untested
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Legend of Zelda, The - Twilight Princess - Preview Trailer (USA).nds") -- second screen black

-- to be tested

--ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Animaniacs - Lights, Camera, Action! (Europe) (En,Fr,De,Es,It) (Rev 1).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\11 Card Games (Europe) (En,De,Es).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\100 Classic Games (Europe) (En,Fr,De,Es,It) (Rev 1).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Best of Tests DS (Europe) (En,Fr,De,Es,It,Pt).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Ace Attorney Investigations - Miles Edgeworth (Europe).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Biene Maja, Die - Klatschmohnwiese in Gefahr (Germany).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Best of Card Games DS (Europe) (En,Fr,De,Es,It,Nl).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Digimon World - Dawn (USA).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Ancient Spirits - Columbus' Legacy (Europe) (En,Fr,De,Nl).nds")aa
load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Dokapon Journey (USA).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\50 More Classic Games (USA).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\18 Card Games (Europe) (En,Fr,De,Es,Nl).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Beauty Academy (Europe) (En,Fr,De,Nl).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Diabolik - The Original Sin (Europe) (En,Fr,De,Es,It,Nl).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Balls of Fury (Europe) (En,Fr,De,Es,It).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Barbie in the 12 Dancing Princesses (Europe) (En,Fr,De,Es,It).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Best of Arcade Games DS (Europe) (En,Fr,De,Es,It,Nl,Pt).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Best of Board Games DS (Europe) (En,Fr,De,Es,It,Pt).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\101 in 1 Explosive Megamix (Europe) (En,Fr,De,Es,It,Nl).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Beauty Salon (Europe) (En,Fr,De,Es,It) [b].nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Beetle King (Europe).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\B Team - Metal Cartoon Squad (Europe) (En,Fr,De,Es,It).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Kirby Super Star Ultra (Europe) (En,Fr,De,Es,It).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Betty Boop's Double Shift (Europe) (En,Fr,De,Es,It).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Bauernhof, Der (Germany).nds")
--load_rom("C:\\Users\\FPGADev\\Desktop\\ds roms\\Chrono Trigger (Europe) (En,Fr).nds")

--testroms
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_BmpBg_MainRam.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_BmpBg_Vram.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_1.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_2.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_3.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_4.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_5.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_6.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_7.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_8.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_9.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_256_16.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_256BMP.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_BankEx.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_CharBg_Direct.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_1.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_2.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_3.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_4.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_5.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_256_16.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_Char1D.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_OBJWindow.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_Translucent.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_Bmp1D.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\2D_Oam_Direct.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Window.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Window_HDMA.nds") -- wrong
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_1.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_2.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_3.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_4.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_5.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_6.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_7.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_8.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_CharBg_9.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_Oam_1.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_Oam_2.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_Oam_3.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_Oam_4.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Sub_Oam_5.nds") -- ok

--layer 0 in 3D visible without 3D
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\ClearColor.nds") -- ok -- also shows cube with 3D
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\ClearDepthOnly.nds") -- ok -- also shows cube with 3D
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\ClearImage.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\gxDemos\\Master_Bright.nds") -- ok

-- sound
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\soundchannel.srl")
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\sound_seq.srl")
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\sound_synth_touch.srl")
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\sound_touch_mic.srl")

-- touch
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\padRead.srl") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\touch.srl") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\touch2.srl") -- ok

-- homebrew
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\Armwrestler.nds") -- ok
--load_rom("C:\\Users\\FPGADev\\Desktop\\Emu-Docs-master\\Nintendo DS\\testroms\\Eigenmath1.0.nds") -- ok


--reg_set(1, ds.Reg_DS_Touch)
--reg_set(50, ds.Reg_DS_TouchX)
--reg_set(50, ds.Reg_DS_TouchY)

reg_set(3, audio.REG_Audio_Source)
reg_set(1, ds.Reg_DS_bootloader)
reg_set(0, ds.Reg_DS_freerunclock)
reg_set(1, ds.Reg_DS_lockspeed)
reg_set(900, ds.Reg_DS_CyclePrecalc)
reg_set(1, ds.Reg_DS_on)

print("DS ON")

brk()
