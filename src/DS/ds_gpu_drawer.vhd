library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;  

library MEM;

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

entity ds_gpu_drawer is
   generic
   (
      is_simu                        : std_logic;
      ds_nogpu                       : std_logic;
      isGPUA                         : std_logic;
      DISPCNT                        : regmap_type; 
      DISPCNT_BG_Mode                : regmap_type;
      DISPCNT_BG0_2D_3D              : regmap_type;
      DISPCNT_Tile_OBJ_Mapping       : regmap_type;
      DISPCNT_Bitmap_OBJ_2D_Dim      : regmap_type;
      DISPCNT_Bitmap_OBJ_Mapping     : regmap_type;
      DISPCNT_Forced_Blank           : regmap_type;
      DISPCNT_Screen_Display_BG0     : regmap_type;
      DISPCNT_Screen_Display_BG1     : regmap_type;
      DISPCNT_Screen_Display_BG2     : regmap_type;
      DISPCNT_Screen_Display_BG3     : regmap_type;
      DISPCNT_Screen_Display_OBJ     : regmap_type;
      DISPCNT_Window_0_Display_Flag  : regmap_type;
      DISPCNT_Window_1_Display_Flag  : regmap_type;
      DISPCNT_OBJ_Wnd_Display_Flag   : regmap_type;
      DISPCNT_Display_Mode           : regmap_type;
      DISPCNT_VRAM_block             : regmap_type;
      DISPCNT_Tile_OBJ_1D_Boundary   : regmap_type;
      DISPCNT_Bitmap_OBJ_1D_Boundary : regmap_type;
      DISPCNT_OBJ_Process_H_Blank    : regmap_type;
      DISPCNT_Character_Base         : regmap_type;
      DISPCNT_Screen_Base            : regmap_type;
      DISPCNT_BG_Extended_Palettes   : regmap_type;
      DISPCNT_OBJ_Extended_Palettes  : regmap_type;
      BG0CNT                         : regmap_type;
      BG0CNT_BG_Priority             : regmap_type;
      BG0CNT_Character_Base_Block    : regmap_type;
      BG0CNT_Mosaic                  : regmap_type;
      BG0CNT_Colors_Palettes         : regmap_type;
      BG0CNT_Screen_Base_Block       : regmap_type;
      BG0CNT_Ext_Palette_Slot        : regmap_type;
      BG0CNT_Screen_Size             : regmap_type;                            
      BG1CNT                         : regmap_type;
      BG1CNT_BG_Priority             : regmap_type;
      BG1CNT_Character_Base_Block    : regmap_type;
      BG1CNT_Mosaic                  : regmap_type;
      BG1CNT_Colors_Palettes         : regmap_type;
      BG1CNT_Screen_Base_Block       : regmap_type;
      BG1CNT_Ext_Palette_Slot        : regmap_type;
      BG1CNT_Screen_Size             : regmap_type;                             
      BG2CNT                         : regmap_type;
      BG2CNT_BG_Priority             : regmap_type;
      BG2CNT_Character_Base_Block    : regmap_type;
      BG2CNT_Mosaic                  : regmap_type;
      BG2CNT_Colors_Palettes         : regmap_type;
      BG2CNT_Screen_Base_Block       : regmap_type;
      BG2CNT_Display_Area_Overflow   : regmap_type;
      BG2CNT_Screen_Size             : regmap_type;                             
      BG3CNT                         : regmap_type;
      BG3CNT_BG_Priority             : regmap_type;
      BG3CNT_Character_Base_Block    : regmap_type;
      BG3CNT_Mosaic                  : regmap_type;
      BG3CNT_Colors_Palettes         : regmap_type;
      BG3CNT_Screen_Base_Block       : regmap_type;
      BG3CNT_Display_Area_Overflow   : regmap_type;
      BG3CNT_Screen_Size             : regmap_type;                            
      BG0HOFS                        : regmap_type;
      BG0VOFS                        : regmap_type;
      BG1HOFS                        : regmap_type;
      BG1VOFS                        : regmap_type;
      BG2HOFS                        : regmap_type;
      BG2VOFS                        : regmap_type;
      BG3HOFS                        : regmap_type;
      BG3VOFS                        : regmap_type;                            
      BG2RotScaleParDX               : regmap_type;
      BG2RotScaleParDMX              : regmap_type;
      BG2RotScaleParDY               : regmap_type;
      BG2RotScaleParDMY              : regmap_type;
      BG2RefX                        : regmap_type;
      BG2RefY                        : regmap_type;                             
      BG3RotScaleParDX               : regmap_type;
      BG3RotScaleParDMX              : regmap_type;
      BG3RotScaleParDY               : regmap_type;
      BG3RotScaleParDMY              : regmap_type;
      BG3RefX                        : regmap_type;
      BG3RefY                        : regmap_type;                               
      WIN0H                          : regmap_type;
      WIN0H_X2                       : regmap_type;
      WIN0H_X1                       : regmap_type;                               
      WIN1H                          : regmap_type;
      WIN1H_X2                       : regmap_type;
      WIN1H_X1                       : regmap_type;                                   
      WIN0V                          : regmap_type;
      WIN0V_Y2                       : regmap_type;
      WIN0V_Y1                       : regmap_type;                               
      WIN1V                          : regmap_type;
      WIN1V_Y2                       : regmap_type;
      WIN1V_Y1                       : regmap_type;                             
      WININ                          : regmap_type;
      WININ_Window_0_BG0_Enable      : regmap_type;
      WININ_Window_0_BG1_Enable      : regmap_type;
      WININ_Window_0_BG2_Enable      : regmap_type;
      WININ_Window_0_BG3_Enable      : regmap_type;
      WININ_Window_0_OBJ_Enable      : regmap_type;
      WININ_Window_0_Special_Effect  : regmap_type;
      WININ_Window_1_BG0_Enable      : regmap_type;
      WININ_Window_1_BG1_Enable      : regmap_type;
      WININ_Window_1_BG2_Enable      : regmap_type;
      WININ_Window_1_BG3_Enable      : regmap_type;
      WININ_Window_1_OBJ_Enable      : regmap_type;
      WININ_Window_1_Special_Effect  : regmap_type;                            
      WINOUT                         : regmap_type;
      WINOUT_Outside_BG0_Enable      : regmap_type;
      WINOUT_Outside_BG1_Enable      : regmap_type;
      WINOUT_Outside_BG2_Enable      : regmap_type;
      WINOUT_Outside_BG3_Enable      : regmap_type;
      WINOUT_Outside_OBJ_Enable      : regmap_type;
      WINOUT_Outside_Special_Effect  : regmap_type;
      WINOUT_Objwnd_BG0_Enable       : regmap_type;
      WINOUT_Objwnd_BG1_Enable       : regmap_type;
      WINOUT_Objwnd_BG2_Enable       : regmap_type;
      WINOUT_Objwnd_BG3_Enable       : regmap_type;
      WINOUT_Objwnd_OBJ_Enable       : regmap_type;
      WINOUT_Objwnd_Special_Effect   : regmap_type;                              
      MOSAIC                         : regmap_type;
      MOSAIC_BG_Mosaic_H_Size        : regmap_type;
      MOSAIC_BG_Mosaic_V_Size        : regmap_type;
      MOSAIC_OBJ_Mosaic_H_Size       : regmap_type;
      MOSAIC_OBJ_Mosaic_V_Size       : regmap_type;
      BLDCNT                         : regmap_type;
      BLDCNT_BG0_1st_Target_Pixel    : regmap_type;
      BLDCNT_BG1_1st_Target_Pixel    : regmap_type;
      BLDCNT_BG2_1st_Target_Pixel    : regmap_type;
      BLDCNT_BG3_1st_Target_Pixel    : regmap_type;
      BLDCNT_OBJ_1st_Target_Pixel    : regmap_type;
      BLDCNT_BD_1st_Target_Pixel     : regmap_type;
      BLDCNT_Color_Special_Effect    : regmap_type;
      BLDCNT_BG0_2nd_Target_Pixel    : regmap_type;
      BLDCNT_BG1_2nd_Target_Pixel    : regmap_type;
      BLDCNT_BG2_2nd_Target_Pixel    : regmap_type;
      BLDCNT_BG3_2nd_Target_Pixel    : regmap_type;
      BLDCNT_OBJ_2nd_Target_Pixel    : regmap_type;
      BLDCNT_BD_2nd_Target_Pixel     : regmap_type;                             
      BLDALPHA                       : regmap_type;
      BLDALPHA_EVA_Coefficient       : regmap_type;
      BLDALPHA_EVB_Coefficient       : regmap_type;                             
      BLDY                           : regmap_type;
      MASTER_BRIGHT                  : regmap_type;
      MASTER_BRIGHT_Factor           : regmap_type;
      MASTER_BRIGHT_Mode             : regmap_type
   );
   port 
   (
      clk100               : in  std_logic; 
      
      ds_bus               : in  proc_bus_ds_type; 
      ds_bus_data          : out std_logic_vector(31 downto 0);       
        
      lockspeed            : in  std_logic;
      maxpixels            : in  std_logic;
      
      pixel_out_x          : out integer range 0 to 255;
      pixel_out_y          : out integer range 0 to 191;
      pixel_out_data       : out std_logic_vector(17 downto 0);  
      pixel_out_we         : out std_logic := '0';
                           
      linecounter          : in  unsigned(8 downto 0);
      pixelpos             : in  integer range 0 to 511;
      drawline             : in  std_logic;
      refpoint_update      : in  std_logic;
      hblank_trigger       : in  std_logic;
      vblank_trigger       : in  std_logic;
      line_trigger         : in  std_logic;
      newline_invsync      : in  std_logic;            
      vsync_end            : in  std_logic;            
                                  
      Palette_addr         : in   natural range 0 to 127;
      Palette_datain       : in   std_logic_vector(31 downto 0);
      Palette_dataout_bg   : out  std_logic_vector(31 downto 0);
      Palette_dataout_obj  : out  std_logic_vector(31 downto 0);
      Palette_we_bg        : in   std_logic := '0';
      Palette_we_obj       : in   std_logic := '0';
      Palette_be           : in   std_logic_vector(3 downto 0);
      
      OAMRam_addr          : in   natural range 0 to 255;
      OAMRam_datain        : in   std_logic_vector(31 downto 0);
      OAMRam_dataout       : out  std_logic_vector(31 downto 0);
      OAMRam_we            : in   std_logic := '0';
      OAMRam_be            : in   std_logic_vector(3 downto 0);
      
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
      VRam_valid_I         : in   std_logic
   );
end entity;

