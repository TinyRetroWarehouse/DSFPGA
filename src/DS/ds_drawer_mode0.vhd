library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   

entity ds_drawer_mode0 is
   port 
   (
      clk100               : in  std_logic;                     
      reset                : in  std_logic;
                           
      drawline             : in  std_logic;
      busy                 : out std_logic := '0';
      
      lockspeed            : in  std_logic;
      pixelpos             : in  integer range 0 to 511;
      
      ypos                 : in  integer range 0 to 191;
      ypos_mosaic          : in  integer range 0 to 191;
      mapbase              : in  integer range 0 to 224;
      tilebase             : in  integer range 0 to 28;
      hicolor              : in  std_logic;
      extpalette           : in  std_logic;
      extpalette_offset    : in  std_logic_vector(1 downto 0);
      mosaic               : in  std_logic;
      Mosaic_H_Size        : in  unsigned(3 downto 0);
      screensize           : in  unsigned(1 downto 0);
      scrollX              : in  unsigned(8 downto 0);
      scrollY              : in  unsigned(8 downto 0);
      
      pixel_we             : out std_logic := '0';
      pixeldata            : buffer std_logic_vector(15 downto 0) := (others => '0');
      pixel_x              : out integer range 0 to 255;
      
      PALETTE_Drawer_addr  : out integer range 0 to 127;
      PALETTE_Drawer_data  : in  std_logic_vector(31 downto 0);
      PALETTE_Drawer_valid : in  std_logic;
      
      EXTPALETTE_req       : out std_logic := '0';
      EXTPALETTE_addr      : out integer range 0 to 524287;
      EXTPALETTE_data      : in  std_logic_vector(31 downto 0);
      EXTPALETTE_valid     : in  std_logic;
      
      VRAM_Drawer_req      : out std_logic := '0';
      VRAM_Drawer_addr     : out integer range 0 to 524287;
      VRAM_Drawer_data     : in  std_logic_vector(31 downto 0);
      VRAM_Drawer_valid    : in  std_logic
   );
end entity;

architecture arch of ds_drawer_mode0 is
   
   type tVRAMState is
   (
      IDLE,
      CALCBASE,
      CALCADDR1,
      CALCADDR2,
      WAITREAD_TILE,
      CALCCOLORADDR,
      WAITREAD_COLOR,
      FETCHDONE
   );
   signal vramfetch    : tVRAMState := IDLE;
   
   type tPALETTEState is
   (
      IDLE,
      STARTREAD,
      WAITREAD
   );
   signal palettefetch : tPALETTEState := IDLE;
  
   signal VRAM_byteaddr        : unsigned(18 downto 0) := (others => '0'); 
                               
   signal PALETTE_byteaddr     : std_logic_vector(8 downto 0) := (others => '0');
   signal palette_readwait     : integer range 0 to 2;
                               
   signal mapbaseaddr          : integer range 0 to 524287;
   signal tilebaseaddr         : integer range 0 to 1048575;
                               
   signal x_cnt                : integer range 0 to 255;
   signal y_scrolled           : integer range 0 to 1023; 
   signal offset_y             : integer range 0 to 1023; 
   signal scroll_x_mod         : integer range 256 to 512; 
   signal scroll_y_mod         : integer range 256 to 512; 
                               
   signal x_flip_offset        : integer range 3 to 7;
   signal x_div                : integer range 1 to 2;
                               
   signal x_scrolled           : integer range 0 to 1023;
   signal tileindex            : integer range 0 to 4095;
                               
   signal tileinfo             : std_logic_vector(15 downto 0) := (others => '0');
   signal pixeladdr_base       : integer range 0 to 524287;
                               
   signal colordata            : std_logic_vector(7 downto 0) := (others => '0');
   signal VRAM_lastcolor_addr  : unsigned(16 downto 0) := (others => '0');
   signal VRAM_lastcolor_data  : std_logic_vector(31 downto 0) := (others => '0');
   signal VRAM_lastcolor_valid : std_logic := '0';
   
   signal mosaik_cnt           : integer range 0 to 15 := 0;
   
