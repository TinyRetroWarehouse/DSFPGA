library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   

use work.pProc_bus_ds.all;
use work.pReg_ds_display_9.all;

entity ds_drawer_mainram is
   port 
   (
      clk100      : in  std_logic;                     
            
      ds_bus      : in  proc_bus_ds_type; 
            
      drawline    : in  std_logic;                     
      ypos        : in  integer range 0 to 191;
      
      pixel_x     : out integer range 0 to 255;
      pixel_y     : out integer range 0 to 191;
      pixeldata   : out std_logic_vector(15 downto 0) := (others => '0');  
      pixel_we    : out std_logic := '0'
   );
end entity;

architecture arch of ds_drawer_mainram is
   
   signal REG_DISP_MMEM_FIFO : std_logic_vector(DISP_MMEM_FIFO.upper downto DISP_MMEM_FIFO.lower) := (others => '0');
   signal reg_written : std_logic;
   
   type tState is
   (
      IDLE,
      WAITWRITE,
      WRITEPIXEL
   );
   signal state            : tState := IDLE;
   
   signal x_cnt            : integer range 0 to 255;
  
begin 

   iREG_DISP_MMEM_FIFO : entity work.eProcReg_ds generic map (DISP_MMEM_FIFO) port map (clk100, ds_bus, open, REG_DISP_MMEM_FIFO, REG_DISP_MMEM_FIFO, reg_written);

   pixel_y <= ypos;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         pixel_we <= '0';
         
         if (drawline = '1') then
         
            x_cnt <= 0;
            state <= WAITWRITE;
         
         else
      
            case (state) is
            
               when IDLE => null;
               
               when WAITWRITE =>
                  if (reg_written = '1') then
                     state       <= WRITEPIXEL;
                     x_cnt       <= x_cnt + 1;
                     pixel_x     <= x_cnt;          
                     pixeldata   <= REG_DISP_MMEM_FIFO(15 downto 0);
                     pixel_we    <= '1';
                  end if;
               
               when WRITEPIXEL =>
                  if (x_cnt = 255) then
                     state <= IDLE;
                  else
                     state <= WAITWRITE;
                     x_cnt <= x_cnt + 1;
                  end if;
                  pixel_x     <= x_cnt;          
                  pixeldata   <= REG_DISP_MMEM_FIFO(31 downto 16);
                  pixel_we    <= '1';
                       
            end case;
            
         end if;
      
      end if;
   end process;

end architecture;





