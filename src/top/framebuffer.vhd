library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;  
use STD.textio.all;

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

entity framebuffer is
   generic
   (
      isSecond              : std_logic;
      drawmarker            : std_logic;
      drawfile              : std_logic;
      FRAMESIZE_X           : integer;
      FRAMESIZE_Y           : integer;
      Reg_Framebuffer_PosX  : regmap_type;
      Reg_Framebuffer_PosY  : regmap_type;
      Reg_Framebuffer_SizeX : regmap_type;
      Reg_Framebuffer_SizeY : regmap_type;
      Reg_Framebuffer_Scale : regmap_type;
      Reg_Framebuffer_LCD   : regmap_type
   );
   port 
   (
      clk100               : in  std_logic; 
      
      bus_in               : in  proc_bus_intype;
      bus_Dout             : out std_logic_vector(proc_buswidth-1 downto 0);
      bus_done             : out std_logic;
      
      pixel_in_x           : in  integer range 0 to (FRAMESIZE_X - 1);
      pixel_in_y           : in  integer range 0 to (FRAMESIZE_Y - 1);
      pixel_in_data        : in  std_logic_vector(17 downto 0);  
      pixel_in_we          : in  std_logic;
      
      clkvga               : in  std_logic;
      oCoord_X             : in  integer range -1023 to 2047;
      oCoord_Y             : in  integer range -1023 to 2047;
      pixel_out_data       : out std_logic_vector(17 downto 0);
      framebuffer_active   : out std_logic := '0';
      
      markerX              : in  std_logic_vector(7 downto 0);
      markerY              : in  std_logic_vector(7 downto 0)
   );
end entity;

architecture arch of framebuffer is
   
   --regs
   signal Framebuffer_PosX  : std_logic_vector(Reg_Framebuffer_PosX .upper downto Reg_Framebuffer_PosX .lower) := (others => '0');
   signal Framebuffer_PosY  : std_logic_vector(Reg_Framebuffer_PosY .upper downto Reg_Framebuffer_PosY .lower) := (others => '0');
   signal Framebuffer_SizeX : std_logic_vector(Reg_Framebuffer_SizeX.upper downto Reg_Framebuffer_SizeX.lower) := (others => '0');
   signal Framebuffer_SizeY : std_logic_vector(Reg_Framebuffer_SizeY.upper downto Reg_Framebuffer_SizeY.lower) := (others => '0');
   signal Framebuffer_Scale : std_logic_vector(Reg_Framebuffer_Scale.upper downto Reg_Framebuffer_Scale.lower) := (others => '0');
   signal Framebuffer_LCD   : std_logic_vector(Reg_Framebuffer_LCD.upper   downto Reg_Framebuffer_LCD.lower)   := (others => '0');
   
   -- data write
   signal pixel_in_addr   : integer range 0 to (FRAMESIZE_X * FRAMESIZE_Y) - 1;
   signal pixel_in_data_1 : std_logic_vector(17 downto 0);
   signal pixel_in_we_1   : std_logic;
   
   -- vga readout
   signal startx     : integer range 0 to 1023;
   signal starty     : integer range 0 to 1023;
   signal scale      : integer range 0 to 15;
   signal sizex      : integer range 0 to 511;
   signal sizey      : integer range 0 to 255;
   signal lcd_effect : std_logic;
   
   signal endx   : integer range 0 to 2047;
   signal endy   : integer range 0 to 2047;
   
   signal oCoord_active   : std_logic := '0';
   signal oCoord_active_1 : std_logic := '0';
   signal oCoord_active_2 : std_logic := '0';
   
   signal lcd_next        : std_logic := '0';
   signal lcd_next_1      : std_logic := '0';
   
   signal readout_addr_x      : integer range 0 to (FRAMESIZE_X - 1)                 := 0; 
   signal readout_addr_y      : integer range 0 to (FRAMESIZE_Y - 1)                 := 0; 
   signal readout_addr_ymul   : integer range 0 to (FRAMESIZE_X * FRAMESIZE_Y) - 1   := 0;  
   signal readout_addr        : integer range 0 to (FRAMESIZE_X * FRAMESIZE_Y) - 1   := 0; 
   signal readout_slow_x      : integer range 0 to 15    := 0; 
   signal readout_slow_y      : integer range 0 to 15    := 0; 
   signal readout_buffer      : std_logic_vector(17 downto 0) := (others => '0');
   
   type tPixelArray is array(0 to (FRAMESIZE_X * FRAMESIZE_Y) - 1) of std_logic_vector(17 downto 0);
   signal PixelArray : tPixelArray := (others => (others => '0'));
   
