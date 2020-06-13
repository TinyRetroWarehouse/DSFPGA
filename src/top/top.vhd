library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

library reg_map;
use reg_map.pReg_test.all;
use reg_map.pReg_External.all;
use reg_map.pReg_audio.all;
use reg_map.pReg_gpu.all; 


library audio;
library hdmi;
library ds;


entity eTop  is
   generic
   (
      is_simu        : std_logic := '0';
      vgattxoff      : std_logic := '1';
      FB1ttxon       : std_logic := '0';
      FB2ttxon       : std_logic := '0';
      gba_off        : std_logic := '1';
      ds_nogpu       : std_logic := '0'
   );
   port 
   (
      clk            : in     std_logic;
               
      sw             : in     std_logic_vector(7 downto 0);
               
      led            : out    std_logic_vector(7 downto 0);
         
      ftdi_d         : inout  std_logic_vector(7 downto 0);
      ftdi_rdn       : out    std_logic := '1';
      ftdi_rxen      : in     std_logic;
      ftdi_siwun     : out    std_logic;
      ftdi_txen      : in     std_logic;
      ftdi_wrn       : out    std_logic;
      
      hdmi_tx_clk_n  : out    std_logic;
      hdmi_tx_clk_p  : out    std_logic;
      hdmi_tx_p      : out    std_logic_vector(2 downto 0);
      hdmi_tx_n      : out    std_logic_vector(2 downto 0);
      
      ddr3_dq        : inout  std_logic_vector(15 downto 0);
      ddr3_dqs_p     : inout  std_logic_vector(1 downto 0);
      ddr3_dqs_n     : inout  std_logic_vector(1 downto 0);
      ddr3_addr      : out    std_logic_vector(14 downto 0);
      ddr3_ba        : out    std_logic_vector(2 downto 0);
      ddr3_ras_n     : out    std_logic;
      ddr3_cas_n     : out    std_logic;
      ddr3_we_n      : out    std_logic;
      ddr3_reset_n   : out    std_logic;
      ddr3_ck_p      : out    std_logic_vector(0 downto 0);
      ddr3_ck_n      : out    std_logic_vector(0 downto 0);
      ddr3_cke       : out    std_logic_vector(0 downto 0);
      ddr3_dm        : out    std_logic_vector(1 downto 0);
      ddr3_odt       : out    std_logic_vector(0 downto 0);
      
      ac_adc_sdata   : in     std_logic;
      ac_bclk        : out    std_logic;
      ac_dac_sdata   : out    std_logic;
      ac_lrclk       : out    std_logic;
      ac_mclk        : out    std_logic;
      
      scl            : inout  std_logic;
      sda            : inout  std_logic
   );
end entity;

