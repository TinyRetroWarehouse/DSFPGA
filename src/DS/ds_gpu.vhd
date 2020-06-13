library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;
use work.pReg_ds_display_9.all;
use work.pReg_ds_system_9.all;

entity ds_gpu is
   generic
   (
      is_simu  : std_logic;
      ds_nogpu : std_logic
   );
   port 
   (
      clk100               : in     std_logic;  
      ds_on                : in     std_logic;
      reset                : in     std_logic;
      
      ds_bus9              : in     proc_bus_ds_type;
      ds_bus9_data         : out    std_logic_vector(31 downto 0); 
      ds_bus7              : in     proc_bus_ds_type;
      ds_bus7_data         : out    std_logic_vector(31 downto 0); 
                      
      lockspeed            : in     std_logic;
      maxpixels            : in     std_logic;
                                    
      pixel_out1_x         : out    integer range 0 to 255;
      pixel_out1_y         : out    integer range 0 to 191;
      pixel_out1_data      : out    std_logic_vector(17 downto 0);  
      pixel_out1_we        : out    std_logic := '0';
      pixel_out2_x         : out    integer range 0 to 255;
      pixel_out2_y         : out    integer range 0 to 191;
      pixel_out2_data      : out    std_logic_vector(17 downto 0);  
      pixel_out2_we        : out    std_logic := '0';
                                    
      new_cycles           : in     unsigned(7 downto 0);
      new_cycles_valid     : in     std_logic;
                                    
      IRP_HBlank9          : out    std_logic;
      IRP_HBlank7          : out    std_logic;
      IRP_VBlank9          : out    std_logic;
      IRP_VBlank7          : out    std_logic;
      IRP_LCDStat9         : out    std_logic;
      IRP_LCDStat7         : out    std_logic;
                           
      hblank_trigger       : buffer std_logic;
      vblank_trigger       : buffer std_logic;
      MemDisplay_trigger   : out    std_logic;
                           
      Palette_addr         : in     natural range 0 to 127;
      Palette_datain       : in     std_logic_vector(31 downto 0);
      Palette_dataout_bgA  : out    std_logic_vector(31 downto 0);
      Palette_dataout_objA : out    std_logic_vector(31 downto 0);
      Palette_dataout_bgB  : out    std_logic_vector(31 downto 0);
      Palette_dataout_objB : out    std_logic_vector(31 downto 0);
      Palette_we_bgA       : in     std_logic := '0';
      Palette_we_objA      : in     std_logic := '0';
      Palette_we_bgB       : in     std_logic := '0';
      Palette_we_objB      : in     std_logic := '0';
      Palette_be           : in     std_logic_vector(3 downto 0);
      
      OAMRam_addr          : in     natural range 0 to 255;
      OAMRam_datain        : in     std_logic_vector(31 downto 0);
      OAMRam_dataout_A     : out    std_logic_vector(31 downto 0);
      OAMRam_dataout_B     : out    std_logic_vector(31 downto 0);
      OAMRam_we_A          : in     std_logic := '0';
      OAMRam_we_B          : in     std_logic := '0';
      OAMRam_be            : in     std_logic_vector(3 downto 0);
      
      vram_ENA_A           : in  std_logic;
      vram_MST_A           : in  std_logic_vector(1 downto 0);
      vram_Offset_A        : in  std_logic_vector(1 downto 0);
      vram_ENA_B           : in  std_logic;
      vram_MST_B           : in  std_logic_vector(1 downto 0);
      vram_Offset_B        : in  std_logic_vector(1 downto 0);
      vram_ENA_C           : in  std_logic;
      vram_MST_C           : in  std_logic_vector(2 downto 0);
      vram_Offset_C        : in  std_logic_vector(1 downto 0);
      vram_ENA_D           : in  std_logic;
      vram_MST_D           : in  std_logic_vector(2 downto 0);
      vram_Offset_D        : in  std_logic_vector(1 downto 0);
      vram_ENA_E           : in  std_logic;
      vram_MST_E           : in  std_logic_vector(2 downto 0);
      vram_ENA_F           : in  std_logic;
      vram_MST_F           : in  std_logic_vector(2 downto 0);
      vram_Offset_F        : in  std_logic_vector(1 downto 0);
      vram_ENA_G           : in  std_logic;
      vram_MST_G           : in  std_logic_vector(2 downto 0);
      vram_Offset_G        : in  std_logic_vector(1 downto 0);
      vram_ENA_H           : in  std_logic;
      vram_MST_H           : in  std_logic_vector(1 downto 0);
      vram_ENA_I           : in  std_logic;
      vram_MST_I           : in  std_logic_vector(1 downto 0);
      
      VRam_req_A           : out  std_logic;
      VRam_req_B           : out  std_logic;
      VRam_req_C           : out  std_logic;
      VRam_req_D           : out  std_logic;
      VRam_req_E           : out  std_logic;
      VRam_req_F           : out  std_logic;
      VRam_req_G           : out  std_logic;
      VRam_req_H           : out  std_logic;
      VRam_req_I           : out  std_logic;
      VRam_addr_A          : out  std_logic_vector(16 downto 0);
      VRam_addr_B          : out  std_logic_vector(16 downto 0);
      VRam_addr_C          : out  std_logic_vector(16 downto 0);
      VRam_addr_D          : out  std_logic_vector(16 downto 0);
      VRam_addr_E          : out  std_logic_vector(15 downto 0);
      VRam_addr_F          : out  std_logic_vector(13 downto 0);
      VRam_addr_G          : out  std_logic_vector(13 downto 0);
      VRam_addr_H          : out  std_logic_vector(14 downto 0);
      VRam_addr_I          : out  std_logic_vector(13 downto 0);
      VRam_dataout_A       : in   std_logic_vector(31 downto 0);
      VRam_dataout_B       : in   std_logic_vector(31 downto 0);
      VRam_dataout_C       : in   std_logic_vector(31 downto 0);
      VRam_dataout_D       : in   std_logic_vector(31 downto 0);
      VRam_dataout_E       : in   std_logic_vector(31 downto 0);
      VRam_dataout_F       : in   std_logic_vector(31 downto 0);
      VRam_dataout_G       : in   std_logic_vector(31 downto 0);
      VRam_dataout_H       : in   std_logic_vector(31 downto 0);
      VRam_dataout_I       : in   std_logic_vector(31 downto 0);
      VRam_valid_A         : in   std_logic;
      VRam_valid_B         : in   std_logic;
      VRam_valid_C         : in   std_logic;
      VRam_valid_D         : in   std_logic;
      VRam_valid_E         : in   std_logic;
      VRam_valid_F         : in   std_logic;
      VRam_valid_G         : in   std_logic;
      VRam_valid_H         : in   std_logic;
      VRam_valid_I         : in   std_logic;
      
      DISPSTAT_debug       : out    std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_gpu is

   -- regs
    signal REG_POWCNT1_Enable_Flag_for_both_LCDs : std_logic_vector(POWCNT1_Enable_Flag_for_both_LCDs.upper downto POWCNT1_Enable_Flag_for_both_LCDs.lower) := (others => '0');
    signal REG_POWCNT1_2D_Graphics_Engine_A      : std_logic_vector(POWCNT1_2D_Graphics_Engine_A     .upper downto POWCNT1_2D_Graphics_Engine_A     .lower) := (others => '0');
    signal REG_POWCNT1_3D_Rendering_Engine       : std_logic_vector(POWCNT1_3D_Rendering_Engine      .upper downto POWCNT1_3D_Rendering_Engine      .lower) := (others => '0');
    signal REG_POWCNT1_3D_Geometry_Engine        : std_logic_vector(POWCNT1_3D_Geometry_Engine       .upper downto POWCNT1_3D_Geometry_Engine       .lower) := (others => '0');
    signal REG_POWCNT1_2D_Graphics_Engine_B      : std_logic_vector(POWCNT1_2D_Graphics_Engine_B     .upper downto POWCNT1_2D_Graphics_Engine_B     .lower) := (others => '0');
    signal REG_POWCNT1_Display_Swap              : std_logic_vector(POWCNT1_Display_Swap             .upper downto POWCNT1_Display_Swap             .lower) := (others => '0');
   

   -- wiring
   signal drawline             : std_logic;
   signal line_trigger         : std_logic;
   signal refpoint_update      : std_logic;
   signal newline_invsync      : std_logic;
   signal linecounter_drawer   : unsigned(8 downto 0);
   signal pixelpos             : integer range 0 to 511;
   signal vsync_end            : std_logic;
   
   signal pixel_outA_x         : integer range 0 to 255;
   signal pixel_outA_y         : integer range 0 to 191;
   signal pixel_outA_data      : std_logic_vector(17 downto 0);  
   signal pixel_outA_we        : std_logic;
   signal pixel_outB_x         : integer range 0 to 255;
   signal pixel_outB_y         : integer range 0 to 191;
   signal pixel_outB_data      : std_logic_vector(17 downto 0);  
   signal pixel_outB_we        : std_logic;
   
   
   -- vram mux
   signal VRam_req_A_GPUA     : std_logic;
   signal VRam_req_B_GPUA     : std_logic;
   signal VRam_req_C_GPUA     : std_logic;
   signal VRam_req_D_GPUA     : std_logic;
   signal VRam_req_E_GPUA     : std_logic;
   signal VRam_req_F_GPUA     : std_logic;
   signal VRam_req_G_GPUA     : std_logic;
   signal VRam_req_H_GPUA     : std_logic;
   signal VRam_req_I_GPUA     : std_logic;
               
   signal VRam_req_A_GPUB     : std_logic;
   signal VRam_req_B_GPUB     : std_logic;
   signal VRam_req_C_GPUB     : std_logic;
   signal VRam_req_D_GPUB     : std_logic;
   signal VRam_req_E_GPUB     : std_logic;
   signal VRam_req_F_GPUB     : std_logic;
   signal VRam_req_G_GPUB     : std_logic;
   signal VRam_req_H_GPUB     : std_logic;
   signal VRam_req_I_GPUB     : std_logic;
   
   signal VRam_addr_A_GPUA    : std_logic_vector(16 downto 0);
   signal VRam_addr_B_GPUA    : std_logic_vector(16 downto 0);
   signal VRam_addr_C_GPUA    : std_logic_vector(16 downto 0);
   signal VRam_addr_D_GPUA    : std_logic_vector(16 downto 0);
   signal VRam_addr_E_GPUA    : std_logic_vector(15 downto 0);
   signal VRam_addr_F_GPUA    : std_logic_vector(13 downto 0);
   signal VRam_addr_G_GPUA    : std_logic_vector(13 downto 0);
   signal VRam_addr_H_GPUA    : std_logic_vector(14 downto 0);
   signal VRam_addr_I_GPUA    : std_logic_vector(13 downto 0);
    
   signal VRam_addr_A_GPUB    : std_logic_vector(16 downto 0);
   signal VRam_addr_B_GPUB    : std_logic_vector(16 downto 0);
   signal VRam_addr_C_GPUB    : std_logic_vector(16 downto 0);
   signal VRam_addr_D_GPUB    : std_logic_vector(16 downto 0);
   signal VRam_addr_E_GPUB    : std_logic_vector(15 downto 0);
   signal VRam_addr_F_GPUB    : std_logic_vector(13 downto 0);
   signal VRam_addr_G_GPUB    : std_logic_vector(13 downto 0);
   signal VRam_addr_H_GPUB    : std_logic_vector(14 downto 0);
   signal VRam_addr_I_GPUB    : std_logic_vector(13 downto 0);
   
   signal VRam_valid_A_GPUA   : std_logic;
   signal VRam_valid_B_GPUA   : std_logic;
   signal VRam_valid_C_GPUA   : std_logic;
   signal VRam_valid_D_GPUA   : std_logic;
   signal VRam_valid_E_GPUA   : std_logic;
   signal VRam_valid_F_GPUA   : std_logic;
   signal VRam_valid_G_GPUA   : std_logic;
   signal VRam_valid_H_GPUA   : std_logic;
   signal VRam_valid_I_GPUA   : std_logic;
               
   signal VRam_valid_A_GPUB   : std_logic;
   signal VRam_valid_B_GPUB   : std_logic;
   signal VRam_valid_C_GPUB   : std_logic;
   signal VRam_valid_D_GPUB   : std_logic;
   signal VRam_valid_E_GPUB   : std_logic;
   signal VRam_valid_F_GPUB   : std_logic;
   signal VRam_valid_G_GPUB   : std_logic;
   signal VRam_valid_H_GPUB   : std_logic;
   signal VRam_valid_I_GPUB   : std_logic;
   
   type t_reg_wired_or is array(0 to 8) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
 
begin 

   iPOWCNT1_Enable_Flag_for_both_LCDs : entity work.eProcReg_ds generic map (POWCNT1_Enable_Flag_for_both_LCDs) port map  (clk100, ds_bus9, reg_wired_or(3), REG_POWCNT1_Enable_Flag_for_both_LCDs, REG_POWCNT1_Enable_Flag_for_both_LCDs);
   iPOWCNT1_2D_Graphics_Engine_A      : entity work.eProcReg_ds generic map (POWCNT1_2D_Graphics_Engine_A     ) port map  (clk100, ds_bus9, reg_wired_or(4), REG_POWCNT1_2D_Graphics_Engine_A     , REG_POWCNT1_2D_Graphics_Engine_A     );
   iPOWCNT1_3D_Rendering_Engine       : entity work.eProcReg_ds generic map (POWCNT1_3D_Rendering_Engine      ) port map  (clk100, ds_bus9, reg_wired_or(5), REG_POWCNT1_3D_Rendering_Engine      , REG_POWCNT1_3D_Rendering_Engine      );
   iPOWCNT1_3D_Geometry_Engine        : entity work.eProcReg_ds generic map (POWCNT1_3D_Geometry_Engine       ) port map  (clk100, ds_bus9, reg_wired_or(6), REG_POWCNT1_3D_Geometry_Engine       , REG_POWCNT1_3D_Geometry_Engine       );
   iPOWCNT1_2D_Graphics_Engine_B      : entity work.eProcReg_ds generic map (POWCNT1_2D_Graphics_Engine_B     ) port map  (clk100, ds_bus9, reg_wired_or(7), REG_POWCNT1_2D_Graphics_Engine_B     , REG_POWCNT1_2D_Graphics_Engine_B     );
   iPOWCNT1_Display_Swap              : entity work.eProcReg_ds generic map (POWCNT1_Display_Swap             ) port map  (clk100, ds_bus9, reg_wired_or(8), REG_POWCNT1_Display_Swap             , REG_POWCNT1_Display_Swap             );

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus9_data <= wired_or;
   end process;

   pixel_out1_x    <= pixel_outA_x    when REG_POWCNT1_Display_Swap = "1" else pixel_outB_x;   
   pixel_out1_y    <= pixel_outA_y    when REG_POWCNT1_Display_Swap = "1" else pixel_outB_y;   
   pixel_out1_data <= pixel_outA_data when REG_POWCNT1_Display_Swap = "1" else pixel_outB_data;
   pixel_out1_we   <= pixel_outA_we   when REG_POWCNT1_Display_Swap = "1" else pixel_outB_we;  
   
   pixel_out2_x    <= pixel_outB_x    when REG_POWCNT1_Display_Swap = "1" else pixel_outA_x;   
   pixel_out2_y    <= pixel_outB_y    when REG_POWCNT1_Display_Swap = "1" else pixel_outA_y;   
   pixel_out2_data <= pixel_outB_data when REG_POWCNT1_Display_Swap = "1" else pixel_outA_data;
   pixel_out2_we   <= pixel_outB_we   when REG_POWCNT1_Display_Swap = "1" else pixel_outA_we;  



   igba_gpu_timing : entity work.ds_gpu_timing
   generic map
   (
      is_simu => is_simu
   )
   port map
   (
      clk100               => clk100,
      ds_on                => ds_on,
      reset                => reset,
      lockspeed            => lockspeed,
               
      ds_bus9              => ds_bus9,
      ds_bus9_data         => reg_wired_or(0),
      ds_bus7              => ds_bus7,
      ds_bus7_data         => ds_bus7_data,
               
      new_cycles           => new_cycles,      
      new_cycles_valid     => new_cycles_valid,
                           
      IRP_HBlank9          => IRP_HBlank9,
      IRP_HBlank7          => IRP_HBlank7,
      IRP_VBlank9          => IRP_VBlank9, 
      IRP_VBlank7          => IRP_VBlank7, 
      IRP_LCDStat9         => IRP_LCDStat9,
      IRP_LCDStat7         => IRP_LCDStat7,
            
      line_trigger         => line_trigger,
      hblank_trigger       => hblank_trigger,                            
      vblank_trigger       => vblank_trigger, 
      MemDisplay_trigger   => MemDisplay_trigger,
      drawline             => drawline,   
      refpoint_update      => refpoint_update,   
      newline_invsync      => newline_invsync,   
      linecounter_drawer   => linecounter_drawer, 
      pixelpos             => pixelpos,
      vsync_end            => vsync_end,      
                           
      DISPSTAT_debug       => DISPSTAT_debug
   );
   
   VRam_req_A <= VRam_req_A_GPUA;
   VRam_req_B <= VRam_req_B_GPUA;
   VRam_req_C <= VRam_req_C_GPUA when vram_MST_C(2) = '0' else VRam_req_C_GPUB;
   VRam_req_D <= VRam_req_D_GPUA when vram_MST_D(2) = '0' else VRam_req_D_GPUB;
   VRam_req_E <= VRam_req_E_GPUA;
   VRam_req_F <= VRam_req_F_GPUA;
   VRam_req_G <= VRam_req_G_GPUA;
   VRam_req_H <= VRam_req_H_GPUB;
   VRam_req_I <= VRam_req_I_GPUB;
   
   VRam_addr_A <= VRam_addr_A_GPUA;
   VRam_addr_B <= VRam_addr_B_GPUA;
   VRam_addr_C <= VRam_addr_C_GPUA when vram_MST_C(2) = '0' else VRam_addr_C_GPUB;
   VRam_addr_D <= VRam_addr_D_GPUA when vram_MST_D(2) = '0' else VRam_addr_D_GPUB;
   VRam_addr_E <= VRam_addr_E_GPUA;
   VRam_addr_F <= VRam_addr_F_GPUA;
   VRam_addr_G <= VRam_addr_G_GPUA;
   VRam_addr_H <= VRam_addr_H_GPUB;
   VRam_addr_I <= VRam_addr_I_GPUB;
   
   VRam_valid_A_GPUA <= VRam_valid_A;
   VRam_valid_B_GPUA <= VRam_valid_B;
   VRam_valid_C_GPUA <= VRam_valid_C when vram_MST_C(2) = '0' else '0';
   VRam_valid_D_GPUA <= VRam_valid_D when vram_MST_D(2) = '0' else '0';
   VRam_valid_E_GPUA <= VRam_valid_E;
   VRam_valid_F_GPUA <= VRam_valid_F;
   VRam_valid_G_GPUA <= VRam_valid_G;
   VRam_valid_H_GPUA <= '0';
   VRam_valid_I_GPUA <= '0';
   
   VRam_valid_A_GPUB <= '0';
   VRam_valid_B_GPUB <= '0';
   VRam_valid_C_GPUB <= VRam_valid_C when vram_MST_C(2) = '1' else '0';
   VRam_valid_D_GPUB <= VRam_valid_D when vram_MST_D(2) = '1' else '0';
   VRam_valid_E_GPUB <= '0';
   VRam_valid_F_GPUB <= '0';
   VRam_valid_G_GPUB <= '0';
   VRam_valid_H_GPUB <= VRam_valid_H;
   VRam_valid_I_GPUB <= VRam_valid_I;

   igba_gpu_drawerA : entity work.ds_gpu_drawer
   generic map
   (
      is_simu                        => is_simu,
      ds_nogpu                       => ds_nogpu, 
      isGPUA                         => '1',
      DISPCNT                        => A_DISPCNT                       ,
      DISPCNT_BG_Mode                => A_DISPCNT_BG_Mode               ,
      DISPCNT_BG0_2D_3D              => A_DISPCNT_BG0_2D_3D             ,
      DISPCNT_Tile_OBJ_Mapping       => A_DISPCNT_Tile_OBJ_Mapping      ,
      DISPCNT_Bitmap_OBJ_2D_Dim      => A_DISPCNT_Bitmap_OBJ_2D_Dim     ,
      DISPCNT_Bitmap_OBJ_Mapping     => A_DISPCNT_Bitmap_OBJ_Mapping    ,
      DISPCNT_Forced_Blank           => A_DISPCNT_Forced_Blank          ,
      DISPCNT_Screen_Display_BG0     => A_DISPCNT_Screen_Display_BG0    ,
      DISPCNT_Screen_Display_BG1     => A_DISPCNT_Screen_Display_BG1    ,
      DISPCNT_Screen_Display_BG2     => A_DISPCNT_Screen_Display_BG2    ,
      DISPCNT_Screen_Display_BG3     => A_DISPCNT_Screen_Display_BG3    ,
      DISPCNT_Screen_Display_OBJ     => A_DISPCNT_Screen_Display_OBJ    ,
      DISPCNT_Window_0_Display_Flag  => A_DISPCNT_Window_0_Display_Flag ,
      DISPCNT_Window_1_Display_Flag  => A_DISPCNT_Window_1_Display_Flag ,
      DISPCNT_OBJ_Wnd_Display_Flag   => A_DISPCNT_OBJ_Wnd_Display_Flag  ,
      DISPCNT_Display_Mode           => A_DISPCNT_Display_Mode          ,
      DISPCNT_VRAM_block             => A_DISPCNT_VRAM_block            ,
      DISPCNT_Tile_OBJ_1D_Boundary   => A_DISPCNT_Tile_OBJ_1D_Boundary  ,
      DISPCNT_Bitmap_OBJ_1D_Boundary => A_DISPCNT_Bitmap_OBJ_1D_Boundary,
      DISPCNT_OBJ_Process_H_Blank    => A_DISPCNT_OBJ_Process_H_Blank   ,
      DISPCNT_Character_Base         => A_DISPCNT_Character_Base        ,
      DISPCNT_Screen_Base            => A_DISPCNT_Screen_Base           ,
      DISPCNT_BG_Extended_Palettes   => A_DISPCNT_BG_Extended_Palettes  ,
      DISPCNT_OBJ_Extended_Palettes  => A_DISPCNT_OBJ_Extended_Palettes ,
      BG0CNT                         => A_BG0CNT                        ,
      BG0CNT_BG_Priority             => A_BG0CNT_BG_Priority            ,
      BG0CNT_Character_Base_Block    => A_BG0CNT_Character_Base_Block   ,
      BG0CNT_Mosaic                  => A_BG0CNT_Mosaic                 ,
      BG0CNT_Colors_Palettes         => A_BG0CNT_Colors_Palettes        ,
      BG0CNT_Screen_Base_Block       => A_BG0CNT_Screen_Base_Block      ,
      BG0CNT_Ext_Palette_Slot        => A_BG0CNT_Ext_Palette_Slot       ,
      BG0CNT_Screen_Size             => A_BG0CNT_Screen_Size            ,                           
      BG1CNT                         => A_BG1CNT                        ,
      BG1CNT_BG_Priority             => A_BG1CNT_BG_Priority            ,
      BG1CNT_Character_Base_Block    => A_BG1CNT_Character_Base_Block   ,
      BG1CNT_Mosaic                  => A_BG1CNT_Mosaic                 ,
      BG1CNT_Colors_Palettes         => A_BG1CNT_Colors_Palettes        ,
      BG1CNT_Screen_Base_Block       => A_BG1CNT_Screen_Base_Block      ,
      BG1CNT_Ext_Palette_Slot        => A_BG1CNT_Ext_Palette_Slot       ,
      BG1CNT_Screen_Size             => A_BG1CNT_Screen_Size            ,                            
      BG2CNT                         => A_BG2CNT                        ,
      BG2CNT_BG_Priority             => A_BG2CNT_BG_Priority            ,
      BG2CNT_Character_Base_Block    => A_BG2CNT_Character_Base_Block   ,
      BG2CNT_Mosaic                  => A_BG2CNT_Mosaic                 ,
      BG2CNT_Colors_Palettes         => A_BG2CNT_Colors_Palettes        ,
      BG2CNT_Screen_Base_Block       => A_BG2CNT_Screen_Base_Block      ,
      BG2CNT_Display_Area_Overflow   => A_BG2CNT_Display_Area_Overflow  ,
      BG2CNT_Screen_Size             => A_BG2CNT_Screen_Size            ,                            
      BG3CNT                         => A_BG3CNT                        ,
      BG3CNT_BG_Priority             => A_BG3CNT_BG_Priority            ,
      BG3CNT_Character_Base_Block    => A_BG3CNT_Character_Base_Block   ,
      BG3CNT_Mosaic                  => A_BG3CNT_Mosaic                 ,
      BG3CNT_Colors_Palettes         => A_BG3CNT_Colors_Palettes        ,
      BG3CNT_Screen_Base_Block       => A_BG3CNT_Screen_Base_Block      ,
      BG3CNT_Display_Area_Overflow   => A_BG3CNT_Display_Area_Overflow  ,
      BG3CNT_Screen_Size             => A_BG3CNT_Screen_Size            ,                           
      BG0HOFS                        => A_BG0HOFS                       ,
      BG0VOFS                        => A_BG0VOFS                       ,
      BG1HOFS                        => A_BG1HOFS                       ,
      BG1VOFS                        => A_BG1VOFS                       ,
      BG2HOFS                        => A_BG2HOFS                       ,
      BG2VOFS                        => A_BG2VOFS                       ,
      BG3HOFS                        => A_BG3HOFS                       ,
      BG3VOFS                        => A_BG3VOFS                       ,                           
      BG2RotScaleParDX               => A_BG2RotScaleParDX              ,
      BG2RotScaleParDMX              => A_BG2RotScaleParDMX             ,
      BG2RotScaleParDY               => A_BG2RotScaleParDY              ,
      BG2RotScaleParDMY              => A_BG2RotScaleParDMY             ,
      BG2RefX                        => A_BG2RefX                       ,
      BG2RefY                        => A_BG2RefY                       ,                            
      BG3RotScaleParDX               => A_BG3RotScaleParDX              ,
      BG3RotScaleParDMX              => A_BG3RotScaleParDMX             ,
      BG3RotScaleParDY               => A_BG3RotScaleParDY              ,
      BG3RotScaleParDMY              => A_BG3RotScaleParDMY             ,
      BG3RefX                        => A_BG3RefX                       ,
      BG3RefY                        => A_BG3RefY                       ,                              
      WIN0H                          => A_WIN0H                         ,
      WIN0H_X2                       => A_WIN0H_X2                      ,
      WIN0H_X1                       => A_WIN0H_X1                      ,                              
      WIN1H                          => A_WIN1H                         ,
      WIN1H_X2                       => A_WIN1H_X2                      ,
      WIN1H_X1                       => A_WIN1H_X1                      ,                                  
      WIN0V                          => A_WIN0V                         ,
      WIN0V_Y2                       => A_WIN0V_Y2                      ,
      WIN0V_Y1                       => A_WIN0V_Y1                      ,                              
      WIN1V                          => A_WIN1V                         ,
      WIN1V_Y2                       => A_WIN1V_Y2                      ,
      WIN1V_Y1                       => A_WIN1V_Y1                      ,                            
      WININ                          => A_WININ                         ,
      WININ_Window_0_BG0_Enable      => A_WININ_Window_0_BG0_Enable     ,
      WININ_Window_0_BG1_Enable      => A_WININ_Window_0_BG1_Enable     ,
      WININ_Window_0_BG2_Enable      => A_WININ_Window_0_BG2_Enable     ,
      WININ_Window_0_BG3_Enable      => A_WININ_Window_0_BG3_Enable     ,
      WININ_Window_0_OBJ_Enable      => A_WININ_Window_0_OBJ_Enable     ,
      WININ_Window_0_Special_Effect  => A_WININ_Window_0_Special_Effect ,
      WININ_Window_1_BG0_Enable      => A_WININ_Window_1_BG0_Enable     ,
      WININ_Window_1_BG1_Enable      => A_WININ_Window_1_BG1_Enable     ,
      WININ_Window_1_BG2_Enable      => A_WININ_Window_1_BG2_Enable     ,
      WININ_Window_1_BG3_Enable      => A_WININ_Window_1_BG3_Enable     ,
      WININ_Window_1_OBJ_Enable      => A_WININ_Window_1_OBJ_Enable     ,
      WININ_Window_1_Special_Effect  => A_WININ_Window_1_Special_Effect ,                           
      WINOUT                         => A_WINOUT                        ,
      WINOUT_Outside_BG0_Enable      => A_WINOUT_Outside_BG0_Enable     ,
      WINOUT_Outside_BG1_Enable      => A_WINOUT_Outside_BG1_Enable     ,
      WINOUT_Outside_BG2_Enable      => A_WINOUT_Outside_BG2_Enable     ,
      WINOUT_Outside_BG3_Enable      => A_WINOUT_Outside_BG3_Enable     ,
      WINOUT_Outside_OBJ_Enable      => A_WINOUT_Outside_OBJ_Enable     ,
      WINOUT_Outside_Special_Effect  => A_WINOUT_Outside_Special_Effect ,
      WINOUT_Objwnd_BG0_Enable       => A_WINOUT_Objwnd_BG0_Enable      ,
      WINOUT_Objwnd_BG1_Enable       => A_WINOUT_Objwnd_BG1_Enable      ,
      WINOUT_Objwnd_BG2_Enable       => A_WINOUT_Objwnd_BG2_Enable      ,
      WINOUT_Objwnd_BG3_Enable       => A_WINOUT_Objwnd_BG3_Enable      ,
      WINOUT_Objwnd_OBJ_Enable       => A_WINOUT_Objwnd_OBJ_Enable      ,
      WINOUT_Objwnd_Special_Effect   => A_WINOUT_Objwnd_Special_Effect  ,                             
      MOSAIC                         => A_MOSAIC                        ,
      MOSAIC_BG_Mosaic_H_Size        => A_MOSAIC_BG_Mosaic_H_Size       ,
      MOSAIC_BG_Mosaic_V_Size        => A_MOSAIC_BG_Mosaic_V_Size       ,
      MOSAIC_OBJ_Mosaic_H_Size       => A_MOSAIC_OBJ_Mosaic_H_Size      ,
      MOSAIC_OBJ_Mosaic_V_Size       => A_MOSAIC_OBJ_Mosaic_V_Size      ,
      BLDCNT                         => A_BLDCNT                        ,
      BLDCNT_BG0_1st_Target_Pixel    => A_BLDCNT_BG0_1st_Target_Pixel   ,
      BLDCNT_BG1_1st_Target_Pixel    => A_BLDCNT_BG1_1st_Target_Pixel   ,
      BLDCNT_BG2_1st_Target_Pixel    => A_BLDCNT_BG2_1st_Target_Pixel   ,
      BLDCNT_BG3_1st_Target_Pixel    => A_BLDCNT_BG3_1st_Target_Pixel   ,
      BLDCNT_OBJ_1st_Target_Pixel    => A_BLDCNT_OBJ_1st_Target_Pixel   ,
      BLDCNT_BD_1st_Target_Pixel     => A_BLDCNT_BD_1st_Target_Pixel    ,
      BLDCNT_Color_Special_Effect    => A_BLDCNT_Color_Special_Effect   ,
      BLDCNT_BG0_2nd_Target_Pixel    => A_BLDCNT_BG0_2nd_Target_Pixel   ,
      BLDCNT_BG1_2nd_Target_Pixel    => A_BLDCNT_BG1_2nd_Target_Pixel   ,
      BLDCNT_BG2_2nd_Target_Pixel    => A_BLDCNT_BG2_2nd_Target_Pixel   ,
      BLDCNT_BG3_2nd_Target_Pixel    => A_BLDCNT_BG3_2nd_Target_Pixel   ,
      BLDCNT_OBJ_2nd_Target_Pixel    => A_BLDCNT_OBJ_2nd_Target_Pixel   ,
      BLDCNT_BD_2nd_Target_Pixel     => A_BLDCNT_BD_2nd_Target_Pixel    ,                            
      BLDALPHA                       => A_BLDALPHA                      ,
      BLDALPHA_EVA_Coefficient       => A_BLDALPHA_EVA_Coefficient      ,
      BLDALPHA_EVB_Coefficient       => A_BLDALPHA_EVB_Coefficient      ,                            
      BLDY                           => A_BLDY                          ,
      MASTER_BRIGHT                  => A_MASTER_BRIGHT                 ,
      MASTER_BRIGHT_Factor           => A_MASTER_BRIGHT_Factor          ,
      MASTER_BRIGHT_Mode             => A_MASTER_BRIGHT_Mode            
   )
   port map
   (
      clk100                 => clk100,
      
      ds_bus                 => ds_bus9,
      ds_bus_data            => reg_wired_or(1),
      
      lockspeed              => lockspeed,
      maxpixels              => maxpixels,
      
      pixel_out_x            => pixel_outA_x,   
      pixel_out_y            => pixel_outA_y,  
      pixel_out_data         => pixel_outA_data,
      pixel_out_we           => pixel_outA_we,  
                             
      linecounter            => linecounter_drawer,    
      drawline               => drawline,
      refpoint_update        => refpoint_update,
      hblank_trigger         => hblank_trigger,  
      vblank_trigger         => vblank_trigger,  
      line_trigger           => line_trigger,  
      newline_invsync        => newline_invsync,  
      pixelpos               => pixelpos,        
      vsync_end              => vsync_end,      
                                                                       
      Palette_addr           => Palette_addr,        
      Palette_datain         => Palette_datain,      
      Palette_dataout_bg     => Palette_dataout_bgA, 
      Palette_dataout_obj    => Palette_dataout_objA,
      Palette_we_bg          => Palette_we_bgA,      
      Palette_we_obj         => Palette_we_objA,        
      Palette_be             => Palette_be,

      OAMRam_addr            => OAMRam_addr,     
      OAMRam_datain          => OAMRam_datain,   
      OAMRam_dataout         => OAMRam_dataout_A,
      OAMRam_we              => OAMRam_we_A,        
      OAMRam_be              => OAMRam_be,

      vram_ENA_A             => vram_ENA_A   ,
      vram_MST_A             => vram_MST_A   ,
      vram_Offset_A          => vram_Offset_A,
      vram_ENA_B             => vram_ENA_B   ,
      vram_MST_B             => vram_MST_B   ,
      vram_Offset_B          => vram_Offset_B,
      vram_ENA_C             => vram_ENA_C   ,
      vram_MST_C             => vram_MST_C   ,
      vram_Offset_C          => vram_Offset_C,
      vram_ENA_D             => vram_ENA_D   ,
      vram_MST_D             => vram_MST_D   ,
      vram_Offset_D          => vram_Offset_D,
      vram_ENA_E             => vram_ENA_E   ,
      vram_MST_E             => vram_MST_E   ,
      vram_ENA_F             => vram_ENA_F   ,
      vram_MST_F             => vram_MST_F   ,
      vram_Offset_F          => vram_Offset_F,
      vram_ENA_G             => vram_ENA_G   ,
      vram_MST_G             => vram_MST_G   ,
      vram_Offset_G          => vram_Offset_G,
      vram_ENA_H             => vram_ENA_H   ,
      vram_MST_H             => vram_MST_H   ,
      vram_ENA_I             => vram_ENA_I   ,
      vram_MST_I             => vram_MST_I   ,
                                     
      VRam_req_A             => VRam_req_A_GPUA,
      VRam_req_B             => VRam_req_B_GPUA,
      VRam_req_C             => VRam_req_C_GPUA,
      VRam_req_D             => VRam_req_D_GPUA,
      VRam_req_E             => VRam_req_E_GPUA,
      VRam_req_F             => VRam_req_F_GPUA,
      VRam_req_G             => VRam_req_G_GPUA,
      VRam_req_H             => VRam_req_H_GPUA,
      VRam_req_I             => VRam_req_I_GPUA,
      VRam_addr_A            => VRam_addr_A_GPUA,
      VRam_addr_B            => VRam_addr_B_GPUA,
      VRam_addr_C            => VRam_addr_C_GPUA,
      VRam_addr_D            => VRam_addr_D_GPUA,
      VRam_addr_E            => VRam_addr_E_GPUA,
      VRam_addr_F            => VRam_addr_F_GPUA,
      VRam_addr_G            => VRam_addr_G_GPUA,
      VRam_addr_H            => VRam_addr_H_GPUA,
      VRam_addr_I            => VRam_addr_I_GPUA,
      VRam_dataout_A         => VRam_dataout_A,
      VRam_dataout_B         => VRam_dataout_B,
      VRam_dataout_C         => VRam_dataout_C,
      VRam_dataout_D         => VRam_dataout_D,
      VRam_dataout_E         => VRam_dataout_E,
      VRam_dataout_F         => VRam_dataout_F,
      VRam_dataout_G         => VRam_dataout_G,
      VRam_dataout_H         => VRam_dataout_H,
      VRam_dataout_I         => VRam_dataout_I,
      VRam_valid_A           => VRam_valid_A_GPUA,
      VRam_valid_B           => VRam_valid_B_GPUA,
      VRam_valid_C           => VRam_valid_C_GPUA,
      VRam_valid_D           => VRam_valid_D_GPUA,
      VRam_valid_E           => VRam_valid_E_GPUA,
      VRam_valid_F           => VRam_valid_F_GPUA,
      VRam_valid_G           => VRam_valid_G_GPUA,
      VRam_valid_H           => VRam_valid_H_GPUA,
      VRam_valid_I           => VRam_valid_I_GPUA     
   );  

   igba_gpu_drawerB : entity work.ds_gpu_drawer
   generic map
   (
      is_simu                        => is_simu,
      ds_nogpu                       => ds_nogpu, 
      isGPUA                         => '0',
      DISPCNT                        => B_DISPCNT                       ,
      DISPCNT_BG_Mode                => B_DISPCNT_BG_Mode               ,
      DISPCNT_BG0_2D_3D              => B_DISPCNT_BG0_2D_3D             ,
      DISPCNT_Tile_OBJ_Mapping       => B_DISPCNT_Tile_OBJ_Mapping      ,
      DISPCNT_Bitmap_OBJ_2D_Dim      => B_DISPCNT_Bitmap_OBJ_2D_Dim     ,
      DISPCNT_Bitmap_OBJ_Mapping     => B_DISPCNT_Bitmap_OBJ_Mapping    ,
      DISPCNT_Forced_Blank           => B_DISPCNT_Forced_Blank          ,
      DISPCNT_Screen_Display_BG0     => B_DISPCNT_Screen_Display_BG0    ,
      DISPCNT_Screen_Display_BG1     => B_DISPCNT_Screen_Display_BG1    ,
      DISPCNT_Screen_Display_BG2     => B_DISPCNT_Screen_Display_BG2    ,
      DISPCNT_Screen_Display_BG3     => B_DISPCNT_Screen_Display_BG3    ,
      DISPCNT_Screen_Display_OBJ     => B_DISPCNT_Screen_Display_OBJ    ,
      DISPCNT_Window_0_Display_Flag  => B_DISPCNT_Window_0_Display_Flag ,
      DISPCNT_Window_1_Display_Flag  => B_DISPCNT_Window_1_Display_Flag ,
      DISPCNT_OBJ_Wnd_Display_Flag   => B_DISPCNT_OBJ_Wnd_Display_Flag  ,
      DISPCNT_Display_Mode           => B_DISPCNT_Display_Mode          ,
      DISPCNT_VRAM_block             => B_DISPCNT_VRAM_block            ,
      DISPCNT_Tile_OBJ_1D_Boundary   => B_DISPCNT_Tile_OBJ_1D_Boundary  ,
      DISPCNT_Bitmap_OBJ_1D_Boundary => B_DISPCNT_Bitmap_OBJ_1D_Boundary,
      DISPCNT_OBJ_Process_H_Blank    => B_DISPCNT_OBJ_Process_H_Blank   ,
      DISPCNT_Character_Base         => B_DISPCNT_Character_Base        ,
      DISPCNT_Screen_Base            => B_DISPCNT_Screen_Base           ,
      DISPCNT_BG_Extended_Palettes   => B_DISPCNT_BG_Extended_Palettes  ,
      DISPCNT_OBJ_Extended_Palettes  => B_DISPCNT_OBJ_Extended_Palettes ,
      BG0CNT                         => B_BG0CNT                        ,
      BG0CNT_BG_Priority             => B_BG0CNT_BG_Priority            ,
      BG0CNT_Character_Base_Block    => B_BG0CNT_Character_Base_Block   ,
      BG0CNT_Mosaic                  => B_BG0CNT_Mosaic                 ,
      BG0CNT_Colors_Palettes         => B_BG0CNT_Colors_Palettes        ,
      BG0CNT_Screen_Base_Block       => B_BG0CNT_Screen_Base_Block      ,
      BG0CNT_Ext_Palette_Slot        => B_BG0CNT_Ext_Palette_Slot       ,
      BG0CNT_Screen_Size             => B_BG0CNT_Screen_Size            ,                           
      BG1CNT                         => B_BG1CNT                        ,
      BG1CNT_BG_Priority             => B_BG1CNT_BG_Priority            ,
      BG1CNT_Character_Base_Block    => B_BG1CNT_Character_Base_Block   ,
      BG1CNT_Mosaic                  => B_BG1CNT_Mosaic                 ,
      BG1CNT_Colors_Palettes         => B_BG1CNT_Colors_Palettes        ,
      BG1CNT_Screen_Base_Block       => B_BG1CNT_Screen_Base_Block      ,
      BG1CNT_Ext_Palette_Slot        => B_BG1CNT_Ext_Palette_Slot       ,
      BG1CNT_Screen_Size             => B_BG1CNT_Screen_Size            ,                            
      BG2CNT                         => B_BG2CNT                        ,
      BG2CNT_BG_Priority             => B_BG2CNT_BG_Priority            ,
      BG2CNT_Character_Base_Block    => B_BG2CNT_Character_Base_Block   ,
      BG2CNT_Mosaic                  => B_BG2CNT_Mosaic                 ,
      BG2CNT_Colors_Palettes         => B_BG2CNT_Colors_Palettes        ,
      BG2CNT_Screen_Base_Block       => B_BG2CNT_Screen_Base_Block      ,
      BG2CNT_Display_Area_Overflow   => B_BG2CNT_Display_Area_Overflow  ,
      BG2CNT_Screen_Size             => B_BG2CNT_Screen_Size            ,                            
      BG3CNT                         => B_BG3CNT                        ,
      BG3CNT_BG_Priority             => B_BG3CNT_BG_Priority            ,
      BG3CNT_Character_Base_Block    => B_BG3CNT_Character_Base_Block   ,
      BG3CNT_Mosaic                  => B_BG3CNT_Mosaic                 ,
      BG3CNT_Colors_Palettes         => B_BG3CNT_Colors_Palettes        ,
      BG3CNT_Screen_Base_Block       => B_BG3CNT_Screen_Base_Block      ,
      BG3CNT_Display_Area_Overflow   => B_BG3CNT_Display_Area_Overflow  ,
      BG3CNT_Screen_Size             => B_BG3CNT_Screen_Size            ,                           
      BG0HOFS                        => B_BG0HOFS                       ,
      BG0VOFS                        => B_BG0VOFS                       ,
      BG1HOFS                        => B_BG1HOFS                       ,
      BG1VOFS                        => B_BG1VOFS                       ,
      BG2HOFS                        => B_BG2HOFS                       ,
      BG2VOFS                        => B_BG2VOFS                       ,
      BG3HOFS                        => B_BG3HOFS                       ,
      BG3VOFS                        => B_BG3VOFS                       ,                           
      BG2RotScaleParDX               => B_BG2RotScaleParDX              ,
      BG2RotScaleParDMX              => B_BG2RotScaleParDMX             ,
      BG2RotScaleParDY               => B_BG2RotScaleParDY              ,
      BG2RotScaleParDMY              => B_BG2RotScaleParDMY             ,
      BG2RefX                        => B_BG2RefX                       ,
      BG2RefY                        => B_BG2RefY                       ,                            
      BG3RotScaleParDX               => B_BG3RotScaleParDX              ,
      BG3RotScaleParDMX              => B_BG3RotScaleParDMX             ,
      BG3RotScaleParDY               => B_BG3RotScaleParDY              ,
      BG3RotScaleParDMY              => B_BG3RotScaleParDMY             ,
      BG3RefX                        => B_BG3RefX                       ,
      BG3RefY                        => B_BG3RefY                       ,                              
      WIN0H                          => B_WIN0H                         ,
      WIN0H_X2                       => B_WIN0H_X2                      ,
      WIN0H_X1                       => B_WIN0H_X1                      ,                              
      WIN1H                          => B_WIN1H                         ,
      WIN1H_X2                       => B_WIN1H_X2                      ,
      WIN1H_X1                       => B_WIN1H_X1                      ,                                  
      WIN0V                          => B_WIN0V                         ,
      WIN0V_Y2                       => B_WIN0V_Y2                      ,
      WIN0V_Y1                       => B_WIN0V_Y1                      ,                              
      WIN1V                          => B_WIN1V                         ,
      WIN1V_Y2                       => B_WIN1V_Y2                      ,
      WIN1V_Y1                       => B_WIN1V_Y1                      ,                            
      WININ                          => B_WININ                         ,
      WININ_Window_0_BG0_Enable      => B_WININ_Window_0_BG0_Enable     ,
      WININ_Window_0_BG1_Enable      => B_WININ_Window_0_BG1_Enable     ,
      WININ_Window_0_BG2_Enable      => B_WININ_Window_0_BG2_Enable     ,
      WININ_Window_0_BG3_Enable      => B_WININ_Window_0_BG3_Enable     ,
      WININ_Window_0_OBJ_Enable      => B_WININ_Window_0_OBJ_Enable     ,
      WININ_Window_0_Special_Effect  => B_WININ_Window_0_Special_Effect ,
      WININ_Window_1_BG0_Enable      => B_WININ_Window_1_BG0_Enable     ,
      WININ_Window_1_BG1_Enable      => B_WININ_Window_1_BG1_Enable     ,
      WININ_Window_1_BG2_Enable      => B_WININ_Window_1_BG2_Enable     ,
      WININ_Window_1_BG3_Enable      => B_WININ_Window_1_BG3_Enable     ,
      WININ_Window_1_OBJ_Enable      => B_WININ_Window_1_OBJ_Enable     ,
      WININ_Window_1_Special_Effect  => B_WININ_Window_1_Special_Effect ,                           
      WINOUT                         => B_WINOUT                        ,
      WINOUT_Outside_BG0_Enable      => B_WINOUT_Outside_BG0_Enable     ,
      WINOUT_Outside_BG1_Enable      => B_WINOUT_Outside_BG1_Enable     ,
      WINOUT_Outside_BG2_Enable      => B_WINOUT_Outside_BG2_Enable     ,
      WINOUT_Outside_BG3_Enable      => B_WINOUT_Outside_BG3_Enable     ,
      WINOUT_Outside_OBJ_Enable      => B_WINOUT_Outside_OBJ_Enable     ,
      WINOUT_Outside_Special_Effect  => B_WINOUT_Outside_Special_Effect ,
      WINOUT_Objwnd_BG0_Enable       => B_WINOUT_Objwnd_BG0_Enable      ,
      WINOUT_Objwnd_BG1_Enable       => B_WINOUT_Objwnd_BG1_Enable      ,
      WINOUT_Objwnd_BG2_Enable       => B_WINOUT_Objwnd_BG2_Enable      ,
      WINOUT_Objwnd_BG3_Enable       => B_WINOUT_Objwnd_BG3_Enable      ,
      WINOUT_Objwnd_OBJ_Enable       => B_WINOUT_Objwnd_OBJ_Enable      ,
      WINOUT_Objwnd_Special_Effect   => B_WINOUT_Objwnd_Special_Effect  ,                             
      MOSAIC                         => B_MOSAIC                        ,
      MOSAIC_BG_Mosaic_H_Size        => B_MOSAIC_BG_Mosaic_H_Size       ,
      MOSAIC_BG_Mosaic_V_Size        => B_MOSAIC_BG_Mosaic_V_Size       ,
      MOSAIC_OBJ_Mosaic_H_Size       => B_MOSAIC_OBJ_Mosaic_H_Size      ,
      MOSAIC_OBJ_Mosaic_V_Size       => B_MOSAIC_OBJ_Mosaic_V_Size      ,
      BLDCNT                         => B_BLDCNT                        ,
      BLDCNT_BG0_1st_Target_Pixel    => B_BLDCNT_BG0_1st_Target_Pixel   ,
      BLDCNT_BG1_1st_Target_Pixel    => B_BLDCNT_BG1_1st_Target_Pixel   ,
      BLDCNT_BG2_1st_Target_Pixel    => B_BLDCNT_BG2_1st_Target_Pixel   ,
      BLDCNT_BG3_1st_Target_Pixel    => B_BLDCNT_BG3_1st_Target_Pixel   ,
      BLDCNT_OBJ_1st_Target_Pixel    => B_BLDCNT_OBJ_1st_Target_Pixel   ,
      BLDCNT_BD_1st_Target_Pixel     => B_BLDCNT_BD_1st_Target_Pixel    ,
      BLDCNT_Color_Special_Effect    => B_BLDCNT_Color_Special_Effect   ,
      BLDCNT_BG0_2nd_Target_Pixel    => B_BLDCNT_BG0_2nd_Target_Pixel   ,
      BLDCNT_BG1_2nd_Target_Pixel    => B_BLDCNT_BG1_2nd_Target_Pixel   ,
      BLDCNT_BG2_2nd_Target_Pixel    => B_BLDCNT_BG2_2nd_Target_Pixel   ,
      BLDCNT_BG3_2nd_Target_Pixel    => B_BLDCNT_BG3_2nd_Target_Pixel   ,
      BLDCNT_OBJ_2nd_Target_Pixel    => B_BLDCNT_OBJ_2nd_Target_Pixel   ,
      BLDCNT_BD_2nd_Target_Pixel     => B_BLDCNT_BD_2nd_Target_Pixel    ,                            
      BLDALPHA                       => B_BLDALPHA                      ,
      BLDALPHA_EVA_Coefficient       => B_BLDALPHA_EVA_Coefficient      ,
      BLDALPHA_EVB_Coefficient       => B_BLDALPHA_EVB_Coefficient      ,                            
      BLDY                           => B_BLDY                          ,
      MASTER_BRIGHT                  => B_MASTER_BRIGHT                 ,
      MASTER_BRIGHT_Factor           => B_MASTER_BRIGHT_Factor          ,
      MASTER_BRIGHT_Mode             => B_MASTER_BRIGHT_Mode            
   )
   port map
   (
      clk100                 => clk100,
      
      ds_bus                 => ds_bus9,
      ds_bus_data            => reg_wired_or(2),
      
      lockspeed              => lockspeed,
      maxpixels              => maxpixels,
      
      pixel_out_x            => pixel_outB_x,   
      pixel_out_y            => pixel_outB_y,  
      pixel_out_data         => pixel_outB_data,
      pixel_out_we           => pixel_outB_we,  
                             
      linecounter            => linecounter_drawer,    
      drawline               => drawline,
      refpoint_update        => refpoint_update,
      hblank_trigger         => hblank_trigger,  
      vblank_trigger         => vblank_trigger,  
      line_trigger           => line_trigger,  
      newline_invsync        => newline_invsync,  
      pixelpos               => pixelpos, 
      vsync_end              => vsync_end,            
                                                   
      Palette_addr           => Palette_addr,        
      Palette_datain         => Palette_datain,      
      Palette_dataout_bg     => Palette_dataout_bgB, 
      Palette_dataout_obj    => Palette_dataout_objB,
      Palette_we_bg          => Palette_we_bgB,      
      Palette_we_obj         => Palette_we_objB,        
      Palette_be             => Palette_be,

      OAMRam_addr            => OAMRam_addr,     
      OAMRam_datain          => OAMRam_datain,   
      OAMRam_dataout         => OAMRam_dataout_B,
      OAMRam_we              => OAMRam_we_B,        
      OAMRam_be              => OAMRam_be,
      
      vram_ENA_A             => vram_ENA_A   ,
      vram_MST_A             => vram_MST_A   ,
      vram_Offset_A          => vram_Offset_A,
      vram_ENA_B             => vram_ENA_B   ,
      vram_MST_B             => vram_MST_B   ,
      vram_Offset_B          => vram_Offset_B,
      vram_ENA_C             => vram_ENA_C   ,
      vram_MST_C             => vram_MST_C   ,
      vram_Offset_C          => vram_Offset_C,
      vram_ENA_D             => vram_ENA_D   ,
      vram_MST_D             => vram_MST_D   ,
      vram_Offset_D          => vram_Offset_D,
      vram_ENA_E             => vram_ENA_E   ,
      vram_MST_E             => vram_MST_E   ,
      vram_ENA_F             => vram_ENA_F   ,
      vram_MST_F             => vram_MST_F   ,
      vram_Offset_F          => vram_Offset_F,
      vram_ENA_G             => vram_ENA_G   ,
      vram_MST_G             => vram_MST_G   ,
      vram_Offset_G          => vram_Offset_G,
      vram_ENA_H             => vram_ENA_H   ,
      vram_MST_H             => vram_MST_H   ,
      vram_ENA_I             => vram_ENA_I   ,
      vram_MST_I             => vram_MST_I   ,
                                           
      VRam_req_A             => VRam_req_A_GPUB,
      VRam_req_B             => VRam_req_B_GPUB,
      VRam_req_C             => VRam_req_C_GPUB,
      VRam_req_D             => VRam_req_D_GPUB,
      VRam_req_E             => VRam_req_E_GPUB,
      VRam_req_F             => VRam_req_F_GPUB,
      VRam_req_G             => VRam_req_G_GPUB,
      VRam_req_H             => VRam_req_H_GPUB,
      VRam_req_I             => VRam_req_I_GPUB,
      VRam_addr_A            => VRam_addr_A_GPUB,
      VRam_addr_B            => VRam_addr_B_GPUB,
      VRam_addr_C            => VRam_addr_C_GPUB,
      VRam_addr_D            => VRam_addr_D_GPUB,
      VRam_addr_E            => VRam_addr_E_GPUB,
      VRam_addr_F            => VRam_addr_F_GPUB,
      VRam_addr_G            => VRam_addr_G_GPUB,
      VRam_addr_H            => VRam_addr_H_GPUB,
      VRam_addr_I            => VRam_addr_I_GPUB,
      VRam_dataout_A         => VRam_dataout_A,
      VRam_dataout_B         => VRam_dataout_B,
      VRam_dataout_C         => VRam_dataout_C,
      VRam_dataout_D         => VRam_dataout_D,
      VRam_dataout_E         => VRam_dataout_E,
      VRam_dataout_F         => VRam_dataout_F,
      VRam_dataout_G         => VRam_dataout_G,
      VRam_dataout_H         => VRam_dataout_H,
      VRam_dataout_I         => VRam_dataout_I,
      VRam_valid_A           => VRam_valid_A_GPUB,
      VRam_valid_B           => VRam_valid_B_GPUB,
      VRam_valid_C           => VRam_valid_C_GPUB,
      VRam_valid_D           => VRam_valid_D_GPUB,
      VRam_valid_E           => VRam_valid_E_GPUB,
      VRam_valid_F           => VRam_valid_F_GPUB,
      VRam_valid_G           => VRam_valid_G_GPUB,
      VRam_valid_H           => VRam_valid_H_GPUB,
      VRam_valid_I           => VRam_valid_I_GPUB    
   );            

end architecture;





