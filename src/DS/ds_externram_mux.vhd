library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;

library MEM;

entity ds_externram_mux is
   port 
   (
      clk100                : in     std_logic; 
      reset                 : in     std_logic; 
                            
      Externram9data_Adr    : in     std_logic_vector(28 downto 0);
      Externram9data_rnw    : in     std_logic;
      Externram9data_ena    : in     std_logic;
      Externram9data_be     : in     std_logic_vector(3 downto 0);
      Externram9data_dout   : in     std_logic_vector(31 downto 0);
      Externram9data_din    : out    std_logic_vector(31 downto 0);
      Externram9data_din128 : out    std_logic_vector(127 downto 0);
      Externram9data_done   : out    std_logic := '0';
                            
      Externram9code_Adr    : in     std_logic_vector(28 downto 0);
      Externram9code_ena    : in     std_logic;
      Externram9code_din    : out    std_logic_vector(31 downto 0);
      Externram9code_din128 : out    std_logic_vector(127 downto 0);
      Externram9code_done   : out    std_logic := '0';
                            
      Externram7_Adr        : in     std_logic_vector(28 downto 0);
      Externram7_rnw        : in     std_logic;
      Externram7_ena        : in     std_logic;
      Externram7_be         : in     std_logic_vector(3 downto 0);
      Externram7_dout       : in     std_logic_vector(31 downto 0);
      Externram7_din        : out    std_logic_vector(31 downto 0);
      Externram7_din128     : out    std_logic_vector(127 downto 0);
      Externram7_done       : out    std_logic:= '0';    
                            
      Externram_Adr         : out    std_logic_vector(28 downto 0);
      Externram_rnw         : out    std_logic;
      Externram_ena         : out    std_logic;
      Externram_128         : out    std_logic;
      Externram_be          : out    std_logic_vector(3 downto 0);
      Externram_dout        : out    std_logic_vector(31 downto 0);
      Externram_dout128     : out    std_logic_vector(127 downto 0);
      Externram_din         : in     std_logic_vector(31 downto 0);
      Externram_din128      : in     std_logic_vector(127 downto 0);
      Externram_done        : in     std_logic;
                            
      snoop_Adr             : out    std_logic_vector(21 downto 0); -- snoop only for sram!
      snoop_data            : out    std_logic_vector(31 downto 0);
      snoop_we              : out    std_logic;
      snoop_be              : out    std_logic_vector(3 downto 0)
   );
end entity;

architecture arch of ds_externram_mux is

   type tState is
   (
      IDLE,
      WAITING9DATA,
      WAITING9CODE,
      WAITING7
   );
   signal state : tState := IDLE;

   signal request_buffer_9data : std_logic := '0';
   signal request_buffer_9code : std_logic := '0';
   signal request_buffer_7     : std_logic := '0';
   
   signal Externmux_Adr        : std_logic_vector(28 downto 0);
   signal Externmux_rnw        : std_logic;
   signal Externmux_ena        : std_logic;
   signal Externmux_128        : std_logic;
   signal Externmux_be         : std_logic_vector(3 downto 0);
   signal Externmux_dout       : std_logic_vector(31 downto 0);
   signal Externmux_dout128    : std_logic_vector(127 downto 0);

begin 

   -- todo: priority should come from register!
   
   Externram_Adr     <= Externmux_Adr;    
   Externram_rnw     <= Externmux_rnw;    
   Externram_ena     <= Externmux_ena;    
   Externram_128     <= Externmux_128;    
   Externram_be      <= Externmux_be;     
   Externram_dout    <= Externmux_dout;   
   Externram_dout128 <= (others => '0');

   process (clk100)
   begin
      if rising_edge(clk100) then
      
         Externmux_ena   <= '0';
      
         if (reset = '1') then
      
            state                <= IDLE;
            request_buffer_9data <= '0';
            request_buffer_9code <= '0';
            request_buffer_7     <= '0';
      
         else 
         
            if (Externram9data_ena = '1') then request_buffer_9data <= '1'; end if;
            if (Externram9code_ena = '1') then request_buffer_9code <= '1'; end if;
            if (Externram7_ena = '1')     then request_buffer_7     <= '1'; end if;
         
            case state is
               
               when IDLE =>
                  if (request_buffer_9data = '1' or Externram9data_ena = '1') then
                     state            <= WAITING9DATA;
                     Externmux_ena    <= '1';
                     Externmux_Adr    <= Externram9data_Adr; 
                     Externmux_rnw    <= Externram9data_rnw; 
                     Externmux_be     <= Externram9data_be; 
                     Externmux_dout   <= Externram9data_dout;
                     Externmux_128    <= '0';
                  elsif (request_buffer_9code = '1' or Externram9code_ena = '1') then
                     state            <= WAITING9CODE;
                     Externmux_ena    <= '1';
                     Externmux_Adr    <= Externram9code_Adr; 
                     Externmux_rnw    <= '1'; 
                     Externmux_128    <= '0';
                  elsif (request_buffer_7 = '1' or Externram7_ena = '1') then
                     state            <= WAITING7;
                     Externmux_ena    <= '1';
                     Externmux_Adr    <= Externram7_Adr; 
                     Externmux_rnw    <= Externram7_rnw; 
                     Externmux_be     <= Externram7_be; 
                     Externmux_dout   <= Externram7_dout;
                     Externmux_128    <= '0';
                  end if;
         
               when WAITING9DATA =>
                  if (Externram_done = '1') then
                     state              <= IDLE;
                     request_buffer_9data <= '0';
                  end if;
                  
               when WAITING9CODE =>
                  if (Externram_done = '1') then
                     state                <= IDLE;
                     request_buffer_9code <= '0';
                  end if;
               
               when WAITING7 =>
                  if (Externram_done = '1') then
                     state            <= IDLE;  
                     request_buffer_7 <= '0';                     
                  end if;
                  
            end case;
            
            -- snoop port
            snoop_we <= '0';
            if (Externmux_ena = '1' and Externmux_rnw = '0' and Externmux_Adr(28 downto 22) = (28 downto 22 => '0')) then
               snoop_Adr  <= Externmux_Adr(21 downto 2) & "00";
               snoop_data <= Externmux_dout;
               snoop_we   <= '1';
               snoop_be   <= Externmux_be;  
            end if;
            
         end if;
      
      end if;
   end process;
   
   -- to internal
   Externram9data_din <= Externram_din;
   Externram9code_din <= Externram_din;
   Externram7_din     <= Externram_din;
   
   Externram9data_din128 <= Externram_din128;
   Externram9code_din128 <= Externram_din128;
   Externram7_din128     <= Externram_din128;
   
   Externram9data_done <= '1' when Externram_done = '1' and state = WAITING9DATA else '0';
   Externram9code_done <= '1' when Externram_done = '1' and state = WAITING9CODE else '0';
   Externram7_done     <= '1' when Externram_done = '1' and state = WAITING7     else '0';

end architecture;





