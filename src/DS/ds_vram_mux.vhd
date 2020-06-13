library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

entity ds_vram_mux is
   generic
   (
      isGPUA        : std_logic
   );
   port 
   (
      clk100        : in  std_logic;
      directmode    : in  std_logic;
      
      vramaddress_0 : in  integer range 0 to 524287;
      vramaddress_1 : in  integer range 0 to 524287;
      vramaddress_2 : in  integer range 0 to 524287;
      vramaddress_3 : in  integer range 0 to 524287;
      vramaddress_S : in  integer range 0 to 524287;
      vram_req_0    : in  std_logic;
      vram_req_1    : in  std_logic;
      vram_req_2    : in  std_logic;
      vram_req_3    : in  std_logic;
      vram_req_S    : in  std_logic;
      vram_data_0   : out std_logic_vector(31 downto 0);
      vram_data_1   : out std_logic_vector(31 downto 0);
      vram_data_2   : out std_logic_vector(31 downto 0);
      vram_data_3   : out std_logic_vector(31 downto 0);
      vram_data_S   : out std_logic_vector(31 downto 0);
      vram_valid_0  : out std_logic;
      vram_valid_1  : out std_logic;
      vram_valid_2  : out std_logic;
      vram_valid_3  : out std_logic;
      vram_valid_S  : out std_logic;
      
      pal_address_0 : in  integer range 0 to 524287;
      pal_address_1 : in  integer range 0 to 524287;
      pal_address_2 : in  integer range 0 to 524287;
      pal_address_3 : in  integer range 0 to 524287;
      pal_address_S : in  integer range 0 to 524287;
      pal_req_0     : in  std_logic;
      pal_req_1     : in  std_logic;
      pal_req_2     : in  std_logic;
      pal_req_3     : in  std_logic;
      pal_req_S     : in  std_logic;
      pal_data_0    : out std_logic_vector(31 downto 0);
      pal_data_1    : out std_logic_vector(31 downto 0);
      pal_data_2    : out std_logic_vector(31 downto 0);
      pal_data_3    : out std_logic_vector(31 downto 0);
      pal_data_S    : out std_logic_vector(31 downto 0);
      pal_valid_0   : out std_logic;
      pal_valid_1   : out std_logic;
      pal_valid_2   : out std_logic;
      pal_valid_3   : out std_logic;
      pal_valid_S   : out std_logic;
      
      vramaddress3D : in  integer range 0 to 524287;
      vram_req3D    : in  std_logic;
      vram_data3D   : out std_logic_vector(31 downto 0);
      vram_valid3D  : out std_logic;
      
      vram_ENA_A    : in  std_logic;
      vram_MST_A    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_Offset_A : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_A    : out std_logic;
      vram_addr_A   : out std_logic_vector(16 downto 0);
      vram_data_A   : in  std_logic_vector(31 downto 0);
      vram_valid_A  : in  std_logic;
      
      vram_ENA_B    : in  std_logic;
      vram_MST_B    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_Offset_B : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_B    : out std_logic;
      vram_addr_B   : out std_logic_vector(16 downto 0);
      vram_data_B   : in  std_logic_vector(31 downto 0);
      vram_valid_B  : in  std_logic;
      
      vram_ENA_C    : in  std_logic;
      vram_MST_C    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_C : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_C    : out std_logic;
      vram_addr_C   : out std_logic_vector(16 downto 0);
      vram_data_C   : in  std_logic_vector(31 downto 0);
      vram_valid_C  : in  std_logic;
      
      vram_ENA_D    : in  std_logic;
      vram_MST_D    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_D : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_D    : out std_logic;
      vram_addr_D   : out std_logic_vector(16 downto 0);
      vram_data_D   : in  std_logic_vector(31 downto 0);
      vram_valid_D  : in  std_logic;
      
      vram_ENA_E    : in  std_logic;
      vram_MST_E    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_req_E    : out std_logic;
      vram_addr_E   : out std_logic_vector(15 downto 0);
      vram_data_E   : in  std_logic_vector(31 downto 0);
      vram_valid_E  : in  std_logic;
      
      vram_ENA_F    : in  std_logic;
      vram_MST_F    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_F : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_F    : out std_logic;
      vram_addr_F   : out std_logic_vector(13 downto 0);
      vram_data_F   : in  std_logic_vector(31 downto 0);
      vram_valid_F  : in  std_logic;
      
      vram_ENA_G    : in  std_logic;
      vram_MST_G    : in  std_logic_vector(2 downto 0) := (others => '0');
      vram_Offset_G : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_G    : out std_logic;
      vram_addr_G   : out std_logic_vector(13 downto 0);
      vram_data_G   : in  std_logic_vector(31 downto 0);
      vram_valid_G  : in  std_logic;
      
      vram_ENA_H    : in  std_logic;
      vram_MST_H    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_H    : out std_logic;
      vram_addr_H   : out std_logic_vector(14 downto 0);
      vram_data_H   : in  std_logic_vector(31 downto 0);
      vram_valid_H  : in  std_logic;
      
      vram_ENA_I    : in  std_logic;
      vram_MST_I    : in  std_logic_vector(1 downto 0) := (others => '0');
      vram_req_I    : out std_logic;
      vram_addr_I   : out std_logic_vector(13 downto 0);
      vram_data_I   : in  std_logic_vector(31 downto 0);
      vram_valid_I  : in  std_logic
   );
