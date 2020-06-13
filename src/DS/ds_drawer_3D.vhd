library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   

use work.pProc_bus_ds.all;
use work.pReg_ds_display_9.all;
use work.pReg_ds_display_3D9.all;

entity ds_drawer_3D is
   port 
   (
      clk100       : in  std_logic;                     
      reset        : in  std_logic;
      
      ds_bus       : in  proc_bus_ds_type; 
      ds_bus_data  : out std_logic_vector(31 downto 0); 
                   
      drawline     : in  std_logic;
      busy         : out std_logic := '0';
      
      ypos         : in  integer range 0 to 191;
      scrollX      : in  unsigned(8 downto 0);
      
      pixel_we     : out std_logic := '0';
      pixeldata    : buffer std_logic_vector(15 downto 0) := (others => '0');
      pixel_x      : out integer range 0 to 255;
      
      Vram_req     : out std_logic := '0';
      VRam_addr    : out integer range 0 to 524287;
      VRam_dataout : in  std_logic_vector(31 downto 0);
      Vram_valid   : in  std_logic
   );
end entity;

architecture arch of ds_drawer_3D is
   
   signal REG_DISP3DCNT_Texture_Mapping      : std_logic_vector(DISP3DCNT_Texture_Mapping     .upper downto DISP3DCNT_Texture_Mapping     .lower) := (others => '0');
   signal REG_DISP3DCNT_PolygonAttr_Shading  : std_logic_vector(DISP3DCNT_PolygonAttr_Shading .upper downto DISP3DCNT_PolygonAttr_Shading .lower) := (others => '0');
   signal REG_DISP3DCNT_Alpha_Test           : std_logic_vector(DISP3DCNT_Alpha_Test          .upper downto DISP3DCNT_Alpha_Test          .lower) := (others => '0');
   signal REG_DISP3DCNT_Alpha_Blending       : std_logic_vector(DISP3DCNT_Alpha_Blending      .upper downto DISP3DCNT_Alpha_Blending      .lower) := (others => '0');
   signal REG_DISP3DCNT_Anti_Aliasing        : std_logic_vector(DISP3DCNT_Anti_Aliasing       .upper downto DISP3DCNT_Anti_Aliasing       .lower) := (others => '0');
   signal REG_DISP3DCNT_Edge_Marking         : std_logic_vector(DISP3DCNT_Edge_Marking        .upper downto DISP3DCNT_Edge_Marking        .lower) := (others => '0');
   signal REG_DISP3DCNT_Fog_Color_Alpha_Mode : std_logic_vector(DISP3DCNT_Fog_Color_Alpha_Mode.upper downto DISP3DCNT_Fog_Color_Alpha_Mode.lower) := (others => '0');
   signal REG_DISP3DCNT_Fog_Master_Enable    : std_logic_vector(DISP3DCNT_Fog_Master_Enable   .upper downto DISP3DCNT_Fog_Master_Enable   .lower) := (others => '0');
   signal REG_DISP3DCNT_Fog_Depth_Shift      : std_logic_vector(DISP3DCNT_Fog_Depth_Shift     .upper downto DISP3DCNT_Fog_Depth_Shift     .lower) := (others => '0');
   signal REG_DISP3DCNT_RDLINES_Underflow    : std_logic_vector(DISP3DCNT_RDLINES_Underflow   .upper downto DISP3DCNT_RDLINES_Underflow   .lower) := (others => '0');
   signal REG_DISP3DCNT_RAM_Overflow         : std_logic_vector(DISP3DCNT_RAM_Overflow        .upper downto DISP3DCNT_RAM_Overflow        .lower) := (others => '0');
   signal REG_DISP3DCNT_Rear_Plane_Mode      : std_logic_vector(DISP3DCNT_Rear_Plane_Mode     .upper downto DISP3DCNT_Rear_Plane_Mode     .lower) := (others => '0');
   
   signal REG_CLEAR_COLOR_Red                : std_logic_vector(CLEAR_COLOR_Red               .upper downto CLEAR_COLOR_Red               .lower) := (others => '0');
   signal REG_CLEAR_COLOR_Green              : std_logic_vector(CLEAR_COLOR_Green             .upper downto CLEAR_COLOR_Green             .lower) := (others => '0');
   signal REG_CLEAR_COLOR_Blue               : std_logic_vector(CLEAR_COLOR_Blue              .upper downto CLEAR_COLOR_Blue              .lower) := (others => '0');
   signal REG_CLEAR_COLOR_Fog                : std_logic_vector(CLEAR_COLOR_Fog               .upper downto CLEAR_COLOR_Fog               .lower) := (others => '0');
   signal REG_CLEAR_COLOR_Alpha              : std_logic_vector(CLEAR_COLOR_Alpha             .upper downto CLEAR_COLOR_Alpha             .lower) := (others => '0');
   signal REG_CLEAR_COLOR_Clear_Polygon_ID   : std_logic_vector(CLEAR_COLOR_Clear_Polygon_ID  .upper downto CLEAR_COLOR_Clear_Polygon_ID  .lower) := (others => '0');
                                                                                                                                          
   signal REG_CLEAR_DEPTH_DEPTH              : std_logic_vector(CLEAR_DEPTH_DEPTH             .upper downto CLEAR_DEPTH_DEPTH             .lower) := (others => '0');
   signal REG_CLEAR_DEPTH_X_Offset           : std_logic_vector(CLEAR_DEPTH_X_Offset          .upper downto CLEAR_DEPTH_X_Offset          .lower) := (others => '0');
   signal REG_CLEAR_DEPTH_Y_Offset           : std_logic_vector(CLEAR_DEPTH_Y_Offset          .upper downto CLEAR_DEPTH_Y_Offset          .lower) := (others => '0');

   type t_reg_wired_or is array(0 to 11) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   type tState is
   (
      IDLE,
      BLANK,
      STARTREAD,
      WAITREAD
   );
   signal state            : tState := IDLE;
   
   signal x_cnt            : integer range 0 to 255;
   
   signal VRAM_byteaddr    : unsigned(18 downto 0) := (others => '0');
   
   signal VRAM_last_data   : std_logic_vector(15 downto 0) := (others => '0');
   signal VRAM_last_valid  : std_logic := '0';
   