architecture arch of eTop is

   signal clk100_mig : std_logic;
   signal clk100     : std_logic;
   signal clk200     : std_logic;
   signal clk12      : std_logic;
   signal clk50      : std_logic;
   signal pixclk     : std_logic;
   
   signal reset_cnt : integer range 0 to 4095 := 4095;
   signal reset     : std_logic := '1';
   
   signal bus_in     : proc_bus_intype;
   signal bus_Dout   : std_logic_vector(proc_buswidth-1 downto 0);
   signal bus_done   : std_logic;
   
   signal ftdi_timeout_error : std_logic;
   
   signal Simu       : std_logic_vector(0 downto 0);
   signal testreg    : std_logic_vector(31 downto 0);
   signal Errorflags : std_logic_vector(31 downto 0);
   
   signal led_buffer : std_logic_vector(7 downto 0);
   
   -- HDMI
   signal pixel_x    : integer range 0 to 1279;
   signal pixel_y    : integer range 0 to 719;
   signal color_r    : std_logic_vector(7 downto 0);
   signal color_g    : std_logic_vector(7 downto 0);
   signal color_b    : std_logic_vector(7 downto 0);
   
   -- DDRRam
   signal DDRLatency         : std_logic_vector(15 downto 0) := (others => '0');
   signal DDRLatencyCnt      : unsigned(15 downto 0) := (others => '0');
   
   signal ddr_calib_complete : std_logic;
   
   signal ddr_addr           : std_logic_vector(28 downto 0);
   signal ddr_cmd            : std_logic_vector(2 downto 0);
   signal ddr_en             : std_logic := '0';
   signal ddr_wdf_data       : std_logic_vector(127 downto 0);
   signal ddr_wdf_end        : std_logic := '0';
   signal ddr_wdf_mask       : std_logic_vector(15 downto 0);
   signal ddr_wdf_wren       : std_logic := '0';
   signal ddr_rd_data        : std_logic_vector(127 downto 0);
   signal ddr_rd_data_end    : std_logic;
   signal ddr_rd_data_valid  : std_logic;
   signal ddr_rdy            : std_logic;
   signal ddr_wdf_rdy        : std_logic;
   signal ddr_sr_req         : std_logic;
   signal ddr_ref_req        : std_logic;
   signal ddr_zq_req         : std_logic;
   signal ddr_sr_active      : std_logic;
   signal ddr_ref_ack        : std_logic;
   signal ddr_zq_ack         : std_logic;
                             
   signal ddr_debugout       : std_logic_vector(31 downto 0);
   signal ddr_gbaout         : std_logic_vector(31 downto 0);
   signal ddr_gbaromout      : std_logic_vector(31 downto 0);
   signal ddr_debugdone      : std_logic := '0';
   
   signal ddr_readreq_debug  : std_logic := '0';
   signal ddr_readreq_ds     : std_logic := '0';
   signal ddr_readreq_gba    : std_logic := '0';
   signal ddr_readreq_cart   : std_logic := '0';
   
   -- audio
   signal Audio_Source         : std_logic_vector(REG_Audio_Source      .upper downto REG_Audio_Source      .lower) := (others => '0');
   signal Audio_Value          : std_logic_vector(REG_Audio_Value       .upper downto REG_Audio_Value       .lower) := (others => '0');
   signal Audio_SquarePeriod   : std_logic_vector(REG_Audio_SquarePeriod.upper downto REG_Audio_SquarePeriod.lower) := (others => '0');
   
   signal aud_data_in          : std_logic_vector(31 downto 0);
   signal aud_square_cnt       : unsigned(REG_Audio_SquarePeriod.upper downto REG_Audio_SquarePeriod.lower) := (others => '0');
   signal aud_square_value     : std_logic_vector(15 downto 0) := (others => '0');

   component audio_init
   port
   (
      clk : in std_logic;
      rst : in std_logic;
      sda : inout std_logic;
      scl : inout std_logic
   );
   end component;
   
   -- GBA
   signal aud_gba_left         : std_logic_vector(15 downto 0) := (others => '0');
   signal aud_gba_right        : std_logic_vector(15 downto 0) := (others => '0');

   -- DS
   signal DS_RAM_Adr           : std_logic_vector(28 downto 0);
   signal DS_RAM_rnw           : std_logic;
   signal DS_RAM_ena           : std_logic;
   signal DS_RAM_be            : std_logic_vector(3 downto 0);
   signal DS_RAM_128           : std_logic;
   signal DS_RAM_dout          : std_logic_vector(31 downto 0);
   signal DS_RAM_dout128       : std_logic_vector(127 downto 0);
   signal DS_RAM_din           : std_logic_vector(31 downto 0);
   signal DS_RAM_din128        : std_logic_vector(127 downto 0);
   signal DS_RAM_done          : std_logic;
   
   signal pixel_DSA_x          : integer range 0 to 255;
   signal pixel_DSA_y          : integer range 0 to 191;
   signal pixel_DSA_data       : std_logic_vector(17 downto 0);  
   signal pixel_DSA_we         : std_logic;
   signal pixel_DSB_x          : integer range 0 to 255;
   signal pixel_DSB_y          : integer range 0 to 191;
   signal pixel_DSB_data       : std_logic_vector(17 downto 0);  
   signal pixel_DSB_we         : std_logic;
   
   signal TouchX               : std_logic_vector(7 downto 0);
   signal TouchY               : std_logic_vector(7 downto 0);
   
   -- framebuffer
   signal framebuffer_graphic1 : std_logic_vector(17 downto 0);
   signal framebuffer_graphic2 : std_logic_vector(17 downto 0);
   signal framebuffer_active1  : std_logic;
   signal framebuffer_active2  : std_logic;
   