end entity;

architecture arch of ds_vram_mux is

   -- adress mapping
   type t_address_17 is array(0 to 9) of std_logic_vector(16 downto 0);
   type t_address_16 is array(0 to 9) of std_logic_vector(15 downto 0);
   type t_address_15 is array(0 to 9) of std_logic_vector(14 downto 0);
   type t_address_14 is array(0 to 9) of std_logic_vector(13 downto 0);
   
   signal addresses_A : t_address_17;
   signal addresses_B : t_address_17;
   signal addresses_C : t_address_17;
   signal addresses_D : t_address_17;
   signal addresses_E : t_address_16;
   signal addresses_F : t_address_14;
   signal addresses_G : t_address_14;
   signal addresses_H : t_address_15;
   signal addresses_I : t_address_14;
   
   signal enables_A : std_logic_vector(0 to 9);
   signal enables_B : std_logic_vector(0 to 9);
   signal enables_C : std_logic_vector(0 to 9);
   signal enables_D : std_logic_vector(0 to 9);
   signal enables_E : std_logic_vector(0 to 9);
   signal enables_F : std_logic_vector(0 to 9);
   signal enables_G : std_logic_vector(0 to 9);
   signal enables_H : std_logic_vector(0 to 9);
   signal enables_I : std_logic_vector(0 to 9);
   
   signal valid_A   : std_logic_vector(0 to 9);
   signal valid_B   : std_logic_vector(0 to 9);
   signal valid_C   : std_logic_vector(0 to 9);
   signal valid_D   : std_logic_vector(0 to 9);
   signal valid_E   : std_logic_vector(0 to 9);
   signal valid_F   : std_logic_vector(0 to 9);
   signal valid_G   : std_logic_vector(0 to 9);
   signal valid_H   : std_logic_vector(0 to 9);
   signal valid_I   : std_logic_vector(0 to 9);
   
   type t_data is array(0 to 9) of std_logic_vector(31 downto 0);
   signal dataall_A : t_data;
   signal dataall_B : t_data;
   signal dataall_C : t_data;
   signal dataall_D : t_data;
   signal dataall_E : t_data;
   signal dataall_F : t_data;
   signal dataall_G : t_data;
   signal dataall_H : t_data;
   signal dataall_I : t_data;
   
   signal nomap   : std_logic_vector(0 to 9);
   
   -- direct muxing for sprites ext palette
   signal vram_req_F_arbiter   : std_logic;
   signal vram_addr_F_arbiter  : std_logic_vector(13 downto 0);
   signal vram_req_G_arbiter   : std_logic;
   signal vram_addr_G_arbiter  : std_logic_vector(13 downto 0);
   signal vram_req_I_arbiter   : std_logic;
   signal vram_addr_I_arbiter  : std_logic_vector(13 downto 0);