begin 

   iREG_DISP3DCNT_Texture_Mapping      : entity work.eProcReg_ds generic map (DISP3DCNT_Texture_Mapping     ) port map  (clk100, ds_bus, reg_wired_or( 0), REG_DISP3DCNT_Texture_Mapping     , REG_DISP3DCNT_Texture_Mapping     ); 
   iREG_DISP3DCNT_PolygonAttr_Shading  : entity work.eProcReg_ds generic map (DISP3DCNT_PolygonAttr_Shading ) port map  (clk100, ds_bus, reg_wired_or( 1), REG_DISP3DCNT_PolygonAttr_Shading , REG_DISP3DCNT_PolygonAttr_Shading ); 
   iREG_DISP3DCNT_Alpha_Test           : entity work.eProcReg_ds generic map (DISP3DCNT_Alpha_Test          ) port map  (clk100, ds_bus, reg_wired_or( 2), REG_DISP3DCNT_Alpha_Test          , REG_DISP3DCNT_Alpha_Test          ); 
   iREG_DISP3DCNT_Alpha_Blending       : entity work.eProcReg_ds generic map (DISP3DCNT_Alpha_Blending      ) port map  (clk100, ds_bus, reg_wired_or( 3), REG_DISP3DCNT_Alpha_Blending      , REG_DISP3DCNT_Alpha_Blending      ); 
   iREG_DISP3DCNT_Anti_Aliasing        : entity work.eProcReg_ds generic map (DISP3DCNT_Anti_Aliasing       ) port map  (clk100, ds_bus, reg_wired_or( 4), REG_DISP3DCNT_Anti_Aliasing       , REG_DISP3DCNT_Anti_Aliasing       ); 
   iREG_DISP3DCNT_Edge_Marking         : entity work.eProcReg_ds generic map (DISP3DCNT_Edge_Marking        ) port map  (clk100, ds_bus, reg_wired_or( 5), REG_DISP3DCNT_Edge_Marking        , REG_DISP3DCNT_Edge_Marking        ); 
   iREG_DISP3DCNT_Fog_Color_Alpha_Mode : entity work.eProcReg_ds generic map (DISP3DCNT_Fog_Color_Alpha_Mode) port map  (clk100, ds_bus, reg_wired_or( 6), REG_DISP3DCNT_Fog_Color_Alpha_Mode, REG_DISP3DCNT_Fog_Color_Alpha_Mode); 
   iREG_DISP3DCNT_Fog_Master_Enable    : entity work.eProcReg_ds generic map (DISP3DCNT_Fog_Master_Enable   ) port map  (clk100, ds_bus, reg_wired_or( 7), REG_DISP3DCNT_Fog_Master_Enable   , REG_DISP3DCNT_Fog_Master_Enable   ); 
   iREG_DISP3DCNT_Fog_Depth_Shift      : entity work.eProcReg_ds generic map (DISP3DCNT_Fog_Depth_Shift     ) port map  (clk100, ds_bus, reg_wired_or( 8), REG_DISP3DCNT_Fog_Depth_Shift     , REG_DISP3DCNT_Fog_Depth_Shift     ); 
   iREG_DISP3DCNT_RDLINES_Underflow    : entity work.eProcReg_ds generic map (DISP3DCNT_RDLINES_Underflow   ) port map  (clk100, ds_bus, reg_wired_or( 9), REG_DISP3DCNT_RDLINES_Underflow   , REG_DISP3DCNT_RDLINES_Underflow   ); 
   iREG_DISP3DCNT_RAM_Overflow         : entity work.eProcReg_ds generic map (DISP3DCNT_RAM_Overflow        ) port map  (clk100, ds_bus, reg_wired_or(10), REG_DISP3DCNT_RAM_Overflow        , REG_DISP3DCNT_RAM_Overflow        ); 
   iREG_DISP3DCNT_Rear_Plane_Mode      : entity work.eProcReg_ds generic map (DISP3DCNT_Rear_Plane_Mode     ) port map  (clk100, ds_bus, reg_wired_or(11), REG_DISP3DCNT_Rear_Plane_Mode     , REG_DISP3DCNT_Rear_Plane_Mode     ); 
                                                                                                                                                       
   iREG_CLEAR_COLOR_Red                : entity work.eProcReg_ds generic map (CLEAR_COLOR_Red               ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Red               , REG_CLEAR_COLOR_Red               ); 
   iREG_CLEAR_COLOR_Green              : entity work.eProcReg_ds generic map (CLEAR_COLOR_Green             ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Green             , REG_CLEAR_COLOR_Green             ); 
   iREG_CLEAR_COLOR_Blue               : entity work.eProcReg_ds generic map (CLEAR_COLOR_Blue              ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Blue              , REG_CLEAR_COLOR_Blue              ); 
   iREG_CLEAR_COLOR_Fog                : entity work.eProcReg_ds generic map (CLEAR_COLOR_Fog               ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Fog               , REG_CLEAR_COLOR_Fog               ); 
   iREG_CLEAR_COLOR_Alpha              : entity work.eProcReg_ds generic map (CLEAR_COLOR_Alpha             ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Alpha             , REG_CLEAR_COLOR_Alpha             ); 
   iREG_CLEAR_COLOR_Clear_Polygon_ID   : entity work.eProcReg_ds generic map (CLEAR_COLOR_Clear_Polygon_ID  ) port map  (clk100, ds_bus, open            , REG_CLEAR_COLOR_Clear_Polygon_ID  , REG_CLEAR_COLOR_Clear_Polygon_ID  ); 
                                                                                                                                                                                                                            
   iREG_CLEAR_DEPTH_DEPTH              : entity work.eProcReg_ds generic map (CLEAR_DEPTH_DEPTH             ) port map  (clk100, ds_bus, open            , REG_CLEAR_DEPTH_DEPTH             , REG_CLEAR_DEPTH_DEPTH             ); 
   iREG_CLEAR_DEPTH_X_Offset           : entity work.eProcReg_ds generic map (CLEAR_DEPTH_X_Offset          ) port map  (clk100, ds_bus, open            , REG_CLEAR_DEPTH_X_Offset          , REG_CLEAR_DEPTH_X_Offset          ); 
   iREG_CLEAR_DEPTH_Y_Offset           : entity work.eProcReg_ds generic map (CLEAR_DEPTH_Y_Offset          ) port map  (clk100, ds_bus, open            , REG_CLEAR_DEPTH_Y_Offset          , REG_CLEAR_DEPTH_Y_Offset          ); 

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;


   VRam_addr <= to_integer(VRAM_byteaddr);
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         pixel_we  <= '0';
         Vram_req  <= '0';
         
         if (reset = '1') then
            state <= IDLE;
            busy  <= '0';
         else
      
            case (state) is
            
               when IDLE =>
                  if (drawline = '1') then
                     x_cnt           <= 0;
                     busy            <= '1';
                     if (REG_DISP3DCNT_Rear_Plane_Mode(REG_DISP3DCNT_Rear_Plane_Mode'left) = '1') then
                        state           <= STARTREAD;
                        VRAM_byteaddr   <= to_unsigned(16#40000# + ypos * 512, 19);
                        Vram_req        <= '1';
                     else
                        state           <= BLANK;
                     end if;
                  end if;
                  
               when BLANK =>
                  if (x_cnt = 255) then
                     state <= IDLE;
                     busy  <= '0';
                  else
                     x_cnt <= x_cnt + 1;
                  end if;
                  pixel_x          <= x_cnt;      
                  pixel_we         <= '1';                  
                  pixeldata(14 downto 0) <= REG_CLEAR_COLOR_Blue & REG_CLEAR_COLOR_Green & REG_CLEAR_COLOR_Red;
                  if (unsigned(REG_CLEAR_COLOR_Alpha) = 0) then
                     pixeldata(15) <= '1';
                  else
                     pixeldata(15) <= '0';
                  end if;
                  
               when STARTREAD => 
                  if (VRAM_last_valid = '1') then
                     VRAM_last_valid  <= '0';
                     pixel_x          <= x_cnt;          
                     pixeldata        <= VRAM_last_data;
                     pixel_we         <= '1';
                     if (x_cnt = 255) then
                        state <= IDLE;
                        busy  <= '0';
                     else
                        x_cnt <= x_cnt + 1;
                     end if;
                  else
                     state     <= WAITREAD;
                  end if;
               
               when WAITREAD =>
                  if (Vram_valid = '1') then
                     state           <= STARTREAD;
                     VRAM_last_valid <= '1';
                     VRAM_last_data  <= not VRam_dataout(31) & VRam_dataout(30 downto 16);
                     pixel_x         <= x_cnt;          
                     pixeldata       <= not VRam_dataout(15) & VRam_dataout(14 downto 0);
                     pixel_we        <= '1';
                     x_cnt           <= x_cnt + 1;
                     VRAM_byteaddr   <= VRAM_byteaddr + 4;
                     Vram_req        <= '1';
                  end if;
            
            end case;
         end if;
      
      end if;
   end process;

end architecture;





