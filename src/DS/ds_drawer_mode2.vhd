library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   

entity ds_drawer_mode2 is
   port 
   (
      clk100               : in  std_logic; 
      reset                : in  std_logic; 
                           
      line_trigger         : in  std_logic;
      drawline             : in  std_logic;
      busy                 : out std_logic := '0';
      
      mapbase              : in  integer range 0 to 224;
      tilebase             : in  integer range 0 to 28;
      screensize           : in  unsigned(1 downto 0);
      wrapping             : in  std_logic;
      tile16bit            : in  std_logic;
      extpalette           : in  std_logic;
      extpalette_offset    : in  std_logic_vector(1 downto 0);
      mosaic               : in  std_logic;
      Mosaic_H_Size        : in  unsigned(3 downto 0);
      refX                 : in  signed(27 downto 0);
      refY                 : in  signed(27 downto 0);      
      refX_mosaic          : in  signed(27 downto 0);
      refY_mosaic          : in  signed(27 downto 0);
      dx                   : in  signed(15 downto 0);
      dy                   : in  signed(15 downto 0);
      
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

architecture arch of ds_drawer_mode2 is
   
   type tVRAMState is
   (
      IDLE,
      CALCADDR1,
      CALCADDR2,
      WAITREAD_TILE,
      EVALTILE,
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
   signal VRAM_lasttile_addr   : unsigned(16 downto 0) := (others => '0');
   signal VRAM_lasttile_data   : std_logic_vector(31 downto 0) := (others => '0');
   signal VRAM_lasttile_valid  : std_logic := '0';
                               
   signal PALETTE_byteaddr     : std_logic_vector(8 downto 0) := (others => '0');
   signal palette_readwait     : integer range 0 to 2;
                               
   signal mapbaseaddr          : integer range 0 to 524287;
   signal tilebaseaddr         : integer range 0 to 1048575;
                               
   signal realX                : signed(27 downto 0);
   signal realY                : signed(27 downto 0);
   signal xxx                  : signed(19 downto 0);
   signal yyy                  : signed(19 downto 0);
   signal xxx_pre              : signed(19 downto 0);
   signal yyy_pre              : signed(19 downto 0);
                               
   signal x_cnt                : integer range 0 to 255;
   signal scroll_mod           : integer range 128 to 1024; 
   signal tileinfo             : std_logic_vector(15 downto 0) := (others => '0');
                               
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
  
   xxx_pre <= realX(27 downto 8);
   yyy_pre <= realY(27 downto 8);
  
   -- vramfetch
   process (clk100)
      variable tileindex_var  : integer range 0 to 16383;
      variable pixeladdr      : integer range 0 to 524287;
      variable xxx_flipped    : unsigned(2 downto 0);
      variable yyy_flipped    : unsigned(2 downto 0);
   begin
      if rising_edge(clk100) then
      
         VRAM_Drawer_req <= '0';
      
         if (reset = '1') then
      
            vramfetch <= IDLE;
            busy      <= '0';
      
         else
      
            case (vramfetch) is
            
               when IDLE =>
                  if (line_trigger = '1') then
                     if (mosaic = '1') then
                        realX     <= refX_mosaic;
                        realY     <= refY_mosaic;
                     else
                        realX     <= refX;
                        realY     <= refY;
                     end if;
                  elsif (drawline = '1') then
                     busy         <= '1';
                     vramfetch    <= CALCADDR1;
                     case (to_integer(screensize)) is
                        when 0 => scroll_mod <= 128; 
                        when 1 => scroll_mod <= 256; 
                        when 2 => scroll_mod <= 512; 
                        when 3 => scroll_mod <= 1024;
                        when others => null;
                     end case;
                     x_cnt     <= 0;
                     VRAM_lasttile_valid  <= '0'; -- invalidate fetch cache
                     VRAM_lastcolor_valid <= '0';
                  elsif (palettefetch = IDLE) then
                     busy         <= '0';
                  end if;
                  
               when CALCADDR1 =>
                  vramfetch  <= CALCADDR2;
                  if (wrapping = '1') then
                     case (to_integer(screensize)) is
                        when 0 => xxx <= xxx_pre mod 128; yyy <= yyy_pre mod 128;
                        when 1 => xxx <= xxx_pre mod 256; yyy <= yyy_pre mod 256;
                        when 2 => xxx <= xxx_pre mod 512; yyy <= yyy_pre mod 512;
                        when 3 => xxx <= xxx_pre mod 1024; yyy <= yyy_pre mod 1024;
                        when others => null;
                     end case;
                  else
                     xxx <= xxx_pre; 
                     yyy <= yyy_pre;
                     if (xxx_pre < 0 or yyy_pre < 0 or xxx_pre >= scroll_mod or yyy_pre >= scroll_mod) then
                        if (x_cnt < 255) then
                           vramfetch <= CALCADDR1;
                           x_cnt     <= x_cnt + 1;
                        else
                           vramfetch <= IDLE;
                        end if;
                     end if;
                  end if;
                  realX <= realX + dx;
                  realY <= realy + dy;
      
               when CALCADDR2 =>
                  case (to_integer(screensize)) is
                     when 0 => tileindex_var := to_integer((xxx / 8) + shift_left(shift_right(yyy, 3), 4)); -- << 4
                     when 1 => tileindex_var := to_integer((xxx / 8) + shift_left(shift_right(yyy, 3), 5)); -- << 5
                     when 2 => tileindex_var := to_integer((xxx / 8) + shift_left(shift_right(yyy, 3), 6)); -- << 6
                     when 3 => tileindex_var := to_integer((xxx / 8) + shift_left(shift_right(yyy, 3), 7)); -- << 7
                     when others => null;
                  end case;
                  if (tile16bit = '1') then
                     VRAM_byteaddr   <= to_unsigned(mapbaseaddr + (tileindex_var * 2), VRAM_byteaddr'length);
                  else
                     VRAM_byteaddr   <= to_unsigned(mapbaseaddr + tileindex_var, VRAM_byteaddr'length);
                  end if;
                  vramfetch       <= WAITREAD_TILE;
                  VRAM_Drawer_req <= '1';
               
               when WAITREAD_TILE =>
                  --if (VRAM_lasttile_valid = '1' and VRAM_lasttile_addr = VRAM_byteaddr(VRAM_byteaddr'left downto 2)) then
                  --   case (to_integer(VRAM_byteaddr(1 downto 0))) is
                  --      when 0 => tileinfo <= VRAM_lasttile_data( 7 downto  0);
                  --      when 1 => tileinfo <= VRAM_lasttile_data(15 downto  8);
                  --      when 2 => tileinfo <= VRAM_lasttile_data(23 downto 16);
                  --      when 3 => tileinfo <= VRAM_lasttile_data(31 downto 24);
                  --      when others => null;
                  --   end case;
                  --   vramfetch  <= EVALTILE;
                  --elsif (vram_readwait > 0) then
                  --   vram_readwait <= vram_readwait - 1;
                  --elsif (VRAM_Drawer_valid = '1') then
                  if (VRAM_Drawer_valid = '1') then
                     VRAM_lasttile_addr  <= VRAM_byteaddr(VRAM_byteaddr'left downto 2);
                     VRAM_lasttile_data  <= VRAM_Drawer_data;
                     VRAM_lasttile_valid <= '1';
                     vramfetch           <= EVALTILE;
                     if (tile16bit = '1') then
                        case (to_integer(VRAM_byteaddr(1 downto 0))) is
                           when 0 => tileinfo <= VRAM_Drawer_data(15 downto  0);
                           when 2 => tileinfo <= VRAM_Drawer_data(31 downto 16);
                           when others => null;
                        end case;
                     else
                        case (to_integer(VRAM_byteaddr(1 downto 0))) is
                           when 0 => tileinfo <= x"00" & VRAM_Drawer_data( 7 downto  0);
                           when 1 => tileinfo <= x"00" & VRAM_Drawer_data(15 downto  8);
                           when 2 => tileinfo <= x"00" & VRAM_Drawer_data(23 downto 16);
                           when 3 => tileinfo <= x"00" & VRAM_Drawer_data(31 downto 24);
                           when others => null;
                        end case;
                     end if;
                  end if;
                  
               when EVALTILE =>
                  vramfetch       <= WAITREAD_COLOR;
                  xxx_flipped     := unsigned(xxx(2 downto 0));
                  yyy_flipped     := unsigned(yyy(2 downto 0));
                  if (tileinfo(10) = '1') then
                     xxx_flipped := 7 - xxx_flipped;
                  end if;
                  if (tileinfo(11) = '1') then
                     yyy_flipped := 7 - yyy_flipped;
                  end if;
                  pixeladdr       := tilebaseaddr + to_integer(unsigned(tileinfo(9 downto 0)) & yyy_flipped & xxx_flipped); -- (tileinfo << 6) + ((yyy & 7) * 8) + xxx & 7;
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
                  --elsif (vram_readwait > 0) then
                  --   vram_readwait <= vram_readwait - 1;
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
            mosaik_cnt    <= 15; -- first pixel must fetch new data
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
                     PALETTE_byteaddr <= colordata & '0';
                     if (colordata = x"00") then -- transparent
                        palettefetch  <= IDLE;
                        pixeldata(15) <= '1';
                     elsif (extpalette = '1') then
                        EXTPALETTE_req  <= '1';
                        EXTPALETTE_addr <= to_integer(unsigned(extpalette_offset) & unsigned(tileinfo(15 downto 12)) & unsigned(colordata) & '0');
                     end if;
                  end if;
               end if;
               
            when STARTREAD => 
               palettefetch     <= WAITREAD;
               palette_readwait <= 2;
            
            when WAITREAD =>
               if (extpalette = '1') then
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