begin 

   ids_vram_mapbg_0 : entity work.ds_vram_mapbg generic map(isGPUA)
   port map
   (
      clk100        => clk100,
      directmode    => directmode,
      
      vramaddress   => vramaddress_0,
      vram_ena      => vram_req_0,
      vram_nomap    => nomap(0),
                  
      vram_ENA_A    => vram_ENA_A,
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(0),
      vram_req_A    => enables_A(0),
           
      vram_ENA_B    => vram_ENA_B,
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(0),  
      vram_req_B    => enables_B(0),   
                 
      vram_ENA_C    => vram_ENA_C,                 
      vram_MST_C    => vram_MST_C,   
      vram_Offset_C => vram_Offset_C,
      vram_addr_C   => addresses_C(0),  
      vram_req_C    => enables_C(0),   
                   
      vram_ENA_D    => vram_ENA_D,             
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(0),  
      vram_req_D    => enables_D(0),   
            
      vram_ENA_E    => vram_ENA_E,      
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(0),  
      vram_req_E    => enables_E(0),   
             
      vram_ENA_F    => vram_ENA_F,             
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(0),  
      vram_req_F    => enables_F(0),   
                 
      vram_ENA_G    => vram_ENA_G,                 
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(0),  
      vram_req_G    => enables_G(0),   
              
      vram_ENA_H    => vram_ENA_H,               
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(0),  
      vram_req_H    => enables_H(0),   
                
      vram_ENA_I    => vram_ENA_I,                
      vram_MST_I    => vram_MST_I,   
      vram_addr_I   => addresses_I(0),  
      vram_req_I    => enables_I(0)   
   );

   ids_vram_mapbg_1 : entity work.ds_vram_mapbg generic map(isGPUA)
   port map
   (
      clk100        => clk100,
      directmode    => '0',
      
      vramaddress   => vramaddress_1,
      vram_ena      => vram_req_1,
      vram_nomap    => nomap(1),
            
      vram_ENA_A    => vram_ENA_A,            
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(1),
      vram_req_A    => enables_A(1),
        
      vram_ENA_B    => vram_ENA_B,
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(1),  
      vram_req_B    => enables_B(1),   
                   
      vram_ENA_C    => vram_ENA_C, 
      vram_MST_C    => vram_MST_C,   
      vram_Offset_C => vram_Offset_C,
      vram_addr_C   => addresses_C(1),  
      vram_req_C    => enables_C(1),   
                      
      vram_ENA_D    => vram_ENA_D,                
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(1),  
      vram_req_D    => enables_D(1),   
                            
      vram_ENA_E    => vram_ENA_E,                          
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(1),  
      vram_req_E    => enables_E(1),   
              
      vram_ENA_F    => vram_ENA_F,              
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(1),  
      vram_req_F    => enables_F(1),   
                
      vram_ENA_G    => vram_ENA_G,                 
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(1),  
      vram_req_G    => enables_G(1),   
               
      vram_ENA_H    => vram_ENA_H,                
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(1),  
      vram_req_H    => enables_H(1),   
               
      vram_ENA_I    => vram_ENA_I,               
      vram_MST_I    => vram_MST_I,   
      vram_addr_I   => addresses_I(1),  
      vram_req_I    => enables_I(1)   
   );
   
   ids_vram_mapbg_2 : entity work.ds_vram_mapbg generic map(isGPUA)
   port map
   (
      clk100        => clk100,
      directmode    => '0',
      
      vramaddress   => vramaddress_2,
      vram_ena      => vram_req_2,
      vram_nomap    => nomap(2),
                  
      vram_ENA_A    => vram_ENA_A,
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(2),
      vram_req_A    => enables_A(2),
                            
      vram_ENA_B    => vram_ENA_B,                      
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(2),  
      vram_req_B    => enables_B(2),   
                
      vram_ENA_C    => vram_ENA_C, 
      vram_MST_C    => vram_MST_C,   
      vram_Offset_C => vram_Offset_C,
      vram_addr_C   => addresses_C(2),  
      vram_req_C    => enables_C(2),   
       
      vram_ENA_D    => vram_ENA_D,       
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(2),  
      vram_req_D    => enables_D(2),   
         
      vram_ENA_E    => vram_ENA_E,         
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(2),  
      vram_req_E    => enables_E(2),   
              
      vram_ENA_F    => vram_ENA_F,              
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(2),  
      vram_req_F    => enables_F(2),   
               
      vram_ENA_G    => vram_ENA_G,                
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(2),  
      vram_req_G    => enables_G(2),   
               
      vram_ENA_H    => vram_ENA_H,                
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(2),  
      vram_req_H    => enables_H(2),   
                              
      vram_ENA_I    => vram_ENA_I,
      vram_MST_I    => vram_MST_I,   
      vram_addr_I   => addresses_I(2),  
      vram_req_I    => enables_I(2)   
   );
   
   ids_vram_mapbg_3 : entity work.ds_vram_mapbg generic map(isGPUA)
   port map
   (
      clk100        => clk100,
      directmode    => '0',
      
      vramaddress   => vramaddress_3,
      vram_ena      => vram_req_3,
      vram_nomap    => nomap(3),
            
      vram_ENA_A    => vram_ENA_A,            
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(3),
      vram_req_A    => enables_A(3),
            
      vram_ENA_B    => vram_ENA_B,            
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(3),  
      vram_req_B    => enables_B(3),   
               
      vram_ENA_C    => vram_ENA_C,          
      vram_MST_C    => vram_MST_C,   
      vram_Offset_C => vram_Offset_C,
      vram_addr_C   => addresses_C(3),  
      vram_req_C    => enables_C(3),   
      
      vram_ENA_D    => vram_ENA_D,
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(3),  
      vram_req_D    => enables_D(3),   
            
      vram_ENA_E    => vram_ENA_E,            
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(3),  
      vram_req_E    => enables_E(3),   
             
      vram_ENA_F    => vram_ENA_F,             
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(3),  
      vram_req_F    => enables_F(3),   
                   
      vram_ENA_G    => vram_ENA_G,                    
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(3),  
      vram_req_G    => enables_G(3),   
           
      vram_ENA_H    => vram_ENA_H,            
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(3),  
      vram_req_H    => enables_H(3),   
                            
      vram_ENA_I    => vram_ENA_I,                            
      vram_MST_I    => vram_MST_I,   
      vram_addr_I   => addresses_I(3),  
      vram_req_I    => enables_I(3)   
   );
   
   ids_vram_mapbg_S : entity work.ds_vram_mapobj generic map(isGPUA)
   port map
   (
      clk100        => clk100,
            
      vramaddress   => vramaddress_S,
      vram_ena      => vram_req_S,
      vram_nomap    => nomap(4),
              
      vram_ENA_A    => vram_ENA_A,              
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(4),
      vram_req_A    => enables_A(4),
                            
      vram_ENA_B    => vram_ENA_B,
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(4),  
      vram_req_B    => enables_B(4),   

      vram_ENA_D    => vram_ENA_D, 
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(4),  
      vram_req_D    => enables_D(4),   
              
      vram_ENA_E    => vram_ENA_E,              
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(4),  
      vram_req_E    => enables_E(4),   
            
      vram_ENA_F    => vram_ENA_F,            
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(4),  
      vram_req_F    => enables_F(4),   
                  
      vram_ENA_G    => vram_ENA_G,                   
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(4),  
      vram_req_G    => enables_G(4),    
                              
      vram_ENA_I    => vram_ENA_I, 
      vram_MST_I    => vram_MST_I,   
      vram_addr_I   => addresses_I(4),  
      vram_req_I    => enables_I(4)   
   );

   ids_vram_mapbgpal_0 : entity work.ds_vram_mapbgpal generic map(isGPUA)
   port map
   (
      clk100        => clk100,
            
      vramaddress   => pal_address_0,
      vram_ena      => pal_req_0,
      vram_nomap    => nomap(5),
              
      vram_ENA_E    => vram_ENA_E,              
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(5),  
      vram_req_E    => enables_E(5),   
            
      vram_ENA_F    => vram_ENA_F,            
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(5),  
      vram_req_F    => enables_F(5),   
                  
      vram_ENA_G    => vram_ENA_G,                   
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(5),  
      vram_req_G    => enables_G(5),    
                              
      vram_ENA_H    => vram_ENA_H,            
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(5),  
      vram_req_H    => enables_H(5)
   );
   
   ids_vram_mapbgpal_1 : entity work.ds_vram_mapbgpal generic map(isGPUA)
   port map
   (
      clk100        => clk100,
            
      vramaddress   => pal_address_1,
      vram_ena      => pal_req_1,
      vram_nomap    => nomap(6),
              
      vram_ENA_E    => vram_ENA_E,              
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(6),  
      vram_req_E    => enables_E(6),   
            
      vram_ENA_F    => vram_ENA_F,            
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(6),  
      vram_req_F    => enables_F(6),   
                  
      vram_ENA_G    => vram_ENA_G,                   
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(6),  
      vram_req_G    => enables_G(6),    
                              
      vram_ENA_H    => vram_ENA_H,            
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(6),  
      vram_req_H    => enables_H(6)
   );
   
   ids_vram_mapbgpal_2 : entity work.ds_vram_mapbgpal generic map(isGPUA)
   port map
   (
      clk100        => clk100,
            
      vramaddress   => pal_address_2,
      vram_ena      => pal_req_2,
      vram_nomap    => nomap(7),
              
      vram_ENA_E    => vram_ENA_E,              
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(7),  
      vram_req_E    => enables_E(7),   
            
      vram_ENA_F    => vram_ENA_F,            
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(7),  
      vram_req_F    => enables_F(7),   
                  
      vram_ENA_G    => vram_ENA_G,                   
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(7),  
      vram_req_G    => enables_G(7),    
                              
      vram_ENA_H    => vram_ENA_H,            
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(7),  
      vram_req_H    => enables_H(7)
   );
   
   ids_vram_mapbgpal_3 : entity work.ds_vram_mapbgpal generic map(isGPUA)
   port map
   (
      clk100        => clk100,
            
      vramaddress   => pal_address_3,
      vram_ena      => pal_req_3,
      vram_nomap    => nomap(8),
              
      vram_ENA_E    => vram_ENA_E,              
      vram_MST_E    => vram_MST_E,  
      vram_addr_E   => addresses_E(8),  
      vram_req_E    => enables_E(8),   
            
      vram_ENA_F    => vram_ENA_F,            
      vram_MST_F    => vram_MST_F,   
      vram_Offset_F => vram_Offset_F,
      vram_addr_F   => addresses_F(8),  
      vram_req_F    => enables_F(8),   
                  
      vram_ENA_G    => vram_ENA_G,                   
      vram_MST_G    => vram_MST_G,   
      vram_Offset_G => vram_Offset_G,
      vram_addr_G   => addresses_G(8),  
      vram_req_G    => enables_G(8),    
                              
      vram_ENA_H    => vram_ENA_H,            
      vram_MST_H    => vram_MST_H,   
      vram_addr_H   => addresses_H(8),  
      vram_req_H    => enables_H(8)
   );
   
   ids_vram_maptexture : entity work.ds_vram_maptexture
   port map
   (
      clk100        => clk100,
                     
      vramaddress   => vramaddress3D,
      vram_ena      => vram_req3D,
      vram_nomap    => nomap(9),
                     
      vram_ENA_A    => vram_ENA_A,
      vram_MST_A    => vram_MST_A,   
      vram_Offset_A => vram_Offset_A,
      vram_addr_A   => addresses_A(9),
      vram_req_A    => enables_A(9),
                       
      vram_ENA_B    => vram_ENA_B,
      vram_MST_B    => vram_MST_B,   
      vram_Offset_B => vram_Offset_B,
      vram_addr_B   => addresses_B(9),
      vram_req_B    => enables_B(9),  
                       
      vram_ENA_C    => vram_ENA_C,    
      vram_MST_C    => vram_MST_C,   
      vram_Offset_C => vram_Offset_C,
      vram_addr_C   => addresses_C(9),
      vram_req_C    => enables_C(9),  
                       
      vram_ENA_D    => vram_ENA_D,    
      vram_MST_D    => vram_MST_D,   
      vram_Offset_D => vram_Offset_D,
      vram_addr_D   => addresses_D(9),
      vram_req_D    => enables_D(9)  
   );
   
   ids_memory_arbiter_A : entity work.ds_memory_arbiter generic map (ports => 6, addrbits => 17)
   port map
   (
      clk100        => clk100,
      
      request(0)    => enables_A(0),
      request(1)    => enables_A(1),
      request(2)    => enables_A(2),
      request(3)    => enables_A(3),
      request(4)    => enables_A(4),
      request(5)    => enables_A(9),
      valid(0)      => valid_A(0),
      valid(1)      => valid_A(1),
      valid(2)      => valid_A(2),
      valid(3)      => valid_A(3),
      valid(4)      => valid_A(4),
      valid(5)      => valid_A(9),
    
      addr_in_0     => addresses_A(0),
      addr_in_1     => addresses_A(1),
      addr_in_2     => addresses_A(2),
      addr_in_3     => addresses_A(3),
      addr_in_4     => addresses_A(4),
      addr_in_5     => addresses_A(9),
      data_out_0    => dataall_A(0),
      data_out_1    => dataall_A(1),
      data_out_2    => dataall_A(2),
      data_out_3    => dataall_A(3),
      data_out_4    => dataall_A(4),
      data_out_5    => dataall_A(9),
        
      addr_out      => vram_addr_A,
      read_ena      => vram_req_A,
      data_rec      => vram_data_A, 
      data_valid    => vram_valid_A
   );
   
   ids_memory_arbiter_B : entity work.ds_memory_arbiter generic map (ports => 6, addrbits => 17)
   port map
   (
      clk100        => clk100,
      
      request(0)    => enables_B(0),
      request(1)    => enables_B(1),
      request(2)    => enables_B(2),
      request(3)    => enables_B(3),
      request(4)    => enables_B(4),
      request(5)    => enables_B(9),
      valid(0)      => valid_B(0),
      valid(1)      => valid_B(1),
      valid(2)      => valid_B(2),
      valid(3)      => valid_B(3),
      valid(4)      => valid_B(4),
      valid(5)      => valid_B(9),
    
      addr_in_0     => addresses_B(0),
      addr_in_1     => addresses_B(1),
      addr_in_2     => addresses_B(2),
      addr_in_3     => addresses_B(3),
      addr_in_4     => addresses_B(4),
      data_out_0    => dataall_B(0),
      data_out_1    => dataall_B(1),
      data_out_2    => dataall_B(2),
      data_out_3    => dataall_B(3),
      data_out_4    => dataall_B(4),
        
      addr_out      => vram_addr_B,
      read_ena      => vram_req_B,
      data_rec      => vram_data_B, 
      data_valid    => vram_valid_B
   );
   
   ids_memory_arbiter_C : entity work.ds_memory_Arbiter generic map (ports => 5, addrbits => 17)
   port map
   (
      clk100        => clk100,
      
      request(0)    => enables_C(0),
      request(1)    => enables_C(1),
      request(2)    => enables_C(2),
      request(3)    => enables_C(3),
      request(4)    => enables_C(9),
      valid(0)      => valid_C(0),
      valid(1)      => valid_C(1),
      valid(2)      => valid_C(2),
      valid(3)      => valid_C(3),
      valid(4)      => valid_C(9),
    
      addr_in_0     => addresses_C(0),
      addr_in_1     => addresses_C(1),
      addr_in_2     => addresses_C(2),
      addr_in_3     => addresses_C(3),
      addr_in_4     => addresses_C(9),
      data_out_0    => dataall_C(0),
      data_out_1    => dataall_C(1),
      data_out_2    => dataall_C(2),
      data_out_3    => dataall_C(3),
      data_out_4    => dataall_C(9),
        
      addr_out      => vram_addr_C,
      read_ena      => vram_req_C,
      data_rec      => vram_data_C, 
      data_valid    => vram_valid_C
   );
   
   ids_memory_arbiter_D : entity work.ds_memory_arbiter generic map (ports => 6, addrbits => 17)
   port map
   (
      clk100        => clk100,
      
      request(0)    => enables_D(0),
      request(1)    => enables_D(1),
      request(2)    => enables_D(2),
      request(3)    => enables_D(3),
      request(4)    => enables_D(4),
      request(5)    => enables_D(9),
      valid(0)      => valid_D(0),
      valid(1)      => valid_D(1),
      valid(2)      => valid_D(2),
      valid(3)      => valid_D(3),
      valid(4)      => valid_D(4),
      valid(5)      => valid_D(9),
    
      addr_in_0     => addresses_D(0),
      addr_in_1     => addresses_D(1),
      addr_in_2     => addresses_D(2),
      addr_in_3     => addresses_D(3),
      addr_in_4     => addresses_D(4),
      addr_in_5     => addresses_D(9),
      data_out_0    => dataall_D(0),
      data_out_1    => dataall_D(1),
      data_out_2    => dataall_D(2),
      data_out_3    => dataall_D(3),
      data_out_4    => dataall_D(4),
      data_out_5    => dataall_D(9),
        
      addr_out      => vram_addr_D,
      read_ena      => vram_req_D,
      data_rec      => vram_data_D, 
      data_valid    => vram_valid_D
   );
   
   ids_memory_arbiter_E : entity work.ds_memory_arbiter generic map (ports => 9, addrbits => 16)
   port map
   (
      clk100        => clk100,
      
      request       => enables_E(0 to 8),
      valid         => valid_E(0 to 8),
    
      addr_in_0     => addresses_E(0),
      addr_in_1     => addresses_E(1),
      addr_in_2     => addresses_E(2),
      addr_in_3     => addresses_E(3),
      addr_in_4     => addresses_E(4),
      addr_in_5     => addresses_E(5),
      addr_in_6     => addresses_E(6),
      addr_in_7     => addresses_E(7),
      addr_in_8     => addresses_E(8),
      data_out_0    => dataall_E(0),
      data_out_1    => dataall_E(1),
      data_out_2    => dataall_E(2),
      data_out_3    => dataall_E(3),
      data_out_4    => dataall_E(4),
      data_out_5    => dataall_E(5),
      data_out_6    => dataall_E(6),
      data_out_7    => dataall_E(7),
      data_out_8    => dataall_E(8),
        
      addr_out      => vram_addr_E,
      read_ena      => vram_req_E,
      data_rec      => vram_data_E, 
      data_valid    => vram_valid_E
   );
   
   ids_memory_arbiter_F : entity work.ds_memory_arbiter generic map (ports => 9, addrbits => 14)
   port map
   (
      clk100        => clk100,
      
      request       => enables_F(0 to 8),
      valid         => valid_F(0 to 8),
    
      addr_in_0     => addresses_F(0),
      addr_in_1     => addresses_F(1),
      addr_in_2     => addresses_F(2),
      addr_in_3     => addresses_F(3),
      addr_in_4     => addresses_F(4),
      addr_in_5     => addresses_F(5),
      addr_in_6     => addresses_F(6),
      addr_in_7     => addresses_F(7),
      addr_in_8     => addresses_F(8),
      data_out_0    => dataall_F(0),
      data_out_1    => dataall_F(1),
      data_out_2    => dataall_F(2),
      data_out_3    => dataall_F(3),
      data_out_4    => dataall_F(4),
      data_out_5    => dataall_F(5),
      data_out_6    => dataall_F(6),
      data_out_7    => dataall_F(7),
      data_out_8    => dataall_F(8),
        
      addr_out      => vram_addr_F_arbiter,
      read_ena      => vram_req_F_arbiter,
      data_rec      => vram_data_F, 
      data_valid    => vram_valid_F
   );
   
   ids_memory_arbiter_G : entity work.ds_memory_arbiter generic map (ports => 9, addrbits => 14)
   port map
   (
      clk100        => clk100,
      
      request       => enables_G(0 to 8),
      valid         => valid_G(0 to 8),
    
      addr_in_0     => addresses_G(0),
      addr_in_1     => addresses_G(1),
      addr_in_2     => addresses_G(2),
      addr_in_3     => addresses_G(3),
      addr_in_4     => addresses_G(4),
      addr_in_5     => addresses_G(5),
      addr_in_6     => addresses_G(6),
      addr_in_7     => addresses_G(7),
      addr_in_8     => addresses_G(8),
      data_out_0    => dataall_G(0),
      data_out_1    => dataall_G(1),
      data_out_2    => dataall_G(2),
      data_out_3    => dataall_G(3),
      data_out_4    => dataall_G(4),
      data_out_5    => dataall_G(5),
      data_out_6    => dataall_G(6),
      data_out_7    => dataall_G(7),
      data_out_8    => dataall_G(8),
        
      addr_out      => vram_addr_G_arbiter,
      read_ena      => vram_req_G_arbiter,
      data_rec      => vram_data_G, 
      data_valid    => vram_valid_G
   );
   
   ids_memory_arbiter_H : entity work.ds_memory_arbiter generic map (ports => 8, addrbits => 15)
   port map
   (
      clk100        => clk100,
      
      request(0)    => enables_H(0),
      request(1)    => enables_H(1),
      request(2)    => enables_H(2),
      request(3)    => enables_H(3),
      request(4)    => enables_H(5),
      request(5)    => enables_H(6),
      request(6)    => enables_H(7),
      request(7)    => enables_H(8),
      valid(0)      => valid_H(0),
      valid(1)      => valid_H(1),
      valid(2)      => valid_H(2),
      valid(3)      => valid_H(3),
      valid(4)      => valid_H(5),
      valid(5)      => valid_H(6),
      valid(6)      => valid_H(7),
      valid(7)      => valid_H(8),
      
      addr_in_0     => addresses_H(0),
      addr_in_1     => addresses_H(1),
      addr_in_2     => addresses_H(2),
      addr_in_3     => addresses_H(3),
      addr_in_4     => addresses_H(5),
      addr_in_5     => addresses_H(6),
      addr_in_6     => addresses_H(7),
      addr_in_7     => addresses_H(8),
      data_out_0    => dataall_H(0),
      data_out_1    => dataall_H(1),
      data_out_2    => dataall_H(2),
      data_out_3    => dataall_H(3),
      data_out_4    => dataall_H(5),
      data_out_5    => dataall_H(6),
      data_out_6    => dataall_H(7),
      data_out_7    => dataall_H(8),
      
      addr_out      => vram_addr_H,
      read_ena      => vram_req_H,
      data_rec      => vram_data_H, 
      data_valid    => vram_valid_H
   );
   
   ids_memory_arbiter_I : entity work.ds_memory_arbiter generic map (ports => 5, addrbits => 14)
   port map
   (
      clk100        => clk100,
      
      request       => enables_I(0 to 4),
      valid         => valid_I(0 to 4),
    
      addr_in_0     => addresses_I(0),
      addr_in_1     => addresses_I(1),
      addr_in_2     => addresses_I(2),
      addr_in_3     => addresses_I(3),
      addr_in_4     => addresses_I(4),
      data_out_0    => dataall_I(0),
      data_out_1    => dataall_I(1),
      data_out_2    => dataall_I(2),
      data_out_3    => dataall_I(3),
      data_out_4    => dataall_I(4),
        
      addr_out      => vram_addr_I_arbiter,
      read_ena      => vram_req_I_arbiter,
      data_rec      => vram_data_I, 
      data_valid    => vram_valid_I
   );
   
   process (clk100)
   begin
      if rising_edge(clk100) then
   
         vram_valid_0 <= '0';
         vram_valid_1 <= '0';
         vram_valid_2 <= '0';
         vram_valid_3 <= '0';
         vram_valid_S <= '0';
         pal_valid_0  <= '0';
         pal_valid_1  <= '0';
         pal_valid_2  <= '0';
         pal_valid_3  <= '0';
         vram_valid3D <= '0';
      
         if    (valid_A(0) = '1') then vram_data_0 <= dataall_A(0); vram_valid_0 <= '1';
         elsif (valid_B(0) = '1') then vram_data_0 <= dataall_B(0); vram_valid_0 <= '1';
         elsif (valid_C(0) = '1') then vram_data_0 <= dataall_C(0); vram_valid_0 <= '1';
         elsif (valid_D(0) = '1') then vram_data_0 <= dataall_D(0); vram_valid_0 <= '1';
         elsif (valid_E(0) = '1') then vram_data_0 <= dataall_E(0); vram_valid_0 <= '1';
         elsif (valid_F(0) = '1') then vram_data_0 <= dataall_F(0); vram_valid_0 <= '1';
         elsif (valid_G(0) = '1') then vram_data_0 <= dataall_G(0); vram_valid_0 <= '1';
         elsif (valid_H(0) = '1') then vram_data_0 <= dataall_H(0); vram_valid_0 <= '1';
         elsif (valid_I(0) = '1') then vram_data_0 <= dataall_I(0); vram_valid_0 <= '1';
         elsif (nomap(0)   = '1') then vram_data_0 <= (others => '0'); vram_valid_0 <= '1';
         end if;
         
         if    (valid_A(1) = '1') then vram_data_1 <= dataall_A(1); vram_valid_1 <= '1';
         elsif (valid_B(1) = '1') then vram_data_1 <= dataall_B(1); vram_valid_1 <= '1';
         elsif (valid_C(1) = '1') then vram_data_1 <= dataall_C(1); vram_valid_1 <= '1';
         elsif (valid_D(1) = '1') then vram_data_1 <= dataall_D(1); vram_valid_1 <= '1';
         elsif (valid_E(1) = '1') then vram_data_1 <= dataall_E(1); vram_valid_1 <= '1';
         elsif (valid_F(1) = '1') then vram_data_1 <= dataall_F(1); vram_valid_1 <= '1';
         elsif (valid_G(1) = '1') then vram_data_1 <= dataall_G(1); vram_valid_1 <= '1';
         elsif (valid_H(1) = '1') then vram_data_1 <= dataall_H(1); vram_valid_1 <= '1';
         elsif (valid_I(1) = '1') then vram_data_1 <= dataall_I(1); vram_valid_1 <= '1';
         elsif (nomap(1)   = '1') then vram_data_1 <= (others => '0'); vram_valid_1 <= '1';
         end if;
         
         if    (valid_A(2) = '1') then vram_data_2 <= dataall_A(2); vram_valid_2 <= '1';
         elsif (valid_B(2) = '1') then vram_data_2 <= dataall_B(2); vram_valid_2 <= '1';
         elsif (valid_C(2) = '1') then vram_data_2 <= dataall_C(2); vram_valid_2 <= '1';
         elsif (valid_D(2) = '1') then vram_data_2 <= dataall_D(2); vram_valid_2 <= '1';
         elsif (valid_E(2) = '1') then vram_data_2 <= dataall_E(2); vram_valid_2 <= '1';
         elsif (valid_F(2) = '1') then vram_data_2 <= dataall_F(2); vram_valid_2 <= '1';
         elsif (valid_G(2) = '1') then vram_data_2 <= dataall_G(2); vram_valid_2 <= '1';
         elsif (valid_H(2) = '1') then vram_data_2 <= dataall_H(2); vram_valid_2 <= '1';
         elsif (valid_I(2) = '1') then vram_data_2 <= dataall_I(2); vram_valid_2 <= '1';
         elsif (nomap(2)   = '1') then vram_data_2 <= (others => '0'); vram_valid_2 <= '1';
         end if;
         
         if    (valid_A(3) = '1') then vram_data_3 <= dataall_A(3); vram_valid_3 <= '1';
         elsif (valid_B(3) = '1') then vram_data_3 <= dataall_B(3); vram_valid_3 <= '1';
         elsif (valid_C(3) = '1') then vram_data_3 <= dataall_C(3); vram_valid_3 <= '1';
         elsif (valid_D(3) = '1') then vram_data_3 <= dataall_D(3); vram_valid_3 <= '1';
         elsif (valid_E(3) = '1') then vram_data_3 <= dataall_E(3); vram_valid_3 <= '1';
         elsif (valid_F(3) = '1') then vram_data_3 <= dataall_F(3); vram_valid_3 <= '1';
         elsif (valid_G(3) = '1') then vram_data_3 <= dataall_G(3); vram_valid_3 <= '1';
         elsif (valid_H(3) = '1') then vram_data_3 <= dataall_H(3); vram_valid_3 <= '1';
         elsif (valid_I(3) = '1') then vram_data_3 <= dataall_I(3); vram_valid_3 <= '1';
         elsif (nomap(3)   = '1') then vram_data_3 <= (others => '0'); vram_valid_3 <= '1';
         end if;
         
         if    (valid_A(4) = '1') then vram_data_S <= dataall_A(4); vram_valid_S <= '1';
         elsif (valid_B(4) = '1') then vram_data_S <= dataall_B(4); vram_valid_S <= '1';
         elsif (valid_D(4) = '1') then vram_data_S <= dataall_D(4); vram_valid_S <= '1';
         elsif (valid_E(4) = '1') then vram_data_S <= dataall_E(4); vram_valid_S <= '1';
         elsif (valid_F(4) = '1') then vram_data_S <= dataall_F(4); vram_valid_S <= '1';
         elsif (valid_G(4) = '1') then vram_data_S <= dataall_G(4); vram_valid_S <= '1';
         elsif (valid_I(4) = '1') then vram_data_S <= dataall_I(4); vram_valid_S <= '1';
         elsif (nomap(4)   = '1') then vram_data_S <= (others => '0'); vram_valid_S <= '1';
         end if;
         
         if    (valid_E(5) = '1') then pal_data_0  <= dataall_E(5); pal_valid_0  <= '1';
         elsif (valid_F(5) = '1') then pal_data_0  <= dataall_F(5); pal_valid_0  <= '1';
         elsif (valid_G(5) = '1') then pal_data_0  <= dataall_G(5); pal_valid_0  <= '1';
         elsif (valid_H(5) = '1') then pal_data_0  <= dataall_H(5); pal_valid_0  <= '1';
         elsif (nomap(5)   = '1') then pal_data_0 <= (others => '0'); pal_valid_0 <= '1';
         end if;
         
         if    (valid_E(6) = '1') then pal_data_1  <= dataall_E(6); pal_valid_1  <= '1';
         elsif (valid_F(6) = '1') then pal_data_1  <= dataall_F(6); pal_valid_1  <= '1';
         elsif (valid_G(6) = '1') then pal_data_1  <= dataall_G(6); pal_valid_1  <= '1';
         elsif (valid_H(6) = '1') then pal_data_1  <= dataall_H(6); pal_valid_1  <= '1';
         elsif (nomap(6)   = '1') then pal_data_1 <= (others => '0'); pal_valid_1 <= '1';
         end if;
         
         if    (valid_E(7) = '1') then pal_data_2  <= dataall_E(7); pal_valid_2  <= '1';
         elsif (valid_F(7) = '1') then pal_data_2  <= dataall_F(7); pal_valid_2  <= '1';
         elsif (valid_G(7) = '1') then pal_data_2  <= dataall_G(7); pal_valid_2  <= '1';
         elsif (valid_H(7) = '1') then pal_data_2  <= dataall_H(7); pal_valid_2  <= '1';
         elsif (nomap(7)   = '1') then pal_data_2 <= (others => '0'); pal_valid_2 <= '1';
         end if;
         
         if    (valid_E(8) = '1') then pal_data_3  <= dataall_E(8); pal_valid_3  <= '1';
         elsif (valid_F(8) = '1') then pal_data_3  <= dataall_F(8); pal_valid_3  <= '1';
         elsif (valid_G(8) = '1') then pal_data_3  <= dataall_G(8); pal_valid_3  <= '1';
         elsif (valid_H(8) = '1') then pal_data_3  <= dataall_H(8); pal_valid_3  <= '1';
         elsif (nomap(8)   = '1') then pal_data_3 <= (others => '0'); pal_valid_3 <= '1';
         end if;
         
         if    (valid_A(9) = '1') then vram_data3D <= dataall_A(9); vram_valid3D <= '1';
         elsif (valid_B(9) = '1') then vram_data3D <= dataall_B(9); vram_valid3D <= '1';
         elsif (valid_C(9) = '1') then vram_data3D <= dataall_C(9); vram_valid3D <= '1';
         elsif (valid_D(9) = '1') then vram_data3D <= dataall_D(9); vram_valid3D <= '1';
         elsif (nomap(9)   = '1') then vram_data3D <= (others => '0'); vram_valid3D <= '1';
         end if;
         
      end if;
   end process;
   
   gsprite_ext_A : if isGPUA = '1' generate
   begin
   
      vram_req_F  <= pal_req_S                                        when vram_MST_F = "101" else vram_req_F_arbiter; 
      vram_addr_F <= std_logic_vector(to_unsigned(pal_address_S, 14)) when vram_MST_F = "101" else vram_addr_F_arbiter;
      vram_req_G  <= pal_req_S                                        when vram_MST_G = "101" else vram_req_G_arbiter;
      vram_addr_G <= std_logic_vector(to_unsigned(pal_address_S, 14)) when vram_MST_G = "101" else vram_addr_G_arbiter;
      vram_req_I  <= vram_req_I_arbiter; 
      vram_addr_I <= vram_addr_I_arbiter;
      
      pal_valid_S <= vram_valid_F when (vram_ENA_F = '1' and vram_MST_F = "101") else vram_valid_G;
      pal_data_S  <= vram_data_F  when (vram_ENA_F = '1' and vram_MST_F = "101") else vram_data_G;
      
   end generate;   
   
   gsprite_ext_B : if isGPUA = '0' generate
   begin
   
      vram_req_F   <= vram_req_F_arbiter; 
      vram_addr_F  <= vram_addr_F_arbiter;
      vram_req_G   <= vram_req_G_arbiter;
      vram_addr_G  <= vram_addr_G_arbiter;
      vram_req_I   <= pal_req_S                                        when vram_MST_I = "11" else vram_req_I_arbiter; 
      vram_addr_I  <= std_logic_vector(to_unsigned(pal_address_S, 14)) when vram_MST_I = "11" else vram_addr_I_arbiter;
      
      pal_valid_S <= vram_valid_I;
      pal_data_S  <= vram_data_I;
      
   end generate;  
      
      
end architecture;





