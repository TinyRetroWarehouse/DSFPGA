library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   

entity ds_drawer_directvram is
   port 
   (
      clk100               : in  std_logic;                     
      VRam_Block           : in  std_logic_vector(1 downto 0);
                           
      drawline             : in  std_logic;                     
      ypos                 : in  integer range 0 to 191;
      
      Vram_req             : out std_logic := '0';
      VRam_addr            : out integer range 0 to 524287;
      VRam_dataout         : in  std_logic_vector(31 downto 0);
      Vram_valid           : in  std_logic;
      
      pixel_x              : out integer range 0 to 255;
      pixel_y              : out integer range 0 to 191;
      pixeldata            : out std_logic_vector(15 downto 0) := (others => '0');  
      directvram_pixel_we  : out std_logic := '0'
   );
end entity;

architecture arch of ds_drawer_directvram is
   
   type tState is
   (
      IDLE,
      STARTREAD,
      WAITREAD
   );
   signal state            : tState := IDLE;
   
   signal x_cnt            : integer range 0 to 255;
   
   signal VRAM_byteaddr    : unsigned(16 downto 0) := (others => '0');
   
   signal VRAM_last_data   : std_logic_vector(15 downto 0) := (others => '0');
   signal VRAM_last_valid  : std_logic := '0';
  
   
begin 

   VRam_addr <= to_integer(unsigned(VRam_Block) & VRAM_byteaddr);
   
   pixel_y <= ypos;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         directvram_pixel_we <= '0';
         Vram_req            <= '0';
      
         case (state) is
         
            when IDLE =>
               if (drawline = '1') then
                  state           <= STARTREAD;
                  VRAM_byteaddr   <= to_unsigned(ypos * 512, 17);
                  x_cnt           <= 0;
                  Vram_req        <= '1';
               end if;
               
            when STARTREAD => 
               if (VRAM_last_valid = '1') then
                  VRAM_last_valid     <= '0';
                  pixel_x             <= x_cnt;          
                  pixeldata           <= VRAM_last_data;
                  directvram_pixel_we <= '1';
                  if (x_cnt = 255) then
                     state <= IDLE;
                  else
                     x_cnt <= x_cnt + 1;
                  end if;
               else
                  state     <= WAITREAD;
               end if;
            
            when WAITREAD =>
               if (Vram_valid = '1') then
                  state               <= STARTREAD;
                  VRAM_last_valid     <= '1';
                  VRAM_last_data      <= VRam_dataout(31 downto 16);
                  pixel_x             <= x_cnt;          
                  pixeldata           <= VRam_dataout(15 downto 0);
                  directvram_pixel_we <= '1';
                  x_cnt               <= x_cnt + 1;
                  VRAM_byteaddr       <= VRAM_byteaddr + 4;
                  Vram_req            <= '1';
               end if;
         
         end case;
      
      end if;
   end process;

end architecture;