architecture arch of ds_gpu_drawer is
   
   -- todo : missing new registers
   signal REG_DISPCNT_BG_Mode                : std_logic_vector(DISPCNT_BG_Mode               .upper downto DISPCNT_BG_Mode               .lower) := (others => '0');
   signal REG_DISPCNT_BG0_2D_3D              : std_logic_vector(DISPCNT_BG0_2D_3D             .upper downto DISPCNT_BG0_2D_3D             .lower) := (others => '0');
   signal REG_DISPCNT_Tile_OBJ_Mapping       : std_logic_vector(DISPCNT_Tile_OBJ_Mapping      .upper downto DISPCNT_Tile_OBJ_Mapping      .lower) := (others => '0');
   signal REG_DISPCNT_Bitmap_OBJ_2D_Dim      : std_logic_vector(DISPCNT_Bitmap_OBJ_2D_Dim     .upper downto DISPCNT_Bitmap_OBJ_2D_Dim     .lower) := (others => '0');
   signal REG_DISPCNT_Bitmap_OBJ_Mapping     : std_logic_vector(DISPCNT_Bitmap_OBJ_Mapping    .upper downto DISPCNT_Bitmap_OBJ_Mapping    .lower) := (others => '0');
   signal REG_DISPCNT_Forced_Blank           : std_logic_vector(DISPCNT_Forced_Blank          .upper downto DISPCNT_Forced_Blank          .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Display_BG0     : std_logic_vector(DISPCNT_Screen_Display_BG0    .upper downto DISPCNT_Screen_Display_BG0    .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Display_BG1     : std_logic_vector(DISPCNT_Screen_Display_BG1    .upper downto DISPCNT_Screen_Display_BG1    .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Display_BG2     : std_logic_vector(DISPCNT_Screen_Display_BG2    .upper downto DISPCNT_Screen_Display_BG2    .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Display_BG3     : std_logic_vector(DISPCNT_Screen_Display_BG3    .upper downto DISPCNT_Screen_Display_BG3    .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Display_OBJ     : std_logic_vector(DISPCNT_Screen_Display_OBJ    .upper downto DISPCNT_Screen_Display_OBJ    .lower) := (others => '0');
   signal REG_DISPCNT_Window_0_Display_Flag  : std_logic_vector(DISPCNT_Window_0_Display_Flag .upper downto DISPCNT_Window_0_Display_Flag .lower) := (others => '0');
   signal REG_DISPCNT_Window_1_Display_Flag  : std_logic_vector(DISPCNT_Window_1_Display_Flag .upper downto DISPCNT_Window_1_Display_Flag .lower) := (others => '0');
   signal REG_DISPCNT_OBJ_Wnd_Display_Flag   : std_logic_vector(DISPCNT_OBJ_Wnd_Display_Flag  .upper downto DISPCNT_OBJ_Wnd_Display_Flag  .lower) := (others => '0');
   signal REG_DISPCNT_Display_Mode           : std_logic_vector(DISPCNT_Display_Mode          .upper downto DISPCNT_Display_Mode          .lower) := (others => '0');
   signal REG_DISPCNT_VRAM_block             : std_logic_vector(DISPCNT_VRAM_block            .upper downto DISPCNT_VRAM_block            .lower) := (others => '0');
   signal REG_DISPCNT_Tile_OBJ_1D_Boundary   : std_logic_vector(DISPCNT_Tile_OBJ_1D_Boundary  .upper downto DISPCNT_Tile_OBJ_1D_Boundary  .lower) := (others => '0');
   signal REG_DISPCNT_Bitmap_OBJ_1D_Boundary : std_logic_vector(DISPCNT_Bitmap_OBJ_1D_Boundary.upper downto DISPCNT_Bitmap_OBJ_1D_Boundary.lower) := (others => '0');
   signal REG_DISPCNT_OBJ_Process_H_Blank    : std_logic_vector(DISPCNT_OBJ_Process_H_Blank   .upper downto DISPCNT_OBJ_Process_H_Blank   .lower) := (others => '0');
   signal REG_DISPCNT_Character_Base         : std_logic_vector(DISPCNT_Character_Base        .upper downto DISPCNT_Character_Base        .lower) := (others => '0');
   signal REG_DISPCNT_Screen_Base            : std_logic_vector(DISPCNT_Screen_Base           .upper downto DISPCNT_Screen_Base           .lower) := (others => '0');
   signal REG_DISPCNT_BG_Extended_Palettes   : std_logic_vector(DISPCNT_BG_Extended_Palettes  .upper downto DISPCNT_BG_Extended_Palettes  .lower) := (others => '0');
   signal REG_DISPCNT_OBJ_Extended_Palettes  : std_logic_vector(DISPCNT_OBJ_Extended_Palettes .upper downto DISPCNT_OBJ_Extended_Palettes .lower) := (others => '0');

   signal REG_BG0CNT_BG_Priority             : std_logic_vector(BG0CNT_BG_Priority            .upper downto BG0CNT_BG_Priority            .lower) := (others => '0');
   signal REG_BG0CNT_Character_Base_Block    : std_logic_vector(BG0CNT_Character_Base_Block   .upper downto BG0CNT_Character_Base_Block   .lower) := (others => '0');
   signal REG_BG0CNT_Mosaic                  : std_logic_vector(BG0CNT_Mosaic                 .upper downto BG0CNT_Mosaic                 .lower) := (others => '0');
   signal REG_BG0CNT_Colors_Palettes         : std_logic_vector(BG0CNT_Colors_Palettes        .upper downto BG0CNT_Colors_Palettes        .lower) := (others => '0');
   signal REG_BG0CNT_Screen_Base_Block       : std_logic_vector(BG0CNT_Screen_Base_Block      .upper downto BG0CNT_Screen_Base_Block      .lower) := (others => '0');
   signal REG_BG0CNT_Ext_Palette_Slot        : std_logic_vector(BG0CNT_Ext_Palette_Slot       .upper downto BG0CNT_Ext_Palette_Slot       .lower) := (others => '0');
   signal REG_BG0CNT_Screen_Size             : std_logic_vector(BG0CNT_Screen_Size            .upper downto BG0CNT_Screen_Size            .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG1CNT_BG_Priority             : std_logic_vector(BG1CNT_BG_Priority            .upper downto BG1CNT_BG_Priority            .lower) := (others => '0');
   signal REG_BG1CNT_Character_Base_Block    : std_logic_vector(BG1CNT_Character_Base_Block   .upper downto BG1CNT_Character_Base_Block   .lower) := (others => '0');
   signal REG_BG1CNT_Mosaic                  : std_logic_vector(BG1CNT_Mosaic                 .upper downto BG1CNT_Mosaic                 .lower) := (others => '0');
   signal REG_BG1CNT_Colors_Palettes         : std_logic_vector(BG1CNT_Colors_Palettes        .upper downto BG1CNT_Colors_Palettes        .lower) := (others => '0');
   signal REG_BG1CNT_Screen_Base_Block       : std_logic_vector(BG1CNT_Screen_Base_Block      .upper downto BG1CNT_Screen_Base_Block      .lower) := (others => '0');
   signal REG_BG1CNT_Ext_Palette_Slot        : std_logic_vector(BG1CNT_Ext_Palette_Slot       .upper downto BG1CNT_Ext_Palette_Slot       .lower) := (others => '0');
   signal REG_BG1CNT_Screen_Size             : std_logic_vector(BG1CNT_Screen_Size            .upper downto BG1CNT_Screen_Size            .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG2CNT_BG_Priority             : std_logic_vector(BG2CNT_BG_Priority            .upper downto BG2CNT_BG_Priority            .lower) := (others => '0');
   signal REG_BG2CNT_Character_Base_Block    : std_logic_vector(BG2CNT_Character_Base_Block   .upper downto BG2CNT_Character_Base_Block   .lower) := (others => '0');
   signal REG_BG2CNT_Mosaic                  : std_logic_vector(BG2CNT_Mosaic                 .upper downto BG2CNT_Mosaic                 .lower) := (others => '0');
   signal REG_BG2CNT_Colors_Palettes         : std_logic_vector(BG2CNT_Colors_Palettes        .upper downto BG2CNT_Colors_Palettes        .lower) := (others => '0');
   signal REG_BG2CNT_Screen_Base_Block       : std_logic_vector(BG2CNT_Screen_Base_Block      .upper downto BG2CNT_Screen_Base_Block      .lower) := (others => '0');
   signal REG_BG2CNT_Display_Area_Overflow   : std_logic_vector(BG2CNT_Display_Area_Overflow  .upper downto BG2CNT_Display_Area_Overflow  .lower) := (others => '0');
   signal REG_BG2CNT_Screen_Size             : std_logic_vector(BG2CNT_Screen_Size            .upper downto BG2CNT_Screen_Size            .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG3CNT_BG_Priority             : std_logic_vector(BG3CNT_BG_Priority            .upper downto BG3CNT_BG_Priority            .lower) := (others => '0');
   signal REG_BG3CNT_Character_Base_Block    : std_logic_vector(BG3CNT_Character_Base_Block   .upper downto BG3CNT_Character_Base_Block   .lower) := (others => '0');
   signal REG_BG3CNT_Mosaic                  : std_logic_vector(BG3CNT_Mosaic                 .upper downto BG3CNT_Mosaic                 .lower) := (others => '0');
   signal REG_BG3CNT_Colors_Palettes         : std_logic_vector(BG3CNT_Colors_Palettes        .upper downto BG3CNT_Colors_Palettes        .lower) := (others => '0');
   signal REG_BG3CNT_Screen_Base_Block       : std_logic_vector(BG3CNT_Screen_Base_Block      .upper downto BG3CNT_Screen_Base_Block      .lower) := (others => '0');
   signal REG_BG3CNT_Display_Area_Overflow   : std_logic_vector(BG3CNT_Display_Area_Overflow  .upper downto BG3CNT_Display_Area_Overflow  .lower) := (others => '0');
   signal REG_BG3CNT_Screen_Size             : std_logic_vector(BG3CNT_Screen_Size            .upper downto BG3CNT_Screen_Size            .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG0HOFS                        : std_logic_vector(BG0HOFS                       .upper downto BG0HOFS                       .lower) := (others => '0');
   signal REG_BG0VOFS                        : std_logic_vector(BG0VOFS                       .upper downto BG0VOFS                       .lower) := (others => '0');
   signal REG_BG1HOFS                        : std_logic_vector(BG1HOFS                       .upper downto BG1HOFS                       .lower) := (others => '0');
   signal REG_BG1VOFS                        : std_logic_vector(BG1VOFS                       .upper downto BG1VOFS                       .lower) := (others => '0');
   signal REG_BG2HOFS                        : std_logic_vector(BG2HOFS                       .upper downto BG2HOFS                       .lower) := (others => '0');
   signal REG_BG2VOFS                        : std_logic_vector(BG2VOFS                       .upper downto BG2VOFS                       .lower) := (others => '0');
   signal REG_BG3HOFS                        : std_logic_vector(BG3HOFS                       .upper downto BG3HOFS                       .lower) := (others => '0');
   signal REG_BG3VOFS                        : std_logic_vector(BG3VOFS                       .upper downto BG3VOFS                       .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG2RotScaleParDX               : std_logic_vector(BG2RotScaleParDX              .upper downto BG2RotScaleParDX              .lower) := (others => '0');
   signal REG_BG2RotScaleParDMX              : std_logic_vector(BG2RotScaleParDMX             .upper downto BG2RotScaleParDMX             .lower) := (others => '0');
   signal REG_BG2RotScaleParDY               : std_logic_vector(BG2RotScaleParDY              .upper downto BG2RotScaleParDY              .lower) := (others => '0');
   signal REG_BG2RotScaleParDMY              : std_logic_vector(BG2RotScaleParDMY             .upper downto BG2RotScaleParDMY             .lower) := (others => '0');
   signal REG_BG2RefX                        : std_logic_vector(BG2RefX                       .upper downto BG2RefX                       .lower) := (others => '0');
   signal REG_BG2RefY                        : std_logic_vector(BG2RefY                       .upper downto BG2RefY                       .lower) := (others => '0');
                                                                                                                                          
   signal REG_BG3RotScaleParDX               : std_logic_vector(BG3RotScaleParDX              .upper downto BG3RotScaleParDX              .lower) := (others => '0');
   signal REG_BG3RotScaleParDMX              : std_logic_vector(BG3RotScaleParDMX             .upper downto BG3RotScaleParDMX             .lower) := (others => '0');
   signal REG_BG3RotScaleParDY               : std_logic_vector(BG3RotScaleParDY              .upper downto BG3RotScaleParDY              .lower) := (others => '0');
   signal REG_BG3RotScaleParDMY              : std_logic_vector(BG3RotScaleParDMY             .upper downto BG3RotScaleParDMY             .lower) := (others => '0');
   signal REG_BG3RefX                        : std_logic_vector(BG3RefX                       .upper downto BG3RefX                       .lower) := (others => '0');
   signal REG_BG3RefY                        : std_logic_vector(BG3RefY                       .upper downto BG3RefY                       .lower) := (others => '0');
                                                                                                                                          
   signal REG_WIN0H_X2                       : std_logic_vector(WIN0H_X2                      .upper downto WIN0H_X2                      .lower) := (others => '0');
   signal REG_WIN0H_X1                       : std_logic_vector(WIN0H_X1                      .upper downto WIN0H_X1                      .lower) := (others => '0');
                                                                                                                                          
   signal REG_WIN1H_X2                       : std_logic_vector(WIN1H_X2                      .upper downto WIN1H_X2                      .lower) := (others => '0');
   signal REG_WIN1H_X1                       : std_logic_vector(WIN1H_X1                      .upper downto WIN1H_X1                      .lower) := (others => '0');
                                                                                                                                          
   signal REG_WIN0V_Y2                       : std_logic_vector(WIN0V_Y2                      .upper downto WIN0V_Y2                      .lower) := (others => '0');
   signal REG_WIN0V_Y1                       : std_logic_vector(WIN0V_Y1                      .upper downto WIN0V_Y1                      .lower) := (others => '0');
                                                                                                                                          
   signal REG_WIN1V_Y2                       : std_logic_vector(WIN1V_Y2                      .upper downto WIN1V_Y2                      .lower) := (others => '0');
   signal REG_WIN1V_Y1                       : std_logic_vector(WIN1V_Y1                      .upper downto WIN1V_Y1                      .lower) := (others => '0');
                                                                                                                                          
   signal REG_WININ_Window_0_BG0_Enable      : std_logic_vector(WININ_Window_0_BG0_Enable     .upper downto WININ_Window_0_BG0_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_0_BG1_Enable      : std_logic_vector(WININ_Window_0_BG1_Enable     .upper downto WININ_Window_0_BG1_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_0_BG2_Enable      : std_logic_vector(WININ_Window_0_BG2_Enable     .upper downto WININ_Window_0_BG2_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_0_BG3_Enable      : std_logic_vector(WININ_Window_0_BG3_Enable     .upper downto WININ_Window_0_BG3_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_0_OBJ_Enable      : std_logic_vector(WININ_Window_0_OBJ_Enable     .upper downto WININ_Window_0_OBJ_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_0_Special_Effect  : std_logic_vector(WININ_Window_0_Special_Effect .upper downto WININ_Window_0_Special_Effect .lower) := (others => '0');
   signal REG_WININ_Window_1_BG0_Enable      : std_logic_vector(WININ_Window_1_BG0_Enable     .upper downto WININ_Window_1_BG0_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_1_BG1_Enable      : std_logic_vector(WININ_Window_1_BG1_Enable     .upper downto WININ_Window_1_BG1_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_1_BG2_Enable      : std_logic_vector(WININ_Window_1_BG2_Enable     .upper downto WININ_Window_1_BG2_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_1_BG3_Enable      : std_logic_vector(WININ_Window_1_BG3_Enable     .upper downto WININ_Window_1_BG3_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_1_OBJ_Enable      : std_logic_vector(WININ_Window_1_OBJ_Enable     .upper downto WININ_Window_1_OBJ_Enable     .lower) := (others => '0');
   signal REG_WININ_Window_1_Special_Effect  : std_logic_vector(WININ_Window_1_Special_Effect .upper downto WININ_Window_1_Special_Effect .lower) := (others => '0');
                                                                                                                                          
   signal REG_WINOUT_Outside_BG0_Enable      : std_logic_vector(WINOUT_Outside_BG0_Enable     .upper downto WINOUT_Outside_BG0_Enable     .lower) := (others => '0');
   signal REG_WINOUT_Outside_BG1_Enable      : std_logic_vector(WINOUT_Outside_BG1_Enable     .upper downto WINOUT_Outside_BG1_Enable     .lower) := (others => '0');
   signal REG_WINOUT_Outside_BG2_Enable      : std_logic_vector(WINOUT_Outside_BG2_Enable     .upper downto WINOUT_Outside_BG2_Enable     .lower) := (others => '0');
   signal REG_WINOUT_Outside_BG3_Enable      : std_logic_vector(WINOUT_Outside_BG3_Enable     .upper downto WINOUT_Outside_BG3_Enable     .lower) := (others => '0');
   signal REG_WINOUT_Outside_OBJ_Enable      : std_logic_vector(WINOUT_Outside_OBJ_Enable     .upper downto WINOUT_Outside_OBJ_Enable     .lower) := (others => '0');
   signal REG_WINOUT_Outside_Special_Effect  : std_logic_vector(WINOUT_Outside_Special_Effect .upper downto WINOUT_Outside_Special_Effect .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_BG0_Enable       : std_logic_vector(WINOUT_Objwnd_BG0_Enable      .upper downto WINOUT_Objwnd_BG0_Enable      .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_BG1_Enable       : std_logic_vector(WINOUT_Objwnd_BG1_Enable      .upper downto WINOUT_Objwnd_BG1_Enable      .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_BG2_Enable       : std_logic_vector(WINOUT_Objwnd_BG2_Enable      .upper downto WINOUT_Objwnd_BG2_Enable      .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_BG3_Enable       : std_logic_vector(WINOUT_Objwnd_BG3_Enable      .upper downto WINOUT_Objwnd_BG3_Enable      .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_OBJ_Enable       : std_logic_vector(WINOUT_Objwnd_OBJ_Enable      .upper downto WINOUT_Objwnd_OBJ_Enable      .lower) := (others => '0');
   signal REG_WINOUT_Objwnd_Special_Effect   : std_logic_vector(WINOUT_Objwnd_Special_Effect  .upper downto WINOUT_Objwnd_Special_Effect  .lower) := (others => '0');
                                                                                                                                          
   signal REG_MOSAIC_BG_Mosaic_H_Size        : std_logic_vector(MOSAIC_BG_Mosaic_H_Size       .upper downto MOSAIC_BG_Mosaic_H_Size       .lower) := (others => '0');
   signal REG_MOSAIC_BG_Mosaic_V_Size        : std_logic_vector(MOSAIC_BG_Mosaic_V_Size       .upper downto MOSAIC_BG_Mosaic_V_Size       .lower) := (others => '0');
   signal REG_MOSAIC_OBJ_Mosaic_H_Size       : std_logic_vector(MOSAIC_OBJ_Mosaic_H_Size      .upper downto MOSAIC_OBJ_Mosaic_H_Size      .lower) := (others => '0');
   signal REG_MOSAIC_OBJ_Mosaic_V_Size       : std_logic_vector(MOSAIC_OBJ_Mosaic_V_Size      .upper downto MOSAIC_OBJ_Mosaic_V_Size      .lower) := (others => '0');
                                                                                                                                          
   signal REG_BLDCNT_BG0_1st_Target_Pixel    : std_logic_vector(BLDCNT_BG0_1st_Target_Pixel   .upper downto BLDCNT_BG0_1st_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG1_1st_Target_Pixel    : std_logic_vector(BLDCNT_BG1_1st_Target_Pixel   .upper downto BLDCNT_BG1_1st_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG2_1st_Target_Pixel    : std_logic_vector(BLDCNT_BG2_1st_Target_Pixel   .upper downto BLDCNT_BG2_1st_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG3_1st_Target_Pixel    : std_logic_vector(BLDCNT_BG3_1st_Target_Pixel   .upper downto BLDCNT_BG3_1st_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_OBJ_1st_Target_Pixel    : std_logic_vector(BLDCNT_OBJ_1st_Target_Pixel   .upper downto BLDCNT_OBJ_1st_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BD_1st_Target_Pixel     : std_logic_vector(BLDCNT_BD_1st_Target_Pixel    .upper downto BLDCNT_BD_1st_Target_Pixel    .lower) := (others => '0');
   signal REG_BLDCNT_Color_Special_Effect    : std_logic_vector(BLDCNT_Color_Special_Effect   .upper downto BLDCNT_Color_Special_Effect   .lower) := (others => '0');
   signal REG_BLDCNT_BG0_2nd_Target_Pixel    : std_logic_vector(BLDCNT_BG0_2nd_Target_Pixel   .upper downto BLDCNT_BG0_2nd_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG1_2nd_Target_Pixel    : std_logic_vector(BLDCNT_BG1_2nd_Target_Pixel   .upper downto BLDCNT_BG1_2nd_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG2_2nd_Target_Pixel    : std_logic_vector(BLDCNT_BG2_2nd_Target_Pixel   .upper downto BLDCNT_BG2_2nd_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BG3_2nd_Target_Pixel    : std_logic_vector(BLDCNT_BG3_2nd_Target_Pixel   .upper downto BLDCNT_BG3_2nd_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_OBJ_2nd_Target_Pixel    : std_logic_vector(BLDCNT_OBJ_2nd_Target_Pixel   .upper downto BLDCNT_OBJ_2nd_Target_Pixel   .lower) := (others => '0');
   signal REG_BLDCNT_BD_2nd_Target_Pixel     : std_logic_vector(BLDCNT_BD_2nd_Target_Pixel    .upper downto BLDCNT_BD_2nd_Target_Pixel    .lower) := (others => '0');
                                                                                                                                          
   signal REG_BLDALPHA_EVA_Coefficient       : std_logic_vector(BLDALPHA_EVA_Coefficient      .upper downto BLDALPHA_EVA_Coefficient      .lower) := (others => '0');
   signal REG_BLDALPHA_EVB_Coefficient       : std_logic_vector(BLDALPHA_EVB_Coefficient      .upper downto BLDALPHA_EVB_Coefficient      .lower) := (others => '0');
                                                                                                                                          
   signal REG_BLDY                           : std_logic_vector(BLDY                          .upper downto BLDY                          .lower) := (others => '0');
   
   signal REG_MASTER_BRIGHT_Factor           : std_logic_vector(MASTER_BRIGHT_Factor          .upper downto MASTER_BRIGHT_Factor          .lower) := (others => '0');
   signal REG_MASTER_BRIGHT_Mode             : std_logic_vector(MASTER_BRIGHT_Mode            .upper downto MASTER_BRIGHT_Mode            .lower) := (others => '0');

   signal MASTER_BRIGHT_maxed  : integer range 0 to 16;

   type t_reg_wired_or is array(0 to 92) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
   
   signal extmode_2           : std_logic_vector(1 downto 0);
   signal extmode_3           : std_logic_vector(1 downto 0);
         
   signal tile16bit_2         : std_logic;
   signal tile16bit_3         : std_logic;
   
   signal extpalette_offset_0 : std_logic_vector(1 downto 0);
   signal extpalette_offset_1 : std_logic_vector(1 downto 0);

   signal on_delay_bg0        : std_logic_vector(2 downto 0) := (others => '0');
   signal on_delay_bg1        : std_logic_vector(2 downto 0) := (others => '0');
   signal on_delay_bg2        : std_logic_vector(2 downto 0) := (others => '0');
   signal on_delay_bg3        : std_logic_vector(2 downto 0) := (others => '0');
         
   signal ref2_x_written      : std_logic;
   signal ref2_y_written      : std_logic;
   signal ref3_x_written      : std_logic;
   signal ref3_y_written      : std_logic;
         
   signal enables_wnd0        : std_logic_vector(5 downto 0);
   signal enables_wnd1        : std_logic_vector(5 downto 0);
   signal enables_wndobj      : std_logic_vector(5 downto 0);
   signal enables_wndout      : std_logic_vector(5 downto 0);
         
   signal screenbase_0        : integer range 0 to 224;
   signal screenbase_1        : integer range 0 to 224;
   signal screenbase_2        : integer range 0 to 224;
   signal screenbase_3        : integer range 0 to 224;
   
   signal screenbase_2_bmp    : integer range 0 to 31;
   signal screenbase_3_bmp    : integer range 0 to 31;
      
   signal charbase_0          : integer range 0 to 28;
   signal charbase_1          : integer range 0 to 28;
   signal charbase_2          : integer range 0 to 28;
   signal charbase_3          : integer range 0 to 28;
   
   -- ram wiring
   signal drawermux_0              : integer range 0 to 3;
   signal drawermux_1              : integer range 0 to 1;
   signal drawermux_2              : integer range 0 to 3;
   signal drawermux_3              : integer range 0 to 3;
   
   signal OAMRAM_Drawer_addr       : integer range 0 to 255;
   signal OAMRAM_Drawer_data       : std_logic_vector(31 downto 0);
   
   -- palette
   signal PALETTE_OAM_Drawer_addr  : integer range 0 to 127;
   signal PALETTE_OAM_Drawer_data  : std_logic_vector(31 downto 0);
   
   signal PALETTE_BG_Drawer_addr   : integer range 0 to 127;
   signal PALETTE_BG_Drawer_addr0  : integer range 0 to 127;
   signal PALETTE_BG_Drawer_addr1  : integer range 0 to 127;
   signal PALETTE_BG_Drawer_addr2  : integer range 0 to 127;
   signal PALETTE_BG_Drawer_addr3  : integer range 0 to 127;
   signal PALETTE_BG_Drawer_data   : std_logic_vector(31 downto 0);
   signal PALETTE_BG_Drawer_valid  : std_logic_vector(3 downto 0) := (others => '0');
   signal PALETTE_BG_Drawer_cnt    : unsigned(1 downto 0) := (others => '0');
   
   signal PALETTE_Drawer_addr_mode0_0  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode0_1  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode0_2  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode0_3  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode2_2  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode2_3  : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode45_2 : integer range 0 to 127;
   signal PALETTE_Drawer_addr_mode45_3 : integer range 0 to 127;
   
   signal EXTPALETTE_addr0         : integer range 0 to 524287;
   signal EXTPALETTE_addr1         : integer range 0 to 524287;
   signal EXTPALETTE_addr2         : integer range 0 to 524287;
   signal EXTPALETTE_addr3         : integer range 0 to 524287;
   signal EXTPALETTE_data0         : std_logic_vector(31 downto 0);
   signal EXTPALETTE_data1         : std_logic_vector(31 downto 0);
   signal EXTPALETTE_data2         : std_logic_vector(31 downto 0);
   signal EXTPALETTE_data3         : std_logic_vector(31 downto 0);
   signal EXTPALETTE_data_obj      : std_logic_vector(31 downto 0);
   signal EXTPALETTE_valid         : std_logic_vector(0 to 4);
   signal EXTPALETTE_req           : std_logic_vector(0 to 4);
          
   signal EXTPALETTE_addr_mode0_0  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode0_1  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode0_2  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode0_3  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode2_2  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode2_3  : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode45_2 : integer range 0 to 524287;
   signal EXTPALETTE_addr_mode45_3 : integer range 0 to 524287;
   signal EXTPALETTE_addrobj       : integer range 0 to 524287;
          
   signal EXTPALETTE_req_mode0_0   : std_logic := '0';
   signal EXTPALETTE_req_mode0_1   : std_logic := '0';
   signal EXTPALETTE_req_mode0_2   : std_logic := '0';
   signal EXTPALETTE_req_mode0_3   : std_logic := '0';
   signal EXTPALETTE_req_mode2_2   : std_logic := '0';
   signal EXTPALETTE_req_mode2_3   : std_logic := '0';
   signal EXTPALETTE_req_mode45_2  : std_logic := '0';
   signal EXTPALETTE_req_mode45_3  : std_logic := '0';
   signal EXTPALETTE_reqobj        : std_logic := '0';
   
   -- vram
   signal VRAM_Drawer_addr0    : integer range 0 to 524287;
   signal VRAM_Drawer_addr1    : integer range 0 to 524287;
   signal VRAM_Drawer_addr2    : integer range 0 to 524287;
   signal VRAM_Drawer_addr3    : integer range 0 to 524287;
   signal VRam_Drawer_data0    : std_logic_vector(31 downto 0);
   signal VRam_Drawer_data1    : std_logic_vector(31 downto 0);
   signal VRam_Drawer_data2    : std_logic_vector(31 downto 0);
   signal VRam_Drawer_data3    : std_logic_vector(31 downto 0);
   signal VRam_Drawer_data_obj : std_logic_vector(31 downto 0);
   signal VRam_Drawer_data_3D  : std_logic_vector(31 downto 0);
   signal VRAM_Drawer_valid    : std_logic_vector(0 to 5);
   signal VRAM_Drawer_req      : std_logic_vector(0 to 5);
   
   signal VRAM_Drawer_addr_mode0_0  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode0_1  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode0_2  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode0_3  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode2_2  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode2_3  : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode45_2 : integer range 0 to 524287;
   signal VRAM_Drawer_addr_mode45_3 : integer range 0 to 524287;
   signal VRAM_Drawer_addrobj       : integer range 0 to 524287;
   signal VRAM_Drawer_addr3D        : integer range 0 to 524287;
   signal VRAM_Drawer_direct_addr   : integer range 0 to 524287;
   
   signal VRAM_Drawer_req_mode0_0   : std_logic;
   signal VRAM_Drawer_req_mode0_1   : std_logic;
   signal VRAM_Drawer_req_mode0_2   : std_logic;
   signal VRAM_Drawer_req_mode0_3   : std_logic;
   signal VRAM_Drawer_req_mode2_2   : std_logic;
   signal VRAM_Drawer_req_mode2_3   : std_logic;
   signal VRAM_Drawer_req_mode45_2  : std_logic;
   signal VRAM_Drawer_req_mode45_3  : std_logic;
   signal VRAM_Drawer_reqobj        : std_logic;
   signal VRAM_Drawer_req3D         : std_logic;
   signal VRAM_Drawer_reqvramdraw   : std_logic;
                                    
   signal directmode                : std_logic;
   
   -- background multiplexing
   signal drawline_1           : std_logic := '0';
   signal hblank_trigger_1     : std_logic := '0';
   
   signal drawline_mode0_0     : std_logic;
   signal drawline_mode0_1     : std_logic;
   signal drawline_mode0_2     : std_logic;
   signal drawline_mode0_3     : std_logic;
   signal drawline_mode2_2     : std_logic;
   signal drawline_mode2_3     : std_logic;
   signal drawline_mode45_2    : std_logic;
   signal drawline_mode45_3    : std_logic;
   signal drawline_obj         : std_logic;
   signal drawline_3D          : std_logic;
       
   signal pixel_we_mode0_0          : std_logic;
   signal pixel_we_mode0_1          : std_logic;
   signal pixel_we_mode0_2          : std_logic;
   signal pixel_we_mode0_3          : std_logic;
   signal pixel_we_mode2_2          : std_logic;
   signal pixel_we_mode2_3          : std_logic;
   signal pixel_we_mode45_2         : std_logic;
   signal pixel_we_mode45_3         : std_logic;
   signal pixel_we_modeobj_color    : std_logic;
   signal pixel_we_modeobj_settings : std_logic;
   signal pixel_we_bg0              : std_logic;
   signal pixel_we_bg1              : std_logic;
   signal pixel_we_bg2              : std_logic;
   signal pixel_we_bg3              : std_logic;
   signal pixel_we_obj_color        : std_logic;
   signal pixel_we_obj_settings     : std_logic;
   signal pixel_we_3D               : std_logic;
   
   signal pixeldata_mode0_0            : std_logic_vector(15 downto 0);
   signal pixeldata_mode0_1            : std_logic_vector(15 downto 0);
   signal pixeldata_mode0_2            : std_logic_vector(15 downto 0);
   signal pixeldata_mode0_3            : std_logic_vector(15 downto 0);
   signal pixeldata_mode2_2            : std_logic_vector(15 downto 0);
   signal pixeldata_mode2_3            : std_logic_vector(15 downto 0);
   signal pixeldata_mode45_2           : std_logic_vector(15 downto 0);
   signal pixeldata_mode45_3           : std_logic_vector(15 downto 0);
   signal pixeldata_modeobj_color      : std_logic_vector(15 downto 0);
   signal pixeldata_modeobj_settings   : std_logic_vector( 2 downto 0);
   signal pixeldata_bg0                : std_logic_vector(15 downto 0);
   signal pixeldata_bg1                : std_logic_vector(15 downto 0);
   signal pixeldata_bg2                : std_logic_vector(15 downto 0);
   signal pixeldata_bg3                : std_logic_vector(15 downto 0);
   signal pixeldata_obj                : std_logic_vector(18 downto 0);
   signal pixeldata_obj_color          : std_logic_vector(15 downto 0);
   signal pixeldata_obj_settings       : std_logic_vector( 2 downto 0);
   signal pixeldata_3D                 : std_logic_vector(15 downto 0);
   
   signal pixel_x_mode0_0  : integer range 0 to 255;
   signal pixel_x_mode0_1  : integer range 0 to 255;
   signal pixel_x_mode0_2  : integer range 0 to 255;
   signal pixel_x_mode0_3  : integer range 0 to 255;
   signal pixel_x_mode2_2  : integer range 0 to 255;
   signal pixel_x_mode2_3  : integer range 0 to 255;
   signal pixel_x_mode45_2 : integer range 0 to 255;
   signal pixel_x_mode45_3 : integer range 0 to 255;
   signal pixel_x_modeobj  : integer range 0 to 255;
   signal pixel_x_bg0      : integer range 0 to 255;
   signal pixel_x_bg1      : integer range 0 to 255;
   signal pixel_x_bg2      : integer range 0 to 255;
   signal pixel_x_bg3      : integer range 0 to 255;
   signal pixel_x_obj      : integer range 0 to 255;
   signal pixel_x_3D       : integer range 0 to 255;
                           
   signal pixel_objwnd     : std_logic;
   
   signal busy_mode0_0  : std_logic;
   signal busy_mode0_1  : std_logic;
   signal busy_mode0_2  : std_logic;
   signal busy_mode0_3  : std_logic;
   signal busy_mode2_2  : std_logic;
   signal busy_mode2_3  : std_logic;
   signal busy_mode45_2 : std_logic;
   signal busy_mode45_3 : std_logic;
   signal busy_modeobj  : std_logic;
   signal busy_3D       : std_logic;
   
   signal draw_allmod   : std_logic_vector(9 downto 0);
   signal busy_allmod   : std_logic_vector(9 downto 0);
   
   -- linebuffers
   signal clear_enable           : std_logic := '0';
   signal clear_addr             : integer range 0 to 255;
   signal clear_trigger          : std_logic := '0';
   signal clear_trigger_1        : std_logic := '0';
                                 
   signal linecounter_int        : integer range 0 to 191;
   signal linebuffer_addr        : integer range 0 to 255;
   signal linebuffer_addr_1      : integer range 0 to 255;
   
   signal linebuffer_bg0_data    : std_logic_vector(15 downto 0);
   signal linebuffer_bg1_data    : std_logic_vector(15 downto 0);
   signal linebuffer_bg2_data    : std_logic_vector(15 downto 0);
   signal linebuffer_bg3_data    : std_logic_vector(15 downto 0);
   signal linebuffer_obj_data    : std_logic_vector(18 downto 0);
   signal linebuffer_obj_color   : std_logic_vector(15 downto 0);
   signal linebuffer_obj_setting : std_logic_vector( 2 downto 0);
                                 
   signal linebuffer_objwindow   : std_logic_vector(0 to 255) := (others => '0');
                                 
   -- merge_pixel                
   signal pixeldata_back_next    : std_logic_vector(15 downto 0) := (others => '0');
   signal pixeldata_back         : std_logic_vector(15 downto 0) := (others => '0');
   signal merge_enable           : std_logic := '0';
   signal merge_enable_1         : std_logic := '0';
   signal merge_pixeldata_out    : std_logic_vector(15 downto 0);
   signal merge_pixel_x          : integer range 0 to 255;
   signal merge_pixel_y          : integer range 0 to 191;
   signal merge_pixel_we         : std_logic := '0';
   signal objwindow_merge_in     : std_logic := '0';  
   
   -- masterbright mixing
   signal bright_pixeldata_out   : std_logic_vector(15 downto 0);
   signal bright_pixel_x         : integer range 0 to 255;
   signal bright_pixel_y         : integer range 0 to 191;
   signal bright_pixel_we        : std_logic := '0';
   
   -- directvram
   signal pixeldata_directvram   : std_logic_vector(15 downto 0) := (others => '0');
   signal directvram_pixel_x     : integer range 0 to 255;
   signal directvram_pixel_y     : integer range 0 to 191;
   signal directvram_pixel_we    : std_logic := '0';
   
   -- mainram drawer
   signal pixeldata_mainram      : std_logic_vector(15 downto 0) := (others => '0');
   signal mainram_pixel_x        : integer range 0 to 255;
   signal mainram_pixel_y        : integer range 0 to 191;
   signal mainram_pixel_we       : std_logic := '0';
   
                                 
   signal lineUpToDate           : std_logic_vector(0 to 191) := (others => '0');
   signal linesDrawn             : integer range 0 to 192 := 0;
   signal nextLineDrawn          : std_logic := '0';
   signal start_draw             : std_logic := '0';
   
   type tdrawstate is
   (
      IDLE,
      WAITHBLANK,
      DRAWING,
      MERGING
   );
   signal drawstate : tdrawstate := IDLE;
   
   -- affine + mosaik
   signal ref2_x : signed(27 downto 0) := (others => '0'); 
   signal ref2_y : signed(27 downto 0) := (others => '0'); 
   signal ref3_x : signed(27 downto 0) := (others => '0'); 
   signal ref3_y : signed(27 downto 0) := (others => '0'); 
   
   signal mosaik_vcnt_bg  : integer range 0 to 15 := 0;
   signal mosaik_vcnt_obj : integer range 0 to 15 := 0;
       
   signal linecounter_mosaic_bg  : integer range 0 to 255;
   signal linecounter_mosaic_obj : integer range 0 to 255;
   
   signal mosaic_ref2_x : signed(27 downto 0) := (others => '0'); 
   signal mosaic_ref2_y : signed(27 downto 0) := (others => '0'); 
   signal mosaic_ref3_x : signed(27 downto 0) := (others => '0'); 
   signal mosaic_ref3_y : signed(27 downto 0) := (others => '0'); 
   
   
begin 
   
   iREG_DISPCNT_BG_Mode                 : entity work.eProcReg_ds generic map (DISPCNT_BG_Mode               ) port map  (clk100, ds_bus, reg_wired_or( 0), REG_DISPCNT_BG_Mode               , REG_DISPCNT_BG_Mode               ); 
   iREG_DISPCNT_BG0_2D_3D               : entity work.eProcReg_ds generic map (DISPCNT_BG0_2D_3D             ) port map  (clk100, ds_bus, reg_wired_or( 1), REG_DISPCNT_BG0_2D_3D             , REG_DISPCNT_BG0_2D_3D             ); 
   iREG_DISPCNT_Tile_OBJ_Mapping        : entity work.eProcReg_ds generic map (DISPCNT_Tile_OBJ_Mapping      ) port map  (clk100, ds_bus, reg_wired_or( 2), REG_DISPCNT_Tile_OBJ_Mapping      , REG_DISPCNT_Tile_OBJ_Mapping      ); 
   iREG_DISPCNT_Bitmap_OBJ_2D_Dim       : entity work.eProcReg_ds generic map (DISPCNT_Bitmap_OBJ_2D_Dim     ) port map  (clk100, ds_bus, reg_wired_or( 3), REG_DISPCNT_Bitmap_OBJ_2D_Dim     , REG_DISPCNT_Bitmap_OBJ_2D_Dim     ); 
   iREG_DISPCNT_Bitmap_OBJ_Mapping      : entity work.eProcReg_ds generic map (DISPCNT_Bitmap_OBJ_Mapping    ) port map  (clk100, ds_bus, reg_wired_or( 4), REG_DISPCNT_Bitmap_OBJ_Mapping    , REG_DISPCNT_Bitmap_OBJ_Mapping    ); 
   iREG_DISPCNT_Forced_Blank            : entity work.eProcReg_ds generic map (DISPCNT_Forced_Blank          ) port map  (clk100, ds_bus, reg_wired_or( 5), REG_DISPCNT_Forced_Blank          , REG_DISPCNT_Forced_Blank          ); 
   iREG_DISPCNT_Screen_Display_BG0      : entity work.eProcReg_ds generic map (DISPCNT_Screen_Display_BG0    ) port map  (clk100, ds_bus, reg_wired_or( 6), REG_DISPCNT_Screen_Display_BG0    , REG_DISPCNT_Screen_Display_BG0    ); 
   iREG_DISPCNT_Screen_Display_BG1      : entity work.eProcReg_ds generic map (DISPCNT_Screen_Display_BG1    ) port map  (clk100, ds_bus, reg_wired_or( 7), REG_DISPCNT_Screen_Display_BG1    , REG_DISPCNT_Screen_Display_BG1    ); 
   iREG_DISPCNT_Screen_Display_BG2      : entity work.eProcReg_ds generic map (DISPCNT_Screen_Display_BG2    ) port map  (clk100, ds_bus, reg_wired_or( 8), REG_DISPCNT_Screen_Display_BG2    , REG_DISPCNT_Screen_Display_BG2    ); 
   iREG_DISPCNT_Screen_Display_BG3      : entity work.eProcReg_ds generic map (DISPCNT_Screen_Display_BG3    ) port map  (clk100, ds_bus, reg_wired_or( 9), REG_DISPCNT_Screen_Display_BG3    , REG_DISPCNT_Screen_Display_BG3    ); 
   iREG_DISPCNT_Screen_Display_OBJ      : entity work.eProcReg_ds generic map (DISPCNT_Screen_Display_OBJ    ) port map  (clk100, ds_bus, reg_wired_or(10), REG_DISPCNT_Screen_Display_OBJ    , REG_DISPCNT_Screen_Display_OBJ    ); 
   iREG_DISPCNT_Window_0_Display_Flag   : entity work.eProcReg_ds generic map (DISPCNT_Window_0_Display_Flag ) port map  (clk100, ds_bus, reg_wired_or(11), REG_DISPCNT_Window_0_Display_Flag , REG_DISPCNT_Window_0_Display_Flag ); 
   iREG_DISPCNT_Window_1_Display_Flag   : entity work.eProcReg_ds generic map (DISPCNT_Window_1_Display_Flag ) port map  (clk100, ds_bus, reg_wired_or(12), REG_DISPCNT_Window_1_Display_Flag , REG_DISPCNT_Window_1_Display_Flag ); 
   iREG_DISPCNT_OBJ_Wnd_Display_Flag    : entity work.eProcReg_ds generic map (DISPCNT_OBJ_Wnd_Display_Flag  ) port map  (clk100, ds_bus, reg_wired_or(13), REG_DISPCNT_OBJ_Wnd_Display_Flag  , REG_DISPCNT_OBJ_Wnd_Display_Flag  ); 
   iREG_DISPCNT_Display_Mode            : entity work.eProcReg_ds generic map (DISPCNT_Display_Mode          ) port map  (clk100, ds_bus, reg_wired_or(14), REG_DISPCNT_Display_Mode          , REG_DISPCNT_Display_Mode          ); 
   iREG_DISPCNT_VRAM_block              : entity work.eProcReg_ds generic map (DISPCNT_VRAM_block            ) port map  (clk100, ds_bus, reg_wired_or(15), REG_DISPCNT_VRAM_block            , REG_DISPCNT_VRAM_block            ); 
   iREG_DISPCNT_Tile_OBJ_1D_Boundary    : entity work.eProcReg_ds generic map (DISPCNT_Tile_OBJ_1D_Boundary  ) port map  (clk100, ds_bus, reg_wired_or(16), REG_DISPCNT_Tile_OBJ_1D_Boundary  , REG_DISPCNT_Tile_OBJ_1D_Boundary  ); 
   iREG_DISPCNT_Bitmap_OBJ_1D_Boundary  : entity work.eProcReg_ds generic map (DISPCNT_Bitmap_OBJ_1D_Boundary) port map  (clk100, ds_bus, reg_wired_or(17), REG_DISPCNT_Bitmap_OBJ_1D_Boundary, REG_DISPCNT_Bitmap_OBJ_1D_Boundary); 
   iREG_DISPCNT_OBJ_Process_H_Blank     : entity work.eProcReg_ds generic map (DISPCNT_OBJ_Process_H_Blank   ) port map  (clk100, ds_bus, reg_wired_or(18), REG_DISPCNT_OBJ_Process_H_Blank   , REG_DISPCNT_OBJ_Process_H_Blank   ); 
   iREG_DISPCNT_Character_Base          : entity work.eProcReg_ds generic map (DISPCNT_Character_Base        ) port map  (clk100, ds_bus, reg_wired_or(19), REG_DISPCNT_Character_Base        , REG_DISPCNT_Character_Base        ); 
   iREG_DISPCNT_Screen_Base             : entity work.eProcReg_ds generic map (DISPCNT_Screen_Base           ) port map  (clk100, ds_bus, reg_wired_or(20), REG_DISPCNT_Screen_Base           , REG_DISPCNT_Screen_Base           ); 
   iREG_DISPCNT_BG_Extended_Palettes    : entity work.eProcReg_ds generic map (DISPCNT_BG_Extended_Palettes  ) port map  (clk100, ds_bus, reg_wired_or(21), REG_DISPCNT_BG_Extended_Palettes  , REG_DISPCNT_BG_Extended_Palettes  ); 
   iREG_DISPCNT_OBJ_Extended_Palettes   : entity work.eProcReg_ds generic map (DISPCNT_OBJ_Extended_Palettes ) port map  (clk100, ds_bus, reg_wired_or(22), REG_DISPCNT_OBJ_Extended_Palettes , REG_DISPCNT_OBJ_Extended_Palettes ); 
                                                                                                                     
   iREG_BG0CNT_BG_Priority              : entity work.eProcReg_ds generic map (BG0CNT_BG_Priority            ) port map  (clk100, ds_bus, reg_wired_or(23), REG_BG0CNT_BG_Priority            , REG_BG0CNT_BG_Priority            ); 
   iREG_BG0CNT_Character_Base_Block     : entity work.eProcReg_ds generic map (BG0CNT_Character_Base_Block   ) port map  (clk100, ds_bus, reg_wired_or(24), REG_BG0CNT_Character_Base_Block   , REG_BG0CNT_Character_Base_Block   ); 
   iREG_BG0CNT_Mosaic                   : entity work.eProcReg_ds generic map (BG0CNT_Mosaic                 ) port map  (clk100, ds_bus, reg_wired_or(25), REG_BG0CNT_Mosaic                 , REG_BG0CNT_Mosaic                 ); 
   iREG_BG0CNT_Colors_Palettes          : entity work.eProcReg_ds generic map (BG0CNT_Colors_Palettes        ) port map  (clk100, ds_bus, reg_wired_or(26), REG_BG0CNT_Colors_Palettes        , REG_BG0CNT_Colors_Palettes        ); 
   iREG_BG0CNT_Screen_Base_Block        : entity work.eProcReg_ds generic map (BG0CNT_Screen_Base_Block      ) port map  (clk100, ds_bus, reg_wired_or(27), REG_BG0CNT_Screen_Base_Block      , REG_BG0CNT_Screen_Base_Block      ); 
   iREG_BG0CNT_Ext_Palette_Slot         : entity work.eProcReg_ds generic map (BG0CNT_Ext_Palette_Slot       ) port map  (clk100, ds_bus, reg_wired_or(88), REG_BG0CNT_Ext_Palette_Slot       , REG_BG0CNT_Ext_Palette_Slot       ); 
   iREG_BG0CNT_Screen_Size              : entity work.eProcReg_ds generic map (BG0CNT_Screen_Size            ) port map  (clk100, ds_bus, reg_wired_or(28), REG_BG0CNT_Screen_Size            , REG_BG0CNT_Screen_Size            ); 
                                                                                                                                                                                                        
   iREG_BG1CNT_BG_Priority              : entity work.eProcReg_ds generic map (BG1CNT_BG_Priority            ) port map  (clk100, ds_bus, reg_wired_or(29), REG_BG1CNT_BG_Priority            , REG_BG1CNT_BG_Priority            ); 
   iREG_BG1CNT_Character_Base_Block     : entity work.eProcReg_ds generic map (BG1CNT_Character_Base_Block   ) port map  (clk100, ds_bus, reg_wired_or(30), REG_BG1CNT_Character_Base_Block   , REG_BG1CNT_Character_Base_Block   );
   iREG_BG1CNT_Mosaic                   : entity work.eProcReg_ds generic map (BG1CNT_Mosaic                 ) port map  (clk100, ds_bus, reg_wired_or(31), REG_BG1CNT_Mosaic                 , REG_BG1CNT_Mosaic                 ); 
   iREG_BG1CNT_Colors_Palettes          : entity work.eProcReg_ds generic map (BG1CNT_Colors_Palettes        ) port map  (clk100, ds_bus, reg_wired_or(32), REG_BG1CNT_Colors_Palettes        , REG_BG1CNT_Colors_Palettes        ); 
   iREG_BG1CNT_Screen_Base_Block        : entity work.eProcReg_ds generic map (BG1CNT_Screen_Base_Block      ) port map  (clk100, ds_bus, reg_wired_or(33), REG_BG1CNT_Screen_Base_Block      , REG_BG1CNT_Screen_Base_Block      ); 
   iREG_BG1CNT_Ext_Palette_Slot         : entity work.eProcReg_ds generic map (BG1CNT_Ext_Palette_Slot       ) port map  (clk100, ds_bus, reg_wired_or(89), REG_BG1CNT_Ext_Palette_Slot       , REG_BG1CNT_Ext_Palette_Slot       ); 
   iREG_BG1CNT_Screen_Size              : entity work.eProcReg_ds generic map (BG1CNT_Screen_Size            ) port map  (clk100, ds_bus, reg_wired_or(34), REG_BG1CNT_Screen_Size            , REG_BG1CNT_Screen_Size            ); 
                                                                                                                                                                                              
   iREG_BG2CNT_BG_Priority              : entity work.eProcReg_ds generic map (BG2CNT_BG_Priority            ) port map  (clk100, ds_bus, reg_wired_or(35), REG_BG2CNT_BG_Priority            , REG_BG2CNT_BG_Priority            ); 
   iREG_BG2CNT_Character_Base_Block     : entity work.eProcReg_ds generic map (BG2CNT_Character_Base_Block   ) port map  (clk100, ds_bus, reg_wired_or(36), REG_BG2CNT_Character_Base_Block   , REG_BG2CNT_Character_Base_Block   ); 
   iREG_BG2CNT_Mosaic                   : entity work.eProcReg_ds generic map (BG2CNT_Mosaic                 ) port map  (clk100, ds_bus, reg_wired_or(37), REG_BG2CNT_Mosaic                 , REG_BG2CNT_Mosaic                 ); 
   iREG_BG2CNT_Colors_Palettes          : entity work.eProcReg_ds generic map (BG2CNT_Colors_Palettes        ) port map  (clk100, ds_bus, reg_wired_or(38), REG_BG2CNT_Colors_Palettes        , REG_BG2CNT_Colors_Palettes        ); 
   iREG_BG2CNT_Screen_Base_Block        : entity work.eProcReg_ds generic map (BG2CNT_Screen_Base_Block      ) port map  (clk100, ds_bus, reg_wired_or(39), REG_BG2CNT_Screen_Base_Block      , REG_BG2CNT_Screen_Base_Block      ); 
   iREG_BG2CNT_Display_Area_Overflow    : entity work.eProcReg_ds generic map (BG2CNT_Display_Area_Overflow  ) port map  (clk100, ds_bus, reg_wired_or(40), REG_BG2CNT_Display_Area_Overflow  , REG_BG2CNT_Display_Area_Overflow  ); 
   iREG_BG2CNT_Screen_Size              : entity work.eProcReg_ds generic map (BG2CNT_Screen_Size            ) port map  (clk100, ds_bus, reg_wired_or(41), REG_BG2CNT_Screen_Size            , REG_BG2CNT_Screen_Size            ); 
                                                                                                                                                                                                      
   iREG_BG3CNT_BG_Priority              : entity work.eProcReg_ds generic map (BG3CNT_BG_Priority            ) port map  (clk100, ds_bus, reg_wired_or(42), REG_BG3CNT_BG_Priority            , REG_BG3CNT_BG_Priority            ); 
   iREG_BG3CNT_Character_Base_Block     : entity work.eProcReg_ds generic map (BG3CNT_Character_Base_Block   ) port map  (clk100, ds_bus, reg_wired_or(43), REG_BG3CNT_Character_Base_Block   , REG_BG3CNT_Character_Base_Block   ); 
   iREG_BG3CNT_Mosaic                   : entity work.eProcReg_ds generic map (BG3CNT_Mosaic                 ) port map  (clk100, ds_bus, reg_wired_or(44), REG_BG3CNT_Mosaic                 , REG_BG3CNT_Mosaic                 ); 
   iREG_BG3CNT_Colors_Palettes          : entity work.eProcReg_ds generic map (BG3CNT_Colors_Palettes        ) port map  (clk100, ds_bus, reg_wired_or(45), REG_BG3CNT_Colors_Palettes        , REG_BG3CNT_Colors_Palettes        ); 
   iREG_BG3CNT_Screen_Base_Block        : entity work.eProcReg_ds generic map (BG3CNT_Screen_Base_Block      ) port map  (clk100, ds_bus, reg_wired_or(46), REG_BG3CNT_Screen_Base_Block      , REG_BG3CNT_Screen_Base_Block      ); 
   iREG_BG3CNT_Display_Area_Overflow    : entity work.eProcReg_ds generic map (BG3CNT_Display_Area_Overflow  ) port map  (clk100, ds_bus, reg_wired_or(47), REG_BG3CNT_Display_Area_Overflow  , REG_BG3CNT_Display_Area_Overflow  ); 
   iREG_BG3CNT_Screen_Size              : entity work.eProcReg_ds generic map (BG3CNT_Screen_Size            ) port map  (clk100, ds_bus, reg_wired_or(48), REG_BG3CNT_Screen_Size            , REG_BG3CNT_Screen_Size            ); 
                                                                                                                                                                                              
   iREG_BG0HOFS                         : entity work.eProcReg_ds generic map (BG0HOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG0HOFS                       ); 
   iREG_BG0VOFS                         : entity work.eProcReg_ds generic map (BG0VOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG0VOFS                       ); 
   iREG_BG1HOFS                         : entity work.eProcReg_ds generic map (BG1HOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG1HOFS                       ); 
   iREG_BG1VOFS                         : entity work.eProcReg_ds generic map (BG1VOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG1VOFS                       ); 
   iREG_BG2HOFS                         : entity work.eProcReg_ds generic map (BG2HOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2HOFS                       ); 
   iREG_BG2VOFS                         : entity work.eProcReg_ds generic map (BG2VOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2VOFS                       ); 
   iREG_BG3HOFS                         : entity work.eProcReg_ds generic map (BG3HOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3HOFS                       ); 
   iREG_BG3VOFS                         : entity work.eProcReg_ds generic map (BG3VOFS                       ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3VOFS                       ); 
                                                                                                                                                                                                
   iREG_BG2RotScaleParDX                : entity work.eProcReg_ds generic map (BG2RotScaleParDX              ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2RotScaleParDX              ); 
   iREG_BG2RotScaleParDMX               : entity work.eProcReg_ds generic map (BG2RotScaleParDMX             ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2RotScaleParDMX             ); 
   iREG_BG2RotScaleParDY                : entity work.eProcReg_ds generic map (BG2RotScaleParDY              ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2RotScaleParDY              ); 
   iREG_BG2RotScaleParDMY               : entity work.eProcReg_ds generic map (BG2RotScaleParDMY             ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG2RotScaleParDMY             ); 
   iREG_BG2RefX                         : entity work.eProcReg_ds generic map (BG2RefX                       ) port map  (clk100, ds_bus, open            , x"0000000"                        , REG_BG2RefX                       , ref2_x_written); 
   iREG_BG2RefY                         : entity work.eProcReg_ds generic map (BG2RefY                       ) port map  (clk100, ds_bus, open            , x"0000000"                        , REG_BG2RefY                       , ref2_y_written); 
                                                                                                                                                                                   
   iREG_BG3RotScaleParDX                : entity work.eProcReg_ds generic map (BG3RotScaleParDX              ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3RotScaleParDX              ); 
   iREG_BG3RotScaleParDMX               : entity work.eProcReg_ds generic map (BG3RotScaleParDMX             ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3RotScaleParDMX             ); 
   iREG_BG3RotScaleParDY                : entity work.eProcReg_ds generic map (BG3RotScaleParDY              ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3RotScaleParDY              ); 
   iREG_BG3RotScaleParDMY               : entity work.eProcReg_ds generic map (BG3RotScaleParDMY             ) port map  (clk100, ds_bus, open            , x"0000"                           , REG_BG3RotScaleParDMY             ); 
   iREG_BG3RefX                         : entity work.eProcReg_ds generic map (BG3RefX                       ) port map  (clk100, ds_bus, open            , x"0000000"                        , REG_BG3RefX                       , ref3_x_written); 
   iREG_BG3RefY                         : entity work.eProcReg_ds generic map (BG3RefY                       ) port map  (clk100, ds_bus, open            , x"0000000"                        , REG_BG3RefY                       , ref3_y_written); 
                                                                                                                                                                                  
   iREG_WIN0H_X2                        : entity work.eProcReg_ds generic map (WIN0H_X2                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN0H_X2                      ); 
   iREG_WIN0H_X1                        : entity work.eProcReg_ds generic map (WIN0H_X1                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN0H_X1                      ); 
                                                                                                                                                                             
   iREG_WIN1H_X2                        : entity work.eProcReg_ds generic map (WIN1H_X2                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN1H_X2                      ); 
   iREG_WIN1H_X1                        : entity work.eProcReg_ds generic map (WIN1H_X1                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN1H_X1                      ); 
                                                                                                                                                                             
   iREG_WIN0V_Y2                        : entity work.eProcReg_ds generic map (WIN0V_Y2                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN0V_Y2                      ); 
   iREG_WIN0V_Y1                        : entity work.eProcReg_ds generic map (WIN0V_Y1                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN0V_Y1                      ); 
                                                                                                                                                                              
   iREG_WIN1V_Y2                        : entity work.eProcReg_ds generic map (WIN1V_Y2                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN1V_Y2                      ); 
   iREG_WIN1V_Y1                        : entity work.eProcReg_ds generic map (WIN1V_Y1                      ) port map  (clk100, ds_bus, open            , x"00"                             , REG_WIN1V_Y1                      ); 
                                                                                                                                                                                       
   iREG_WININ_Window_0_BG0_Enable       : entity work.eProcReg_ds generic map (WININ_Window_0_BG0_Enable     ) port map  (clk100, ds_bus, reg_wired_or(49), REG_WININ_Window_0_BG0_Enable     , REG_WININ_Window_0_BG0_Enable     ); 
   iREG_WININ_Window_0_BG1_Enable       : entity work.eProcReg_ds generic map (WININ_Window_0_BG1_Enable     ) port map  (clk100, ds_bus, reg_wired_or(50), REG_WININ_Window_0_BG1_Enable     , REG_WININ_Window_0_BG1_Enable     ); 
   iREG_WININ_Window_0_BG2_Enable       : entity work.eProcReg_ds generic map (WININ_Window_0_BG2_Enable     ) port map  (clk100, ds_bus, reg_wired_or(51), REG_WININ_Window_0_BG2_Enable     , REG_WININ_Window_0_BG2_Enable     ); 
   iREG_WININ_Window_0_BG3_Enable       : entity work.eProcReg_ds generic map (WININ_Window_0_BG3_Enable     ) port map  (clk100, ds_bus, reg_wired_or(52), REG_WININ_Window_0_BG3_Enable     , REG_WININ_Window_0_BG3_Enable     ); 
   iREG_WININ_Window_0_OBJ_Enable       : entity work.eProcReg_ds generic map (WININ_Window_0_OBJ_Enable     ) port map  (clk100, ds_bus, reg_wired_or(53), REG_WININ_Window_0_OBJ_Enable     , REG_WININ_Window_0_OBJ_Enable     ); 
   iREG_WININ_Window_0_Special_Effect   : entity work.eProcReg_ds generic map (WININ_Window_0_Special_Effect ) port map  (clk100, ds_bus, reg_wired_or(54), REG_WININ_Window_0_Special_Effect , REG_WININ_Window_0_Special_Effect ); 
   iREG_WININ_Window_1_BG0_Enable       : entity work.eProcReg_ds generic map (WININ_Window_1_BG0_Enable     ) port map  (clk100, ds_bus, reg_wired_or(55), REG_WININ_Window_1_BG0_Enable     , REG_WININ_Window_1_BG0_Enable     ); 
   iREG_WININ_Window_1_BG1_Enable       : entity work.eProcReg_ds generic map (WININ_Window_1_BG1_Enable     ) port map  (clk100, ds_bus, reg_wired_or(56), REG_WININ_Window_1_BG1_Enable     , REG_WININ_Window_1_BG1_Enable     ); 
   iREG_WININ_Window_1_BG2_Enable       : entity work.eProcReg_ds generic map (WININ_Window_1_BG2_Enable     ) port map  (clk100, ds_bus, reg_wired_or(57), REG_WININ_Window_1_BG2_Enable     , REG_WININ_Window_1_BG2_Enable     ); 
   iREG_WININ_Window_1_BG3_Enable       : entity work.eProcReg_ds generic map (WININ_Window_1_BG3_Enable     ) port map  (clk100, ds_bus, reg_wired_or(58), REG_WININ_Window_1_BG3_Enable     , REG_WININ_Window_1_BG3_Enable     ); 
   iREG_WININ_Window_1_OBJ_Enable       : entity work.eProcReg_ds generic map (WININ_Window_1_OBJ_Enable     ) port map  (clk100, ds_bus, reg_wired_or(59), REG_WININ_Window_1_OBJ_Enable     , REG_WININ_Window_1_OBJ_Enable     ); 
   iREG_WININ_Window_1_Special_Effect   : entity work.eProcReg_ds generic map (WININ_Window_1_Special_Effect ) port map  (clk100, ds_bus, reg_wired_or(60), REG_WININ_Window_1_Special_Effect , REG_WININ_Window_1_Special_Effect ); 
                                                                                                                                                                                          
   iREG_WINOUT_Outside_BG0_Enable       : entity work.eProcReg_ds generic map (WINOUT_Outside_BG0_Enable     ) port map  (clk100, ds_bus, reg_wired_or(61), REG_WINOUT_Outside_BG0_Enable     , REG_WINOUT_Outside_BG0_Enable     ); 
   iREG_WINOUT_Outside_BG1_Enable       : entity work.eProcReg_ds generic map (WINOUT_Outside_BG1_Enable     ) port map  (clk100, ds_bus, reg_wired_or(62), REG_WINOUT_Outside_BG1_Enable     , REG_WINOUT_Outside_BG1_Enable     ); 
   iREG_WINOUT_Outside_BG2_Enable       : entity work.eProcReg_ds generic map (WINOUT_Outside_BG2_Enable     ) port map  (clk100, ds_bus, reg_wired_or(63), REG_WINOUT_Outside_BG2_Enable     , REG_WINOUT_Outside_BG2_Enable     ); 
   iREG_WINOUT_Outside_BG3_Enable       : entity work.eProcReg_ds generic map (WINOUT_Outside_BG3_Enable     ) port map  (clk100, ds_bus, reg_wired_or(64), REG_WINOUT_Outside_BG3_Enable     , REG_WINOUT_Outside_BG3_Enable     ); 
   iREG_WINOUT_Outside_OBJ_Enable       : entity work.eProcReg_ds generic map (WINOUT_Outside_OBJ_Enable     ) port map  (clk100, ds_bus, reg_wired_or(65), REG_WINOUT_Outside_OBJ_Enable     , REG_WINOUT_Outside_OBJ_Enable     ); 
   iREG_WINOUT_Outside_Special_Effect   : entity work.eProcReg_ds generic map (WINOUT_Outside_Special_Effect ) port map  (clk100, ds_bus, reg_wired_or(66), REG_WINOUT_Outside_Special_Effect , REG_WINOUT_Outside_Special_Effect ); 
   iREG_WINOUT_Objwnd_BG0_Enable        : entity work.eProcReg_ds generic map (WINOUT_Objwnd_BG0_Enable      ) port map  (clk100, ds_bus, reg_wired_or(67), REG_WINOUT_Objwnd_BG0_Enable      , REG_WINOUT_Objwnd_BG0_Enable      ); 
   iREG_WINOUT_Objwnd_BG1_Enable        : entity work.eProcReg_ds generic map (WINOUT_Objwnd_BG1_Enable      ) port map  (clk100, ds_bus, reg_wired_or(68), REG_WINOUT_Objwnd_BG1_Enable      , REG_WINOUT_Objwnd_BG1_Enable      ); 
   iREG_WINOUT_Objwnd_BG2_Enable        : entity work.eProcReg_ds generic map (WINOUT_Objwnd_BG2_Enable      ) port map  (clk100, ds_bus, reg_wired_or(69), REG_WINOUT_Objwnd_BG2_Enable      , REG_WINOUT_Objwnd_BG2_Enable      ); 
   iREG_WINOUT_Objwnd_BG3_Enable        : entity work.eProcReg_ds generic map (WINOUT_Objwnd_BG3_Enable      ) port map  (clk100, ds_bus, reg_wired_or(70), REG_WINOUT_Objwnd_BG3_Enable      , REG_WINOUT_Objwnd_BG3_Enable      ); 
   iREG_WINOUT_Objwnd_OBJ_Enable        : entity work.eProcReg_ds generic map (WINOUT_Objwnd_OBJ_Enable      ) port map  (clk100, ds_bus, reg_wired_or(71), REG_WINOUT_Objwnd_OBJ_Enable      , REG_WINOUT_Objwnd_OBJ_Enable      ); 
   iREG_WINOUT_Objwnd_Special_Effect    : entity work.eProcReg_ds generic map (WINOUT_Objwnd_Special_Effect  ) port map  (clk100, ds_bus, reg_wired_or(72), REG_WINOUT_Objwnd_Special_Effect  , REG_WINOUT_Objwnd_Special_Effect  ); 
                                                                                                                                                                                                      
   iREG_MOSAIC_BG_Mosaic_H_Size         : entity work.eProcReg_ds generic map (MOSAIC_BG_Mosaic_H_Size       ) port map  (clk100, ds_bus, open            , x"0"                              , REG_MOSAIC_BG_Mosaic_H_Size       ); 
   iREG_MOSAIC_BG_Mosaic_V_Size         : entity work.eProcReg_ds generic map (MOSAIC_BG_Mosaic_V_Size       ) port map  (clk100, ds_bus, open            , x"0"                              , REG_MOSAIC_BG_Mosaic_V_Size       ); 
   iREG_MOSAIC_OBJ_Mosaic_H_Size        : entity work.eProcReg_ds generic map (MOSAIC_OBJ_Mosaic_H_Size      ) port map  (clk100, ds_bus, open            , x"0"                              , REG_MOSAIC_OBJ_Mosaic_H_Size      ); 
   iREG_MOSAIC_OBJ_Mosaic_V_Size        : entity work.eProcReg_ds generic map (MOSAIC_OBJ_Mosaic_V_Size      ) port map  (clk100, ds_bus, open            , x"0"                              , REG_MOSAIC_OBJ_Mosaic_V_Size      ); 
                                                                                                                                                                                                    
   iREG_BLDCNT_BG0_1st_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG0_1st_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(73), REG_BLDCNT_BG0_1st_Target_Pixel   , REG_BLDCNT_BG0_1st_Target_Pixel   ); 
   iREG_BLDCNT_BG1_1st_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG1_1st_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(74), REG_BLDCNT_BG1_1st_Target_Pixel   , REG_BLDCNT_BG1_1st_Target_Pixel   ); 
   iREG_BLDCNT_BG2_1st_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG2_1st_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(75), REG_BLDCNT_BG2_1st_Target_Pixel   , REG_BLDCNT_BG2_1st_Target_Pixel   ); 
   iREG_BLDCNT_BG3_1st_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG3_1st_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(76), REG_BLDCNT_BG3_1st_Target_Pixel   , REG_BLDCNT_BG3_1st_Target_Pixel   ); 
   iREG_BLDCNT_OBJ_1st_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_OBJ_1st_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(77), REG_BLDCNT_OBJ_1st_Target_Pixel   , REG_BLDCNT_OBJ_1st_Target_Pixel   ); 
   iREG_BLDCNT_BD_1st_Target_Pixel      : entity work.eProcReg_ds generic map (BLDCNT_BD_1st_Target_Pixel    ) port map  (clk100, ds_bus, reg_wired_or(78), REG_BLDCNT_BD_1st_Target_Pixel    , REG_BLDCNT_BD_1st_Target_Pixel    ); 
   iREG_BLDCNT_Color_Special_Effect     : entity work.eProcReg_ds generic map (BLDCNT_Color_Special_Effect   ) port map  (clk100, ds_bus, reg_wired_or(79), REG_BLDCNT_Color_Special_Effect   , REG_BLDCNT_Color_Special_Effect   ); 
   iREG_BLDCNT_BG0_2nd_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG0_2nd_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(80), REG_BLDCNT_BG0_2nd_Target_Pixel   , REG_BLDCNT_BG0_2nd_Target_Pixel   ); 
   iREG_BLDCNT_BG1_2nd_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG1_2nd_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(81), REG_BLDCNT_BG1_2nd_Target_Pixel   , REG_BLDCNT_BG1_2nd_Target_Pixel   ); 
   iREG_BLDCNT_BG2_2nd_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG2_2nd_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(82), REG_BLDCNT_BG2_2nd_Target_Pixel   , REG_BLDCNT_BG2_2nd_Target_Pixel   ); 
   iREG_BLDCNT_BG3_2nd_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_BG3_2nd_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(83), REG_BLDCNT_BG3_2nd_Target_Pixel   , REG_BLDCNT_BG3_2nd_Target_Pixel   ); 
   iREG_BLDCNT_OBJ_2nd_Target_Pixel     : entity work.eProcReg_ds generic map (BLDCNT_OBJ_2nd_Target_Pixel   ) port map  (clk100, ds_bus, reg_wired_or(84), REG_BLDCNT_OBJ_2nd_Target_Pixel   , REG_BLDCNT_OBJ_2nd_Target_Pixel   ); 
   iREG_BLDCNT_BD_2nd_Target_Pixel      : entity work.eProcReg_ds generic map (BLDCNT_BD_2nd_Target_Pixel    ) port map  (clk100, ds_bus, reg_wired_or(85), REG_BLDCNT_BD_2nd_Target_Pixel    , REG_BLDCNT_BD_2nd_Target_Pixel    ); 
                                                                                                                                                                                       
   iREG_BLDALPHA_EVA_Coefficient        : entity work.eProcReg_ds generic map (BLDALPHA_EVA_Coefficient      ) port map  (clk100, ds_bus, reg_wired_or(86), REG_BLDALPHA_EVA_Coefficient      , REG_BLDALPHA_EVA_Coefficient      ); 
   iREG_BLDALPHA_EVB_Coefficient        : entity work.eProcReg_ds generic map (BLDALPHA_EVB_Coefficient      ) port map  (clk100, ds_bus, reg_wired_or(87), REG_BLDALPHA_EVB_Coefficient      , REG_BLDALPHA_EVB_Coefficient      ); 
                                                                                                                                                                                                
   iREG_BLDY                            : entity work.eProcReg_ds generic map (BLDY                          ) port map  (clk100, ds_bus, open            , "00000"                           , REG_BLDY                          );
   
   iMASTER_BRIGHT_Factor                : entity work.eProcReg_ds generic map (MASTER_BRIGHT_Factor          ) port map  (clk100, ds_bus, reg_wired_or(91), REG_MASTER_BRIGHT_Factor          , REG_MASTER_BRIGHT_Factor          );  
   iMASTER_BRIGHT_Mode                  : entity work.eProcReg_ds generic map (MASTER_BRIGHT_Mode            ) port map  (clk100, ds_bus, reg_wired_or(92), REG_MASTER_BRIGHT_Mode            , REG_MASTER_BRIGHT_Mode            );  
   
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   
   ipaletteram_bg : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 7
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => Palette_addr,   
      datain_a0  => Palette_datain( 7 downto  0), 
      datain_a1  => Palette_datain(15 downto  8),
      datain_a2  => Palette_datain(23 downto 16),
      datain_a3  => Palette_datain(31 downto 24),
      dataout_a  => Palette_dataout_bg,
      we_a       => Palette_we_bg,    
      be_a       => Palette_be,     
		           
      addr_b     => PALETTE_BG_Drawer_addr,   
      datain_b0  => x"00", 
      datain_b1  => x"00",
      datain_b2  => x"00",
      datain_b3  => x"00",
      dataout_b  => PALETTE_BG_Drawer_data,
      we_b       => '0',    
      be_b       => "1111"     
   );
   
   ipaletteram_oam : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 7
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => Palette_addr,   
      datain_a0  => Palette_datain( 7 downto  0), 
      datain_a1  => Palette_datain(15 downto  8),
      datain_a2  => Palette_datain(23 downto 16),
      datain_a3  => Palette_datain(31 downto 24),
      dataout_a  => Palette_dataout_obj,
      we_a       => Palette_we_obj,    
      be_a       => Palette_be,     
		           
      addr_b     => PALETTE_OAM_Drawer_addr,   
      datain_b0  => x"00", 
      datain_b1  => x"00",
      datain_b2  => x"00",
      datain_b3  => x"00",
      dataout_b  => PALETTE_OAM_Drawer_data,
      we_b       => '0',    
      be_b       => "1111"     
   );
   
   ioamram : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => OAMRam_addr,   
      datain_a0  => OAMRam_datain( 7 downto  0), 
      datain_a1  => OAMRam_datain(15 downto  8),
      datain_a2  => OAMRam_datain(23 downto 16),
      datain_a3  => OAMRam_datain(31 downto 24),
      dataout_a  => OAMRam_dataout,
      we_a       => OAMRam_we,    
      be_a       => OAMRam_be,     
		           
      addr_b     => OAMRAM_Drawer_addr,   
      datain_b0  => x"00", 
      datain_b1  => x"00",
      datain_b2  => x"00",
      datain_b3  => x"00",
      dataout_b  => OAMRAM_Drawer_data,
      we_b       => '0',    
      be_b       => "1111"     
   );
   
   gdrawer_on :  if ds_nogpu = '0' generate
   begin
   
      screenbase_0 <= to_integer(unsigned(REG_BG0CNT_Screen_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Screen_Base)) * 32 when isGPUA = '1' else to_integer(unsigned(REG_BG0CNT_Screen_Base_Block));
      screenbase_1 <= to_integer(unsigned(REG_BG1CNT_Screen_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Screen_Base)) * 32 when isGPUA = '1' else to_integer(unsigned(REG_BG1CNT_Screen_Base_Block));
      screenbase_2 <= to_integer(unsigned(REG_BG2CNT_Screen_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Screen_Base)) * 32 when isGPUA = '1' else to_integer(unsigned(REG_BG2CNT_Screen_Base_Block));
      screenbase_3 <= to_integer(unsigned(REG_BG3CNT_Screen_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Screen_Base)) * 32 when isGPUA = '1' else to_integer(unsigned(REG_BG3CNT_Screen_Base_Block));
       
      screenbase_2_bmp <= to_integer(unsigned(REG_BG2CNT_Screen_Base_Block));
      screenbase_3_bmp <= to_integer(unsigned(REG_BG3CNT_Screen_Base_Block)); 
      
      charbase_0   <= to_integer(unsigned(REG_BG0CNT_Character_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Character_Base)) * 4 when isGPUA = '1' else to_integer(unsigned(REG_BG0CNT_Character_Base_Block));
      charbase_1   <= to_integer(unsigned(REG_BG1CNT_Character_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Character_Base)) * 4 when isGPUA = '1' else to_integer(unsigned(REG_BG1CNT_Character_Base_Block));
      charbase_2   <= to_integer(unsigned(REG_BG2CNT_Character_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Character_Base)) * 4 when isGPUA = '1' else to_integer(unsigned(REG_BG2CNT_Character_Base_Block));
      charbase_3   <= to_integer(unsigned(REG_BG3CNT_Character_Base_Block)) + to_integer(unsigned(REG_DISPCNT_Character_Base)) * 4 when isGPUA = '1' else to_integer(unsigned(REG_BG3CNT_Character_Base_Block));
   
      ids_drawer_mode0_0 : entity work.ds_drawer_mode0
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         drawline             => drawline_mode0_0,
         busy                 => busy_mode0_0,
         lockspeed            => lockspeed,
         pixelpos             => pixelpos, 
         ypos                 => linecounter_int,
         ypos_mosaic          => linecounter_mosaic_bg,
         mapbase              => screenbase_0,
         tilebase             => charbase_0,
         hicolor              => REG_BG0CNT_Colors_Palettes(REG_BG0CNT_Colors_Palettes'left),
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => extpalette_offset_0,
         mosaic               => REG_BG0CNT_Mosaic(REG_BG0CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         screensize           => unsigned(REG_BG0CNT_Screen_Size),
         scrollX              => unsigned(REG_BG0HOFS(8 downto 0)),
         scrollY              => unsigned(REG_BG0VOFS(24 downto 16)),
         pixel_we             => pixel_we_mode0_0,
         pixeldata            => pixeldata_mode0_0,
         pixel_x              => pixel_x_mode0_0,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode0_0,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(0),
         EXTPALETTE_req       => EXTPALETTE_req_mode0_0,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode0_0,
         EXTPALETTE_data      => EXTPALETTE_data0,
         EXTPALETTE_valid     => EXTPALETTE_valid(0),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode0_0,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode0_0,
         VRAM_Drawer_data     => VRam_Drawer_data0,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(0)
      );
      
      ids_drawer_mode0_1 : entity work.ds_drawer_mode0
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         drawline             => drawline_mode0_1,
         busy                 => busy_mode0_1,
         lockspeed            => lockspeed,
         pixelpos             => pixelpos,
         ypos                 => linecounter_int,
         ypos_mosaic          => linecounter_mosaic_bg,
         mapbase              => screenbase_1,
         tilebase             => charbase_1,
         hicolor              => REG_BG1CNT_Colors_Palettes(REG_BG1CNT_Colors_Palettes'left),
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => extpalette_offset_1,
         mosaic               => REG_BG1CNT_Mosaic(REG_BG1CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         screensize           => unsigned(REG_BG1CNT_Screen_Size),
         scrollX              => unsigned(REG_BG1HOFS(8 downto 0)),
         scrollY              => unsigned(REG_BG1VOFS(24 downto 16)),
         pixel_we             => pixel_we_mode0_1,
         pixeldata            => pixeldata_mode0_1,
         pixel_x              => pixel_x_mode0_1,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode0_1,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(1),
         EXTPALETTE_req       => EXTPALETTE_req_mode0_1,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode0_1,
         EXTPALETTE_data      => EXTPALETTE_data1,
         EXTPALETTE_valid     => EXTPALETTE_valid(1),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode0_1,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode0_1,
         VRAM_Drawer_data     => VRam_Drawer_data1,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(1)
      );
      
      ids_drawer_mode0_2 : entity work.ds_drawer_mode0
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         drawline             => drawline_mode0_2,
         busy                 => busy_mode0_2,
         lockspeed            => lockspeed,
         pixelpos             => pixelpos,
         ypos                 => linecounter_int,
         ypos_mosaic          => linecounter_mosaic_bg,
         mapbase              => screenbase_2,
         tilebase             => charbase_2,
         hicolor              => REG_BG2CNT_Colors_Palettes(REG_BG2CNT_Colors_Palettes'left),
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => "10",
         mosaic               => REG_BG2CNT_Mosaic(REG_BG2CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         screensize           => unsigned(REG_BG2CNT_Screen_Size),
         scrollX              => unsigned(REG_BG2HOFS(8 downto 0)),
         scrollY              => unsigned(REG_BG2VOFS(24 downto 16)),
         pixel_we             => pixel_we_mode0_2,
         pixeldata            => pixeldata_mode0_2,
         pixel_x              => pixel_x_mode0_2,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode0_2,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(2),
         EXTPALETTE_req       => EXTPALETTE_req_mode0_2,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode0_2,
         EXTPALETTE_data      => EXTPALETTE_data2,
         EXTPALETTE_valid     => EXTPALETTE_valid(2),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode0_2,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode0_2,
         VRAM_Drawer_data     => VRam_Drawer_data2,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(2)
      );
      
      ids_drawer_mode0_3 : entity work.ds_drawer_mode0
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         drawline             => drawline_mode0_3,
         busy                 => busy_mode0_3,
         lockspeed            => lockspeed,
         pixelpos             => pixelpos,
         ypos                 => linecounter_int,
         ypos_mosaic          => linecounter_mosaic_bg,
         mapbase              => screenbase_3,
         tilebase             => charbase_3,
         hicolor              => REG_BG3CNT_Colors_Palettes(REG_BG3CNT_Colors_Palettes'left),
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => "11",
         mosaic               => REG_BG3CNT_Mosaic(REG_BG3CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         screensize           => unsigned(REG_BG3CNT_Screen_Size),
         scrollX              => unsigned(REG_BG3HOFS(8 downto 0)),
         scrollY              => unsigned(REG_BG3VOFS(24 downto 16)),
         pixel_we             => pixel_we_mode0_3,
         pixeldata            => pixeldata_mode0_3,
         pixel_x              => pixel_x_mode0_3,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode0_3,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(3),
         EXTPALETTE_req       => EXTPALETTE_req_mode0_3,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode0_3,
         EXTPALETTE_data      => EXTPALETTE_data3,
         EXTPALETTE_valid     => EXTPALETTE_valid(3),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode0_3,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode0_3,
         VRAM_Drawer_data     => VRam_Drawer_data3,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(3)
      );
      
      ids_drawer_mode2_2 : entity work.ds_drawer_mode2
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         line_trigger         => line_trigger,
         drawline             => drawline_mode2_2,
         busy                 => busy_mode2_2,
         mapbase              => screenbase_2,
         tilebase             => charbase_2,
         screensize           => unsigned(REG_BG2CNT_Screen_Size),
         wrapping             => REG_BG2CNT_Display_Area_Overflow(REG_BG2CNT_Display_Area_Overflow'left),
         tile16bit            => tile16bit_2,
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => "10",
         mosaic               => REG_BG2CNT_Mosaic(REG_BG2CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         refX                 => ref2_x,
         refY                 => ref2_y,
         refX_mosaic          => mosaic_ref2_x,
         refY_mosaic          => mosaic_ref2_y,
         dx                   => signed(REG_BG2RotScaleParDX),
         dy                   => signed(REG_BG2RotScaleParDY),  
         pixel_we             => pixel_we_mode2_2,
         pixeldata            => pixeldata_mode2_2,
         pixel_x              => pixel_x_mode2_2,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode2_2,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(2),
         EXTPALETTE_req       => EXTPALETTE_req_mode2_2,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode2_2,
         EXTPALETTE_data      => EXTPALETTE_data2,
         EXTPALETTE_valid     => EXTPALETTE_valid(2),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode2_2,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode2_2,
         VRAM_Drawer_data     => VRam_Drawer_data2,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(2)
      );
      
      ids_drawer_mode2_3 : entity work.ds_drawer_mode2
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         line_trigger         => line_trigger,
         drawline             => drawline_mode2_3,
         busy                 => busy_mode2_3,
         mapbase              => screenbase_3,
         tilebase             => charbase_3,
         screensize           => unsigned(REG_BG3CNT_Screen_Size),
         wrapping             => REG_BG3CNT_Display_Area_Overflow(REG_BG3CNT_Display_Area_Overflow'left),
         tile16bit            => tile16bit_3,
         extpalette           => REG_DISPCNT_BG_Extended_Palettes(REG_DISPCNT_BG_Extended_Palettes'left),
         extpalette_offset    => "11",
         mosaic               => REG_BG2CNT_Mosaic(REG_BG2CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         refX                 => ref3_x,
         refY                 => ref3_y,
         refX_mosaic          => mosaic_ref3_x,
         refY_mosaic          => mosaic_ref3_y,
         dx                   => signed(REG_BG3RotScaleParDX),
         dy                   => signed(REG_BG3RotScaleParDY),  
         pixel_we             => pixel_we_mode2_3,
         pixeldata            => pixeldata_mode2_3,
         pixel_x              => pixel_x_mode2_3,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode2_3,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(3),
         EXTPALETTE_req       => EXTPALETTE_req_mode2_3,
         EXTPALETTE_addr      => EXTPALETTE_addr_mode2_3,
         EXTPALETTE_data      => EXTPALETTE_data3,
         EXTPALETTE_valid     => EXTPALETTE_valid(3),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode2_3,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode2_3,
         VRAM_Drawer_data     => VRam_Drawer_data3,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(3)
      );
      
      ids_drawer_mode45_2 : entity work.ds_drawer_mode45
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         BG_Mode5             => extmode_2(0),
         line_trigger         => line_trigger,
         drawline             => drawline_mode45_2,
         busy                 => busy_mode45_2,
         wrap                 => REG_BG2CNT_Display_Area_Overflow(REG_BG2CNT_Display_Area_Overflow'left),
         mosaic               => REG_BG2CNT_Mosaic(REG_BG2CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         refX                 => ref2_x,
         refY                 => ref2_y,
         refX_mosaic          => mosaic_ref2_x,
         refY_mosaic          => mosaic_ref2_y,
         dx                   => signed(REG_BG2RotScaleParDX),
         dy                   => signed(REG_BG2RotScaleParDY), 
         screenbase           => screenbase_2_bmp,         
         pixel_we             => pixel_we_mode45_2,
         pixeldata            => pixeldata_mode45_2,
         pixel_x              => pixel_x_mode45_2,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode45_2,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(2),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode45_2,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode45_2,
         VRAM_Drawer_data     => VRam_Drawer_data2,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(2)
      );
      
      ids_drawer_mode45_3 : entity work.ds_drawer_mode45
      port map
      (
         clk100               => clk100,
         reset                => vsync_end,
         BG_Mode5             => extmode_3(0),
         line_trigger         => line_trigger,
         drawline             => drawline_mode45_3,
         busy                 => busy_mode45_3,
         wrap                 => REG_BG3CNT_Display_Area_Overflow(REG_BG3CNT_Display_Area_Overflow'left),
         mosaic               => REG_BG3CNT_Mosaic(REG_BG3CNT_Mosaic'left),
         Mosaic_H_Size        => unsigned(REG_MOSAIC_BG_Mosaic_H_Size),
         refX                 => ref3_x,
         refY                 => ref3_y,
         refX_mosaic          => mosaic_ref3_x,
         refY_mosaic          => mosaic_ref3_y,
         dx                   => signed(REG_BG3RotScaleParDX),
         dy                   => signed(REG_BG3RotScaleParDY),
         screenbase           => screenbase_3_bmp,
         pixel_we             => pixel_we_mode45_3,
         pixeldata            => pixeldata_mode45_3,
         pixel_x              => pixel_x_mode45_3,
         PALETTE_Drawer_addr  => PALETTE_Drawer_addr_mode45_3,
         PALETTE_Drawer_data  => PALETTE_BG_Drawer_data,
         PALETTE_Drawer_valid => PALETTE_BG_Drawer_valid(3),
         VRAM_Drawer_req      => VRAM_Drawer_req_mode45_3,
         VRAM_Drawer_addr     => VRAM_Drawer_addr_mode45_3,
         VRAM_Drawer_data     => VRam_Drawer_data3,
         VRAM_Drawer_valid    => VRAM_Drawer_valid(3)
      );
      
      ids_drawer_obj : entity work.ds_drawer_obj
      port map
      (
         clk100                 => clk100,
         reset                  => vsync_end,
                                
         hblank                 => hblank_trigger,
         lockspeed              => lockspeed,
         busy                   => busy_modeobj,
                                
         drawline               => drawline_obj,
         ypos                   => linecounter_int,
         ypos_mosaic            => linecounter_mosaic_obj,
                                
         BG_Mode                => REG_DISPCNT_BG_Mode,
         one_dim_mapping        => REG_DISPCNT_Tile_OBJ_Mapping(REG_DISPCNT_Tile_OBJ_Mapping'left),
         Tile_OBJ_1D_Boundary   => REG_DISPCNT_Tile_OBJ_1D_Boundary,
         bitmap_OBJ_Mapping     => REG_DISPCNT_Bitmap_OBJ_Mapping(REG_DISPCNT_Bitmap_OBJ_Mapping'left),
         bitmap_OBJ_1D_Boundary => REG_DISPCNT_Bitmap_OBJ_1D_Boundary(REG_DISPCNT_Bitmap_OBJ_1D_Boundary'left),
         bitmap_OBJ_2D_Dim      => REG_DISPCNT_Bitmap_OBJ_2D_Dim(REG_DISPCNT_Bitmap_OBJ_2D_Dim'left),
         extpalette             => REG_DISPCNT_OBJ_Extended_Palettes(REG_DISPCNT_OBJ_Extended_Palettes'left),
         Mosaic_H_Size          => unsigned(REG_MOSAIC_OBJ_Mosaic_H_Size),
                                
         hblankfree             => '0', -- todo
         maxpixels              => maxpixels,
                                
         pixel_we_color         => pixel_we_modeobj_color,
         pixeldata_color        => pixeldata_modeobj_color,
         pixel_we_settings      => pixel_we_modeobj_settings,
         pixeldata_settings     => pixeldata_modeobj_settings,
         pixel_x                => pixel_x_modeobj,
         pixel_objwnd           => pixel_objwnd,
                                
         OAMRAM_Drawer_addr     => OAMRAM_Drawer_addr,
         OAMRAM_Drawer_data     => OAMRAM_Drawer_data,
                                
         PALETTE_Drawer_addr    => PALETTE_OAM_Drawer_addr,
         PALETTE_Drawer_data    => PALETTE_OAM_Drawer_data,
                                
         EXTPALETTE_req         => EXTPALETTE_reqobj,
         EXTPALETTE_addr        => EXTPALETTE_addrobj,
         EXTPALETTE_data        => EXTPALETTE_data_obj,
         EXTPALETTE_valid       => EXTPALETTE_valid(4),
                                
         VRAM_Drawer_req        => VRAM_Drawer_reqobj,
         VRAM_Drawer_addr       => VRAM_Drawer_addrobj,
         VRAM_Drawer_data       => VRam_Drawer_data_obj,
         VRAM_Drawer_valid      => VRAM_Drawer_valid(4)
      );
      
   end generate;
   
   g3D : if isGPUA = '1' generate
   begin
   
      ids_drawer_3D : entity work.ds_drawer_3D
      port map
      (
         clk100       => clk100,     
         reset        => vsync_end,      
                                 
         ds_bus       => ds_bus,     
         ds_bus_data  => reg_wired_or(90),
                      
         drawline     => drawline_3D,
         busy         => busy_3D,
                      
         ypos         => linecounter_int,
         scrollX      => unsigned(REG_BG0HOFS(8 downto 0)),
                      
         pixel_we     => pixel_we_3D,
         pixeldata    => pixeldata_3D,
         pixel_x      => pixel_x_3D,
                      
         Vram_req     => VRAM_Drawer_req3D,
         VRam_addr    => VRAM_Drawer_addr3D,
         VRam_dataout => VRam_Drawer_data_3D,
         Vram_valid   => VRAM_Drawer_valid(5)
      );
   end generate;
   
   gno3D : if isGPUA = '0' generate
   begin
      reg_wired_or(90) <= (others => '0');
      busy_3D          <= '0';
   end generate;
   
   process (clk100)
   begin
      if (rising_edge(clk100)) then
      
         extmode_2 <= REG_BG2CNT_Colors_Palettes & REG_BG2CNT_Character_Base_Block(REG_BG2CNT_Character_Base_Block'right);
         extmode_3 <= REG_BG3CNT_Colors_Palettes & REG_BG3CNT_Character_Base_Block(REG_BG3CNT_Character_Base_Block'right);
      
         extpalette_offset_0 <= REG_BG0CNT_Ext_Palette_Slot & '0';
         extpalette_offset_1 <= REG_BG1CNT_Ext_Palette_Slot & '1';
         
         tile16bit_2 <= '0';
         if (REG_DISPCNT_BG_Mode = "101" and extmode_2(1) = '0') then
            tile16bit_2 <= '1';
         end if;
         
         tile16bit_3 <= '0';
         if ((REG_DISPCNT_BG_Mode = "011" or REG_DISPCNT_BG_Mode = "100" or REG_DISPCNT_BG_Mode = "101") and extmode_3(1) = '0') then
            tile16bit_3 <= '1';
         end if;
       
         drawermux_0 <= 0;
         if (isGPUA = '1' and REG_DISPCNT_Display_Mode = "10") then
            drawermux_0 <= 2;
         elsif (unsigned(REG_DISPCNT_BG_Mode) < 6 and REG_DISPCNT_BG0_2D_3D = "0") then
            drawermux_0 <= 1;
         elsif (REG_DISPCNT_BG0_2D_3D = "1") then
            drawermux_0 <= 3;
         end if;
      
         drawermux_1 <= 0;
         if (unsigned(REG_DISPCNT_BG_Mode) < 6) then
            drawermux_1 <= 1;
         end if;

         drawermux_2 <= 0;
         if (REG_DISPCNT_BG_Mode = "000" or REG_DISPCNT_BG_Mode = "001" or REG_DISPCNT_BG_Mode = "011") then
            drawermux_2 <= 1;
         elsif (REG_DISPCNT_BG_Mode = "010" or REG_DISPCNT_BG_Mode = "100" or (REG_DISPCNT_BG_Mode = "101" and extmode_2(1) = '0')) then
            drawermux_2 <= 2;
         elsif (REG_DISPCNT_BG_Mode = "101" and extmode_2(1) = '1') then
            drawermux_2 <= 3;
         end if; 
         
         drawermux_3 <= 0;
         if (REG_DISPCNT_BG_Mode = "000") then
            drawermux_3 <= 1;
         elsif (REG_DISPCNT_BG_Mode = "001" or REG_DISPCNT_BG_Mode = "010" or ((REG_DISPCNT_BG_Mode = "011" or REG_DISPCNT_BG_Mode = "100" or REG_DISPCNT_BG_Mode = "101") and extmode_3(1) = '0')) then
            drawermux_3 <= 2;
         elsif (REG_DISPCNT_BG_Mode = "011" or REG_DISPCNT_BG_Mode = "100" or REG_DISPCNT_BG_Mode = "101") then
            drawermux_3 <= 3;
         end if;
   
      end if;
   end process;
   
   drawline_mode0_0  <= on_delay_bg0(2) and start_draw when (drawermux_0 = 1) else '0';
   drawline_mode0_1  <= on_delay_bg1(2) and start_draw when (drawermux_1 = 1) else '0';
   drawline_mode0_2  <= on_delay_bg2(2) and start_draw when (drawermux_2 = 1) else '0';
   drawline_mode0_3  <= on_delay_bg3(2) and start_draw when (drawermux_3 = 1) else '0';
   drawline_mode2_2  <= on_delay_bg2(2) and start_draw when (drawermux_2 = 2) else '0';
   drawline_mode2_3  <= on_delay_bg3(2) and start_draw when (drawermux_3 = 2) else '0';
   drawline_mode45_2 <= on_delay_bg2(2) and start_draw when (drawermux_2 = 3) else '0';
   drawline_mode45_3 <= on_delay_bg3(2) and start_draw when (drawermux_3 = 3) else '0';
   drawline_obj      <= REG_DISPCNT_Screen_Display_OBJ(REG_DISPCNT_Screen_Display_OBJ'left) and start_draw;
   drawline_3D       <= start_draw when drawermux_0 = 3 else '0';

   PALETTE_BG_Drawer_addr0 <= PALETTE_Drawer_addr_mode0_0;
   PALETTE_BG_Drawer_addr1 <= PALETTE_Drawer_addr_mode0_1;
   PALETTE_BG_Drawer_addr2 <= PALETTE_Drawer_addr_mode0_2 when (drawermux_2 = 1) else 
                              PALETTE_Drawer_addr_mode2_2 when (drawermux_2 = 2) else 
                              PALETTE_Drawer_addr_mode45_2;
   PALETTE_BG_Drawer_addr3 <= PALETTE_Drawer_addr_mode0_3 when (drawermux_3 = 1) else 
                              PALETTE_Drawer_addr_mode2_3 when (drawermux_3 = 2) else 
                              PALETTE_Drawer_addr_mode45_3;

   EXTPALETTE_addr0 <= EXTPALETTE_addr_mode0_0;
   EXTPALETTE_addr1 <= EXTPALETTE_addr_mode0_1;
   EXTPALETTE_addr2 <= EXTPALETTE_addr_mode0_2 when (drawermux_2 = 1) else 
                       EXTPALETTE_addr_mode2_2 when (drawermux_2 = 2) else 
                       EXTPALETTE_addr_mode45_2;
   EXTPALETTE_addr3 <= EXTPALETTE_addr_mode0_3 when (drawermux_3 = 1) else 
                       EXTPALETTE_addr_mode2_3 when (drawermux_3 = 2) else 
                       EXTPALETTE_addr_mode45_3;
             
   EXTPALETTE_req(0) <= EXTPALETTE_req_mode0_0;
   EXTPALETTE_req(1) <= EXTPALETTE_req_mode0_1;
   EXTPALETTE_req(2) <= EXTPALETTE_req_mode0_2 when (drawermux_2 = 1) else 
                        EXTPALETTE_req_mode2_2 when (drawermux_2 = 2) else 
                        EXTPALETTE_req_mode45_2;
   EXTPALETTE_req(3) <= EXTPALETTE_req_mode0_3 when (drawermux_3 = 1) else 
                        EXTPALETTE_req_mode2_3 when (drawermux_3 = 2) else 
                        EXTPALETTE_req_mode45_3;
   EXTPALETTE_req(4) <= EXTPALETTE_reqobj;


   VRAM_Drawer_addr0 <= VRAM_Drawer_direct_addr when (drawermux_0 = 2) else 
                        VRAM_Drawer_addr_mode0_0;
   VRAM_Drawer_addr1 <= VRAM_Drawer_addr_mode0_1;
   VRAM_Drawer_addr2 <= VRAM_Drawer_addr_mode0_2 when (drawermux_2 = 1) else 
                        VRAM_Drawer_addr_mode2_2 when (drawermux_2 = 2) else 
                        VRAM_Drawer_addr_mode45_2;
   VRAM_Drawer_addr3 <= VRAM_Drawer_addr_mode0_3 when (drawermux_3 = 1) else 
                        VRAM_Drawer_addr_mode2_3 when (drawermux_3 = 2) else 
                        VRAM_Drawer_addr_mode45_3;
   
   VRAM_Drawer_req(0) <= VRAM_Drawer_reqvramdraw when (drawermux_0 = 2) else 
                         VRAM_Drawer_req_mode0_0;
   VRAM_Drawer_req(1) <= VRAM_Drawer_req_mode0_1;
   VRAM_Drawer_req(2) <= VRAM_Drawer_req_mode0_2 when (drawermux_2 = 1) else 
                         VRAM_Drawer_req_mode2_2 when (drawermux_2 = 2) else 
                         VRAM_Drawer_req_mode45_2;
   VRAM_Drawer_req(3) <= VRAM_Drawer_req_mode0_3 when (drawermux_3 = 1) else 
                         VRAM_Drawer_req_mode2_3 when (drawermux_3 = 2) else 
                         VRAM_Drawer_req_mode45_3;
   VRAM_Drawer_req(4) <= VRAM_Drawer_reqobj;
   
   draw_allmod(0) <= drawline_mode0_0;
   draw_allmod(1) <= drawline_mode0_1;
   draw_allmod(2) <= drawline_mode0_2;
   draw_allmod(3) <= drawline_mode0_3;
   draw_allmod(4) <= drawline_mode2_2;
   draw_allmod(5) <= drawline_mode2_3;
   draw_allmod(6) <= drawline_mode45_2;
   draw_allmod(7) <= drawline_mode45_3;
   draw_allmod(8) <= drawline_obj;
   draw_allmod(9) <= drawline_obj;

   busy_allmod(0) <= '0' when ds_nogpu = '1' else busy_mode0_0;
   busy_allmod(1) <= '0' when ds_nogpu = '1' else busy_mode0_1;
   busy_allmod(2) <= '0' when ds_nogpu = '1' else busy_mode0_2;
   busy_allmod(3) <= '0' when ds_nogpu = '1' else busy_mode0_3;
   busy_allmod(4) <= '0' when ds_nogpu = '1' else busy_mode2_2;
   busy_allmod(5) <= '0' when ds_nogpu = '1' else busy_mode2_3;
   busy_allmod(6) <= '0' when ds_nogpu = '1' else busy_mode45_2;
   busy_allmod(7) <= '0' when ds_nogpu = '1' else busy_mode45_3;
   busy_allmod(8) <= '0' when ds_nogpu = '1' else busy_modeobj;
   busy_allmod(9) <= '0' when ds_nogpu = '1' else busy_3D;
   
   -- memory mapping
   process (clk100)
   begin
      if rising_edge(clk100) then

         if (Palette_addr = 0 and Palette_we_bg = '1' and Palette_be(1 downto 0) = "11") then
            pixeldata_back_next <= Palette_datain(15 downto 0);
         end if;
      
         PALETTE_BG_Drawer_cnt <= PALETTE_BG_Drawer_cnt + 1;
         case (to_integer(PALETTE_BG_Drawer_cnt)) is
            when 0 => PALETTE_BG_Drawer_addr <= PALETTE_BG_Drawer_addr0; PALETTE_BG_Drawer_valid <= "1000";
            when 1 => PALETTE_BG_Drawer_addr <= PALETTE_BG_Drawer_addr1; PALETTE_BG_Drawer_valid <= "0001";
            when 2 => PALETTE_BG_Drawer_addr <= PALETTE_BG_Drawer_addr2; PALETTE_BG_Drawer_valid <= "0010";
            when 3 => PALETTE_BG_Drawer_addr <= PALETTE_BG_Drawer_addr3; PALETTE_BG_Drawer_valid <= "0100";
            when others => null;
         end case;
         
         -- wait with delete for 2 clock cycles
         clear_trigger_1 <= clear_trigger;
         if (clear_trigger_1 = '1') then 
            clear_addr    <= 0;
            clear_enable  <= '1';
         end if;
         
         if (clear_enable = '1') then
            if (clear_addr < 255) then
               clear_addr <= clear_addr + 1;
            else
               clear_enable     <= '0';
            end if;
            
            pixel_we_bg0          <= '1';
            pixel_we_bg1          <= '1';
            pixel_we_bg2          <= '1';
            pixel_we_bg3          <= '1';
            pixel_we_obj_color    <= '1';
            pixel_we_obj_settings <= '1';
            
            pixeldata_bg0          <= x"8000";
            pixeldata_bg1          <= x"8000";
            pixeldata_bg2          <= x"8000";
            pixeldata_bg3          <= x"8000";
            pixeldata_obj_color    <= x"8000";
            pixeldata_obj_settings <= "000";
         
            pixel_x_bg0 <= clear_addr;
            pixel_x_bg1 <= clear_addr;
            pixel_x_bg2 <= clear_addr;
            pixel_x_bg3 <= clear_addr;
            pixel_x_obj <= clear_addr;
         
         else         
         
            pixel_we_bg1          <= pixel_we_mode0_1;
            pixel_we_obj_color    <= pixel_we_modeobj_color;
            pixel_we_obj_settings <= pixel_we_modeobj_settings;
            
            pixeldata_bg1          <= pixeldata_mode0_1;
            pixeldata_obj_color    <= pixeldata_modeobj_color;
            pixeldata_obj_settings <= pixeldata_modeobj_settings;
            
            pixel_x_bg1 <= pixel_x_mode0_1;
            pixel_x_obj <= pixel_x_modeobj;
            
            if (drawermux_0 = 3) then
               pixeldata_bg0 <= pixeldata_3D;
               pixel_we_bg0  <= pixel_we_3D;
               pixel_x_bg0   <= pixel_x_3D;
            else
               pixeldata_bg0 <= pixeldata_mode0_0;
               pixel_we_bg0  <= pixel_we_mode0_0;
               pixel_x_bg0   <= pixel_x_mode0_0;
            end if;
            
            if (drawermux_2 = 1) then
               pixel_we_bg2  <= pixel_we_mode0_2;
               pixeldata_bg2 <= pixeldata_mode0_2;
               pixel_x_bg2   <= pixel_x_mode0_2;
            elsif (drawermux_2 = 2) then
               pixel_we_bg2  <= pixel_we_mode2_2;
               pixeldata_bg2 <= pixeldata_mode2_2;
               pixel_x_bg2   <= pixel_x_mode2_2;
            else
               pixel_we_bg2  <= pixel_we_mode45_2;
               pixeldata_bg2 <= pixeldata_mode45_2;
               pixel_x_bg2   <= pixel_x_mode45_2;
            end if;
            
            if (drawermux_3 = 1) then
               pixel_we_bg3  <= pixel_we_mode0_3; 
               pixeldata_bg3 <= pixeldata_mode0_3;
               pixel_x_bg3   <= pixel_x_mode0_3;
            elsif (drawermux_3 = 2) then
               pixel_we_bg3   <= pixel_we_mode2_3;
               pixeldata_bg3 <= pixeldata_mode2_3;
               pixel_x_bg3   <= pixel_x_mode2_3;
            else
               pixel_we_bg3  <= pixel_we_mode45_3;
               pixeldata_bg3 <= pixeldata_mode45_3;
               pixel_x_bg3   <= pixel_x_mode45_3;
            end if;
            
         end if;

      end if;
   end process;
   
   -- line buffers
   ilinebuffer_bg0: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 16,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_bg0,
      datain_a   => pixeldata_bg0,
      dataout_a  => open,
      we_a       => pixel_we_bg0,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => x"0000",
      dataout_b  => linebuffer_bg0_data,
      we_b       => '0',
      re_b       => '1'
   );
   ilinebuffer_bg1: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 16,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_bg1,
      datain_a   => pixeldata_bg1,
      dataout_a  => open,
      we_a       => pixel_we_bg1,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => x"0000",
      dataout_b  => linebuffer_bg1_data,
      we_b       => '0',
      re_b       => '1'
   );
   ilinebuffer_bg2: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 16,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_bg2,
      datain_a   => pixeldata_bg2,
      dataout_a  => open,
      we_a       => pixel_we_bg2,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => x"0000",
      dataout_b  => linebuffer_bg2_data,
      we_b       => '0',
      re_b       => '1'
   );
   ilinebuffer_bg3: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 16,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_bg3,
      datain_a   => pixeldata_bg3,
      dataout_a  => open,
      we_a       => pixel_we_bg3,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => x"0000",
      dataout_b  => linebuffer_bg3_data,
      we_b       => '0',
      re_b       => '1'
   );
   ilinebuffer_obj_color: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 16,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_obj,
      datain_a   => pixeldata_obj_color,
      dataout_a  => open,
      we_a       => pixel_we_obj_color,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => (15 downto 0 => '0'),
      dataout_b  => linebuffer_obj_color,
      we_b       => '0',
      re_b       => '1'
   );
   ilinebuffer_obj_settings: entity MEM.SyncRamDual
   generic map
   (
      DATA_WIDTH => 3,
      ADDR_WIDTH => 8
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => pixel_x_obj,
      datain_a   => pixeldata_obj_settings,
      dataout_a  => open,
      we_a       => pixel_we_obj_settings,
      re_a       => '0',
               
      addr_b     => linebuffer_addr,
      datain_b   => (2 downto 0 => '0'),
      dataout_b  => linebuffer_obj_setting,
      we_b       => '0',
      re_b       => '1'
   );
   
   linebuffer_obj_data <= linebuffer_obj_setting & linebuffer_obj_color;
   
   -- line buffer readout
   process (clk100)
      variable brightup_red     : integer range 0 to 511;
      variable brightup_green   : integer range 0 to 511;
      variable brightup_blue    : integer range 0 to 511;   
      variable brightdown_red   : integer range -256 to 255;
      variable brightdown_green : integer range -256 to 255;
      variable brightdown_blue  : integer range -256 to 255;
   begin
      if rising_edge(clk100) then
      
         if (pixel_objwnd = '1') then
            linebuffer_objwindow(pixel_x_obj) <= '1';
         end if;
         
         -- synthesis translate_off
         if (to_integer(linecounter) < 192) then
         -- synthesis translate_on
         nextLineDrawn <= lineUpToDate(to_integer(linecounter));
         -- synthesis translate_off
         end if;
         -- synthesis translate_on
         
         if (hblank_trigger = '1') then
            if (REG_DISPCNT_Screen_Display_BG0(REG_DISPCNT_Screen_Display_BG0'left) = '0') then on_delay_bg0 <= (others => '0'); end if;
            if (REG_DISPCNT_Screen_Display_BG1(REG_DISPCNT_Screen_Display_BG1'left) = '0') then on_delay_bg1 <= (others => '0'); end if;
            if (REG_DISPCNT_Screen_Display_BG2(REG_DISPCNT_Screen_Display_BG2'left) = '0') then on_delay_bg2 <= (others => '0'); end if;
            if (REG_DISPCNT_Screen_Display_BG3(REG_DISPCNT_Screen_Display_BG3'left) = '0') then on_delay_bg3 <= (others => '0'); end if;
         end if;
         
         if (drawline = '1' or newline_invsync = '1') then
            if (REG_DISPCNT_Screen_Display_BG0(REG_DISPCNT_Screen_Display_BG0'left) = '1') then on_delay_bg0 <= on_delay_bg0(1 downto 0) & '1'; end if;
            if (REG_DISPCNT_Screen_Display_BG1(REG_DISPCNT_Screen_Display_BG1'left) = '1') then on_delay_bg1 <= on_delay_bg1(1 downto 0) & '1'; end if;
            if (REG_DISPCNT_Screen_Display_BG2(REG_DISPCNT_Screen_Display_BG2'left) = '1') then on_delay_bg2 <= on_delay_bg2(1 downto 0) & '1'; end if;
            if (REG_DISPCNT_Screen_Display_BG3(REG_DISPCNT_Screen_Display_BG3'left) = '1') then on_delay_bg3 <= on_delay_bg3(1 downto 0) & '1'; end if;
         end if;
         
         drawline_1       <= drawline;
         hblank_trigger_1 <= hblank_trigger;
         start_draw <= '0';
         
         -- count and track if all lines have been drawn for fastforward mode
         if (vblank_trigger = '1') then
            if (linesDrawn = 192) then
               lineUpToDate <= (others => '0');
            end if;
            linesDrawn      <= 0;
         end if;  
         if (drawline_1 = '1' and linesDrawn < 192 and (drawstate = IDLE or nextLineDrawn = '1')) then
            linesDrawn <= linesDrawn + 1;
         end if;
         
         clear_trigger <= '0';

         case (drawstate) is
            when IDLE =>
               if (drawline_1 = '1' and linesDrawn < 192) then
                  if (nextLineDrawn = '0') then
                     drawstate       <= WAITHBLANK;
                     start_draw      <= '1';
                     linecounter_int <= to_integer(linecounter);
                     lineUpToDate(to_integer(linecounter)) <= '1';
                     linebuffer_objwindow <= (others => '0');
                  end if;
               end if;
               
            when WAITHBLANK =>
               if (hblank_trigger = '1') then
                  drawstate <= DRAWING;
               end if;

            when DRAWING =>
               if (busy_allmod = (busy_allmod'left downto 0 => '0')) then
                  drawstate        <= MERGING;
                  linebuffer_addr  <= 0;
                  merge_enable     <= '1';
                  clear_trigger    <= '1';
               end if;
            
            when MERGING =>
               if (linebuffer_addr < 255) then
                  linebuffer_addr <= linebuffer_addr + 1;
               else
                  merge_enable    <= '0';
                  drawstate       <= IDLE;
               end if;
            
         end case; 
      
         linebuffer_addr_1 <= linebuffer_addr;
         merge_enable_1 <= merge_enable;
         
         objwindow_merge_in <= linebuffer_objwindow(linebuffer_addr);
               
         bright_pixel_x    <= merge_pixel_x;         
         bright_pixel_y    <= merge_pixel_y;
         bright_pixel_we   <= merge_pixel_we;
         if (REG_DISPCNT_Forced_Blank = "1" or REG_DISPCNT_Display_Mode = "00") then
            bright_pixeldata_out <= (15 downto 0 => '1');
         elsif (REG_DISPCNT_Display_Mode = "01" or isGPUA = '0') then
            bright_pixeldata_out <= '0' & merge_pixeldata_out(4 downto 0) & merge_pixeldata_out(9 downto 5) & merge_pixeldata_out(14 downto 10);
         elsif (REG_DISPCNT_Display_Mode = "10") then
            bright_pixeldata_out <= '0' & pixeldata_directvram(4 downto 0) & pixeldata_directvram(9 downto 5) & pixeldata_directvram(14 downto 10);
            bright_pixel_x       <= directvram_pixel_x;         
            bright_pixel_y       <= directvram_pixel_y;
            bright_pixel_we      <= directvram_pixel_we;
         elsif (REG_DISPCNT_Display_Mode = "11") then
            bright_pixeldata_out <= '0' & pixeldata_mainram(4 downto 0) & pixeldata_mainram(9 downto 5) & pixeldata_mainram(14 downto 10);
            bright_pixel_x       <= mainram_pixel_x;         
            bright_pixel_y       <= mainram_pixel_y;
            bright_pixel_we      <= mainram_pixel_we;
         end if;
         
         -- master bright
         if (unsigned(REG_MASTER_BRIGHT_Factor) < 16) then MASTER_BRIGHT_maxed <= to_integer(unsigned(REG_MASTER_BRIGHT_Factor)); else MASTER_BRIGHT_maxed <= 16; end if;
         pixel_out_x    <= bright_pixel_x;      
         pixel_out_y    <= bright_pixel_y;      
         pixel_out_we   <= bright_pixel_we;    
         pixel_out_data <= (others => '0');       
         if (REG_MASTER_BRIGHT_Mode = "00" or REG_MASTER_BRIGHT_Mode = "11") then
            pixel_out_data(17 downto 13)  <= bright_pixeldata_out(14 downto 10);
            pixel_out_data(11 downto  7)  <= bright_pixeldata_out( 9 downto  5);
            pixel_out_data( 5 downto  1)  <= bright_pixeldata_out( 4 downto  0);
         elsif (REG_MASTER_BRIGHT_Mode = "01") then -- whiter
            brightup_blue    := to_integer(unsigned(bright_pixeldata_out(14 downto 10))) + (((31 - to_integer(unsigned(bright_pixeldata_out(14 downto 10)))) * MASTER_BRIGHT_maxed) / 16);
            brightup_green   := to_integer(unsigned(bright_pixeldata_out( 9 downto  5))) + (((31 - to_integer(unsigned(bright_pixeldata_out( 9 downto  5)))) * MASTER_BRIGHT_maxed) / 16);
            brightup_red     := to_integer(unsigned(bright_pixeldata_out( 4 downto  0))) + (((31 - to_integer(unsigned(bright_pixeldata_out( 4 downto  0)))) * MASTER_BRIGHT_maxed) / 16);
            if (brightup_blue  < 31) then pixel_out_data(17 downto 13) <= std_logic_vector(to_unsigned(brightup_blue , 5)); else pixel_out_data(17 downto 13) <= "11111"; end if;
            if (brightup_green < 31) then pixel_out_data(11 downto  7) <= std_logic_vector(to_unsigned(brightup_green, 5)); else pixel_out_data(11 downto  7) <= "11111"; end if;
            if (brightup_red   < 31) then pixel_out_data( 5 downto  1) <= std_logic_vector(to_unsigned(brightup_red  , 5)); else pixel_out_data( 5 downto  1) <= "11111"; end if;
         elsif (REG_MASTER_BRIGHT_Mode = "01") then -- blacker
            brightdown_blue  := to_integer(unsigned(bright_pixeldata_out(14 downto 10))) - ((to_integer(unsigned(bright_pixeldata_out(14 downto 10))) * MASTER_BRIGHT_maxed) / 16);
            brightdown_green := to_integer(unsigned(bright_pixeldata_out( 9 downto  5))) - ((to_integer(unsigned(bright_pixeldata_out( 9 downto  5))) * MASTER_BRIGHT_maxed) / 16);
            brightdown_red   := to_integer(unsigned(bright_pixeldata_out( 4 downto  0))) - ((to_integer(unsigned(bright_pixeldata_out( 4 downto  0))) * MASTER_BRIGHT_maxed) / 16);
            if (brightdown_blue  > 0) then pixel_out_data(17 downto 13) <= std_logic_vector(to_unsigned(brightdown_blue , 5)); else pixel_out_data(17 downto 13) <= "00000"; end if;
            if (brightdown_green > 0) then pixel_out_data(11 downto  7) <= std_logic_vector(to_unsigned(brightdown_green, 5)); else pixel_out_data(11 downto  7) <= "00000"; end if;
            if (brightdown_red   > 0) then pixel_out_data( 5 downto  1) <= std_logic_vector(to_unsigned(brightdown_red  , 5)); else pixel_out_data( 5 downto  1) <= "00000"; end if;
         end if;

      end if;
   end process;
   
   enables_wnd0   <= REG_WININ_Window_0_Special_Effect & REG_WININ_Window_0_OBJ_Enable & REG_WININ_Window_0_BG3_Enable & REG_WININ_Window_0_BG2_Enable & REG_WININ_Window_0_BG1_Enable & REG_WININ_Window_0_BG0_Enable;
   enables_wnd1   <= REG_WININ_Window_1_Special_Effect & REG_WININ_Window_1_OBJ_Enable & REG_WININ_Window_1_BG3_Enable & REG_WININ_Window_1_BG2_Enable & REG_WININ_Window_1_BG1_Enable & REG_WININ_Window_1_BG0_Enable;
   enables_wndobj <= REG_WINOUT_Objwnd_Special_Effect & REG_WINOUT_Objwnd_OBJ_Enable & REG_WINOUT_Objwnd_BG3_Enable & REG_WINOUT_Objwnd_BG2_Enable & REG_WINOUT_Objwnd_BG1_Enable & REG_WINOUT_Objwnd_BG0_Enable;
   enables_wndout <= REG_WINOUT_Outside_Special_Effect & REG_WINOUT_Outside_OBJ_Enable & REG_WINOUT_Outside_BG3_Enable & REG_WINOUT_Outside_BG2_Enable & REG_WINOUT_Outside_BG1_Enable & REG_WINOUT_Outside_BG0_Enable;
   
   ids_drawer_merge : entity work.ds_drawer_merge
   port map
   (
      clk100               => clk100,                
                           
      enable               => merge_enable_1,                     
      hblank               => hblank_trigger_1,   -- delayed 1 cycle because background is switched off at hblank                  
      xpos                 => linebuffer_addr_1,
      ypos                 => linecounter_int,
      
      in_WND0_on           => REG_DISPCNT_Window_0_Display_Flag(REG_DISPCNT_Window_0_Display_Flag'left),
      in_WND1_on           => REG_DISPCNT_Window_1_Display_Flag(REG_DISPCNT_Window_1_Display_Flag'left),
      in_WNDOBJ_on         => REG_DISPCNT_OBJ_Wnd_Display_Flag(REG_DISPCNT_OBJ_Wnd_Display_Flag'left),
                        
      in_WND0_X1           => unsigned(REG_WIN0H_X1),
      in_WND0_X2           => unsigned(REG_WIN0H_X2),
      in_WND0_Y1           => unsigned(REG_WIN0V_Y1),
      in_WND0_Y2           => unsigned(REG_WIN0V_Y2),
      in_WND1_X1           => unsigned(REG_WIN1H_X1),
      in_WND1_X2           => unsigned(REG_WIN1H_X2),
      in_WND1_Y1           => unsigned(REG_WIN1V_Y1),
      in_WND1_Y2           => unsigned(REG_WIN1V_Y2),
                 
      in_enables_wnd0      => enables_wnd0,  
      in_enables_wnd1      => enables_wnd1,  
      in_enables_wndobj    => enables_wndobj,
      in_enables_wndout    => enables_wndout,
                  
      in_special_effect_in => unsigned(REG_BLDCNT_Color_Special_Effect),
      in_effect_1st_bg0    => REG_BLDCNT_BG0_1st_Target_Pixel(REG_BLDCNT_BG0_1st_Target_Pixel'left),
      in_effect_1st_bg1    => REG_BLDCNT_BG1_1st_Target_Pixel(REG_BLDCNT_BG1_1st_Target_Pixel'left),
      in_effect_1st_bg2    => REG_BLDCNT_BG2_1st_Target_Pixel(REG_BLDCNT_BG2_1st_Target_Pixel'left),
      in_effect_1st_bg3    => REG_BLDCNT_BG3_1st_Target_Pixel(REG_BLDCNT_BG3_1st_Target_Pixel'left),
      in_effect_1st_obj    => REG_BLDCNT_OBJ_1st_Target_Pixel(REG_BLDCNT_OBJ_1st_Target_Pixel'left),
      in_effect_1st_BD     => REG_BLDCNT_BD_1st_Target_Pixel(REG_BLDCNT_BD_1st_Target_Pixel'left),
      in_effect_2nd_bg0    => REG_BLDCNT_BG0_2nd_Target_Pixel(REG_BLDCNT_BG0_2nd_Target_Pixel'left),
      in_effect_2nd_bg1    => REG_BLDCNT_BG1_2nd_Target_Pixel(REG_BLDCNT_BG1_2nd_Target_Pixel'left),
      in_effect_2nd_bg2    => REG_BLDCNT_BG2_2nd_Target_Pixel(REG_BLDCNT_BG2_2nd_Target_Pixel'left),
      in_effect_2nd_bg3    => REG_BLDCNT_BG3_2nd_Target_Pixel(REG_BLDCNT_BG3_2nd_Target_Pixel'left),
      in_effect_2nd_obj    => REG_BLDCNT_OBJ_2nd_Target_Pixel(REG_BLDCNT_OBJ_2nd_Target_Pixel'left),
      in_effect_2nd_BD     => REG_BLDCNT_BD_2nd_Target_Pixel(REG_BLDCNT_BD_2nd_Target_Pixel'left),
                  
      in_Prio_BG0          => unsigned(REG_BG0CNT_BG_Priority),
      in_Prio_BG1          => unsigned(REG_BG1CNT_BG_Priority),
      in_Prio_BG2          => unsigned(REG_BG2CNT_BG_Priority),
      in_Prio_BG3          => unsigned(REG_BG3CNT_BG_Priority),
                         
      in_EVA               => unsigned(REG_BLDALPHA_EVA_Coefficient),
      in_EVB               => unsigned(REG_BLDALPHA_EVB_Coefficient),
      in_BLDY              => unsigned(REG_BLDY),
      
      in_ena_bg0           => on_delay_bg0(2),
      in_ena_bg1           => on_delay_bg1(2),
      in_ena_bg2           => on_delay_bg2(2),
      in_ena_bg3           => on_delay_bg3(2),
      in_ena_obj           => REG_DISPCNT_Screen_Display_OBJ(REG_DISPCNT_Screen_Display_OBJ'left),
                           
      pixeldata_bg0        => linebuffer_bg0_data,
      pixeldata_bg1        => linebuffer_bg1_data,
      pixeldata_bg2        => linebuffer_bg2_data,
      pixeldata_bg3        => linebuffer_bg3_data,
      pixeldata_obj        => linebuffer_obj_data,
      pixeldata_back       => pixeldata_back,
      objwindow_in         => objwindow_merge_in,
                           
      pixeldata_out        => merge_pixeldata_out,
      pixel_x              => merge_pixel_x,      
      pixel_y              => merge_pixel_y,      
      pixel_we             => merge_pixel_we     
   );
   
   -- affine + mosaik
   process (clk100)
   begin
      if rising_edge(clk100) then

         if (refpoint_update = '1' or ref2_x_written = '1') then ref2_x <= signed(REG_BG2RefX); mosaic_ref2_x <= signed(REG_BG2RefX); end if;
         if (refpoint_update = '1' or ref2_y_written = '1') then ref2_y <= signed(REG_BG2RefY); mosaic_ref2_y <= signed(REG_BG2RefY); end if;
         if (refpoint_update = '1' or ref3_x_written = '1') then ref3_x <= signed(REG_BG3RefX); mosaic_ref3_x <= signed(REG_BG3RefX); end if;
         if (refpoint_update = '1' or ref3_y_written = '1') then ref3_y <= signed(REG_BG3RefY); mosaic_ref3_y <= signed(REG_BG3RefY); end if;

         if (hblank_trigger = '1') then
         
            pixeldata_back <= pixeldata_back_next;
         
            if (drawermux_2 > 1 and on_delay_bg2(2) = '1') then
               ref2_x <= ref2_x + signed(REG_BG2RotScaleParDMX);
               ref2_y <= ref2_y + signed(REG_BG2RotScaleParDMY);
            end if;
            if (drawermux_3 > 1 and on_delay_bg3(2) = '1') then
               ref3_x <= ref3_x + signed(REG_BG3RotScaleParDMX);
               ref3_y <= ref3_y + signed(REG_BG3RotScaleParDMY);
            end if;
         end if;
         
         if (vblank_trigger = '1') then
            mosaik_vcnt_bg         <= 0;
            mosaik_vcnt_obj        <= 0;
            linecounter_mosaic_bg  <= 0;
            linecounter_mosaic_obj <= 0;
         elsif (drawline = '1') then
         
            -- background
            if (mosaik_vcnt_bg < unsigned(REG_MOSAIC_BG_Mosaic_V_Size)) then
               mosaik_vcnt_bg <= mosaik_vcnt_bg + 1;
            else
               mosaik_vcnt_bg        <= 0;
               linecounter_mosaic_bg <= to_integer(linecounter);
               mosaic_ref2_x         <= ref2_x;
               mosaic_ref2_y         <= ref2_y;
               mosaic_ref3_x         <= ref3_x;
               mosaic_ref3_y         <= ref3_y;
            end if;
            
            -- sprite
            if (mosaik_vcnt_obj < unsigned(REG_MOSAIC_OBJ_Mosaic_V_Size)) then
               mosaik_vcnt_obj <= mosaik_vcnt_obj + 1;
            else
               mosaik_vcnt_obj        <= 0;
               linecounter_mosaic_obj <= to_integer(linecounter);
            end if;

         end if;

      end if;
   end process;
   
   gdirectvram: if isGPUA = '1' generate
      signal vrammode_draw    : std_logic;
      signal mainrammode_draw : std_logic;
   begin
   
      vrammode_draw    <= start_draw when REG_DISPCNT_Display_Mode = "10" else '0';
      mainrammode_draw <= start_draw when REG_DISPCNT_Display_Mode = "11" else '0';
   
      ids_drawer_directvram : entity work.ds_drawer_directvram
      port map 
      (
         clk100               => clk100,
         VRam_Block           => REG_DISPCNT_VRAM_block,
                              
         drawline             => vrammode_draw,              
         ypos                 => linecounter_int,
         
         VRam_req             => VRAM_Drawer_reqvramdraw,
         VRam_addr            => VRAM_Drawer_direct_addr,     
         VRam_dataout         => VRam_Drawer_data0,  
         Vram_valid           => VRAM_Drawer_valid(0),
         
         pixel_x              => directvram_pixel_x,
         pixel_y              => directvram_pixel_y,
         pixeldata            => pixeldata_directvram,
         directvram_pixel_we  => directvram_pixel_we
      );
      
      ids_drawer_mainram : entity work.ds_drawer_mainram
      port map
      (
         clk100      => clk100,
        
         ds_bus      => ds_bus,
                      
         drawline    => mainrammode_draw,
         ypos        => linecounter_int,
                     
         pixel_x     => mainram_pixel_x,
         pixel_y     => mainram_pixel_y,
         pixeldata   => pixeldata_mainram,
         pixel_we    => mainram_pixel_we
      );

   end generate;

   -- vram muxing
   directmode <= '1' when (isGPUA = '1' and REG_DISPCNT_Display_Mode = "10") else '0';
 
   ids_vram_mux : entity work.ds_vram_mux
   generic map
   (
      isGPUA => isGPUA
   )
   port map
   (
      clk100        => clk100, 
      directmode    => directmode,
      
      vramaddress_0 => VRAM_Drawer_addr0  , 
      vramaddress_1 => VRAM_Drawer_addr1  , 
      vramaddress_2 => VRAM_Drawer_addr2  , 
      vramaddress_3 => VRAM_Drawer_addr3  , 
      vramaddress_S => VRAM_Drawer_addrobj, 
      vram_req_0    => VRAM_Drawer_req(0),
      vram_req_1    => VRAM_Drawer_req(1),
      vram_req_2    => VRAM_Drawer_req(2),
      vram_req_3    => VRAM_Drawer_req(3),
      vram_req_S    => VRAM_Drawer_req(4), 
      vram_data_0   => VRam_Drawer_data0  , 
      vram_data_1   => VRam_Drawer_data1  , 
      vram_data_2   => VRam_Drawer_data2  , 
      vram_data_3   => VRam_Drawer_data3  , 
      vram_data_S   => VRam_Drawer_data_obj, 
      vram_valid_0  => VRAM_Drawer_valid(0), 
      vram_valid_1  => VRAM_Drawer_valid(1), 
      vram_valid_2  => VRAM_Drawer_valid(2), 
      vram_valid_3  => VRAM_Drawer_valid(3), 
      vram_valid_S  => VRAM_Drawer_valid(4), 
      
      pal_address_0 => EXTPALETTE_addr0  , 
      pal_address_1 => EXTPALETTE_addr1  , 
      pal_address_2 => EXTPALETTE_addr2  , 
      pal_address_3 => EXTPALETTE_addr3  , 
      pal_address_S => EXTPALETTE_addrobj, 
      pal_req_0     => EXTPALETTE_req(0),
      pal_req_1     => EXTPALETTE_req(1),
      pal_req_2     => EXTPALETTE_req(2),
      pal_req_3     => EXTPALETTE_req(3),
      pal_req_S     => EXTPALETTE_req(4), 
      pal_data_0    => EXTPALETTE_data0  , 
      pal_data_1    => EXTPALETTE_data1  , 
      pal_data_2    => EXTPALETTE_data2  , 
      pal_data_3    => EXTPALETTE_data3  , 
      pal_data_S    => EXTPALETTE_data_obj,
      pal_valid_0   => EXTPALETTE_valid(0),
      pal_valid_1   => EXTPALETTE_valid(1),
      pal_valid_2   => EXTPALETTE_valid(2),
      pal_valid_3   => EXTPALETTE_valid(3),
      pal_valid_S   => EXTPALETTE_valid(4),
      
      vramaddress3D => VRAM_Drawer_addr3D,
      vram_req3D    => VRAM_Drawer_req3D,
      vram_data3D   => VRam_Drawer_data_3D,
      vram_valid3D  => VRAM_Drawer_valid(5),
      
      vram_ENA_A    => vram_ENA_A,
      vram_MST_A    => vram_MST_A     ,
      vram_Offset_A => vram_Offset_A  ,
      vram_req_A    => vram_req_A     ,
      vram_addr_A   => vram_addr_A    ,
      vram_data_A   => VRam_dataout_A ,
      vram_valid_A  => vram_valid_A   ,
                 
      vram_ENA_B    => vram_ENA_B,
      vram_MST_B    => vram_MST_B     ,
      vram_Offset_B => vram_Offset_B  ,
      vram_req_B    => vram_req_B     ,
      vram_addr_B   => vram_addr_B    ,
      vram_data_B   => vram_dataout_B ,
      vram_valid_B  => vram_valid_B   ,
              
      vram_ENA_C    => vram_ENA_C,        
      vram_MST_C    => vram_MST_C     ,
      vram_Offset_C => vram_Offset_C  ,
      vram_req_C    => vram_req_C     ,
      vram_addr_C   => vram_addr_C    ,
      vram_data_C   => vram_dataout_C ,
      vram_valid_C  => vram_valid_C   ,
          
      vram_ENA_D    => vram_ENA_D,     
      vram_MST_D    => vram_MST_D     ,
      vram_Offset_D => vram_Offset_D  ,
      vram_req_D    => vram_req_D     ,
      vram_addr_D   => vram_addr_D    ,
      vram_data_D   => vram_dataout_D ,
      vram_valid_D  => vram_valid_D   ,

      vram_ENA_E    => vram_ENA_E, 
      vram_MST_E    => vram_MST_E     ,
      vram_req_E    => vram_req_E     ,
      vram_addr_E   => vram_addr_E    ,
      vram_data_E   => vram_dataout_E ,
      vram_valid_E  => vram_valid_E   ,

      vram_ENA_F    => vram_ENA_F, 
      vram_MST_F    => vram_MST_F     ,
      vram_Offset_F => vram_Offset_F  ,
      vram_req_F    => vram_req_F     ,
      vram_addr_F   => vram_addr_F    ,
      vram_data_F   => vram_dataout_F ,
      vram_valid_F  => vram_valid_F   ,

      vram_ENA_G    => vram_ENA_G, 
      vram_MST_G    => vram_MST_G     ,
      vram_Offset_G => vram_Offset_G  ,
      vram_req_G    => vram_req_G     ,
      vram_addr_G   => vram_addr_G    ,
      vram_data_G   => vram_dataout_G ,
      vram_valid_G  => vram_valid_G   ,

      vram_ENA_H    => vram_ENA_H, 
      vram_MST_H    => vram_MST_H     ,
      vram_req_H    => vram_req_H     ,
      vram_addr_H   => vram_addr_H    ,
      vram_data_H   => vram_dataout_H ,
      vram_valid_H  => vram_valid_H   ,
  
      vram_ENA_I    => vram_ENA_I, 
      vram_MST_I    => vram_MST_I     ,
      vram_req_I    => vram_req_I     ,
      vram_addr_I   => vram_addr_I    ,
      vram_data_I   => vram_dataout_I ,
      vram_valid_I  => vram_valid_I    
   );

end architecture;





