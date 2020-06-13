library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

entity ds_vram_maptexture is
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
      
      vram_ENA_C    : in  std_logic;
      vram_MST_C    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_C : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_C   : out std_logic_vector(16 downto 0);
      vram_req_C    : out std_logic := '0';
      
      vram_ENA_D    : in  std_logic;
      vram_MST_D    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_D : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_addr_D   : out std_logic_vector(16 downto 0);
      vram_req_D    : out std_logic := '0'
   );
end entity;

architecture arch of ds_vram_maptexture is

   signal OFS_A : integer range 0 to 3;
   signal OFS_B : integer range 0 to 3;
   signal OFS_C : integer range 0 to 3;
   signal OFS_D : integer range 0 to 3;
   
   signal START_A : integer range 0 to 16#80000#;
   signal START_B : integer range 0 to 16#80000#;
   signal START_C : integer range 0 to 16#80000#;
   signal START_D : integer range 0 to 16#80000#;
                                          
   signal END_A   : integer range 0 to 16#80000#;
   signal END_B   : integer range 0 to 16#80000#;
   signal END_C   : integer range 0 to 16#80000#;
   signal END_D   : integer range 0 to 16#80000#;

   signal vramaddress_full : std_logic_vector(18 downto 0);
   
begin 

   OFS_A <= to_integer(unsigned(vram_Offset_A));
   OFS_B <= to_integer(unsigned(vram_Offset_B));
   OFS_C <= to_integer(unsigned(vram_Offset_C));
   OFS_D <= to_integer(unsigned(vram_Offset_D));
   
   vramaddress_full <= std_logic_vector(to_unsigned(vramaddress, 19));
   
   process (clk100)
   begin
      if rising_edge(clk100) then
         
         vram_req_A <= '0';
         vram_req_B <= '0';
         vram_req_C <= '0';
         vram_req_D <= '0';
         
         vram_nomap <= '0';
         
         vram_addr_A <= vramaddress_full(16 downto 0);
         vram_addr_B <= vramaddress_full(16 downto 0);
         vram_addr_C <= vramaddress_full(16 downto 0);
         vram_addr_D <= vramaddress_full(16 downto 0);

         START_A <= 16#20000# * OFS_A;
         START_B <= 16#20000# * OFS_B;
         START_C <= 16#20000# * OFS_C;
         START_D <= 16#20000# * OFS_D;
         
         END_A   <= START_A + 16#20000#;
         END_B   <= START_B + 16#20000#;
         END_C   <= START_C + 16#20000#;
         END_D   <= START_D + 16#20000#;

         if    (vram_MST_A =  "11" and vram_ENA_A = '1' and vramaddress >= START_A and vramaddress < END_A) then vram_req_A <= vram_ena;
         elsif (vram_MST_B =  "11" and vram_ENA_B = '1' and vramaddress >= START_B and vramaddress < END_B) then vram_req_B <= vram_ena;
         elsif (vram_MST_C = "011" and vram_ENA_C = '1' and vramaddress >= START_C and vramaddress < END_C) then vram_req_C <= vram_ena;
         elsif (vram_MST_D = "011" and vram_ENA_D = '1' and vramaddress >= START_D and vramaddress < END_D) then vram_req_D <= vram_ena;
         else  vram_nomap <= vram_ena;
         end if;
         
      end if;
   end process;

end architecture;





