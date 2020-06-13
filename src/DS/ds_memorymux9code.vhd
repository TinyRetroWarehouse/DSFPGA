library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_memorymux9code is
   port 
   (
      clk100               : in     std_logic; 
      DS_on                : in     std_logic;
      reset                : in     std_logic;
                                        
      mem_bus_Adr          : in     std_logic_vector(31 downto 0);
      mem_bus_ena          : in     std_logic;
      mem_bus_acc          : in     std_logic_vector(1 downto 0);
      mem_bus_din          : out    std_logic_vector(31 downto 0) := (others => '0');
      mem_bus_done         : out    std_logic;
      
      ITCM_addr            : out    natural range 0 to 8191;
      ITCM_dataout         : in     std_logic_vector(31 downto 0);
            
      BIOS_addr            : out    std_logic_vector(9 downto 0);
      BIOS_dataout         : in     std_logic_vector(31 downto 0);
      
      Externram_Adr        : out    std_logic_vector(28 downto 0);
      Externram_ena        : out    std_logic := '0';
      Externram_din        : in     std_logic_vector(31 downto 0);
      Externram_done       : in     std_logic;
      
      WramSmall_Mux        : in     std_logic_vector(1 downto 0);
      WramSmallLo_addr     : out    natural range 0 to 4095;
      WramSmallLo_dataout  : in     std_logic_vector(31 downto 0);
      WramSmallHi_addr     : out    natural range 0 to 4095;
      WramSmallHi_dataout  : in     std_logic_vector(31 downto 0);
      
      Palette_addr         : out    natural range 0 to 127;
      Palette_dataout_bgA  : in     std_logic_vector(31 downto 0);
      Palette_dataout_objA : in     std_logic_vector(31 downto 0);
      Palette_dataout_bgB  : in     std_logic_vector(31 downto 0);
      Palette_dataout_objB : in     std_logic_vector(31 downto 0);
      
      VRam_addr            : out    std_logic_vector(23 downto 0);
      VRam_datain          : out    std_logic_vector(31 downto 0);
      VRam_dataout_A       : in     std_logic_vector(31 downto 0);
      VRam_dataout_B       : in     std_logic_vector(31 downto 0);
      VRam_dataout_C       : in     std_logic_vector(31 downto 0);
      VRam_dataout_D       : in     std_logic_vector(31 downto 0);
      VRam_dataout_E       : in     std_logic_vector(31 downto 0);
      VRam_dataout_F       : in     std_logic_vector(31 downto 0);
      VRam_dataout_G       : in     std_logic_vector(31 downto 0);
      VRam_dataout_H       : in     std_logic_vector(31 downto 0);
      VRam_dataout_I       : in     std_logic_vector(31 downto 0);
      VRam_active_A        : in     std_logic;
      VRam_active_B        : in     std_logic;
      VRam_active_C        : in     std_logic;
      VRam_active_D        : in     std_logic;
      VRam_active_E        : in     std_logic;
      VRam_active_F        : in     std_logic;
      VRam_active_G        : in     std_logic;
      VRam_active_H        : in     std_logic;
      VRam_active_I        : in     std_logic;
      
      OAMRam_addr          : out    natural range 0 to 255;
      OAMRam_dataout_A     : in     std_logic_vector(31 downto 0);
      OAMRam_dataout_B     : in     std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_memorymux9code is

   type tState is
   (
      IDLE,
      READITCM,
      READLARGERAM,
      READWRAMSMALL,
      READPALETTE,
      READVRAM,
      READOAM,
      READBIOS,
      ROTATE
   );
   signal state : tState := IDLE;
   
   signal read_delay       : std_logic := '0';
      
   signal acc_save         : std_logic_vector(1 downto 0);
      
   signal return_rotate    : std_logic_vector(1 downto 0);
   signal rotate_data      : std_logic_vector(31 downto 0);
   
   signal wramsmallswitch  : std_logic;
   signal palettemux       : integer range 0 to 3;
   signal oammux           : integer range 0 to 1;
   
begin 

   ITCM_addr <= to_integer(unsigned(mem_bus_Adr(14 downto 2)));
   
   BIOS_addr <= mem_bus_Adr(11 downto 2);

   WramSmallLo_addr <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));
   WramSmallHi_addr <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));

   Palette_addr <= to_integer(unsigned(mem_bus_Adr(8 downto 2)));
   
   OAMRam_addr  <= to_integer(unsigned(mem_bus_Adr(9 downto 2)));

   process (clk100)
   begin
      if rising_edge(clk100) then
      
         mem_bus_done    <= '0';
         Externram_ena   <= '0';
      
         if (reset = '1') then  
         
            state           <= IDLE;
            
         else
       
            if (read_delay = '1') then
               read_delay <= '0';
            end if;
       
            case state is
         
               when IDLE =>
         
                  if (mem_bus_ena = '1') then
                  
                     acc_save  <= mem_bus_acc;
                     return_rotate  <= mem_bus_Adr(1 downto 0);
                  
                     case (mem_bus_Adr(31 downto 24)) is
                        
                        when x"00" | x"01" =>
                           state        <= READITCM;
                     
                        when x"02" =>
                           state          <= READLARGERAM;
                           Externram_Adr  <= (28 downto 22 => '0') & mem_bus_Adr(21 downto 2) & "00";
                           Externram_ena  <= '1';
                           
                        when x"03" =>
                           state           <= READWRAMSMALL;
                           wramsmallswitch <= mem_bus_Adr(14);                             
                           
                        when x"04" =>
                           mem_bus_din  <= (others => '0');
                           mem_bus_done <= '1';
                           
                        when x"05" =>
                           state      <= READPALETTE; 
                           palettemux <= to_integer(unsigned(mem_bus_Adr(10 downto 9)));
                     
                        when x"06" =>
                           VRam_addr  <= mem_bus_Adr(23 downto 0);
                           state      <= READVRAM;
                           read_delay <= '1';
                     
                        when x"07" =>
                           state  <= READOAM; 
                           oammux <= to_integer(unsigned(mem_bus_Adr(10 downto 10)));
                     
                        when x"FF" =>
                           state  <= READBIOS;
                     
                        when others =>
                           state       <= ROTATE;
                           rotate_data <= (others => '1');
                           
                     
                     end case;
                     
                  end if;
                  
               when READITCM =>
                  state        <= ROTATE;
                  rotate_data  <= ITCM_dataout;
                  
               when READLARGERAM =>
                  if (Externram_done = '1') then
                     state        <= ROTATE;
                     rotate_data  <= Externram_din;
                  end if;
                  
               when READWRAMSMALL =>
                  state        <= ROTATE;
                  case (WramSmall_Mux) is
                     when "00" =>
                        if (wramsmallswitch = '1') then
                           rotate_data <= WramSmallHi_dataout;
                        else
                           rotate_data <= WramSmallLo_dataout;
                        end if;
                     when "01" => rotate_data <= WramSmallHi_dataout;
                     when "10" => rotate_data <= WramSmallLo_dataout;
                     when "11" => rotate_data <= (others => '0');
                     when others => null;
                  end case;
                  
               when READPALETTE =>
                  state        <= ROTATE;
                  case (palettemux) is
                     when 0 => rotate_data <= Palette_dataout_bgA;
                     when 1 => rotate_data <= Palette_dataout_objA;
                     when 2 => rotate_data <= Palette_dataout_bgB;
                     when 3 => rotate_data <= Palette_dataout_objB;
                  end case;
                  
               when READVRAM =>
                  if (read_delay = '0') then
                     state        <= ROTATE;
                     if    (VRam_active_A = '1') then rotate_data  <= VRAM_dataout_A;
                     elsif (VRam_active_B = '1') then rotate_data  <= VRAM_dataout_B;
                     elsif (VRam_active_C = '1') then rotate_data  <= VRAM_dataout_C;
                     elsif (VRam_active_D = '1') then rotate_data  <= VRAM_dataout_D;
                     elsif (VRam_active_E = '1') then rotate_data  <= VRAM_dataout_E;
                     elsif (VRam_active_F = '1') then rotate_data  <= VRAM_dataout_F;
                     elsif (VRam_active_G = '1') then rotate_data  <= VRAM_dataout_G;
                     elsif (VRam_active_H = '1') then rotate_data  <= VRAM_dataout_H;
                     elsif (VRam_active_I = '1') then rotate_data  <= VRAM_dataout_I;
                     else  rotate_data <= (others => '0');
                     end if;
                  end if;
                  
               when READOAM =>
                  state        <= ROTATE;
                  case (oammux) is
                     when 0 => rotate_data <= OAMRam_dataout_A;
                     when 1 => rotate_data <= OAMRam_dataout_B;
                  end case;
               
               when READBIOS =>
                  state       <= ROTATE;
                  rotate_data <= BIOS_dataout;
               
               when ROTATE =>
                  state <= IDLE;
                  if (acc_save = ACCESS_8BIT) then
                     case (return_rotate) is
                        when "00" => mem_bus_din <= x"000000" & rotate_data(7 downto 0);
                        when "01" => mem_bus_din <= x"000000" & rotate_data(15 downto 8);
                        when "10" => mem_bus_din <= x"000000" & rotate_data(23 downto 16);
                        when "11" => mem_bus_din <= x"000000" & rotate_data(31 downto 24);
                        when others => null;
                     end case;
                  elsif (acc_save = ACCESS_16BIT) then
                     case (return_rotate) is
                        when "00" => mem_bus_din <= x"0000" & rotate_data(15 downto 0);
                        when "01" => mem_bus_din <= rotate_data(7 downto 0) & x"0000" & rotate_data(15 downto 8);
                        when "10" => mem_bus_din <= x"0000" & rotate_data(31 downto 16);
                        when "11" => mem_bus_din <= rotate_data(23 downto 16) & x"0000" & rotate_data(31 downto 24);
                        when others => null;
                     end case;
                  else
                     case (return_rotate) is
                        when "00" => mem_bus_din <= rotate_data;
                        when "01" => mem_bus_din <= rotate_data(7 downto 0) & rotate_data(31 downto 8);
                        when "10" => mem_bus_din <= rotate_data(15 downto 0) & rotate_data(31 downto 16);
                        when "11" => mem_bus_din <= rotate_data(23 downto 0) & rotate_data(31 downto 24);
                        when others => null;
                     end case;
                  end if;
                  mem_bus_done   <= '1'; 
           
            end case;
            
         end if;
      
      end if;
   end process;
   

end architecture;





