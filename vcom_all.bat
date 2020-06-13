
vcom -O5 -vopt -quiet -work  sim/tb ^
src/tb/globals.vhd

vcom -O5 -vopt -quiet -work  sim/mem ^
src/tb/SyncRamDual.vhd ^
src/tb/SyncRamDualByteEnable.vhd ^
src/mem/SyncRamByteEnable.vhd ^
src/mem/SyncFifo.vhd

vcom -O5 -vopt -quiet -work sim/procbus ^
src/procbus/proc_bus.vhd ^
src/procbus/testprocessor.vhd

vcom -O5 -vopt -quiet -work sim/reg_map ^
src/reg_map/reg_test.vhd ^
src/reg_map/reg_ddrram.vhd ^
src/reg_map/reg_audio.vhd ^
src/reg_map/reg_gameboy.vhd ^
src/reg_map/reg_ds.vhd ^
src/reg_map/reg_gpu.vhd ^
src/reg_map/reg_external.vhd

vcom -O5 -vopt -quiet -work sim/hdmi ^
src/tb/clock_gen.vhd ^
src/tb/rgb2tmds.vhd ^
src/hdmi/timing_generator.vhd ^
src/hdmi/hdmi_out.vhd

vcom -O5 -vopt -quiet -work sim/audio ^
src/tb/i2s_ctl.vhd ^
src/tb/audio_init.vhd

vcom -O5 -2008 -vopt -quiet -work sim/ds ^
src/ds/ds_vcd_export.vhd

vcom -O5 -vopt -quiet -work sim/ds ^
src/ds/proc_bus_ds.vhd ^
src/ds/ds_memory_arbiter.vhd ^
src/ds/reg_savestates.vhd ^
src/ds/regds_system9.vhd ^
src/ds/regds_system7.vhd ^
src/ds/regds_timer9.vhd ^
src/ds/regds_timer7.vhd ^
src/ds/regds_display9.vhd ^
src/ds/regds_display7.vhd ^
src/ds/regds_3D9.vhd ^
src/ds/regds_dma9.vhd ^
src/ds/regds_dma7.vhd ^
src/ds/regds_keypad9.vhd ^
src/ds/regds_keypad7.vhd ^
src/ds/regds_serial7.vhd ^
src/ds/regds_sound7.vhd ^
src/ds/ds_bios9.vhd ^
src/ds/ds_bios7.vhd ^
src/ds/ds_memorymux9data.vhd ^
src/ds/ds_memorymux9code.vhd ^
src/ds/ds_memorymux7.vhd ^
src/ds/ds_externram_mux.vhd ^
src/ds/ds_bootloader.vhd ^
src/ds/ds_drawer_mode0.vhd ^
src/ds/ds_drawer_mode2.vhd ^
src/ds/ds_drawer_mode45.vhd ^
src/ds/ds_drawer_directvram.vhd ^
src/ds/ds_drawer_mainram.vhd ^
src/ds/ds_drawer_obj.vhd ^
src/ds/ds_drawer_3D.vhd ^
src/ds/ds_drawer_merge.vhd ^
src/ds/ds_gpu_timing.vhd ^
src/ds/ds_vram_mapbg.vhd ^
src/ds/ds_vram_mapobj.vhd ^
src/ds/ds_vram_mapbgpal.vhd ^
src/ds/ds_vram_maptexture.vhd ^
src/ds/ds_vram_mux.vhd ^
src/ds/ds_gpu_drawer.vhd ^
src/ds/ds_gpu.vhd ^
src/ds/ds_vram_A.vhd ^
src/ds/ds_vram_B.vhd ^
src/ds/ds_vram_C.vhd ^
src/ds/ds_vram_D.vhd ^
src/ds/ds_vram_E.vhd ^
src/ds/ds_vram_F.vhd ^
src/ds/ds_vram_G.vhd ^
src/ds/ds_vram_H.vhd ^
src/ds/ds_vram_I.vhd ^
src/ds/ds_IPC.vhd ^
src/ds/ds_IRQ.vhd ^
src/ds/ds_divider.vhd ^
src/ds/ds_sqrt.vhd ^
src/ds/ds_SPI_intern.vhd ^
src/ds/ds_gamecard.vhd ^
src/ds/ds_dma_module.vhd ^
src/ds/ds_dma.vhd ^
src/ds/ds_timer_module.vhd ^
src/ds/ds_timer.vhd ^
src/ds/ds_joypad.vhd ^
src/ds/ds_sound.vhd ^
src/ds/ds_DummyRegs.vhd ^
src/ds/ds_cpucache.vhd ^
src/ds/ds_cpu.vhd ^
src/ds/ds_top.vhd ^
src/ds/ds.vhd

vcom -O5 -vopt -quiet -work sim/top ^
src/tb/clk_wiz.vhd ^
src/tb/mig_7series_0.vhd ^
src/top/framebuffer.vhd ^
src/top/top.vhd

vcom -O5 -vopt -quiet -work sim/tb ^
src/tb/stringprocessor.vhd ^
src/tb/tb_interpreter.vhd ^
src/tb/tb.vhd

