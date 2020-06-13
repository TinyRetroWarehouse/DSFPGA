-- author: Furkan Cayci, 2018
-- description: hdmi out top module
--    consists of the timing module, clock manager and tgb to tdms encoder
--    three different resolutions are added, selectable from the generic
--    objectbuffer is added that displays 2 controllable 1 stationary objects
--    optional pattern generator is added

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;

entity hdmi_out is
   generic 
   (
      is_simu      : std_logic := '0'; 
      vgattxoff    : std_logic := '0'; 
      RESOLUTION   : string    := "HD720P"; -- HD1080P, HD720P, SVGA, VGA
      PIXEL_SIZE   : natural   := 24; -- RGB pixel total size. (R + G + B)
      SERIES6      : boolean   := false -- disables OSERDESE2 and enables OSERDESE1 for GHDL simulation (7 series vs 6 series)
   );
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        -- video signals
        pixclk  : buffer std_logic;
        pixel_x : buffer integer range 0 to 1279;
        pixel_y : buffer integer range 0 to 719;
        color_r : in  std_logic_vector(7 downto 0);
        color_g : in  std_logic_vector(7 downto 0);
        color_b : in  std_logic_vector(7 downto 0);
        -- tmds output ports
        clk_p   : out std_logic;
        clk_n   : out std_logic;
        data_p  : out std_logic_vector(2 downto 0);
        data_n  : out std_logic_vector(2 downto 0)
    );
end hdmi_out;

architecture rtl of hdmi_out is

   signal serclk         : std_logic;
   signal video_active   : std_logic := '0';
   signal video_data     : std_logic_vector(PIXEL_SIZE-1 downto 0);
   signal vsync, hsync   : std_logic := '0';

begin

   video_data <= color_r & color_g & color_b;

   -- generate 1x pixel and 5x serial clocks
   --timing_hd1080p: if RESOLUTION = "HD1080P" generate
   --begin
   --clock: entity work.clock_gen(rtl)
   --  generic map (CLKIN_PERIOD=>10.000, CLK_MULTIPLY=>59, CLK_DIVIDE=>4, CLKOUT0_DIV=>2, CLKOUT1_DIV=>10) -- 1080p
   --  port map (clk_i=>clk, clk0_o=>serclk, clk1_o=>pixclk);
   --end generate;

   timing_hd720p: if RESOLUTION = "HD720P" generate
   begin
   clock: entity work.clock_gen(rtl)
       generic map (CLKIN_PERIOD=>10.000, CLK_MULTIPLY=>59, CLK_DIVIDE=>4, CLKOUT0_DIV=>4, CLKOUT1_DIV=>20) -- 720p
       port map (clk_i=>clk, clk0_o=>serclk, clk1_o=>pixclk);
   end generate;

   --timing_vga: if RESOLUTION = "SVGA" generate
   --begin
   --clock: entity work.clock_gen(rtl)
   --    generic map (CLKIN_PERIOD=>10.000, CLK_MULTIPLY=>10, CLK_DIVIDE=>1, CLKOUT0_DIV=>5, CLKOUT1_DIV=>25) -- 800x600
   --    port map (clk_i=>clk, clk0_o=>serclk, clk1_o=>pixclk);
   --end generate;
   --
   --timing_svga: if RESOLUTION = "VGA" generate
   --begin
   --clock: entity work.clock_gen(rtl)
   --    generic map (CLKIN_PERIOD=>10.000, CLK_MULTIPLY=>10, CLK_DIVIDE=>1, CLKOUT0_DIV=>8, CLKOUT1_DIV=>40) -- 640x480
   --    port map (clk_i=>clk, clk0_o=>serclk, clk1_o=>pixclk );
   --end generate;

   -- video timing
   timing: entity work.timing_generator(rtl)
   generic map 
   (
      RESOLUTION => RESOLUTION
   )
   port map 
   (
      clk=>pixclk, 
      hsync=>hsync, 
      vsync=>vsync, 
      video_active=>video_active, 
      pixel_x=>pixel_x, 
      pixel_y=>pixel_y
   );

   -- tmds signaling
   tmds_signaling: entity work.rgb2tmds(rtl)
      generic map (SERIES6=>SERIES6)
      port map (rst=>rst, pixelclock=>pixclk, serialclock=>serclk,
      video_data=>video_data, video_active=>video_active, hsync=>hsync, vsync=>vsync,
      clk_p=>clk_p, clk_n=>clk_n, data_p=>data_p, data_n=>data_n);

   
   
   
   -- test output
   
   goutput : if vgattxoff = '0' generate
      signal color : unsigned(31 downto 0);
      signal color_filtered : unsigned(31 downto 0);
   begin
   
      color <= x"00" & unsigned(video_data);
   
      gcolorfilter : for i in 0 to 31 generate
         color_filtered(i) <= '0' when (color(i) = 'Z' or color(i) = 'X' or color(i) = 'U') else color(i);
      end generate;
   
      process
      
         file outfile: text;
         variable f_status: FILE_OPEN_STATUS;
         variable line_out : line;
         
         variable color : unsigned(31 downto 0);
         
      begin
   
         file_open(f_status, outfile, "vga_out.gra", write_mode);
         file_close(outfile);
         
         file_open(f_status, outfile, "vga_out.gra", append_mode);
         write(line_out, string'("1280#720")); 
         writeline(outfile, line_out);
         
         while (true) loop
            wait until rising_edge(pixclk);
            
            if (pixel_x >= 0) then
            
               write(line_out, to_integer(color_filtered));
               write(line_out, string'("#"));
               
               write(line_out, pixel_x - 1);
               write(line_out, string'("#")); 
               write(line_out, pixel_y);
               
               writeline(outfile, line_out);
               
               if (pixel_x = 1279) then
                  file_close(outfile);
                  file_open(f_status, outfile, "vga_out.gra", append_mode);
               end if;
            end if;
            
         end loop;
         
      end process;
   
   
   end generate goutput;



end rtl;
