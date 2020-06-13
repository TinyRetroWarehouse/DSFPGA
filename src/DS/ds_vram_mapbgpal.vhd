library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

entity ds_vram_mapbgpal is
   generic
   (
      isGPUA        : std_logic
   );
   port 
   (
      clk100        : in  std_logic;  
      
      vramaddress   : in  integer range 0 to 524287;
      vram_ena      : in  std_logic;
      vram_nomap    : out std_logic := '0';
      
      vram_ENA_E    : in  std_logic;
      vram_MST_E    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_addr_E   : out std_logic_vector(15 downto 0);
      vram_req_E    : out std_logic := '0';
      
      vram_ENA_F    : in  std_logic;
      vram_MST_F    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_F : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_F   : out std_logic_vector(13 downto 0);
      vram_req_F    : out std_logic := '0';
      
      vram_ENA_G    : in  std_logic;
      vram_MST_G    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_G : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_G   : out std_logic_vector(13 downto 0);
      vram_req_G    : out std_logic := '0';
      
      vram_ENA_H    : in  std_logic;
      vram_MST_H    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_H   : out std_logic_vector(14 downto 0);
      vram_req_H    : out std_logic := '0'
   );
end entity;

architecture arch of ds_vram_mapbgpal is

   signal OFS_F : integer range 0 to 3;
   signal OFS_G : integer range 0 to 3;
   
   signal START_E : integer range 0 to 16#80000#;
   signal START_F : integer range 0 to 16#80000#;
   signal START_G : integer range 0 to 16#80000#;
   signal START_H : integer range 0 to 16#80000#;
                                          
   signal END_E   : integer range 0 to 16#80000#;
   signal END_F   : integer range 0 to 16#80000#;
   signal END_G   : integer range 0 to 16#80000#;
   signal END_H   : integer range 0 to 16#80000#;
   
   signal vramaddress_full : std_logic_vector(18 downto 0);
   
begin 

   OFS_F <= to_integer(unsigned(vram_Offset_F));
   OFS_G <= to_integer(unsigned(vram_Offset_G));
   
   vramaddress_full <= std_logic_vector(to_unsigned(vramaddress, 19));
   
   process (clk100)
   begin
      if rising_edge(clk100) then
         
         vram_req_E <= '0';
         vram_req_F <= '0';
         vram_req_G <= '0';
         vram_req_H <= '0';
         
         vram_nomap <= '0';
         
         vram_addr_E <= vramaddress_full(15 downto 0);
         vram_addr_F <= vramaddress_full(13 downto 0);
         vram_addr_G <= vramaddress_full(13 downto 0);
         vram_addr_H <= vramaddress_full(14 downto 0);

         if (isGPUA = '1') then
         
            START_E <= 0;
            START_F <= 0;
            if (OFS_F = 1) then
               START_F <= 16#4000#;
            end if;
            
            START_G <= 0;
            if (OFS_G = 1) then
               START_G <= 16#4000#;
            end if;

            END_E   <= START_E + 16#10000#;
            END_F   <= START_F + 16#4000#;
            END_G   <= START_G + 16#4000#;

            if    (vram_MST_E = "100" and vram_ENA_E = '1' and vramaddress >= START_E and vramaddress < END_E) then vram_req_E <= vram_ena;
            elsif (vram_MST_F = "100" and vram_ENA_F = '1' and vramaddress >= START_F and vramaddress < END_F) then vram_req_F <= vram_ena;
            elsif (vram_MST_G = "100" and vram_ENA_G = '1' and vramaddress >= START_G and vramaddress < END_G) then vram_req_G <= vram_ena;
            else  vram_nomap <= vram_ena;
            end if;
         
         else

            START_H <= 0;
            
            END_H   <= START_H + 16#8000#;
         
            if   (vram_MST_H =  "10" and vram_ENA_H = '1' and vramaddress >= START_H and vramaddress < END_H) then vram_req_H <= vram_ena;
            else  vram_nomap <= vram_ena;
            end if;
   
         end if;
         
      end if;
   end process;

end architecture;