begin 

   -- regs
   iReg_Framebuffer_PosX : entity procbus.eProcReg generic map ( Reg_Framebuffer_PosX  )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_PosX , Framebuffer_PosX ); 
   iReg_Framebuffer_PosY : entity procbus.eProcReg generic map ( Reg_Framebuffer_PosY  )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_PosY , Framebuffer_PosY ); 
   iReg_Framebuffer_SizeX: entity procbus.eProcReg generic map ( Reg_Framebuffer_SizeX )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_SizeX, Framebuffer_SizeX); 
   iReg_Framebuffer_SizeY: entity procbus.eProcReg generic map ( Reg_Framebuffer_SizeY )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_SizeY, Framebuffer_SizeY); 
   iReg_Framebuffer_Scale: entity procbus.eProcReg generic map ( Reg_Framebuffer_Scale )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_Scale, Framebuffer_Scale); 
   iReg_Framebuffer_LCD  : entity procbus.eProcReg generic map ( Reg_Framebuffer_LCD   )  port map  (clk100, bus_in, bus_Dout, bus_done, Framebuffer_LCD  , Framebuffer_LCD  ); 

   -- fill framebuffer
   process (clk100)
   begin
      if rising_edge(clk100) then
         
         pixel_in_addr   <= pixel_in_x + (pixel_in_y * to_integer(unsigned(Framebuffer_SizeX)));
         pixel_in_data_1 <= pixel_in_data;
         pixel_in_we_1   <= pixel_in_we; 
         
         if (drawmarker = '1' and pixel_in_x = to_integer(unsigned(markerX)) and pixel_in_y = to_integer(unsigned(markerY))) then
            pixel_in_data_1 <= (17 downto 12 => '1') & (11 downto 0 => '0');
         end if;
         
         if (pixel_in_we_1 = '1') then
            PixelArray(pixel_in_addr) <= pixel_in_data_1;
         end if;
      
      end if;
   end process;

   -- readout
   process (clkvga)
   begin
      if rising_edge(clkvga) then
      
         startx      <= to_integer(unsigned(Framebuffer_PosX));
         starty      <= to_integer(unsigned(Framebuffer_Posy));
         scale       <= to_integer(unsigned(Framebuffer_Scale));
         sizex       <= to_integer(unsigned(Framebuffer_SizeX));
         sizey       <= to_integer(unsigned(Framebuffer_SizeY));
         lcd_effect  <= Framebuffer_LCD(Framebuffer_LCD'left);

         endx   <= startx + sizex * scale;
         endy   <= starty + sizey * scale;


         if (oCoord_X >= startx and oCoord_X < endx and oCoord_Y >= starty and oCoord_Y < endy) then
            oCoord_active <= '1';
            if (oCoord_active = '1') then
               if (readout_slow_x < (scale - 1)) then
                  readout_slow_x <= readout_slow_x + 1;
               else
                  if (readout_addr_x < (sizex - 1)) then
                     readout_addr_x <= readout_addr_x + 1;
                  end if;
                  readout_slow_x <= 0;
               end if;
            end if;
         else
            oCoord_active  <= '0';
            readout_addr_x <= 0;
            readout_slow_x <= 0;
            if (oCoord_X = endx and oCoord_Y >= starty and oCoord_Y < endy) then
               if (readout_slow_y < (scale - 1)) then
                  readout_slow_y <= readout_slow_y + 1;
               else
                  readout_slow_y <= 0;
                  if (readout_addr_y < (sizey - 1)) then
                     readout_addr_y <= readout_addr_y + 1;
                  end if;
               end if;
            end if;
         end if;
         
         if (oCoord_X = 0 and oCoord_Y = 0) then
            readout_addr_y <= 0;
            readout_slow_x <= 0;
            readout_slow_y <= 0;
         end if;
         
         readout_addr_ymul <= readout_addr_y * sizex;
         
         -- cycle 1
         oCoord_active_1 <= oCoord_active;
         readout_addr    <= readout_addr_x + readout_addr_ymul;
         lcd_next        <= '0';
         if (readout_slow_x = 0 or readout_slow_y = 0) then
            lcd_next     <= '1';
         end if;
         
         oCoord_active_2 <= oCoord_active_1;
         readout_buffer  <= PixelArray(readout_addr);
         lcd_next_1      <= lcd_next;
         
         if (oCoord_active_2 = '1' and (lcd_effect = '0' or lcd_next_1 = '0')) then
            pixel_out_data     <= readout_buffer;
            framebuffer_active <= '1';
         else
            pixel_out_data     <= (others => '0');
            framebuffer_active <= '0';
         end if;
      
      end if;
   end process;

-- synthesis translate_off
   
   goutput : if drawfile = '1' generate
   begin
   
      process
      
         file outfile: text;
         variable f_status: FILE_OPEN_STATUS;
         variable line_out : line;
         variable color : unsigned(31 downto 0);
         variable linecounter_int : integer;
         
      begin
   
         if (isSecond = '1') then
            file_open(f_status, outfile, "gra_fb_out2.gra", write_mode);
            file_close(outfile);
            file_open(f_status, outfile, "gra_fb_out2.gra", append_mode);
         else
            file_open(f_status, outfile, "gra_fb_out.gra", write_mode);
            file_close(outfile);
            file_open(f_status, outfile, "gra_fb_out.gra", append_mode);
         end if;
         write(line_out, string'("512#384")); 
         writeline(outfile, line_out);
         
         while (true) loop
            if (sizex > 0) then
               wait until ((pixel_in_x mod sizex) = (sizex - 1)) and pixel_in_we = '1';
               linecounter_int := pixel_in_y;
   
               wait for 100 ns;
   
               for x in 0 to 255 loop
                  color := x"000" & "00" & unsigned(PixelArray(x + linecounter_int * sizex));
                  color := x"00" & unsigned(color(17 downto 12)) & "00" & unsigned(color(11 downto 6)) & "00" & unsigned(color(5 downto 0)) & "00";
               
                  for doublex in 0 to 1 loop
                     for doubley in 0 to 1 loop
                        write(line_out, to_integer(color));
                        write(line_out, string'("#"));
                        write(line_out, x * 2 + doublex);
                        write(line_out, string'("#")); 
                        write(line_out, linecounter_int * 2 + doubley);
                        writeline(outfile, line_out);
                     end loop;
                  end loop;
   
               end loop;
               
               file_close(outfile);
               if (isSecond = '1') then
                  file_open(f_status, outfile, "gra_fb_out2.gra", append_mode);
               else
                  file_open(f_status, outfile, "gra_fb_out.gra", append_mode);
               end if;
               
            else

               wait for 1 us;
             
            end if;
            
         end loop;
         
      end process;
   
   end generate goutput;
   
-- synthesis translate_on

end architecture;





