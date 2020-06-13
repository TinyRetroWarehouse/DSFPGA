onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/CyclesMissing
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/CyclesVsyncSpeed9
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/CyclesVsyncSpeed7
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/CyclesVsyncIdle9
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/CyclesVsyncIdle7
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/clk_speed
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/baud
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/ftdi_d
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/ftdi_rxen
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/ftdi_txen
add wave -noupdate -group tb_interpreter /etb/itop/ftdi_rdn
add wave -noupdate -group tb_interpreter /etb/itop/ftdi_wrn
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/idle
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/transmit_command
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/transmit_byte_nr
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/sendbyte
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/tx_enable
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/tx_busy
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/receive_command
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/receive_byte_nr
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/receive_valid
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/rx_valid
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/rx_byte
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/proc_command
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/proc_bytes
add wave -noupdate -group tb_interpreter /etb/itb_interpreter/proc_enable
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_d
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/state
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/receive_command
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/receive_byte_nr
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/rx_valid
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/rx_byte
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/transmit_byte_nr
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/transmit_command
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/sendbyte
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/tx_enable
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/tx_busy
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/blocklength_m1
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/workcount
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/addr_buffer
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/timeout
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_state
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_slow
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_rxen_1
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_rxen_2
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_txen_1
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_txen_2
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_d_1
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/ftdi_d_2
add wave -noupdate -group testprocessor /etb/itop/iTestprocessor/receive_ready
add wave -noupdate -group ddrmodel /etb/itop/clk100
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ui_clk
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ui_clk_sync_rst
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/init_calib_complete
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_dq
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_dqs_p
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_dqs_n
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_addr
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_ba
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_ck_p
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_ck_n
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_cke
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_dm
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/ddr3_odt
add wave -noupdate -group ddrmodel /etb/itop/ddr_en
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/app_addr
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/app_cmd
add wave -noupdate -group ddrmodel /etb/itop/ddr_wdf_wren
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/app_wdf_data
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/app_wdf_mask
add wave -noupdate -group ddrmodel /etb/itop/imig_7series_0/app_rd_data
add wave -noupdate -group {ddr access} /etb/itop/DDRLatencyCnt
add wave -noupdate -group {ddr access} -radix unsigned /etb/itop/DDRLatency
add wave -noupdate -group {ddr access} /etb/itop/bus_in
add wave -noupdate -group {ddr access} /etb/itop/bus_Dout
add wave -noupdate -group {ddr access} /etb/itop/bus_done
add wave -noupdate -group {ddr access} /etb/itop/ddr_calib_complete
add wave -noupdate -group {ddr access} /etb/itop/ddr_addr
add wave -noupdate -group {ddr access} /etb/itop/ddr_cmd
add wave -noupdate -group {ddr access} /etb/itop/ddr_en
add wave -noupdate -group {ddr access} /etb/itop/ddr_wdf_data
add wave -noupdate -group {ddr access} /etb/itop/ddr_wdf_end
add wave -noupdate -group {ddr access} /etb/itop/ddr_wdf_mask
add wave -noupdate -group {ddr access} /etb/itop/ddr_wdf_wren
add wave -noupdate -group {ddr access} /etb/itop/ddr_rd_data
add wave -noupdate -group {ddr access} /etb/itop/ddr_rd_data_end
add wave -noupdate -group {ddr access} /etb/itop/ddr_rd_data_valid
add wave -noupdate -group {ddr access} /etb/itop/ddr_rdy
add wave -noupdate -group {ddr access} /etb/itop/ddr_wdf_rdy
add wave -noupdate -group {ddr access} /etb/itop/ddr_sr_req
add wave -noupdate -group {ddr access} /etb/itop/ddr_sr_active
add wave -noupdate -group {ddr access} /etb/itop/ddr_ref_ack
add wave -noupdate -group {ddr access} /etb/itop/ddr_zq_ack
add wave -noupdate -group {ddr access} /etb/itop/ddr_debugdone
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/FRAMESIZE_X
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/FRAMESIZE_Y
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_PosX
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_PosY
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_SizeX
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_SizeY
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_Scale
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Reg_Framebuffer_LCD
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/clk100
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/bus_in
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/bus_Dout
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/bus_done
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_x
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_y
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_data
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_we
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/clkvga
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/oCoord_X
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/oCoord_Y
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_out_data
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/framebuffer_active
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_PosX
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_PosY
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_SizeX
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_SizeY
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_Scale
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/Framebuffer_LCD
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_addr
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_data_1
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/pixel_in_we_1
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/startx
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/starty
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/scale
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/sizex
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/sizey
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/lcd_effect
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/endx
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/endy
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/oCoord_active
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/oCoord_active_1
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/oCoord_active_2
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/lcd_next
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/lcd_next_1
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_addr_x
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_addr_y
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_addr_ymul
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_addr
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_slow_x
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_slow_y
add wave -noupdate -group framebuffer1 /etb/itop/iframebuffer/readout_buffer
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/drawfile
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/FRAMESIZE_X
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/FRAMESIZE_Y
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_PosX
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_PosY
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_SizeX
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_SizeY
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_Scale
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Reg_Framebuffer_LCD
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/clk100
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/bus_in
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/bus_Dout
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/bus_done
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_x
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_y
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_data
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_we
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/clkvga
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/oCoord_X
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/oCoord_Y
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_out_data
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/framebuffer_active
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_PosX
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_PosY
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_SizeX
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_SizeY
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_Scale
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/Framebuffer_LCD
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_addr
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_data_1
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/pixel_in_we_1
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/startx
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/starty
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/scale
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/sizex
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/sizey
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/lcd_effect
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/endx
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/endy
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/oCoord_active
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/oCoord_active_1
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/oCoord_active_2
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/lcd_next
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/lcd_next_1
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_addr_x
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_addr_y
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_addr_ymul
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_addr
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_slow_x
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_slow_y
add wave -noupdate -group framebuffer2 /etb/itop/iframebuffer2/readout_buffer
add wave -noupdate -group ds /etb/itop/ids/is_simu
add wave -noupdate -group ds /etb/itop/ids/clk100
add wave -noupdate -group ds /etb/itop/ids/bus_in
add wave -noupdate -group ds /etb/itop/ids/bus_Dout
add wave -noupdate -group ds /etb/itop/ids/bus_done
add wave -noupdate -group ds /etb/itop/ids/pixel_out1_x
add wave -noupdate -group ds /etb/itop/ids/pixel_out1_y
add wave -noupdate -group ds /etb/itop/ids/pixel_out1_data
add wave -noupdate -group ds /etb/itop/ids/pixel_out1_we
add wave -noupdate -group ds /etb/itop/ids/pixel_out2_x
add wave -noupdate -group ds /etb/itop/ids/pixel_out2_y
add wave -noupdate -group ds /etb/itop/ids/pixel_out2_data
add wave -noupdate -group ds /etb/itop/ids/pixel_out2_we
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_Adr
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_rnw
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_ena
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_be
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_128
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_dout
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_dout128
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_din
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_din128
add wave -noupdate -group ds /etb/itop/ids/DS_RAM_done
add wave -noupdate -group ds /etb/itop/ids/sound_out_left
add wave -noupdate -group ds /etb/itop/ids/sound_out_right
add wave -noupdate -group ds /etb/itop/ids/ds_on
add wave -noupdate -group ds /etb/itop/ids/ds_lockspeed
add wave -noupdate -group ds /etb/itop/ids/ds_freerunclock
add wave -noupdate -group ds /etb/itop/ids/ds_cputurbo
add wave -noupdate -group ds /etb/itop/ids/ds_SaveState
add wave -noupdate -group ds /etb/itop/ids/ds_LoadState
add wave -noupdate -group ds /etb/itop/ids/CyclePrecalc
add wave -noupdate -group ds /etb/itop/ids/CyclesMissing
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9Addr
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9RnW
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9ACC
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9WriteData
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9ReadData
add wave -noupdate -group ds /etb/itop/ids/ds_Bus9_written
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7Addr
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7RnW
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7ACC
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7WriteData
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7ReadData
add wave -noupdate -group ds /etb/itop/ids/ds_Bus7_written
add wave -noupdate -group ds /etb/itop/ids/ds_KeyUp
add wave -noupdate -group ds /etb/itop/ids/ds_KeyDown
add wave -noupdate -group ds /etb/itop/ids/ds_KeyLeft
add wave -noupdate -group ds /etb/itop/ids/ds_KeyRight
add wave -noupdate -group ds /etb/itop/ids/ds_KeyA
add wave -noupdate -group ds /etb/itop/ids/ds_KeyB
add wave -noupdate -group ds /etb/itop/ids/ds_KeyX
add wave -noupdate -group ds /etb/itop/ids/ds_KeyY
add wave -noupdate -group ds /etb/itop/ids/ds_KeyL
add wave -noupdate -group ds /etb/itop/ids/ds_KeyR
add wave -noupdate -group ds /etb/itop/ids/ds_KeyStart
add wave -noupdate -group ds /etb/itop/ids/ds_KeySelect
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9data_Adr
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9data_be
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9data_dout
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9data_din
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9data_done
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9code_Adr
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9code_din
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram9code_done
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram7_Adr
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram7_be
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram7_dout
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram7_din
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram7_done
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram_Adr
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram_be
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram_dout
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram_din
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/Externram_din128
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/snoop_Adr
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/snoop_data
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/snoop_be
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/state
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/request_buffer_9data
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/request_buffer_9code
add wave -noupdate -group {ext ram mux} /etb/itop/ids/ids_top/ids_externram_mux/request_buffer_7
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/is_simu
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Softmap_DS_WRAM_ADDR
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Softmap_DS_FIRMWARE_ADDR
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Softmap_DS_SAVERAM_ADDR
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Softmap_DS_SAVESTATE_ADDR
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Softmap_DS_GAMEROM_ADDR
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/clk100
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ds_on
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ds_on_1
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/reset
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Bootloader
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/load
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/sleep_savestate
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/bus_ena_in_9
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/bus_ena_in_7
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_force
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_Adr
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_rnw
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_ena
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_128
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_be
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_dout
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_dout128
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_din
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_din128
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Externram_done
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_Addr
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_RnW
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_ena
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_ACC
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_WriteData
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_ReadData
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus9_done
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_Addr
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_RnW
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_ena
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_ACC
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_WriteData
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_ReadData
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/Internbus7_done
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/state
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_Adr
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_rnw
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_ena
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_be
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_128
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_dout
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_ram_dout128
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_readpos
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_writepos
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_readbase
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_writebase
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_count
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/boot_firstread
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM9_CODE_SRC
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM9_CODE_DST
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM9_CODE_SIZE
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM7_CODE_SRC
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM7_CODE_DST
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/ARM7_CODE_SIZE
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/savetype_counter
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/count
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/maxcount
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/data_isArm9
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/settle
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/wordcount
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/DataBuffer
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/SETTLECOUNT
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/HEADERCOUNT
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/SAVETYPESCOUNT
add wave -noupdate -group bootloader /etb/itop/ids/ids_top/ids_bootloader/savetypes
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/totalticks
add wave -noupdate -radix unsigned /etb/itop/ids/ids_top/gexport/ids_vcd_export/tc
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/clk100
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/ds_on
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/reset
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/waitsettle
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/waitsettle_cnt
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/ds_bus9
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/ds_bus7
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/fiforead_9_enable
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/fiforead_9_data
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/fiforead_7_enable
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/fiforead_7_data
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC9_Sync
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC7_Sync
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC9_Send_FIFO_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC9_Recv_FIFO_Not_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC7_Send_FIFO_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC7_Recv_FIFO_Not_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCSYNC_Data_to_IPCSYNC
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCSYNC_IRQ_to_remote_CPU
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCSYNC_Ena_IRQ_from_remote_CPU
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCSYNC_Data_to_IPCSYNC
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCSYNC_IRQ_to_remote_CPU
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCSYNC_Ena_IRQ_from_remote_CPU
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCSYNC_IRQ_to_remote_CPU_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCSYNC_IRQ_to_remote_CPU_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Send_Fifo_Empty_Status
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Send_Fifo_Full_Status
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Send_Fifo_Clear
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Receive_Fifo_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Receive_Fifo_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Error_Reset
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOSEND
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Send_Fifo_Empty_Status
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Send_Fifo_Full_Status
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Send_Fifo_Clear
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Receive_Fifo_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Receive_Fifo_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Error_Reset
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOSEND
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Send_Fifo_Clear_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Send_Fifo_Clear_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOCNT_Error_Reset_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOCNT_Error_Reset_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG9_IPCFIFOSEND_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/REG7_IPCFIFOSEND_written
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/reg_wired_or9
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/reg_wired_or7
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_reset
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Din
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Wr
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Dout
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Rd
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo9_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_reset
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Din
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Wr
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Full
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Dout
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Rd
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/Fifo7_Empty
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC9_Send_FIFO_Empty_old
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC9_Recv_FIFO_Not_Empty_old
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC7_Send_FIFO_Empty_old
add wave -noupdate -group IPC /etb/itop/ids/ids_top/ids_IPC/IRQ_IPC7_Recv_FIFO_Not_Empty_old
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/clk100
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/ds_on
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/reset
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/ds_bus9
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/ds_bus9_data
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/ds_bus7
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/ds_bus7_data
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/IRP_Joypad9
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/IRP_Joypad7
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyA
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyB
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyX
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyY
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeySelect
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyStart
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyRight
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyLeft
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyUp
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyDown
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyR
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/KeyL
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG9_KEYINPUT
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG9_KEYCNT
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG7_KEYCNT
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG7_RCNT
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG7_EXTKEYIN
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/reg_wired_or9
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/reg_wired_or7
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/Keys
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/Keys_1
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/Ext_keys
add wave -noupdate -group joypad /etb/itop/ids/ids_top/ids_joypad/REG7_KEYINPUT
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/start_draw
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter_int
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/VRam_Block
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/pixeldata
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/state
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/x_cnt
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/Vram_req
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_0
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/VRAM_byteaddr
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/VRam_dataout
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/VRAM_last_data
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_directvram/VRAM_last_valid
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_directvram
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_x
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_y
add wave -noupdate -group directvram /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_we
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_mainram/pixeldata
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_mainram/REG_DISP_MMEM_FIFO
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_mainram/reg_written
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_mainram/state
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdirectvram/ids_drawer_mainram/x_cnt
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mainram
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mainram_pixel_x
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mainram_pixel_we
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/start_draw
add wave -noupdate -group {mainram drawer} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter_int
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/index
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_SAD
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_DAD
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_L
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/clk100
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/reset
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/savestate_bus
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/loading_savestate
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/ds_bus
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/ds_bus_data
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/new_cycles
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/new_cycles_valid
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/IRP_DMA
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_on
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/allow_on
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_soon
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/hblank_trigger
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/vblank_trigger
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/MemDisplay_trigger
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/cardtrans_trigger
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/last_dma_out
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/last_dma_valid
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/last_dma_in
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_Adr
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_rnw
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_ena
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_acc
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_dout
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_din
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_done
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dma_bus_unread
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/is_idle
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/SAD
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/DAD
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_L
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/reg_wired_or
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/CNT_H_DMA_Enable_written
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Enable
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/running
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/waiting
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/first
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dmaon
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/waitTicks
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/dest_Addr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/source_Adr_Control
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Start_Timing
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Repeat
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/Transfer_Type_DW
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/iRQ_on
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/addr_source
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/addr_target
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/count
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/state
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/SAVESTATE_DMASOURCE
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/SAVESTATE_DMATARGET
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/SAVESTATE_DMAMIXED
add wave -noupdate -group dma9 -group dma90 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/index
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_SAD
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_DAD
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_L
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/clk100
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/reset
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/savestate_bus
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/loading_savestate
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/ds_bus
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/ds_bus_data
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/new_cycles
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/new_cycles_valid
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/IRP_DMA
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_on
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/allow_on
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_soon
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/hblank_trigger
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/vblank_trigger
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/MemDisplay_trigger
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/cardtrans_trigger
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/last_dma_out
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/last_dma_valid
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/last_dma_in
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_Adr
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_rnw
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_ena
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_acc
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_dout
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_din
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_done
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dma_bus_unread
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/is_idle
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/SAD
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/DAD
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_L
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/reg_wired_or
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/CNT_H_DMA_Enable_written
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Enable
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/running
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/waiting
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/first
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dmaon
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/waitTicks
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/dest_Addr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/source_Adr_Control
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Start_Timing
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Repeat
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/Transfer_Type_DW
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/iRQ_on
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/addr_source
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/addr_target
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/count
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/state
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/SAVESTATE_DMASOURCE
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/SAVESTATE_DMATARGET
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/SAVESTATE_DMAMIXED
add wave -noupdate -group dma9 -group dma91 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module1/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/index
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_SAD
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_DAD
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_L
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/clk100
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/reset
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/savestate_bus
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/loading_savestate
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/ds_bus
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/ds_bus_data
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/new_cycles
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/new_cycles_valid
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/IRP_DMA
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_on
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/allow_on
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_soon
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/hblank_trigger
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/vblank_trigger
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/MemDisplay_trigger
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/cardtrans_trigger
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/last_dma_out
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/last_dma_valid
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/last_dma_in
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_Adr
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_rnw
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_ena
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_acc
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_dout
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_din
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_done
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dma_bus_unread
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/is_idle
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/SAD
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/DAD
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_L
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/reg_wired_or
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/CNT_H_DMA_Enable_written
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Enable
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/running
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/waiting
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/first
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dmaon
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/waitTicks
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/dest_Addr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/source_Adr_Control
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Start_Timing
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Repeat
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/Transfer_Type_DW
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/iRQ_on
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/addr_source
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/addr_target
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/count
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/state
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/SAVESTATE_DMASOURCE
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/SAVESTATE_DMATARGET
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/SAVESTATE_DMAMIXED
add wave -noupdate -group dma9 -group dma92 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module2/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/index
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_SAD
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_DAD
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_L
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/clk100
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/reset
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/savestate_bus
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/loading_savestate
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/ds_bus
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/ds_bus_data
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/new_cycles
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/new_cycles_valid
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/IRP_DMA
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_on
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/allow_on
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_soon
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/hblank_trigger
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/vblank_trigger
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/MemDisplay_trigger
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/cardtrans_trigger
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/last_dma_out
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/last_dma_valid
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/last_dma_in
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_Adr
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_rnw
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_ena
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_acc
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_dout
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_din
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_done
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dma_bus_unread
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/is_idle
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/SAD
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/DAD
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_L
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_Source_Adr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_DMA_Repeat
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_IRQ_on
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_DMA_Enable
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/reg_wired_or
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/CNT_H_DMA_Enable_written
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Enable
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/running
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/waiting
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/first
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dmaon
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/waitTicks
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/dest_Addr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/source_Adr_Control
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Start_Timing
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Repeat
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/Transfer_Type_DW
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/iRQ_on
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/addr_source
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/addr_target
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/count
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/state
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/SAVESTATE_DMASOURCE
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/SAVESTATE_DMATARGET
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/SAVESTATE_DMAMIXED
add wave -noupdate -group dma9 -group dma93 /etb/itop/ids/ids_top/ids_dma9/ids_dma_module3/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/clk100
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/reset
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/savestate_bus
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/loading_savestate
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/ds_bus
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/ds_bus_data
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/new_cycles
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/new_cycles_valid
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/IRP_DMA0
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/IRP_DMA1
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/IRP_DMA2
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/IRP_DMA3
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/lastread_dma
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_on
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/CPU_bus_idle
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/do_step
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_soon
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/hblank_trigger
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/vblank_trigger
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_Adr
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_rnw
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_ena
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_acc
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_dout
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_din
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_done
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_bus_unread
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/debug_dma
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_Dout
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_Adr
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_acc
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_rnw
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_ena
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/Array_done
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/single_dma_on
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/single_allow_on
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/single_soon
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_switch
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/dma_idle
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma_value
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma0
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma1
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma2
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma3
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma_valid0
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma_valid1
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma_valid2
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/last_dma_valid3
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/single_is_idle
add wave -noupdate -group dma9 /etb/itop/ids/ids_top/ids_dma9/reg_wired_or
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_iscpu
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_Adr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_rnw
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_ena
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_acc
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_dout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_din
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/mem_bus9_done
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/is_simu
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/clk100
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DS_on
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/reset
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCMRegion
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/reg_wired_or9
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ds_bus_out
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_iscpu
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_Adr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_rnw
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_ena
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_acc
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_dout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_din
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/mem_bus_done
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ITCM_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ITCM_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ITCM_dataout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ITCM_we
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/ITCM_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/BIOS_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/BIOS_dataout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/IPC_fifo_enable
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/IPC_fifo_data
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmall_Mux
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallLo_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallLo_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallLo_dataout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallLo_we
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallLo_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallHi_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallHi_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallHi_dataout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallHi_we
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/WramSmallHi_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_dataout_bgA
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_dataout_objA
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_dataout_bgB
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_dataout_objB
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_we_bgA
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_we_objA
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_we_bgB
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_we_objB
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/Palette_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_A
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_B
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_C
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_D
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_E
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_F
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_G
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_H
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_dataout_I
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_we
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_A
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_B
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_C
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_D
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_E
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_F
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_G
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_H
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/VRam_active_I
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_dataout_A
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_dataout_B
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_we_A
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_we_B
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/OAMRam_be
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/state
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/read_delay
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/acc_save
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/return_rotate
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/rotate_data
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/wramsmallswitch
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/palettemux
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/oammux
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/dsbus_data
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCM_addr
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCM_datain
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCM_dataout
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCM_we
add wave -noupdate -group memmux9 /etb/itop/ids/ids_top/ids_memorymux9data/DTCM_be
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/clk100
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/DS_on
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/reset
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/mem_bus_Adr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/mem_bus_ena
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/mem_bus_acc
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/mem_bus_din
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/mem_bus_done
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/ITCM_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/ITCM_dataout
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/BIOS_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/BIOS_dataout
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/WramSmall_Mux
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/WramSmallLo_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/WramSmallLo_dataout
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/WramSmallHi_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/WramSmallHi_dataout
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/Palette_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/Palette_dataout_bgA
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/Palette_dataout_objA
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/Palette_dataout_bgB
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/Palette_dataout_objB
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_datain
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_A
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_B
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_C
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_D
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_E
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_F
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_G
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_H
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_dataout_I
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_A
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_B
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_C
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_D
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_E
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_F
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_G
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_H
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/VRam_active_I
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/OAMRam_addr
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/OAMRam_dataout_A
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/OAMRam_dataout_B
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/state
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/read_delay
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/acc_save
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/return_rotate
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/rotate_data
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/wramsmallswitch
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/palettemux
add wave -noupdate -group {memmux 9 code} /etb/itop/ids/ids_top/ids_memorymux9code/oammux
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/Vram_enable_A
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/MST
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/OFS
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_cpu9_addr
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_cpu9_datain
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_cpu9_dataout
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_cpu9_be
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_addr
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/VRam_dataout
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/Vram_valid
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu_addr
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu_datain
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu_dataout
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu_we
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu_be
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/cpu9_ena
add wave -noupdate -group vram_a /etb/itop/ids/ids_top/ids_vram_A/gpu_addr
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/MST
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/OFS
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu9_addr
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu9_datain
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu9_dataout
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu9_be
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu7_addr
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu7_datain
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu7_dataout
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_cpu7_be
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_addr
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/VRam_dataout
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu_addr
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu_datain
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu_dataout
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu_we
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu_be
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu9_ena
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/cpu7_ena
add wave -noupdate -group vram_c /etb/itop/ids/ids_top/ids_vram_C/gpu_addr
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/is_simu
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/clk100
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/ds_on
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/reset
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/lockspeed
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/ds_bus9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/ds_bus7
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/new_cycles
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/new_cycles_valid
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_HBlank9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_HBlank7
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_VBlank9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_VBlank7
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_LCDStat9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/IRP_LCDStat7
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/line_trigger
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/hblank_trigger
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/vblank_trigger
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_dma9/ids_dma_module0/MemDisplay_trigger
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/drawline
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/refpoint_update
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/newline_invsync
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/linecounter_drawer
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/pixelpos
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/DISPSTAT_debug
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Blank_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_H_Blank_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Counter_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Blank_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_H_Blank_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Counter_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Count_Setting
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_DISPSTAT_V_Count_Setting8
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG9_VCOUNT
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Blank_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_H_Blank_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Counter_flag
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Blank_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_H_Blank_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Counter_IRQ_Enable
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Count_Setting
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_DISPSTAT_V_Count_Setting8
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/REG7_VCOUNT
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/gpustate
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/linecounter
add wave -noupdate -group {gpu timing} -radix unsigned /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/cycles
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/drawsoon
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/vcount_irp_next9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/vcount_irp_next7
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/V_Count_Setting9
add wave -noupdate -group {gpu timing} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_timing/V_Count_Setting7
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/clk100
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ds_bus
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ds_bus_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/lockspeed
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/maxpixels
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_out_x
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_out_y
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_out_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_out_we
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixelpos
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/refpoint_update
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/hblank_trigger
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/vblank_trigger
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/line_trigger
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/newline_invsync
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_datain
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_dataout_bg
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_dataout_obj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_we_bg
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_we_obj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/Palette_be
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRam_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRam_datain
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRam_dataout
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRam_we
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRam_be
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_A
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_B
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_C
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_D
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_E
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_F
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_G
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_H
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_addr_I
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_A
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_B
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_C
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_D
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_E
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_F
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_G
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_H
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/VRam_dataout_I
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_BG_Mode
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_BG0_2D_3D
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Tile_OBJ_Mapping
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Bitmap_OBJ_2D_Dim
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Bitmap_OBJ_Mapping
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Forced_Blank
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Display_BG0
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Display_BG1
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Display_BG2
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Display_BG3
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Display_OBJ
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Window_0_Display_Flag
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Window_1_Display_Flag
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_OBJ_Wnd_Display_Flag
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Display_Mode
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_VRAM_block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Tile_OBJ_1D_Boundary
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Bitmap_OBJ_1D_Boundary
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_OBJ_Process_H_Blank
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Character_Base
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_Screen_Base
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_BG_Extended_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_DISPCNT_OBJ_Extended_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_BG_Priority
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_Character_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_Mosaic
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_Colors_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_Screen_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0CNT_Screen_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_BG_Priority
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_Character_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_Mosaic
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_Colors_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_Screen_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1CNT_Screen_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_BG_Priority
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Character_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Mosaic
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Colors_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Screen_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Display_Area_Overflow
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2CNT_Screen_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_BG_Priority
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Character_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Mosaic
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Colors_Palettes
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Screen_Base_Block
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Display_Area_Overflow
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3CNT_Screen_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0HOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG0VOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1HOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG1VOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2HOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2VOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3HOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3VOFS
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RotScaleParDX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RotScaleParDMX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RotScaleParDY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RotScaleParDMY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RefX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG2RefY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RotScaleParDX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RotScaleParDMX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RotScaleParDY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RotScaleParDMY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RefX
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BG3RefY
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN0H_X2
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN0H_X1
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN1H_X2
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN1H_X1
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN0V_Y2
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN0V_Y1
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN1V_Y2
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WIN1V_Y1
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_BG0_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_BG1_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_BG2_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_BG3_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_OBJ_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_0_Special_Effect
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_BG0_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_BG1_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_BG2_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_BG3_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_OBJ_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WININ_Window_1_Special_Effect
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_BG0_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_BG1_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_BG2_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_BG3_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_OBJ_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Outside_Special_Effect
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_BG0_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_BG1_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_BG2_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_BG3_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_OBJ_Enable
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_WINOUT_Objwnd_Special_Effect
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_MOSAIC_BG_Mosaic_H_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_MOSAIC_BG_Mosaic_V_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_MOSAIC_OBJ_Mosaic_H_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_MOSAIC_OBJ_Mosaic_V_Size
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG0_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG1_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG2_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG3_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_OBJ_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BD_1st_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_Color_Special_Effect
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG0_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG1_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG2_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BG3_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_OBJ_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDCNT_BD_2nd_Target_Pixel
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDALPHA_EVA_Coefficient
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDALPHA_EVB_Coefficient
add wave -noupdate -group {drawer A} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/REG_BLDY
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/reg_wired_or
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/on_delay_bg0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/on_delay_bg1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/on_delay_bg2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/on_delay_bg3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ref2_x_written
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ref2_y_written
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ref3_x_written
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ref3_y_written
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/extmode_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/extmode_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawermux_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawermux_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawermux_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawermux_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/enables_wnd0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/enables_wnd1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/enables_wndobj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/enables_wndout
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRAM_Drawer_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/OAMRAM_Drawer_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_OAM_Drawer_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_OAM_Drawer_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_addr0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_addr1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_addr2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_addr3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_BG_Drawer_cnt
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/hblank_trigger_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode45_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_mode45_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawline_obj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_modeobj_color
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_modeobj_settings
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_bg0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_bg1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_bg2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_bg3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_obj_color
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_we_obj_settings
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_modeobj_color
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_modeobj_settings
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_bg0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_bg1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_bg2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_bg3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_obj_color
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_obj_settings
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_modeobj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_bg0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_bg1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_bg2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_bg3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_x_obj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixel_objwnd
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/PALETTE_Drawer_addr_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode0_0
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode0_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode0_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode0_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode2_2
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_mode2_3
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_modeobj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/busy_allmod
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/clear_enable
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/clear_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/clear_trigger
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/clear_trigger_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter_int
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_addr
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_addr_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_bg0_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_bg1_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_bg2_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_bg3_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_obj_data
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_obj_color
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_obj_setting
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linebuffer_objwindow
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_back_next
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_back
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_enable
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_enable_1
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_pixeldata_out
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_pixel_x
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_pixel_y
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/merge_pixel_we
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/objwindow_merge_in
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_directvram
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_x
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_y
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/directvram_pixel_we
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_mainram
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mainram_pixel_x
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mainram_pixel_y
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mainram_pixel_we
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/lineUpToDate
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linesDrawn
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/nextLineDrawn
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/start_draw
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/drawstate
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mosaik_vcnt_bg
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/mosaik_vcnt_obj
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter_mosaic_bg
add wave -noupdate -group {drawer A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/linecounter_mosaic_obj
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/clk100
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/reset
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/drawline
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/busy
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/lockspeed
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/pixelpos
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/ypos
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/ypos_mosaic
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/mapbase
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/tilebase
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/hicolor
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/extpalette
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/extpalette_offset
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/mosaic
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/Mosaic_H_Size
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/screensize
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/scrollX
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/scrollY
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/pixel_we
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/pixeldata
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/pixel_x
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_valid
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_req
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_addr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_data
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_valid
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_req
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_data
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/vramfetch
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/palettefetch
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/VRAM_byteaddr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/PALETTE_byteaddr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/palette_readwait
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/mapbaseaddr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/tilebaseaddr
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/x_cnt
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/y_scrolled
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/offset_y
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/x_flip_offset
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/x_div
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/x_scrolled
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/tileinfo
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/pixeladdr_base
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/colordata
add wave -noupdate -group drawer_A_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_0/mosaik_cnt
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/clk100
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/reset
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/drawline
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/busy
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/lockspeed
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/pixelpos
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/ypos
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/ypos_mosaic
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/mapbase
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/tilebase
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/hicolor
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/mosaic
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/Mosaic_H_Size
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/screensize
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/scrollX
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/scrollY
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/pixel_we
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/pixeldata
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/pixel_x
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/PALETTE_Drawer_valid
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/VRAM_Drawer_req
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/VRAM_Drawer_data
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/vramfetch
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/palettefetch
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/VRAM_byteaddr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/PALETTE_byteaddr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/palette_readwait
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/mapbaseaddr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/tilebaseaddr
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/x_cnt
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/y_scrolled
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/offset_y
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/x_flip_offset
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/x_div
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/x_scrolled
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/tileinfo
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/pixeladdr_base
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/colordata
add wave -noupdate -group drawer_A_0_1 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode0_1/mosaik_cnt
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/clk100
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/reset
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/line_trigger
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/drawline
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/busy
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/mapbase
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/tilebase
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/screensize
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/wrapping
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/tile16bit
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/mosaic
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/Mosaic_H_Size
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/refX
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/refY
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/refX_mosaic
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/refY_mosaic
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/dx
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/dy
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/pixel_we
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/pixeldata
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/pixel_x
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/PALETTE_Drawer_valid
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/VRAM_Drawer_req
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/VRAM_Drawer_data
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/vramfetch
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/palettefetch
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/VRAM_byteaddr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/PALETTE_byteaddr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/palette_readwait
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/mapbaseaddr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/tilebaseaddr
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/realX
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/realY
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/xxx
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/yyy
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/xxx_pre
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/yyy_pre
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/x_cnt
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/scroll_mod
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/tileinfo
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/colordata
add wave -noupdate -group drawer_A_2_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_2/mosaik_cnt
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/clk100
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/reset
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/line_trigger
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/drawline
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/busy
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/mapbase
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/tilebase
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/screensize
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/wrapping
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/tile16bit
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/mosaic
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/Mosaic_H_Size
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/refX
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/refY
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/refX_mosaic
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/refY_mosaic
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/dx
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/dy
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/pixel_we
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/pixeldata
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/pixel_x
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/PALETTE_Drawer_valid
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/EXTPALETTE_req
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/EXTPALETTE_addr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/EXTPALETTE_data
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/EXTPALETTE_valid
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/VRAM_Drawer_req
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/VRAM_Drawer_data
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/vramfetch
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/palettefetch
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/VRAM_byteaddr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/PALETTE_byteaddr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/palette_readwait
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/mapbaseaddr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/tilebaseaddr
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/realX
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/realY
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/xxx
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/yyy
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/xxx_pre
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/yyy_pre
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/x_cnt
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/scroll_mod
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/tileinfo
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/colordata
add wave -noupdate -group drawer_A_2_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode2_3/mosaik_cnt
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/clk100
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/reset
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/BG_Mode5
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/line_trigger
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/drawline
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/busy
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/wrap
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/mosaic
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/Mosaic_H_Size
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/refX
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/refY
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/refX_mosaic
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/refY_mosaic
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/dx
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/dy
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/pixel_we
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/pixeldata
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/pixel_x
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/PALETTE_Drawer_valid
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/VRAM_Drawer_req
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/VRAM_Drawer_data
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/vramfetch
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/DrawState
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/x_cnt
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/realX
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/realY
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/xxx
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/yyy
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/VRAM_byteaddr
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/vram_data
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/PALETTE_byteaddr
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/palette_readwait
add wave -noupdate -group drawer_A_45_3 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_mode45_3/mosaik_cnt
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/clk100
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/reset
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/hblank
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/lockspeed
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/busy
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/drawline
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/ypos
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/ypos_mosaic
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/BG_Mode
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/one_dim_mapping
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/extpalette
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Tile_OBJ_1D_Boundary
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmap_OBJ_Mapping
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmap_OBJ_1D_Boundary
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmap_OBJ_2D_Dim
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Mosaic_H_Size
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/hblankfree
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/maxpixels
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixel_we_color
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeldata_color
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixel_we_settings
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeldata_settings
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixel_x
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixel_objwnd
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAMRAM_Drawer_addr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAMRAM_Drawer_data
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/PALETTE_Drawer_addr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/PALETTE_Drawer_data
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/EXTPALETTE_req
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/EXTPALETTE_addr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/EXTPALETTE_data
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/EXTPALETTE_valid
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/VRAM_Drawer_req
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/VRAM_Drawer_addr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/VRAM_Drawer_data
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/VRAM_Drawer_valid
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAMFetch
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/busy_1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/output_ok
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/wait_busydone
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_currentobj
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data_aff0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data_aff1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data_aff2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/OAM_data_aff3
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/PIXELGen
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_data0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_data1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_data2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/dx
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/dmx
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/dy
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/dmy
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/ty
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/posx
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/sizeX
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/sizeY
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/sizemult
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a3
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a4
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a5
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a6
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a7
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_3
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_4
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_5
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_6
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_pre_7
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/x_flip_offset
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/y_flip_offset
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/x_div
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/x_size
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/x
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/realX
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/realY
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/target
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/second_pix
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/skippixel
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/issue_pixel
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_noaff
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff0
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff1
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff2
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff3
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff4
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff5
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/PALETTE_byteaddr
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_readback
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/Pixel_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/target_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/target_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/target_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/enable_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/enable_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/enable_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/second_pix_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/readaddr_mux_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/prio_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/mode_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/hicolor_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/affine_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/hflip_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/palette_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/mosaic_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/mosaic_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/mosaik_cnt
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/mosaik_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmapmode_eval
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmapmode_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmapmode_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmapdata_wait
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/bitmapdata_merge
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeltime
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/pixeltime_current
add wave -noupdate -group drawer_A_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/gdrawer_on/ids_drawer_obj/maxpixeltime
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/clk100
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/reset
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/ds_bus
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/ds_bus_data
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/drawline
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/busy
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/ypos
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/scrollX
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/pixeldata_3D
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/pixel_we
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/pixel_x
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/Vram_req
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/VRam_addr
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/VRam_dataout
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/Vram_valid
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Texture_Mapping
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_PolygonAttr_Shading
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Alpha_Test
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Alpha_Blending
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Anti_Aliasing
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Edge_Marking
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Fog_Color_Alpha_Mode
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Fog_Master_Enable
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Fog_Depth_Shift
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_RDLINES_Underflow
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_RAM_Overflow
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_DISP3DCNT_Rear_Plane_Mode
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Red
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Green
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Blue
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Fog
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Alpha
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_COLOR_Clear_Polygon_ID
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_DEPTH_DEPTH
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_DEPTH_X_Offset
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/REG_CLEAR_DEPTH_Y_Offset
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/reg_wired_or
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/state
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/x_cnt
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/VRAM_byteaddr
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/VRAM_last_data
add wave -noupdate -group {drawer 3D} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/g3D/ids_drawer_3D/VRAM_last_valid
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/clk100
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enable
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/hblank
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/xpos
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ypos
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND0_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND1_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WNDOBJ_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND0_X1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND0_X2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND0_Y1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND0_Y2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND1_X1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND1_X2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND1_Y1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_WND1_Y2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_enables_wnd0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_enables_wnd1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_enables_wndobj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_enables_wndout
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_special_effect_in
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_1st_BD
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_effect_2nd_BD
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_Prio_BG0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_Prio_BG1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_Prio_BG2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_Prio_BG3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_EVA
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_EVB
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_BLDY
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_ena_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_ena_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_ena_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_ena_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/in_ena_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_back
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/objwindow_in
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_out
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixel_x
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixel_y
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixel_we
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND0_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND1_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WNDOBJ_on
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND0_X1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND0_X2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND0_Y1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND0_Y2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND1_X1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND1_X2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND1_Y1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/WND1_Y2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_wnd0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_wnd1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_wndobj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_wndout
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_effect_in
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_1st_BD
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/effect_2nd_BD
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/Prio_BG0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/Prio_BG1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/Prio_BG2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/Prio_BG3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/EVA
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/EVB
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BLDY
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ena_bg0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ena_bg1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ena_bg2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ena_bg3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ena_obj
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/EVA_MAXED
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/EVB_MAXED
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BLDY_MAXED
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/anywindow
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/inwin_0y
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/inwin_1y
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/first_target
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/second_target
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enable_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/xpos_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ypos_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg0_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg1_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg2_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg3_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_obj_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_enable_cycle1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enable_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/xpos_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ypos_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg0_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg1_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg2_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg3_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_obj_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enables_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_enable_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/topprio_cycle2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enable_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/xpos_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ypos_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg0_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg1_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg2_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg3_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_obj_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/topprio_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_enable_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/firstprio_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/secondprio_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/firstpixel_cycle3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/enable_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/xpos_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/ypos_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg0_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg1_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg2_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_bg3_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/pixeldata_obj_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/topprio_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_effect_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/special_out_cycle4
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/alpha_red
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/alpha_green
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/alpha_blue
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/whiter_red
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/whiter_green
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/whiter_blue
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/blacker_red
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/blacker_green
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/blacker_blue
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BG0
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BG1
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BG2
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/BG3
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/OBJ
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/TRANSPARENT
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/OBJALPHA
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/OBJPRIOH
add wave -noupdate -group {drawer merge A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_drawer_merge/OBJPRIOL
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/isGPUA
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/clk100
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_address_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_address_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_address_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_address_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_address_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_req_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_req_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_req_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_req_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_req_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_data_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_data_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_data_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_data_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_data_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_valid_0
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_valid_1
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_valid_2
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_valid_3
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/pal_valid_S
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress3D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req3D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data3D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid3D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_Offset_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_MST_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_addr_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/addresses_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/enables_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/valid_I
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_A
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_B
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_C
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_D
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_E
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_F
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_G
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_H
add wave -noupdate -group vrammux_A /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/dataall_I
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/isGPUA
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/clk100
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vramaddress
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ena
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_E
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_E
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_E
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_Offset_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_H
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_H
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_H
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_MST_I
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_addr_I
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vram_ENA_I
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/OFS_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_E
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/START_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_A
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_B
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_C
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_D
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_E
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_F
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/END_G
add wave -noupdate -group {vram mapgb A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_0/vramaddress_full
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/isGPUA
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_D
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_D
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_D
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_D
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_E
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_E
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_E
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_MST_I
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_addr_I
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vram_req_I
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/OFS_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/OFS_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/OFS_D
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/OFS_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/OFS_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_E
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/START_I
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_A
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_B
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_E
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_F
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_G
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/END_I
add wave -noupdate -group {vram_mapobj A} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_mapbg_S/vramaddress_full
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vramaddress3D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_req3D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_data3D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/vram_valid3D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/vram_ENA_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_MST_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_Offset_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_addr_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_req_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/vram_ENA_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_MST_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_Offset_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_addr_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_req_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/vram_ENA_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_MST_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_Offset_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_addr_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_req_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/vram_ENA_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_MST_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_Offset_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_addr_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vram_req_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/OFS_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/OFS_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/OFS_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/OFS_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/START_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/START_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/START_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/START_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/END_A
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/END_B
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/END_C
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/END_D
add wave -noupdate -group {vram maptexture} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerA/ids_vram_mux/ids_vram_maptexture/vramaddress_full
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/is_simu
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ds_nogpu
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/isGPUA
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/clk100
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ds_bus
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ds_bus_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/lockspeed
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/maxpixels
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_out_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_out_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_out_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_out_we
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linecounter
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixelpos
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/refpoint_update
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/hblank_trigger
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vblank_trigger
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/line_trigger
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/newline_invsync
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vsync_end
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_datain
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_dataout_bg
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_dataout_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_we_bg
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_we_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/Palette_be
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRam_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRam_datain
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRam_dataout
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRam_we
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRam_be
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_Offset_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_ENA_I
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/vram_MST_I
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_req_I
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_addr_I
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_dataout_I
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_A
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_B
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_C
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_D
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_E
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_F
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_G
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_H
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_valid_I
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_BG_Mode
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_BG0_2D_3D
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Tile_OBJ_Mapping
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Bitmap_OBJ_2D_Dim
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Bitmap_OBJ_Mapping
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Forced_Blank
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Display_BG0
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Display_BG1
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Display_BG2
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Display_BG3
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Display_OBJ
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Window_0_Display_Flag
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Window_1_Display_Flag
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_OBJ_Wnd_Display_Flag
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Display_Mode
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_VRAM_block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Tile_OBJ_1D_Boundary
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Bitmap_OBJ_1D_Boundary
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_OBJ_Process_H_Blank
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Character_Base
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_Screen_Base
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_BG_Extended_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_DISPCNT_OBJ_Extended_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_BG_Priority
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_Character_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_Mosaic
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_Colors_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_Screen_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0CNT_Screen_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_BG_Priority
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_Character_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_Mosaic
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_Colors_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_Screen_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1CNT_Screen_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_BG_Priority
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Character_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Mosaic
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Colors_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Screen_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Display_Area_Overflow
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2CNT_Screen_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_BG_Priority
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Character_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Mosaic
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Colors_Palettes
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Screen_Base_Block
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Display_Area_Overflow
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3CNT_Screen_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0HOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG0VOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1HOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG1VOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2HOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2VOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3HOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3VOFS
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RotScaleParDX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RotScaleParDMX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RotScaleParDY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RotScaleParDMY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RefX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG2RefY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RotScaleParDX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RotScaleParDMX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RotScaleParDY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RotScaleParDMY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RefX
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BG3RefY
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN0H_X2
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN0H_X1
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN1H_X2
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN1H_X1
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN0V_Y2
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN0V_Y1
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN1V_Y2
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WIN1V_Y1
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_BG0_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_BG1_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_BG2_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_BG3_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_OBJ_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_0_Special_Effect
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_BG0_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_BG1_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_BG2_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_BG3_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_OBJ_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WININ_Window_1_Special_Effect
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_BG0_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_BG1_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_BG2_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_BG3_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_OBJ_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Outside_Special_Effect
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_BG0_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_BG1_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_BG2_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_BG3_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_OBJ_Enable
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_WINOUT_Objwnd_Special_Effect
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_MOSAIC_BG_Mosaic_H_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_MOSAIC_BG_Mosaic_V_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_MOSAIC_OBJ_Mosaic_H_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_MOSAIC_OBJ_Mosaic_V_Size
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG0_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG1_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG2_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG3_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_OBJ_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BD_1st_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_Color_Special_Effect
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG0_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG1_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG2_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BG3_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_OBJ_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDCNT_BD_2nd_Target_Pixel
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDALPHA_EVA_Coefficient
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDALPHA_EVB_Coefficient
add wave -noupdate -group {drawer B} -group regs /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/REG_BLDY
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/reg_wired_or
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/extmode_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/extmode_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/on_delay_bg0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/on_delay_bg1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/on_delay_bg2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/on_delay_bg3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref2_x_written
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref2_y_written
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref3_x_written
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref3_y_written
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/enables_wnd0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/enables_wnd1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/enables_wndobj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/enables_wndout
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/screenbase_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/screenbase_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/screenbase_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/screenbase_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/charbase_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/charbase_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/charbase_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/charbase_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawermux_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawermux_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawermux_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawermux_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRAM_Drawer_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/OAMRAM_Drawer_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_OAM_Drawer_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_OAM_Drawer_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_addr0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_addr1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_addr2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_addr3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_valid
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_BG_Drawer_cnt
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/PALETTE_Drawer_addr_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_Drawer_data0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_Drawer_data1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_Drawer_data2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_Drawer_data3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRam_Drawer_data_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_valid
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addr_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_addrobj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_direct_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_req_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_reqobj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/VRAM_Drawer_reqvramdraw
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/directmode
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/hblank_trigger_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawline_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_modeobj_color
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_modeobj_settings
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_bg0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_bg1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_bg2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_bg3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_obj_color
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_we_obj_settings
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_modeobj_color
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_modeobj_settings
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_bg0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_bg1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_bg2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_bg3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_obj_color
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_obj_settings
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_modeobj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_bg0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_bg1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_bg2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_bg3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_x_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixel_objwnd
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode0_0
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode0_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode0_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode0_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode2_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode2_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode45_2
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_mode45_3
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_modeobj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/busy_allmod
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/clear_enable
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/clear_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/clear_trigger
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/clear_trigger_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linecounter_int
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_addr
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_addr_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_bg0_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_bg1_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_bg2_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_bg3_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_obj_data
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_obj_color
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_obj_setting
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linebuffer_objwindow
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_back_next
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/pixeldata_back
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_enable
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_enable_1
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_pixeldata_out
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_pixel_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_pixel_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/merge_pixel_we
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/objwindow_merge_in
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/directvram_pixel_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/directvram_pixel_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/directvram_pixel_we
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mainram_pixel_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mainram_pixel_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mainram_pixel_we
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/lineUpToDate
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linesDrawn
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/nextLineDrawn
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/start_draw
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/drawstate
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref2_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref2_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref3_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ref3_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaik_vcnt_bg
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaik_vcnt_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linecounter_mosaic_bg
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/linecounter_mosaic_obj
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaic_ref2_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaic_ref2_y
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaic_ref3_x
add wave -noupdate -group {drawer B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/mosaic_ref3_y
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/clk100
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/reset
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/drawline
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/busy
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/lockspeed
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/pixelpos
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/ypos
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/ypos_mosaic
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/mapbase
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/tilebase
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/hicolor
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/extpalette
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/extpalette_offset
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/mosaic
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/Mosaic_H_Size
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/screensize
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/scrollX
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/scrollY
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/pixel_we
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/pixeldata
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/pixel_x
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_addr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_data
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/PALETTE_Drawer_valid
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_req
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_addr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_data
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/EXTPALETTE_valid
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_req
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_addr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_data
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/VRAM_Drawer_valid
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/vramfetch
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/palettefetch
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/VRAM_byteaddr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/PALETTE_byteaddr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/palette_readwait
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/mapbaseaddr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/tilebaseaddr
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/x_cnt
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/y_scrolled
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/offset_y
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/x_flip_offset
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/x_div
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/x_scrolled
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/tileinfo
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/pixeladdr_base
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/colordata
add wave -noupdate -group drawer_B_0_0 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_0/mosaik_cnt
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/clk100
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/reset
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/drawline
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/busy
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/lockspeed
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/pixelpos
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/ypos
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/ypos_mosaic
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/mapbase
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/tilebase
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/hicolor
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/extpalette
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/extpalette_offset
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/mosaic
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/Mosaic_H_Size
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/screensize
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/scrollX
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/scrollY
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/pixel_we
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/pixeldata
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/pixel_x
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/PALETTE_Drawer_addr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/PALETTE_Drawer_data
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/PALETTE_Drawer_valid
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/EXTPALETTE_req
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/EXTPALETTE_addr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/EXTPALETTE_data
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/EXTPALETTE_valid
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/VRAM_Drawer_req
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/VRAM_Drawer_addr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/VRAM_Drawer_data
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/VRAM_Drawer_valid
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/vramfetch
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/palettefetch
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/VRAM_byteaddr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/PALETTE_byteaddr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/palette_readwait
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/mapbaseaddr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/tilebaseaddr
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/x_cnt
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/y_scrolled
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/offset_y
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/x_flip_offset
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/x_div
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/x_scrolled
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/tileinfo
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/pixeladdr_base
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/colordata
add wave -noupdate -group drawer_B_0_2 /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_mode0_2/mosaik_cnt
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/clk100
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/reset
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/hblank
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/lockspeed
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/busy
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/drawline
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/ypos
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/ypos_mosaic
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/BG_Mode
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/one_dim_mapping
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Tile_OBJ_1D_Boundary
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmap_OBJ_Mapping
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmap_OBJ_1D_Boundary
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmap_OBJ_2D_Dim
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/extpalette
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Mosaic_H_Size
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/hblankfree
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/maxpixels
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixel_we_color
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeldata_color
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixel_we_settings
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeldata_settings
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixel_x
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixel_objwnd
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAMRAM_Drawer_addr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAMRAM_Drawer_data
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/PALETTE_Drawer_addr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/PALETTE_Drawer_data
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/EXTPALETTE_req
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/EXTPALETTE_addr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/EXTPALETTE_data
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/EXTPALETTE_valid
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/VRAM_Drawer_req
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/VRAM_Drawer_addr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/VRAM_Drawer_data
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/VRAM_Drawer_valid
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAMFetch
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/busy_1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/output_ok
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/wait_busydone
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_currentobj
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data_aff0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data_aff1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data_aff2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_data_aff3
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/PIXELGen
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_data0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_data1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_data2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/dx
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/dmx
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/dy
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/dmy
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapmode
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/ty
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/posx
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/sizeX
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/sizeY
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/sizemult
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a3
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a4
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a5
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a6
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_a7
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_3
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_4
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_5
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_6
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_pre_7
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/x_flip_offset
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/y_flip_offset
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/x_div
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/x_size
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/x
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/realX
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/realY
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/target
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/second_pix
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/skippixel
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/issue_pixel
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_noaff
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff0
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff1
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff2
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff3
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff4
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_aff5
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_bitmap_2D
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeladdr_x_bitmap_1D
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/PALETTE_byteaddr
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_readback
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/Pixel_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/target_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/target_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/target_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/enable_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/enable_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/enable_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/second_pix_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/readaddr_mux_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/prio_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/mode_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/hicolor_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/affine_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/hflip_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/palette_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/mosaic_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/mosaic_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/mosaik_cnt
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/mosaik_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapmode_eval
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapmode_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapmode_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapdata_wait
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/bitmapdata_merge
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeltime
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/pixeltime_current
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/maxpixeltime
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_Y_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_Y_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_AFFINE
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_DBLSIZE
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OFF_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OFF_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_MODE_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_MODE_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_MOSAIC
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_HICOLOR
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OBJSHAPE_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OBJSHAPE_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_X_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_X_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_AFF_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_AFF_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_HFLIP
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_VFLIP
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OBJSIZE_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_OBJSIZE_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_TILE_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_TILE_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_PRIO_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_PRIO_LO
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_PALETTE_HI
add wave -noupdate -group drawer_b_obj /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/gdrawer_on/ids_drawer_obj/OAM_PALETTE_LO
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/isGPUA
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/clk100
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/directmode
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_address_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_address_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_address_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_address_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_address_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_req_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_req_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_req_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_req_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_req_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_data_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_data_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_data_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_data_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_data_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_valid_0
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_valid_1
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_valid_2
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_valid_3
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/pal_valid_S
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vramaddress3D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req3D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data3D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid3D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_Offset_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_ENA_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_MST_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_data_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_valid_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/addresses_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/enables_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/valid_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_A
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_B
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_C
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_D
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_E
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_F
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_G
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_H
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/dataall_I
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/nomap
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_F_arbiter
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_F_arbiter
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_G_arbiter
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_G_arbiter
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_req_I_arbiter
add wave -noupdate -group vrammux_B /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/vram_addr_I_arbiter
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/isGPUA
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_D
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_D
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_D
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_D
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_E
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_E
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_E
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_Offset_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_MST_I
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_addr_I
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vram_req_I
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/OFS_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/OFS_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/OFS_D
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/OFS_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/OFS_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_E
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/START_I
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_A
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_B
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_E
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_F
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_G
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/END_I
add wave -noupdate -group {vram_mapobj B} /etb/itop/ids/ids_top/ids_gpu/igba_gpu_drawerB/ids_vram_mux/ids_vram_mapbg_S/vramaddress_full
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/LINES
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/LINESIZE
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/ASSOCIATIVITY
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/ADDRBITS
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/clk
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/ds_on
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_enable
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_req
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_addr
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_addr
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_dataout
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_datavalid
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_readena
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_data
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_acc
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_done
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_checked
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_cached
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/mem_read_ena
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/mem_read_addr
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/mem_read_data
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/mem_read_done
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_Adr
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_data
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_we
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_be
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_next
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/rrb
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/tags
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/state
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/readdata_cache
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/fetch_count
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/fillcount
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/cache_mux
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_addr_a
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_addr_b
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_datain
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_datain96
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_we
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memory_be
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/read_data_rotated
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memmux_addr_b
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memmux_datain
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memmux_we
add wave -noupdate -group {instrcache 9} /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/memmux_be
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_read_enable
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_read_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_read_data
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_read_done
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_read_cached
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_write_enable
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/bus_execute_acc
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_write_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_write_checked
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_write_cached
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_mem_read_ena
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/datacache_mem_read_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/LINES
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/LINESIZE
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/ASSOCIATIVITY
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/ADDRBITS
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/read_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/read_acc
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/read_data
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/write_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/mem_read_ena
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/mem_read_addr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/mem_read_data
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/snoop_Adr
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/snoop_data
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/iinstrcache/snoop_we
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/snoop_be
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/snoop_next
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/rrb
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/tags
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/state
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/readdata_cache
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/cache_mux
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memory_addr_a
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memory_addr_b
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memory_datain
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memory_we
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memory_be
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/fetch_count
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/read_data_rotated
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memmux_addr_b
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memmux_datain
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memmux_we
add wave -noupdate -group datacache_9 /etb/itop/ids/ids_top/ids_cpu9/gdatacache/idatacache/memmux_be
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/is_simu
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/isArm9
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/clk100
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/ds_on
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/reset
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/savestate_bus
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_Adr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_rnw
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_ena
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_acc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_dout
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_din
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_1_done
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_2_Adr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_2_ena
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_2_acc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_2_din
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/OBus_2_done
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_lowbits
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/settle
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/dma_on
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/do_step
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/CPU_bus_idle
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/PC_in_BIOS
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/lastread
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/jump_out
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/done_9
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/new_cycles9_valid
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/new_cycles_out
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/new_halt
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/debug_cpu_pc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/debug_cpu_mixed
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/thumbmode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/halt
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/IRQ_disable
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/FIQ_disable
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Flag_Zero
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Flag_Carry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Flag_Negative
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Flag_V_Overflow
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Flag_Q
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/SAVESTATE_cpu_mode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/cpu_mode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/cpu_mode_old
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/regs
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/regs_plus_12
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_pc_next
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/PC
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/jump
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/new_pc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/branchnext
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/blockr15jump
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_fetch_cycles
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_fetch_cycles
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_cycles
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_addcycles
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/dataaccess_cyclecheck
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/datacache_read_checked
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/datacache_write_checked
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_addcycles
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/dataticksAccess16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/dataticksAccess32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/dataticksAccessSeq32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccess16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccess32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessSeq16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessSeq32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessJump16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessJump32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessSeqJump16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/codeticksAccessSeqJump32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/memoryWait16
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/memoryWait32
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/lastfetchAddress
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/lastAddress
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/fetch_instr_cache
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_instr_cache
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/wait_fetch
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/skip_pending_fetch
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/fetch_req
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/fetch_available
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/fetch_data
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_req
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_dataout
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_datavalid
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_readena
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_addr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/instr_cache_cached
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_fetch_Adr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/fetch_valid
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/last_fetch_onbus
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_request
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_data
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_PC
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_condition
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/state_decode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_start
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/calc_done
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_PC
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_PCprev
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/halt_cnt
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/irq_calc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/irq_delay
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/irq_triggerhold
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/calc_result
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/writeback_reg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_writeback_calc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_writeback_r17
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_writeback_userreg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_switchregs
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_saveregs
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_saveState
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_SWI
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_IRP
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/state_execute
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_functions_detail
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datareceivetype
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_clearbit1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_rdest
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_Rn_op1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_RM_op2
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_alu_use_immi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_alu_use_shift
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_immidiate
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_shiftsettings
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_shiftcarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_useoldcarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_updateflags
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_muladd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_signed
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_useadd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_long
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_x_hi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_x_lo
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_y_Hi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_mul_y_lo
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_writeback
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_switch_op
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_set_thumbmode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_branch_usereg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_branch_link
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_branch_immi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_type
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_preadd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_addup
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_writeback
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_addvalue
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_shiftval
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_regoffset
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_datatransfer_swap
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_usermoderegs
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_switchmode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_addrmod
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_endmod
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_addrmod_baseRlist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_reglist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_block_emptylist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_psr_with_spsr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_leaveirp
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/decode_leaveirp_user
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_functions_detail
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datareceivetype
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_clearbit1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_rdest
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_Rn_op1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_RM_op2
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_alu_use_immi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_alu_use_shift
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_immidiate
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_shiftsettings
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_shiftcarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_useoldcarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_updateflags
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_muladd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_signed
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_useadd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_long
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_x_hi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_x_lo
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_y_hi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_mul_y_lo
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_writeback
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_switch_op
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_set_thumbmode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_branch_usereg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_branch_link
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_branch_immi
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_type
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_preadd
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_addup
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_writeback
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_addvalue
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_shiftval
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_regoffset
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_datatransfer_swap
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_usermoderegs
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_switchmode
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_addrmod
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_endmod
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_addrmod_baseRlist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_reglist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_emptylist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_block_wb_in_reglist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_psr_with_spsr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_leaveirp
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/execute_leaveirp_user
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_op1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_op2
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_result
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_result_add
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_shiftercarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_saturate_max
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/alu_saturate_min
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_op1
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_op2
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_opaddlow
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_opaddhigh
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_result
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/mul_wait
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shifter_start
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftreg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftbyreg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftwait
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftamount
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftervalue
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shift_rrx
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry_LSL
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry_RSL
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry_ARS
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry_ROR
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftercarry_RRX
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult_LSL
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult_RSL
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult_ARS
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult_ROR
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/shiftresult_RRX
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_execute_Adr
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_execute_rnw
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_execute_ena
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/bus_execute_acc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/data_rw_stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/busaddress
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/busaddmod
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/swap_write
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/first_mem_access
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_rw_stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_regindex
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/endaddress
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/endaddressRlist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_writevalue
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_reglist
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_switch_pc
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_hasPC
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/block_arm9_writeback
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/MSR_Stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/msr_value
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/msr_writebackvalue
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/clz_stage
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/clz_workreg
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/clz_count
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/irpTarget
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_ctrl
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_ICConfig
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_DCConfig
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_writeBuffCtrl
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_IaccessPerm
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_DaccessPerm
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_DTCMRegion
add wave -noupdate -group {cpu 9} /etb/itop/ids/ids_top/ids_cpu9/Co15_protectBaseSize
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/IME
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/IE
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/IF_ALL
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/cpu_irq
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/REG_IME
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/REG_IE
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/REG_IF_ALL
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/reg_wired_or
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/IRPFLags
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/IF_written
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/ids_IRQ9/SAVESTATE_IRP
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_LCD_V_Blank
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_LCD_H_Blank
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_LCD_V_Counter_Match
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Timer_0_Overflow
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Timer_1_Overflow
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Timer_2_Overflow
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Timer_3_Overflow
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_DMA_0
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_DMA_1
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_DMA_2
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_DMA_3
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Keypad
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_GBA_Slot
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_IPC_Sync
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_IPC_Send_FIFO_Empty
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_IPC_Recv_FIFO_Not_Empty
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_NDS_Slot_TransferComplete
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_NDS_Slot_IREQ_MC
add wave -noupdate -group irq9 /etb/itop/ids/ids_top/IRQ9_Geometry_Command_FIFO
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/is_simu
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/index
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/Reg_L
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/Reg_H_Prescaler
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/Reg_H_Count_up
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/clk100
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/ds_on
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/reset
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/savestate_bus
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/loading_savestate
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/ds_bus
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/ds_bus_data
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/new_cycles
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/new_cycles_valid
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/countup_in
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/tick
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/IRP_Timer
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/debugout
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/L_Counter_Reload
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/H_Prescaler
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/H_Count_up
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/reg_wired_or
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/H_Timer_Start_Stop_written
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/counter_readback
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/counter
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/prescalecounter
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/prescaleborder
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/timer_on
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/timer_on_next
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/SAVESTATE_TIMER
add wave -noupdate -group timer9 -group timer90 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module0/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/is_simu
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/index
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/Reg_L
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/Reg_H_Prescaler
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/Reg_H_Count_up
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/ds_bus_data
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/new_cycles
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/tick
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/IRP_Timer
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/debugout
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/L_Counter_Reload
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/H_Prescaler
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/H_Count_up
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/reg_wired_or
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/H_Timer_Start_Stop_written
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/counter_readback
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/counter
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/prescalecounter
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/prescaleborder
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/timer_on
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/timer_on_next
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/SAVESTATE_TIMER
add wave -noupdate -group timer9 -group timer91 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module1/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/is_simu
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/index
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/Reg_L
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/Reg_H_Prescaler
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/Reg_H_Count_up
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/ds_bus_data
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/new_cycles
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/tick
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/IRP_Timer
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/debugout
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/L_Counter_Reload
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/H_Prescaler
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/H_Count_up
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/reg_wired_or
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/H_Timer_Start_Stop_written
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/counter_readback
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/counter
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/prescalecounter
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/prescaleborder
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/timer_on
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/timer_on_next
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/SAVESTATE_TIMER
add wave -noupdate -group timer9 -group timer92 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module2/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/is_simu
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/index
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/Reg_L
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/Reg_H_Prescaler
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/Reg_H_Count_up
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/ds_bus_data
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/new_cycles
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/tick
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/IRP_Timer
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/debugout
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/L_Counter_Reload
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/H_Prescaler
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/H_Count_up
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/H_Timer_IRQ_Enable
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/H_Timer_Start_Stop
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/reg_wired_or
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/H_Timer_Start_Stop_written
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/counter_readback
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/counter
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/prescalecounter
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/prescaleborder
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/timer_on
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/timer_on_next
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/SAVESTATE_TIMER
add wave -noupdate -group timer9 -group timer93 /etb/itop/ids/ids_top/ids_timer9/ids_timer_module3/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/clk100
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/ds_on
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/reset
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/savestate_bus
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/loading_savestate
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/ds_bus
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/ds_bus_data
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/new_cycles
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/new_cycles_valid
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/IRP_Timer0
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/IRP_Timer1
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/IRP_Timer2
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/IRP_Timer3
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/debugout0
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/debugout1
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/debugout2
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/debugout3
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/timerticks
add wave -noupdate -group timer9 /etb/itop/ids/ids_top/ids_timer9/reg_wired_or
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/clk100
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/ds_on
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/reset
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/ds_bus
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/haltbus
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/new_cycles
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/new_cycles_valid
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVCNT_Division_Mode
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVCNT_Division_by_zero
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVCNT_Busy
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_NUMER_Low
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_NUMER_High
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_DENOM_Low
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_DENOM_High
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_RESULT_Low
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_RESULT_High
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVREM_RESULT_Low
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVREM_RESULT_High
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIVCNT_Division_Mode_written
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_NUMER_Low_written
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_NUMER_High_written
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_DENOM_Low_written
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/REG9_DIV_DENOM_High_written
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/any_written
add wave -noupdate -group divider -radix unsigned /etb/itop/ids/ids_top/ids_divider/workcnt
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/working
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/start
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/done
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/dividend
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/divisor
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/quotient
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/remainder
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/dividend_u
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/divisor_u
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/quotient_u
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/Akku
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/QPointer
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/done_buffer
add wave -noupdate -group divider /etb/itop/ids/ids_top/ids_divider/bits_per_cycle
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/clk100
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/ds_on
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/reset
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/ds_bus
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/haltbus
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/new_cycles
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/new_cycles_valid
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRTCN_Mode
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRTCN_Busy
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRT_RESULT
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRT_PARAM_Low
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRT_PARAM_High
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRTCN_Mode_written
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRT_PARAM_Low_written
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/REG9_SQRT_PARAM_High_written
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/any_written
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/workcnt
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/working
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/start
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/done
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/paramfull
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/finish
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/op
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/result
add wave -noupdate -group sqrt /etb/itop/ids/ids_top/ids_sqrt/one
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/is_simu
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/clk100
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/DS_on
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/reset
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/ds_bus_out
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/ds_bus_in
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/pc_in_bios
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_Adr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_rnw
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_ena
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_acc
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_dout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_din
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/mem_bus_done
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_Adr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_rnw
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_ena
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_be
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_dout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_din
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/Externram_done
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_Mux
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallLo_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallLo_datain
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallLo_dataout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallLo_we
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallLo_be
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallHi_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallHi_datain
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallHi_dataout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallHi_we
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmallHi_be
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_datain
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_dataout_C
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_dataout_D
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_we
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_be
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_active_C
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/VRam_active_D
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/IPC_fifo_enable
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/IPC_fifo_data
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/spi_done
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/gc_read
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/gc_romaddress
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/gc_readtype
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/gc_chipID
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_dataout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_request
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_rnw
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_datain
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/auxspi_done
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/state
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/read_delay
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/acc_save
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/wramsmallswitch
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/return_rotate
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/rotate_data
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_int_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_int_datain
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_int_dataout
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_int_we
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/WramSmall_int_be
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/BIOS_addr
add wave -noupdate -group memmux7 /etb/itop/ids/ids_top/ids_memorymux7/BIOS_dataout
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/LINES
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/LINESIZE
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/ASSOCIATIVITY
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/ADDRBITS
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_req
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_dataout
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_datavalid
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_readena
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_addr
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/instr_cache_cached
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/clk
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/ds_on
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_enable
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_addr
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_data
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_done
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_checked
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_cached
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/write_addr
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/write_checked
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/write_cached
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/mem_read_ena
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/mem_read_addr
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/mem_read_data
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/mem_read_done
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/snoop_Adr
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/snoop_data
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/snoop_we
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/snoop_be
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/snoop_next
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/rrb
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/tags
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/state
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/readdata_cache
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/cache_mux
add wave -noupdate -group {instr cache 7} -radix hexadecimal /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memory_addr_a
add wave -noupdate -group {instr cache 7} -radix hexadecimal /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memory_addr_b
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memory_datain
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memory_we
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memory_be
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/fetch_count
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/read_data_rotated
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memmux_addr_b
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memmux_datain
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memmux_we
add wave -noupdate -group {instr cache 7} /etb/itop/ids/ids_top/ids_cpu7/iinstrcache/memmux_be
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/index
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_SAD
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_DAD
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_L
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/clk100
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/reset
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/savestate_bus
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/loading_savestate
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/ds_bus
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/ds_bus_data
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/new_cycles
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/new_cycles_valid
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/IRP_DMA
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_on
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/allow_on
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_soon
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/hblank_trigger
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/vblank_trigger
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/cardtrans_trigger
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/cardtrans_size
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/last_dma_out
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/last_dma_valid
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/last_dma_in
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_Adr
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_rnw
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_ena
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_acc
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_dout
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_din
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_done
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dma_bus_unread
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/is_idle
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/SAD
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/DAD
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_L
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/reg_wired_or
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/CNT_H_DMA_Enable_written
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Enable
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/running
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/waiting
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/first
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dmaon
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/waitTicks
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/dest_Addr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/source_Adr_Control
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Start_Timing
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Repeat
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/Transfer_Type_DW
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/iRQ_on
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/addr_source
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/addr_target
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/count
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/state
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/SAVESTATE_DMASOURCE
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/SAVESTATE_DMATARGET
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/SAVESTATE_DMAMIXED
add wave -noupdate -group dma7 -group dma70 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module0/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/index
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_SAD
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_DAD
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_L
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/clk100
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/reset
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/savestate_bus
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/loading_savestate
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/ds_bus
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/ds_bus_data
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/new_cycles
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/new_cycles_valid
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/IRP_DMA
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_on
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/allow_on
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_soon
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/hblank_trigger
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/vblank_trigger
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/last_dma_out
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/last_dma_valid
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/last_dma_in
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_Adr
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_rnw
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_ena
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_acc
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_dout
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_din
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_done
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dma_bus_unread
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/is_idle
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/SAD
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/DAD
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_L
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/reg_wired_or
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/CNT_H_DMA_Enable_written
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Enable
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/running
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/waiting
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/first
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dmaon
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/waitTicks
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/dest_Addr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/source_Adr_Control
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Start_Timing
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Repeat
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/Transfer_Type_DW
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/iRQ_on
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/addr_source
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/addr_target
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/count
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/state
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/SAVESTATE_DMASOURCE
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/SAVESTATE_DMATARGET
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/SAVESTATE_DMAMIXED
add wave -noupdate -group dma7 -group dma71 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module1/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/index
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_SAD
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_DAD
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_L
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/clk100
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/reset
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/savestate_bus
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/loading_savestate
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/ds_bus
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/ds_bus_data
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/new_cycles
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/new_cycles_valid
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/IRP_DMA
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_on
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/allow_on
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_soon
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/hblank_trigger
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/vblank_trigger
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/last_dma_out
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/last_dma_valid
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/last_dma_in
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_Adr
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_rnw
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_ena
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_acc
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_dout
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_din
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_done
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dma_bus_unread
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/is_idle
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/SAD
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/DAD
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_L
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/reg_wired_or
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/CNT_H_DMA_Enable_written
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Enable
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/running
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/waiting
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/first
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dmaon
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/waitTicks
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/dest_Addr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/source_Adr_Control
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Start_Timing
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Repeat
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/Transfer_Type_DW
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/iRQ_on
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/addr_source
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/addr_target
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/count
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/state
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/SAVESTATE_DMASOURCE
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/SAVESTATE_DMATARGET
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/SAVESTATE_DMAMIXED
add wave -noupdate -group dma7 -group dma72 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module2/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/index
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_SAD
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_DAD
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_L
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Reg_CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/clk100
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/reset
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/savestate_bus
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/loading_savestate
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/ds_bus
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/ds_bus_data
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/new_cycles
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/new_cycles_valid
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/IRP_DMA
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_on
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/allow_on
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_soon
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/hblank_trigger
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/vblank_trigger
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/last_dma_out
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/last_dma_valid
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/last_dma_in
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_Adr
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_rnw
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_ena
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_acc
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_dout
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_din
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_done
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dma_bus_unread
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/is_idle
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/SAD
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/DAD
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_L
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_Dest_Addr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_Source_Adr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_DMA_Repeat
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_DMA_Transfer_Type
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_DMA_Start_Timing
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_IRQ_on
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_DMA_Enable
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/reg_wired_or
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/CNT_H_DMA_Enable_written
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Enable
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/running
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/waiting
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/first
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dmaon
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/waitTicks
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/dest_Addr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/source_Adr_Control
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Start_Timing
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Repeat
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/Transfer_Type_DW
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/iRQ_on
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/addr_source
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/addr_target
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/count
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/state
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/SAVESTATE_DMASOURCE
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/SAVESTATE_DMATARGET
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/SAVESTATE_DMAMIXED
add wave -noupdate -group dma7 -group dma73 /etb/itop/ids/ids_top/ids_dma7/ids_dma_module3/SAVESTATE_DMAMIXED_BACK
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/reset
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/clk100
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/savestate_bus
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/loading_savestate
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/ds_bus
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/ds_bus_data
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/new_cycles
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/new_cycles_valid
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/IRP_DMA0
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/IRP_DMA1
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/IRP_DMA2
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/IRP_DMA3
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/lastread_dma
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_on
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/CPU_bus_idle
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/do_step
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_soon
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/hblank_trigger
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/vblank_trigger
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/MemDisplay_trigger
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/cardtrans_trigger
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/cardtrans_size
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_ena
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_addr
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_done
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_data
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_Adr
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_rnw
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_ena
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_acc
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_dout
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_din
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_done
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_bus_unread
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/debug_dma
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_Dout
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_Adr
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_acc
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_rnw
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_ena
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/Array_done
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/single_dma_on
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/single_allow_on
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/single_soon
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_switch
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/dma_idle
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma_value
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma0
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma1
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma2
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma3
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma_valid0
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma_valid1
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma_valid2
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/last_dma_valid3
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/single_is_idle
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/soundstate
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_soon
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_on
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/sounddata_req_dma
add wave -noupdate -group dma7 /etb/itop/ids/ids_top/ids_dma7/reg_wired_or
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/is_simu
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/isArm9
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/clk100
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/ds_on
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/reset
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/savestate_bus
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_Adr
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_rnw
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_ena
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_acc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_dout
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_din
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/OBus_1_done
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_lowbits
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/settle
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/cpu_IRQ
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/dma_on
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/do_step
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/done_7
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/CPU_bus_idle
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/PC_in_BIOS
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/lastread
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/jump_out
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/new_cycles_out
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/new_halt
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/debug_cpu_pc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/debug_cpu_mixed
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/thumbmode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/halt
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/IRQ_disable
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/FIQ_disable
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/Flag_Zero
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/Flag_Carry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/Flag_Negative
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/Flag_V_Overflow
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/cpu_mode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/cpu_mode_old
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/regs
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/regs_plus_12
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_pc_next
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/PC
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/jump
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/new_pc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/branchnext
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/blockr15jump
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_cycles
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_addcycles
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_addcycles
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/dataticksAccess16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/dataticksAccess32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/dataticksAccessSeq32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccess16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccess32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessSeq16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessSeq32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessJump16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessJump32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessSeqJump16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/codeticksAccessSeqJump32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/memoryWait16
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/memoryWait32
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/wait_fetch
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/skip_pending_fetch
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/fetch_available
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/fetch_data
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_request
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_data
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_PC
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_condition
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/state_decode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_start
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/calc_done
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/executebus
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_PC
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_PCprev
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/halt_cnt
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/irq_calc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/irq_delay
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/irq_triggerhold
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/calc_result
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/writeback_reg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_writeback_calc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_writeback_r17
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_writeback_userreg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_switchregs
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_saveregs
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_saveState
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_SWI
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_IRP
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/state_execute
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_functions_detail
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datareceivetype
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_clearbit1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_rdest
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_Rn_op1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_RM_op2
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_alu_use_immi
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_alu_use_shift
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_immidiate
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_shiftsettings
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_shiftcarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_useoldcarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_updateflags
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_muladd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_mul_signed
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_mul_useadd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_mul_long
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_writeback
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_switch_op
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_set_thumbmode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_branch_usereg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_branch_link
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_branch_immi
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_type
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_preadd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_addup
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_writeback
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_addvalue
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_shiftval
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_regoffset
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_datatransfer_swap
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_usermoderegs
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_switchmode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_addrmod
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_endmod
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_addrmod_baseRlist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_reglist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_block_emptylist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_psr_with_spsr
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_leaveirp
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/decode_leaveirp_user
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_functions_detail
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datareceivetype
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_clearbit1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_rdest
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_Rn_op1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_RM_op2
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_alu_use_immi
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_alu_use_shift
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_immidiate
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_shiftsettings
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_shiftcarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_useoldcarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_updateflags
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_muladd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_mul_signed
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_mul_useadd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_mul_long
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_writeback
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_switch_op
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_set_thumbmode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_branch_usereg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_branch_link
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_branch_immi
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_type
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_preadd
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_addup
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_writeback
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_addvalue
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_shiftval
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_regoffset
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_datatransfer_swap
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_usermoderegs
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_switchmode
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_addrmod
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_endmod
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_addrmod_baseRlist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_reglist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_block_emptylist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_psr_with_spsr
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_leaveirp
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/execute_leaveirp_user
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_stage
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_op1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_op2
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_result
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_result_add
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/alu_shiftercarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_stage
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_op1
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_op2
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_opaddlow
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_opaddhigh
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_result
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/mul_wait
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shifter_start
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftreg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftbyreg
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftwait
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftamount
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftervalue
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shift_rrx
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry_LSL
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry_RSL
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry_ARS
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry_ROR
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftercarry_RRX
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult_LSL
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult_RSL
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult_ARS
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult_ROR
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/shiftresult_RRX
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_fetch_Adr
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_fetch_rnw
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_execute_Adr
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_execute_rnw
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_execute_ena
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/bus_execute_acc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/data_rw_stage
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/busaddress
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/busaddmod
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/swap_write
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/first_mem_access
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_rw_stage
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_regindex
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/endaddress
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/endaddressRlist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_writevalue
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_reglist
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_switch_pc
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/block_hasPC
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/MSR_Stage
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/msr_value
add wave -noupdate -group cpu7 /etb/itop/ids/ids_top/ids_cpu7/msr_writebackvalue
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/IME
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/IE
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/IF_ALL
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/cpu_irq
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/REG_IME
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/REG_IE
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/REG_IF_ALL
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/IRPFLags
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/IF_written
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/ids_IRQ7/SAVESTATE_IRP
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_LCD_V_Blank
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_LCD_H_Blank
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_LCD_V_Counter_Match
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Timer_0_Overflow
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Timer_1_Overflow
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Timer_2_Overflow
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Timer_3_Overflow
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_SIO_RCNT_RTC
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_DMA_0
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_DMA_1
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_DMA_2
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_DMA_3
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Keypad
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_GBA_Slot
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_IPC_Sync
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_IPC_Send_FIFO_Empty
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_IPC_Recv_FIFO_Not_Empty
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_NDS_Slot_TransferComplete
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_NDS_Slot_IREQ_MC
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Screens_unfolding
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_SPI_bus
add wave -noupdate -group irq7 /etb/itop/ids/ids_top/IRQ7_Wifi
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/is_simu
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/index
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/Reg_L
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/Reg_H_Prescaler
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/Reg_H_Count_up
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/clk100
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/ds_on
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/reset
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/savestate_bus
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/loading_savestate
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/ds_bus
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/ds_bus_data
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/new_cycles
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/new_cycles_valid
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/countup_in
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/tick
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/IRP_Timer
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/debugout
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/L_Counter_Reload
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/H_Prescaler
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/H_Count_up
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/reg_wired_or
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/H_Timer_Start_Stop_written
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/counter_readback
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/counter
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/prescalecounter
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/prescaleborder
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/timer_on
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/timer_on_next
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/SAVESTATE_TIMER
add wave -noupdate -group timer7 -group timer70 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module0/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/is_simu
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/index
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/Reg_L
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/Reg_H_Prescaler
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/Reg_H_Count_up
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/ds_bus_data
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/new_cycles
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/tick
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/IRP_Timer
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/next_event
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/debugout
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/L_Counter_Reload
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/H_Prescaler
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/H_Count_up
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/reg_wired_or
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/H_Timer_Start_Stop_written
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/counter_readback
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/counter
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/prescalecounter
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/prescaleborder
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/timer_on
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/timer_on_next
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/SAVESTATE_TIMER
add wave -noupdate -group timer7 -group timer71 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module1/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/is_simu
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/index
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/Reg_L
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/Reg_H_Prescaler
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/Reg_H_Count_up
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/ds_bus_data
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/new_cycles
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/tick
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/IRP_Timer
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/debugout
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/L_Counter_Reload
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/H_Prescaler
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/H_Count_up
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/reg_wired_or
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/H_Timer_Start_Stop_written
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/counter_readback
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/counter
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/prescalecounter
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/prescaleborder
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/timer_on
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/timer_on_next
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/SAVESTATE_TIMER
add wave -noupdate -group timer7 -group timer72 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module2/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/is_simu
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/index
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/Reg_L
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/Reg_H_Prescaler
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/Reg_H_Count_up
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/Reg_H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/Reg_H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/ds_bus_data
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/new_cycles
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/tick
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/IRP_Timer
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/debugout
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/L_Counter_Reload
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/H_Prescaler
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/H_Count_up
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/H_Timer_IRQ_Enable
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/H_Timer_Start_Stop
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/reg_wired_or
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/H_Timer_Start_Stop_written
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/counter_readback
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/counter
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/prescalecounter
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/prescaleborder
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/timer_on
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/timer_on_next
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/SAVESTATE_TIMER
add wave -noupdate -group timer7 -group timer73 /etb/itop/ids/ids_top/ids_timer7/ids_timer_module3/SAVESTATE_TIMER_BACK
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/clk100
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/ds_on
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/reset
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/savestate_bus
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/loading_savestate
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/ds_bus
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/ds_bus_data
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/new_cycles
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/new_cycles_valid
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/IRP_Timer0
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/IRP_Timer1
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/IRP_Timer2
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/IRP_Timer3
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/debugout0
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/debugout1
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/debugout2
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/debugout3
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/timerticks
add wave -noupdate -group timer7 /etb/itop/ids/ids_top/ids_timer7/reg_wired_or
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/clk100
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/reset
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/ds_bus
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/ds_bus_data
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/new_cycles
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/new_cycles_valid
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/IRQ_Slot
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/dma_request
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/dma_size
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/gamecard_read
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/romaddress
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/readtype
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_addr
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_dataout
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_request
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_rnw
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_datain
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_SPI_Baudrate
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_SPI_Hold_Chipselect
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_SPI_Busy
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_NDS_Slot_Mode
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_Transfer_Ready_IRQ
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPICNT_NDS_Slot_Enable
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPIDATA
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_AUXSPIDATA_readback
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY1_gap1_length
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY2_encrypt_data
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_SE
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY2_Apply_Seed
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY1_gap2_length
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY2_encrypt_cmd
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_Data_Word_Status
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_Data_Block_size
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_Transfer_CLK_rate
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_KEY1_Gap_CLKs
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_RESB_Release_Reset
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_WR
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_Block_Start_Status
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_ROMCTRL_Block_Start_Status_back
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_Gamecard_bus_Command_1
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/REG_Gamecard_bus_Command_2
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/reg_wired_or
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/hold_written
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/enable_written
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/data_written
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/Start_written
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/address
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/transfercount
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/operationtype
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/workcnt
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/spi_oldcnt
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/csOld
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/auxspi_reset
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/cmd
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/write_enable
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/write_protect
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/addr_size
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/addr_counter
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/addr
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/autodetect
add wave -noupdate -group {gamecard 7} /etb/itop/ids/ids_top/ids_gamecard7/autodetectsize
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/clk100
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/ds_on
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/reset
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/ds_bus
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/ds_bus_data
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/Touch
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/TouchX
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/TouchY
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/spi_done
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/spi_active
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_read
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_addr
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_data
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_done
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Baudrate
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Busy_Flag
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Device_Select
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Transfer_Size
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Chipselect_Hold
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Interrupt_Request
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_SPI_Bus_Enable
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPIDATA_IN
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPIDATA_OUT
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/reg_wired_or
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Baudrate_written
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Device_Select_written
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPIDATA_written
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Device_Select_1
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/REG_SPICNT_Chipselect_Hold_1
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/register_access
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/last_command
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/powerman_control_written
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/powerman_control
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/powerman_regs
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firstbyte
add wave -noupdate -group spi_intern -radix unsigned /etb/itop/ids/ids_top/ids_SPI_intern/z1u
add wave -noupdate -group spi_intern -radix unsigned /etb/itop/ids/ids_top/ids_SPI_intern/z2u
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmwarestate
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_wordcnt
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/firmware_address
add wave -noupdate -group spi_intern /etb/itop/ids/ids_top/ids_SPI_intern/fireware_lowmux
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/clk100
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/reset
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/ds_bus
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/ds_bus_data
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/new_cycles
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/new_cycles_valid
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_out_L
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_out_R
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/req_ena
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/req_addr
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/req_done
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/req_data
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Volume_Mul
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Volume_Div
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Hold
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Panning
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Wave_Duty
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Repeat_Mode
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Format
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Start
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDCNT_Status
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDSAD
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDTMR
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDPNT
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/SOUNDLEN
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/Start_written
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Master_Volume
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Left_Output_from
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Right_Output_from
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Output_Ch1_to_Mixer
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Output_Ch3_to_Mixer
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Master_Enable
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDBIAS
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP0_Control
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP0_Capture_Source
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP0_Capture_Repeat
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP0_Capture_Format
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP0_Capture_Start_Status
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP1_Control
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP1_Capture_Source
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP1_Capture_Repeat
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP1_Capture_Format
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCAP1_Capture_Start_Status
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SNDCAP0DAD
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SNDCAP0LEN
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SNDCAP1DAD
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SNDCAP1LEN
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/reg_wired_or
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/adpcm_data
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/req_adpcm_addr
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/channelindex
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/wordindex
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/wordindex_next
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/paramdata
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/paramwrite
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/paramwritedata
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/paramaddr
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/freqCounter
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/Start_written_buffer
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/totallength
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/samplepos
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/timer
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/format
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/lfsr
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/psgcnt
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/databuffer
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/data_ptr
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/tableindex
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/adpcm_4bit
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/adpcm_diff
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/loopindex_reached
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/loopsample
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/loopindex
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sample
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sample_div
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sample_mul
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sample_mul_1
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_out_pan_L
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_out_pan_R
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_result_24_L
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_result_24_R
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/state
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Volume_Mul
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Volume_Div
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Panning
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Wave_Duty
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Repeat_Mode
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Format
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDCNT_Start
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDSAD
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDPNT
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/REG_SOUNDLEN
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_24_L
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_24_R
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_left_0_3
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_left_4_7
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_left_8_11
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_left_12_15
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_left_all
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_right_0_3
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_right_4_7
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_right_8_11
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_right_12_15
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sum_right_all
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_select_left
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_select_right
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_master_left
add wave -noupdate -group sound /etb/itop/ids/ids_top/ids_sound/sound_master_right
add wave -noupdate -group cycling /etb/itop/ids/clk100
add wave -noupdate -group cycling /etb/itop/ids/ids_top/ds_on_1
add wave -noupdate -group cycling /etb/itop/ids/ids_top/reset
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles_valid
add wave -noupdate -group cycling /etb/itop/ids/ids_top/free_running_counter
add wave -noupdate -group cycling /etb/itop/ids/ids_top/free_running_next
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_on9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_on7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_cycles_out9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_cycles_valid9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_cycles_out7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/dma_cycles_valid7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/do_step9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/do_step7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/done_9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/done_7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cpuirqdone9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/irq9_pending
add wave -noupdate -group cycling /etb/itop/ids/ids_top/irq9_disable
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cpu_irq9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cpuirqdone7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/irq7_pending
add wave -noupdate -group cycling /etb/itop/ids/ids_top/irq7_disable
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cpu_irq7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/next_event
add wave -noupdate -group cycling /etb/itop/ids/ids_top/nexteventall
add wave -noupdate -group cycling /etb/itop/ids/ids_top/settleticks
add wave -noupdate -group cycling /etb/itop/ids/ids_top/waitsettle_all
add wave -noupdate -group cycling /etb/itop/ids/ids_top/waitsettle_IPC
add wave -noupdate -group cycling /etb/itop/ids/ids_top/haltcnt
add wave -noupdate -group cycling -radix unsigned /etb/itop/ids/ids_top/totalticks
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cyclestate
add wave -noupdate -group cycling /etb/itop/ids/ids_top/donewait
add wave -noupdate -group cycling -radix unsigned /etb/itop/ids/ids_top/CPU9_totalticks
add wave -noupdate -group cycling -radix unsigned /etb/itop/ids/ids_top/CPU7_totalticks
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles9_valid
add wave -noupdate -group cycling /etb/itop/ids/ids_top/halt9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_cycles7_valid
add wave -noupdate -group cycling /etb/itop/ids/ids_top/halt7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_export
add wave -noupdate -group cycling /etb/itop/ids/ids_top/export_cpu9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/export_cpu7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/gexport/ids_vcd_export/IF_intern9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/gexport/ids_vcd_export/IF_intern7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/export_timer9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/export_timer7
add wave -noupdate -group cycling -radix decimal /etb/itop/ids/ids_top/cycles_ahead9
add wave -noupdate -group cycling -radix decimal /etb/itop/ids/ids_top/cycles_ahead7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/WaitAhead9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/WaitAhead7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cycle_slowdown
add wave -noupdate -group cycling /etb/itop/ids/ids_top/new_missing
add wave -noupdate -group cycling -radix unsigned /etb/itop/ids/ids_top/cycles_ahead
add wave -noupdate -group cycling /etb/itop/ids/ids_top/cycles_66_100
add wave -noupdate -group cycling /etb/itop/ids/ids_top/VSyncCounter
add wave -noupdate -group cycling /etb/itop/ids/ids_top/vsyncspeedpoint
add wave -noupdate -group cycling /etb/itop/ids/ids_top/CyclesVsync9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/CyclesVsync7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/CyclesIdle9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/CyclesIdle7
add wave -noupdate -group cycling /etb/itop/ids/ids_top/commandcount
add wave -noupdate -group cycling /etb/itop/ids/ids_top/debug_dma_count9
add wave -noupdate -group cycling /etb/itop/ids/ids_top/debug_dma_count7
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {674233270000 ps} 0} {{Cursor 2} {690919270000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 466
configure wave -valuecolwidth 129
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {586006727687 ps} {767508932313 ps}