begin 

   -----------------------------------------------------------------
   ------------- Clock generation        ---------------------------
   -----------------------------------------------------------------

   iclk_wiz : entity work.clk_wiz
   port map
   (
      clk_in1  => clk,
      clk100   => clk100_mig,
      clk200   => clk200,
      clk12    => clk12,
      clk50    => clk50
   );
   
   process (clk100_mig)
   begin
      if rising_edge(clk100_mig) then
      
         if (reset_cnt > 0) then
            reset_cnt <= reset_cnt - 1;
         else
            reset <= '0';
         end if;
      
      end if;
   end process;
   
   -----------------------------------------------------------------
   ------------- Debug access        -------------------------------
   -----------------------------------------------------------------
   
   iTestprocessor : entity procbus.eTestprocessor
   port map
   (
      clk             => clk100,        
      debugaccess     => '1',
                           
      ftdi_d          => ftdi_d,     
      ftdi_rdn        => ftdi_rdn,   
      ftdi_rxen       => ftdi_rxen,  
      ftdi_siwun      => ftdi_siwun, 
      ftdi_txen       => ftdi_txen,  
      ftdi_wrn        => ftdi_wrn,   
                
      bus_in          => bus_in,
      bus_Dout        => bus_Dout,
      bus_done        => bus_done,
                   
      timeout_error   => ftdi_timeout_error
   );
   
   Errorflags(31 downto 1) <= (others => '0');
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         if (ftdi_timeout_error = '1') then Errorflags(0) <= '1'; end if;
         --ddr_calib_complete
      
      end if;
   end process;
   
   
   Simu(0) <= is_simu;
   iReg_Simu      : entity procbus.eProcReg generic map ( Reg_Simu       ) port map  (clk100, bus_in, bus_Dout, bus_done, Simu);
   iReg_Testreg   : entity procbus.eProcReg generic map ( Reg_Testreg    ) port map  (clk100, bus_in, bus_Dout, bus_done, testreg, testreg);
   iReg_Errorflags: entity procbus.eProcReg generic map ( Reg_Errorflags ) port map  (clk100, bus_in, bus_Dout, bus_done, Errorflags);
   
   iReg_DDRLatency: entity procbus.eProcReg generic map ( Reg_DDRLatency ) port map  (clk100, bus_in, bus_Dout, bus_done, DDRLatency);
   
   iReg_LED       : entity procbus.eProcReg generic map ( Reg_LED        ) port map  (clk100, bus_in, bus_Dout, bus_done, led_buffer, led_buffer);
   iReg_Switches  : entity procbus.eProcReg generic map ( Reg_Switches   ) port map  (clk100, bus_in, bus_Dout, bus_done, sw);
   led <= led_buffer;
   
   -- testblock for speedtest
   bus_Dout <= x"AA55AA55" when (unsigned(bus_in.Adr) >= 128 and unsigned(bus_in.Adr) < 256) else (others => 'Z');
   bus_done <= '1'         when (unsigned(bus_in.Adr) >= 128 and unsigned(bus_in.Adr) < 256) else 'Z'; 
   
   
   -----------------------------------------------------------------
   ------------- HDMI           ------------------------------------
   -----------------------------------------------------------------
   
   ihdmi_out : entity hdmi.hdmi_out
   generic map
   (
      is_simu   => is_simu,
      vgattxoff => vgattxoff
   )
   port map
   (
      clk     => clk,
      rst     => reset,
      
      pixclk  => pixclk,
      pixel_x => pixel_x,
      pixel_y => pixel_y,
      color_r => color_r,
      color_g => color_g,
      color_b => color_b,
      
      clk_p   => hdmi_tx_clk_p,
      clk_n   => hdmi_tx_clk_n,
      data_p  => hdmi_tx_p,    
      data_n  => hdmi_tx_n    
   );
   
   -----------------------------------------------------------------
   ------------- DDRRam         ------------------------------------
   -----------------------------------------------------------------
   
   
   imig_7series_0 : entity work.mig_7series_0
   port map
   (
      sys_clk_i            => clk100_mig,          --in    std_logic;
      clk_ref_i            => clk200,              --in    std_logic; 
      sys_rst              => reset,               --in    std_logic;
      ui_clk               => clk100,              --out   std_logic;
      ui_clk_sync_rst      => open,                --out   std_logic;
      init_calib_complete  => ddr_calib_complete,  --out   std_logic;
                       
      ddr3_dq              => ddr3_dq,             --inout std_logic_vector(15 downto 0);
      ddr3_dqs_p           => ddr3_dqs_p,          --inout std_logic_vector(1 downto 0);
      ddr3_dqs_n           => ddr3_dqs_n,          --inout std_logic_vector(1 downto 0);
      ddr3_addr            => ddr3_addr,           --out   std_logic_vector(14 downto 0);
      ddr3_ba              => ddr3_ba,             --out   std_logic_vector(2 downto 0);
      ddr3_ras_n           => ddr3_ras_n,          --out   std_logic;
      ddr3_cas_n           => ddr3_cas_n,          --out   std_logic;
      ddr3_we_n            => ddr3_we_n,           --out   std_logic;
      ddr3_reset_n         => ddr3_reset_n,        --out   std_logic;
      ddr3_ck_p            => ddr3_ck_p,           --out   std_logic_vector(0 downto 0);
      ddr3_ck_n            => ddr3_ck_n,           --out   std_logic_vector(0 downto 0);
      ddr3_cke             => ddr3_cke,            --out   std_logic_vector(0 downto 0);
      ddr3_dm              => ddr3_dm,             --out   std_logic_vector(1 downto 0);
      ddr3_odt             => ddr3_odt,            --out   std_logic_vector(0 downto 0);
                 
      app_addr             => ddr_addr,            --in    std_logic_vector(28 downto 0);
      app_cmd              => ddr_cmd,             --in    std_logic_vector(2 downto 0);
      app_en               => ddr_en,              --in    std_logic;
      app_wdf_data         => ddr_wdf_data,        --in    std_logic_vector(127 downto 0);
      app_wdf_end          => ddr_wdf_end,         --in    std_logic;
      app_wdf_mask         => ddr_wdf_mask,        --in    std_logic_vector(15 downto 0);
      app_wdf_wren         => ddr_wdf_wren,        --in    std_logic;
      app_rd_data          => ddr_rd_data,         --out   std_logic_vector(127 downto 0);
      app_rd_data_end      => ddr_rd_data_end,     --out   std_logic;
      app_rd_data_valid    => ddr_rd_data_valid,   --out   std_logic;
      app_rdy              => ddr_rdy,             --out   std_logic;
      app_wdf_rdy          => ddr_wdf_rdy,         --out   std_logic;
      app_sr_req           => ddr_sr_req,          --in    std_logic;
      app_ref_req          => ddr_ref_req,         --in    std_logic;
      app_zq_req           => ddr_zq_req,          --in    std_logic;
      app_sr_active        => ddr_sr_active,       --out   std_logic;
      app_ref_ack          => ddr_ref_ack,         --out   std_logic;
      app_zq_ack           => ddr_zq_ack           --out   std_logic;
   );
   
   ddr_sr_req  <= '0'; -- This input is reserved and should be tied to 0.
   ddr_ref_req <= '0'; -- refresh request, pulse once and wait for ddr_ref_ack
   ddr_zq_req  <= '0'; -- calibration request, pulse once and wait for ddr_zq_ack
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         ddr_debugdone       <= '0';
         --DS_RAM_done         <= '0';
         
         ddr_wdf_wren  <= '0';
         ddr_wdf_end   <= '0';
         
         if (ddr_en = '1' and ddr_cmd = "001") then
            DDRLatencyCnt <= (others => '0');
         else
            DDRLatencyCnt <= DDRLatencyCnt + 1;
         end if;
         
         if (ddr_rd_data_valid = '1') then
            DDRLatency <= std_logic_vector(DDRLatencyCnt);
         end if;
      
         -- request
         if (bus_in.ena = '1' and bus_in.Adr(bus_in.Adr'left) = '1') then
            ddr_en       <= '1';
            ddr_addr     <= '0' & bus_in.Adr(26 downto 2) & "000"; -- byte address
            
            case (bus_in.Adr(1 downto 0)) is
               when "00" => ddr_wdf_data <= (127 downto 32 => '0') & bus_in.Din;                        ddr_wdf_mask <= x"FFF0";
               when "01" => ddr_wdf_data <= (127 downto 64 => '0') & bus_in.Din & (31 downto 0 => '0'); ddr_wdf_mask <= x"FF0F";
               when "10" => ddr_wdf_data <= (127 downto 96 => '0') & bus_in.Din & (63 downto 0 => '0'); ddr_wdf_mask <= x"F0FF";
               when "11" => ddr_wdf_data <= bus_in.Din & (95 downto 0 => '0');                          ddr_wdf_mask <= x"0FFF";
               when others => null;
            end case;
            
            if (bus_in.rnw = '1') then
               ddr_cmd           <= "001";
               ddr_readreq_debug <= '1';
            else
               ddr_cmd       <= "000";
               ddr_wdf_wren  <= '1';
               ddr_wdf_end   <= '1';
            end if;
            
         elsif (DS_RAM_ena = '1') then
            
            ddr_en       <= '1';
            ddr_addr     <=  '0' & DS_RAM_Adr(28 downto 4) & "000"; -- byte address
            
            if (DS_RAM_128 = '1') then
               ddr_wdf_mask <= (others => '0');
               ddr_wdf_data <= DS_RAM_dout128;
            else
               case (DS_RAM_Adr(3 downto 2)) is
                  when "00" => ddr_wdf_data <= (127 downto 32 => '0') & DS_RAM_dout;                        ddr_wdf_mask <= x"FFF" & (not DS_RAM_be);
                  when "01" => ddr_wdf_data <= (127 downto 64 => '0') & DS_RAM_dout & (31 downto 0 => '0'); ddr_wdf_mask <= x"FF" & (not DS_RAM_be) & x"F";
                  when "10" => ddr_wdf_data <= (127 downto 96 => '0') & DS_RAM_dout & (63 downto 0 => '0'); ddr_wdf_mask <= x"F" & (not DS_RAM_be) & x"FF";
                  when "11" => ddr_wdf_data <= DS_RAM_dout & (95 downto 0 => '0');                          ddr_wdf_mask <= (not DS_RAM_be) & x"FFF";
                  when others => null;
               end case;
            end if;
            
            if (DS_RAM_rnw = '1') then
               ddr_cmd         <= "001";
               ddr_readreq_ds  <= '1';
            else
               ddr_cmd       <= "000";
               ddr_wdf_wren  <= '1';
               ddr_wdf_end   <= '1';
            end if;
           
         end if;  

         -- accepted
         if (ddr_en = '1' and ddr_rdy = '1') then
            ddr_en        <= '0';
            if (bus_in.rnw = '0')       then ddr_debugdone     <= '1'; end if;
            --if (DS_RAM_rnw = '0')       then DS_RAM_done       <= '1'; end if;
         end if;
         
         -- reading done
         if (ddr_rd_data_valid = '1') then
            case (bus_in.Adr(1 downto 0)) is
               when "00" => ddr_debugout <= ddr_rd_data( 31 downto  0);
               when "01" => ddr_debugout <= ddr_rd_data( 63 downto 32);
               when "10" => ddr_debugout <= ddr_rd_data( 95 downto 64);
               when "11" => ddr_debugout <= ddr_rd_data(127 downto 96);
               when others => null;
            end case;
            if (ddr_readreq_debug = '1') then
               ddr_readreq_debug <= '0';
               ddr_debugdone     <= '1';
            end if;    

            
            --case (DS_RAM_Adr(3 downto 2)) is
            --   when "00" => DS_RAM_din <= ddr_rd_data( 31 downto  0);
            --   when "01" => DS_RAM_din <= ddr_rd_data( 63 downto 32);
            --   when "10" => DS_RAM_din <= ddr_rd_data( 95 downto 64);
            --   when "11" => DS_RAM_din <= ddr_rd_data(127 downto 96);
            --   when others => null;
            --end case;
            if (ddr_readreq_ds = '1') then
               ddr_readreq_ds <= '0';
               --DS_RAM_done    <= '1';
            end if; 
                 
         end if;
      
      end if;
   end process;
   
   DS_RAM_din128 <= ddr_rd_data;
   DS_RAM_done <= '1' when ((DS_RAM_rnw = '0' and ddr_en = '1' and ddr_rdy = '1') or ddr_rd_data_valid = '1') else '0';
   
   DS_RAM_din <= ddr_rd_data( 31 downto  0) when (DS_RAM_Adr(3 downto 2) = "00") else
                 ddr_rd_data( 63 downto 32) when (DS_RAM_Adr(3 downto 2) = "01") else
                 ddr_rd_data( 95 downto 64) when (DS_RAM_Adr(3 downto 2) = "10") else
                 ddr_rd_data(127 downto 96);
   
   bus_Dout <= ddr_debugout  when (bus_in.Adr(bus_in.Adr'left) = '1') else (others => 'Z');
   bus_done <= ddr_debugdone when (bus_in.Adr(bus_in.Adr'left) = '1') else 'Z'; 
   
   -----------------------------------------------------------------
   ------------- Audio          ------------------------------------
   -----------------------------------------------------------------
   
   iaudio_init: audio_init
   port map
   (
      clk => clk50,
      rst => reset,
      sda => sda,
      scl => scl
   );
   
   ii2s_ctl : entity audio.i2s_ctl
   generic map
   (
      C_DATA_WIDTH => 16
   )
   port map
   (
      CLK_I   => clk100,
      RST_I   => reset,
      EN_TX_I => '1',
      EN_RX_I => '1',
      MM_I    => '0',
      D_L_I   => aud_data_in(31 downto 16),  
      D_R_I   => aud_data_in(15 downto 0),  
      D_L_O   => open,    
      D_R_O   => open,    
      BCLK_O  => ac_bclk,   
      LRCLK_O => ac_lrclk,  
      SDATA_O => ac_dac_sdata,  
      SDATA_I => ac_adc_sdata   
   ); 

   iREG_Audio_Source       : entity procbus.eProcReg generic map ( REG_Audio_Source       ) port map  (clk100, bus_in, bus_Dout, bus_done, Audio_Source      , Audio_Source      );
   iREG_Audio_Value        : entity procbus.eProcReg generic map ( REG_Audio_Value        ) port map  (clk100, bus_in, bus_Dout, bus_done, Audio_Value       , Audio_Value       );
   iREG_Audio_SquarePeriod : entity procbus.eProcReg generic map ( REG_Audio_SquarePeriod ) port map  (clk100, bus_in, bus_Dout, bus_done, Audio_SquarePeriod, Audio_SquarePeriod);

   aud_data_in <= x"00000000" when Audio_Source = "00" else
                  Audio_Value & Audio_Value when Audio_Source = "01" else
                  aud_square_value & aud_square_value when Audio_Source = "10" else
                  aud_gba_left & aud_gba_right;
                  
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         if (aud_square_cnt > 0) then
            aud_square_cnt <= aud_square_cnt - 1;
         else
            aud_square_cnt   <= unsigned(Audio_SquarePeriod);
            aud_square_value(14 downto 0) <= not aud_square_value(14 downto 0);
         end if;
      
      end if;
   end process;
  
   -----------------------------------------------------------------
   ------------- DS             ------------------------------------
   -----------------------------------------------------------------

   ids : entity ds.ds
   generic map
   (
      is_simu   => is_simu,
      ds_nogpu  => ds_nogpu 
   )
   port map
   (
      clk100             => clk100,
      
      bus_in             => bus_in, 
      bus_Dout           => bus_Dout,
      bus_done           => bus_done,
      
      -- RAM access
      DS_RAM_Adr         => DS_RAM_Adr, 
      DS_RAM_rnw         => DS_RAM_rnw, 
      DS_RAM_ena         => DS_RAM_ena, 
      DS_RAM_be          => DS_RAM_be, 
      DS_RAM_128         => DS_RAM_128, 
      DS_RAM_dout        => DS_RAM_dout,
      DS_RAM_dout128     => DS_RAM_dout128,
      DS_RAM_din         => DS_RAM_din, 
      DS_RAM_din128      => DS_RAM_din128, 
      DS_RAM_done        => DS_RAM_done,
      -- display data
      pixel_out1_x       => pixel_DSA_x,
      pixel_out1_y       => pixel_DSA_y,
      pixel_out1_data    => pixel_DSA_data,
      pixel_out1_we      => pixel_DSA_we,  
      pixel_out2_x       => pixel_DSB_x,
      pixel_out2_y       => pixel_DSB_y,
      pixel_out2_data    => pixel_DSB_data,
      pixel_out2_we      => pixel_DSB_we,  
      -- sound                            
      sound_out_left     => aud_gba_left,
      sound_out_right    => aud_gba_right,
      --touch
      TouchX             => TouchX,
      TouchY             => TouchY
   );

   -----------------------------------------------------------------
   ------------- Framebuffer ---------------------------------------
   -----------------------------------------------------------------

   iframebuffer : entity work.framebuffer
   generic map
   (
      isSecond              => '0',
      drawmarker            => '0',
      drawfile              => FB1ttxon,
      FRAMESIZE_X           => 256,
      FRAMESIZE_Y           => 192,
      Reg_Framebuffer_PosX  => Reg_Framebuffer_PosX, 
      Reg_Framebuffer_PosY  => Reg_Framebuffer_PosY, 
      Reg_Framebuffer_SizeX => Reg_Framebuffer_SizeX,
      Reg_Framebuffer_SizeY => Reg_Framebuffer_SizeY,
      Reg_Framebuffer_Scale => Reg_Framebuffer_Scale,
      Reg_Framebuffer_LCD   => Reg_Framebuffer_LCD  
   )
   port map
   (
      clk100             => clk100,
      
      bus_in             => bus_in, 
      bus_Dout           => bus_Dout,
      bus_done           => bus_done,
                          
      pixel_in_x         => pixel_DSA_x,
      pixel_in_y         => pixel_DSA_y,
      pixel_in_data      => pixel_DSA_data,
      pixel_in_we        => pixel_DSA_we, 
                            
      clkvga             => pixclk,      
      oCoord_X           => pixel_x,   
      oCoord_Y           => pixel_y,   
      pixel_out_data     => framebuffer_graphic1,
      framebuffer_active => framebuffer_active1,
      
      markerX            => x"00",
      markerY            => x"00"
   );

   iframebuffer2 : entity work.framebuffer
   generic map
   (
      isSecond              => '1',
      drawmarker            => '1',
      drawfile              => FB2ttxon,
      FRAMESIZE_X           => 256,
      FRAMESIZE_Y           => 192,
      Reg_Framebuffer_PosX  => Reg_Framebuffer2_PosX, 
      Reg_Framebuffer_PosY  => Reg_Framebuffer2_PosY, 
      Reg_Framebuffer_SizeX => Reg_Framebuffer2_SizeX,
      Reg_Framebuffer_SizeY => Reg_Framebuffer2_SizeY,
      Reg_Framebuffer_Scale => Reg_Framebuffer2_Scale,
      Reg_Framebuffer_LCD   => Reg_Framebuffer2_LCD  
   )
   port map
   (
      clk100             => clk100,
      
      bus_in             => bus_in, 
      bus_Dout           => bus_Dout,
      bus_done           => bus_done,
                          
      pixel_in_x         => pixel_DSB_x,
      pixel_in_y         => pixel_DSB_y,
      pixel_in_data      => pixel_DSB_data,
      pixel_in_we        => pixel_DSB_we, 
                            
      clkvga             => pixclk,      
      oCoord_X           => pixel_x,   
      oCoord_Y           => pixel_y,   
      pixel_out_data     => framebuffer_graphic2,
      framebuffer_active => framebuffer_active2,
      
      markerX            => TouchX,
      markerY            => TouchY
   );
   
   color_r <= framebuffer_graphic1(17 downto 12) & "00" when framebuffer_active1 = '1' else framebuffer_graphic2(17 downto 12) & "00";
   color_g <= framebuffer_graphic1(11 downto  6) & "00" when framebuffer_active1 = '1' else framebuffer_graphic2(11 downto  6) & "00";
   color_b <= framebuffer_graphic1( 5 downto  0) & "00" when framebuffer_active1 = '1' else framebuffer_graphic2( 5 downto  0) & "00";
   
   -----------------------------------------------------------------
   ------------- Chipscope         ---------------------------------
   -----------------------------------------------------------------
   
   --iila_0 : entity  work.ila_0
   --port map
   --(
   --   clk        => clk100,
   --   probe0     => ddr_addr,         
   --   probe1     => ddr_cmd,          
   --   probe2(0)  => ddr_en,           
   --   probe3     => ddr_wdf_data(31 downto 0),     
   --   probe4(0)  => ddr_wdf_end,      
   --   probe5     => ddr_wdf_mask,     
   --   probe6(0)  => ddr_wdf_wren,     
   --   probe7     => ddr_rd_data(31 downto 0),      
   --   probe8(0)  => ddr_rd_data_end,  
   --   probe9(0)  => ddr_rd_data_valid,
   --   probe10(0) => ddr_rdy,          
   --   probe11(0) => ddr_wdf_rdy      
   --);
   
end architecture;


 