begin 

   mapbaseaddr  <= mapbase * 2048;
   tilebaseaddr <= tilebase * 16#4000#;
   
   VRAM_Drawer_addr <= to_integer(VRAM_byteaddr(18 downto 2) & "00");
   PALETTE_Drawer_addr <= to_integer(unsigned(PALETTE_byteaddr(8 downto 2)));
  
   -- vramfetch
   process (clk100)
    variable tileindex_var  : integer range 0 to 4095;
    variable x_scrolled_var : integer range 0 to 1023;
    variable pixeladdr      : integer range 0 to 524287;
   begin
      if rising_edge(clk100) then
      
         VRAM_Drawer_req <= '0';
      
         if (reset = '1') then
         
            vramfetch <= IDLE;
            busy      <= '0';
         
         else
      
            case (vramfetch) is
            
               when IDLE =>
                  if (drawline = '1') then
                     busy            <= '1';
                     vramfetch       <= CALCBASE;
                     if (mosaic = '1') then
                        y_scrolled <= ypos_mosaic + to_integer(scrollY);
                     else
                        y_scrolled <= ypos + to_integer(scrollY);
                     end if;
                     offset_y     <= 32;
                     scroll_x_mod <= 256;
                     scroll_y_mod <= 256;
                     case (to_integer(screensize)) is
                        when 1 => scroll_x_mod <= 512;
                        when 2 => scroll_y_mod <= 512; 
                        when 3 => scroll_x_mod <= 512; scroll_y_mod <= 512;
                        when others => null;
                     end case;
                     x_cnt     <= 0;
                     VRAM_lastcolor_valid <= '0'; -- invalidate fetch cache
                  elsif (palettefetch = IDLE) then
                     busy         <= '0';
                  end if;
                  
               when CALCBASE =>
                  vramfetch  <= CALCADDR1;
                  case (to_integer(screensize)) is
                     when 0 => y_scrolled <= y_scrolled mod 256;
                     when 1 => y_scrolled <= y_scrolled mod 256;
                     when 2 => y_scrolled <= y_scrolled mod 512;
                     when 3 => y_scrolled <= y_scrolled mod 512;
                     when others => null;
                  end case;
                  offset_y   <= ((y_scrolled mod 256) / 8) * offset_y;
                  if (hicolor = '0') then
                     --tilemult      <= 32;
                     x_flip_offset <= 3;
                     x_div         <= 2;
                     --x_size        <= 4;
                  else
                     --tilemult      <= 64;
                     x_flip_offset <= 7;
                     x_div         <= 1;
                     --x_size        <= 8;
                  end if;
                  
               when CALCADDR1 =>
                  if (pixelpos >= x_cnt or lockspeed = '0') then
                     vramfetch  <= CALCADDR2;
                     case (to_integer(screensize)) is
                        when 0 => x_scrolled <= ((x_cnt + to_integer(scrollX)) mod 256);
                        when 1 => x_scrolled <= ((x_cnt + to_integer(scrollX)) mod 512);
                        when 2 => x_scrolled <= ((x_cnt + to_integer(scrollX)) mod 256);
                        when 3 => x_scrolled <= ((x_cnt + to_integer(scrollX)) mod 512);
                        when others => null;
                     end case;
                  end if;
      
               when CALCADDR2 =>
                  tileindex_var  := 0;
                  x_scrolled_var := x_scrolled;
                  if (x_scrolled >= 256 or (y_scrolled >= 256 and to_integer(screensize) = 2)) then
                     tileindex_var  := tileindex_var + 1024;
                     x_scrolled_var := x_scrolled mod 256;
                     x_scrolled     <= x_scrolled mod 256;
                  end if;
                  if (y_scrolled >= 256 and to_integer(screensize) = 3) then
                     tileindex_var := tileindex_var + 2048;
                  end if;
                  tileindex_var   := tileindex_var + offset_y + (x_scrolled_var / 8);
                  VRAM_byteaddr   <= to_unsigned(mapbaseaddr + (tileindex_var * 2), VRAM_byteaddr'length);
                  vramfetch       <= WAITREAD_TILE;
                  VRAM_Drawer_req <= '1';
               
               when WAITREAD_TILE =>
                  if (VRAM_Drawer_valid = '1') then
                     if (VRAM_byteaddr(1) = '1') then
                        tileinfo <= VRAM_Drawer_data(31 downto 16);
                        if (hicolor = '0') then
                           pixeladdr_base <= tilebaseaddr + to_integer(unsigned(VRAM_Drawer_data(25 downto 16))) * 32;
                        else
                           pixeladdr_base <= tilebaseaddr + to_integer(unsigned(VRAM_Drawer_data(25 downto 16))) * 64;
                        end if;
                     else
                        tileinfo <= VRAM_Drawer_data(15 downto 0);
                        if (hicolor = '0') then
                           pixeladdr_base <= tilebaseaddr + to_integer(unsigned(VRAM_Drawer_data(9 downto 0))) * 32;
                        else
                           pixeladdr_base <= tilebaseaddr + to_integer(unsigned(VRAM_Drawer_data(9 downto 0))) * 64;
                        end if;
                     end if;
                     vramfetch  <= CALCCOLORADDR;
                  end if;
                  
               when CALCCOLORADDR => 
                  vramfetch  <= WAITREAD_COLOR;
                  if (tileinfo(10) = '1') then -- hoz flip
                     pixeladdr := pixeladdr_base + (x_flip_offset - ((x_scrolled mod 8) / x_div));
                  else
                     pixeladdr := pixeladdr_base + (x_scrolled mod 8) / x_div;
                  end if;
                  if (tileinfo(11) = '1') then -- vert flip
                     if (hicolor = '0') then
                        pixeladdr := pixeladdr + ((7 - (y_scrolled mod 8)) * 4);
                     else
                        pixeladdr := pixeladdr + ((7 - (y_scrolled mod 8)) * 8);
                     end if;
                  else
                     if (hicolor = '0') then
                        pixeladdr := pixeladdr + (y_scrolled mod 8 * 4);
                     else
                        pixeladdr := pixeladdr + (y_scrolled mod 8 * 8);
                     end if;
                  end if;
                  VRAM_byteaddr   <= to_unsigned(pixeladdr, VRAM_byteaddr'length);
                  vramfetch       <= WAITREAD_COLOR;
                  VRAM_Drawer_req <= '1';
                  
               when WAITREAD_COLOR =>
                  --if (VRAM_lastcolor_valid = '1' and VRAM_lastcolor_addr = VRAM_byteaddr(VRAM_byteaddr'left downto 2)) then
                  --   case (VRAM_byteaddr(1 downto 0)) is
                  --      when "00" => colordata <= VRAM_lastcolor_data(7  downto 0);
                  --      when "01" => colordata <= VRAM_lastcolor_data(15 downto 8);
                  --      when "10" => colordata <= VRAM_lastcolor_data(23 downto 16);
                  --      when "11" => colordata <= VRAM_lastcolor_data(31 downto 24);
                  --      when others => null;
                  --   end case;
                  --   vramfetch  <= FETCHDONE;
                  --elsif (VRAM_Drawer_valid = '1') then
                  if (VRAM_Drawer_valid = '1') then
                     VRAM_lastcolor_addr  <= VRAM_byteaddr(VRAM_byteaddr'left downto 2);
                     VRAM_lastcolor_data  <= VRAM_Drawer_data;
                     VRAM_lastcolor_valid <= '1';
                     case (VRAM_byteaddr(1 downto 0)) is
                        when "00" => colordata <= VRAM_Drawer_data(7  downto 0);
                        when "01" => colordata <= VRAM_Drawer_data(15 downto 8);
                        when "10" => colordata <= VRAM_Drawer_data(23 downto 16);
                        when "11" => colordata <= VRAM_Drawer_data(31 downto 24);
                        when others => null;
                     end case;
                     vramfetch  <= FETCHDONE;
                  end if;
               
               when FETCHDONE =>
                  if (palettefetch = IDLE) then
                     if (x_cnt < 255) then
                        vramfetch <= CALCADDR1;
                        x_cnt     <= x_cnt + 1;
                     else
                        vramfetch <= IDLE;
                     end if;
                  end if;
            
            end case;
            
         end if;
      
      end if;
   end process;
   
   -- palette
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         pixel_we       <= '0';
         EXTPALETTE_req <= '0';
      
         if (drawline = '1') then
            mosaik_cnt    <= 15;  -- first pixel must fetch new data
            pixeldata(15) <= '1';
         end if;
      
         case (palettefetch) is
         
            when IDLE =>
               if (vramfetch = FETCHDONE) then
               
                  pixel_x          <= x_cnt;
               
                  if (mosaik_cnt < Mosaic_H_Size and mosaic = '1') then
                     mosaik_cnt <= mosaik_cnt + 1;
                     pixel_we   <= not pixeldata(15);
                  else
                     mosaik_cnt       <= 0;
                     
                     palettefetch     <= STARTREAD; 
                     if (hicolor = '0') then
                        if ((tileinfo(10) = '1' and (x_scrolled mod 2) = 0) or (tileinfo(10) = '0' and (x_scrolled mod 2) = 1)) then
                           PALETTE_byteaddr <= tileinfo(15 downto 12) & colordata(7 downto 4) & '0';
                           if (colordata(7 downto 4) = x"0") then -- transparent
                              palettefetch  <= IDLE;
                              pixeldata(15) <= '1';
                           end if;
                        else
                           PALETTE_byteaddr <= tileinfo(15 downto 12) & colordata(3 downto 0) & '0';
                           if (colordata(3 downto 0) = x"0") then -- transparent
                              palettefetch  <= IDLE;
                              pixeldata(15) <= '1';
                           end if;
                        end if;
                     else
                        PALETTE_byteaddr <= colordata & '0';
                        EXTPALETTE_addr  <= to_integer(unsigned(extpalette_offset) & unsigned(tileinfo(15 downto 12)) & unsigned(colordata) & '0');
                        if (colordata = x"00") then -- transparent
                           palettefetch  <= IDLE;
                           pixeldata(15) <= '1';
                        end if;
                     end if;
                     
                     if (hicolor = '1' and extpalette = '1') then
                        EXTPALETTE_req  <= '1';
                     end if;
                     
                  end if;
               end if;
               
            when STARTREAD => 
               palettefetch     <= WAITREAD;
               palette_readwait <= 2;
            
            when WAITREAD =>
               if (hicolor = '1' and extpalette = '1') then
                  if (EXTPALETTE_valid = '1') then
                     palettefetch  <= IDLE;
                     pixel_we      <= '1';
                     if (PALETTE_byteaddr(1) = '1') then
                        pixeldata <= '0' & EXTPALETTE_data(30 downto 16);
                     else
                        pixeldata <= '0' & EXTPALETTE_data(14 downto 0);
                     end if;
                  end if;
               else
                  if (palette_readwait > 0) then
                     palette_readwait <= palette_readwait - 1;
                  elsif (PALETTE_Drawer_valid = '1') then
                     palettefetch  <= IDLE;
                     pixel_we      <= '1';
                     if (PALETTE_byteaddr(1) = '1') then
                        pixeldata <= '0' & PALETTE_Drawer_data(30 downto 16);
                     else
                        pixeldata <= '0' & PALETTE_Drawer_data(14 downto 0);
                     end if;
                  end if;
               end if;

         
         end case;
      
      end if;
   end process;

end architecture;





