library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

entity ds_vram_mapobj is
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
      
      vram_ENA_A    : in  std_logic;
      vram_MST_A    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_Offset_A : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_A   : out std_logic_vector(16 downto 0);
      vram_req_A    : out std_logic := '0';
      
      vram_ENA_B    : in  std_logic;
      vram_MST_B    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_Offset_B : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_B   : out std_logic_vector(16 downto 0);
      vram_req_B    : out std_logic := '0';
      
      vram_ENA_D    : in  std_logic;
      vram_MST_D    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_D : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_D   : out std_logic_vector(16 downto 0);
      vram_req_D    : out std_logic := '0';
      
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
      
      vram_ENA_I    : in  std_logic;
      vram_MST_I    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_I   : out std_logic_vector(13 downto 0);
      vram_req_I    : out std_logic := '0'
   );
end entity;

architecture arch of ds_vram_mapobj is

   signal OFS_A : integer range 0 to 3;
   signal OFS_B : integer range 0 to 3;
   signal OFS_D : integer range 0 to 3;
   signal OFS_F : integer range 0 to 3;
   signal OFS_G : integer range 0 to 3;
   
   signal START_A : integer range 0 to 16#80000#;
   signal START_B : integer range 0 to 16#80000#;
   signal START_D : integer range 0 to 16#80000#;
   signal START_E : integer range 0 to 16#80000#;
   signal START_F : integer range 0 to 16#80000#;
   signal START_G : integer range 0 to 16#80000#;
   signal START_I : integer range 0 to 16#80000#;
                                          
   signal END_A   : integer range 0 to 16#80000#;
   signal END_B   : integer range 0 to 16#80000#;
   signal END_D   : integer range 0 to 16#80000#;
   signal END_E   : integer range 0 to 16#80000#;
   signal END_F   : integer range 0 to 16#80000#;
   signal END_G   : integer range 0 to 16#80000#;
   signal END_I   : integer range 0 to 16#80000#;
   
   signal vramaddress_full : std_logic_vector(18 downto 0);
   
begin 

   OFS_A <= to_integer(unsigned(vram_Offset_A));
   OFS_B <= to_integer(unsigned(vram_Offset_B));
   OFS_D <= to_integer(unsigned(vram_Offset_D));
   OFS_F <= to_integer(unsigned(vram_Offset_F));
   OFS_G <= to_integer(unsigned(vram_Offset_G));
   
   vramaddress_full <= std_logic_vector(to_unsigned(vramaddress, 19));
   
   process (clk100)
   begin
      if rising_edge(clk100) then
         
         vram_req_A <= '0';
         vram_req_B <= '0';
         vram_req_D <= '0';
         vram_req_E <= '0';
         vram_req_F <= '0';
         vram_req_G <= '0';
         vram_req_I <= '0';
         
         vram_nomap <= '0';
         
         vram_addr_A <= vramaddress_full(16 downto 0);
         vram_addr_B <= vramaddress_full(16 downto 0);
         vram_addr_D <= vramaddress_full(16 downto 0);
         vram_addr_E <= vramaddress_full(15 downto 0);
         vram_addr_F <= vramaddress_full(13 downto 0);
         vram_addr_G <= vramaddress_full(13 downto 0);
         vram_addr_I <= vramaddress_full(13 downto 0);

         if (isGPUA = '1') then
         
            START_A <= 16#20000# * OFS_A;
            START_B <= 16#20000# * OFS_B;
            START_E <= 0;
            case OFS_F is
               when 0 => START_F <= 0; 
               when 1 => START_F <= 16#4000#; 
               when 2 => START_F <= 16#10000#;  
               when 3 => START_F <= 16#14000#; 
            end case;
            case OFS_G is
               when 0 => START_G <= 0; 
               when 1 => START_G <= 16#4000#; 
               when 2 => START_G <= 16#10000#;  
               when 3 => START_G <= 16#14000#; 
            end case;
            
            END_A   <= START_A + 16#20000#;
            END_B   <= START_B + 16#20000#;
            END_E   <= START_E + 16#10000#;
            END_F   <= START_F + 16#4000#;
            END_G   <= START_G + 16#4000#;

            if    (vram_MST_A =  "10" and vram_ENA_A = '1' and vramaddress >= START_A and vramaddress < END_A) then vram_req_A <= vram_ena;
            elsif (vram_MST_B =  "10" and vram_ENA_B = '1' and vramaddress >= START_B and vramaddress < END_B) then vram_req_B <= vram_ena;
            elsif (vram_MST_E = "010" and vram_ENA_E = '1' and vramaddress >= START_E and vramaddress < END_E) then vram_req_E <= vram_ena;
            elsif (vram_MST_F = "010" and vram_ENA_F = '1' and vramaddress >= START_F and vramaddress < END_F) then vram_req_F <= vram_ena;
            elsif (vram_MST_G = "010" and vram_ENA_G = '1' and vramaddress >= START_G and vramaddress < END_G) then vram_req_G <= vram_ena;
            else  vram_nomap <= vram_ena;
            end if;
         
         else

            START_D <= 16#20000# * OFS_D;
            START_I <= 0;
            
            END_D   <= START_D + 16#20000#;
            END_I   <= START_I + 16#4000#;
         
            if    (vram_MST_D = "100" and vram_ENA_D = '1' and vramaddress >= START_D and vramaddress < END_D) then vram_req_D <= vram_ena;
            elsif (vram_MST_I =  "10" and vram_ENA_I = '1' and vramaddress >= START_I and vramaddress < END_I) then vram_req_I <= vram_ena;
            else  vram_nomap <= vram_ena;
            end if;
   
         end if;
         
      end if;
   end process;

end architecture;





