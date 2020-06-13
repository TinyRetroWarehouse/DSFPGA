library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;   
use ieee.math_real.all;  

library mem;

use work.pProc_bus_ds.all;

entity ds_cpucache is
   generic
   (
      LINES             : integer;
      CANROTATE         : std_logic;
      LINESIZE          : integer := 8;
      ASSOCIATIVITY     : integer := 4;
      ADDRBITS          : integer := 21;
      IGNORECANCEL      : std_logic := '0'
   );
   port 
   (
      clk               : in     std_logic;
      ds_on             : in     std_logic;
                                 
      read_enable       : in     std_logic;
      read_addr         : in     std_logic_vector(21 downto 0);
      read_acc          : in     std_logic_vector(1 downto 0);
      read_data         : out    std_logic_vector(31 downto 0) := (others => '0');
      read_done         : out    std_logic := '0';
      read_checked      : out    std_logic := '0';
      read_cached       : out    std_logic := '0';
      
      write_enable      : in     std_logic := '0';
      write_addr        : in     std_logic_vector(21 downto 0) := (others => '0');
      write_checked     : out    std_logic := '0';
      write_cached      : out    std_logic := '0';
      
      mem_read_ena      : out    std_logic := '0';
      mem_read_addr     : buffer std_logic_vector(21 downto 0) := (others => '0');
      mem_read_data     : in     std_logic_vector(127 downto 0);
      mem_read_done     : in     std_logic := '0'; -- early done from direct 128 data, next request must pause 2 clocks
      
      snoop_Adr         : in     std_logic_vector(21 downto 0);
      snoop_data        : in     std_logic_vector(31 downto 0);
      snoop_we          : in     std_logic;
      snoop_be          : in     std_logic_vector(3 downto 0)

   );
end entity;

architecture arch of ds_cpucache is
  
   constant RAMSIZEBITS : integer := integer(ceil(log2(real(LINESIZE * LINES))));
   constant SIZEBITS    : integer := integer(ceil(log2(real(LINESIZE * LINES * ASSOCIATIVITY))));
   constant ASSO_BITS   : integer := integer(ceil(log2(real(ASSOCIATIVITY))));
  
   constant SUBTAGBITS  : integer := integer(ceil(log2(real(LINES)))) + 5;
   
   constant LINEMASKMSB : integer := SUBTAGBITS - 1;
   constant LINEMASKLSB : integer := 5;
  
   type t_rrb is array(0 to LINES-1) of unsigned(ASSO_BITS - 1 downto 0);
   signal rrb : t_rrb := (others => (others => '0'));
   
   type t_tags is array(0 to LINES-1, 0 to ASSOCIATIVITY - 1) of std_logic_vector(ADDRBITS - SUBTAGBITS + 1 downto 0);
   signal tags : t_tags := (others => (others =>(others => '1')));
  
   type tState is
   (
      IDLE,
      ROTATE,
      FETCH_WAIT,
      FILLCACHE,
      READCACHE_NEXT_1,
      READCACHE_NEXT_2,
      READCACHE_OUT,
      WAIT_CANCEL
   );
   signal state : tstate := IDLE;

   
   -- memory
   type treaddata_cache is array(0 to ASSOCIATIVITY-1) of std_logic_vector(31 downto 0);
   signal readdata_cache : treaddata_cache;
   signal cache_mux          : integer range 0 to ASSOCIATIVITY-1;
   
   signal memory_addr_a      : natural range 0 to (LINESIZE * LINES) - 1;
   signal memory_addr_b      : unsigned(RAMSIZEBITS-1 downto 0);
   signal memory_datain      : std_logic_vector(31 downto 0);
   signal memory_datain96    : std_logic_vector(95 downto 0);
   signal memory_we          : std_logic_vector(0 to ASSOCIATIVITY-1);
   signal memory_be          : std_logic_vector(3 downto 0);
   
   signal fetch_count        : integer range 0 to LINESIZE;
   signal fillcount          : integer range 0 to 3;
   signal read_data_rotated  : std_logic_vector(31 downto 0) := (others => '0');
   
   signal memmux_addr_b      : natural range 0 to (LINESIZE * LINES) - 1;
   signal memmux_datain      : std_logic_vector(31 downto 0);
   signal memmux_we          : std_logic_vector(0 to ASSOCIATIVITY-1);
   signal memmux_be          : std_logic_vector(3 downto 0);
   
   signal snoop_next         : std_logic := '0';
   
begin 

   gcache : for i in 0 to ASSOCIATIVITY-1 generate
   begin
      iRamMemory : entity MEM.SyncRamDualByteEnable
      generic map
      (
         ADDR_WIDTH => RAMSIZEBITS
      )
      port map
      (
         clk        => clk,
         
         addr_a     => memory_addr_a,   
         datain_a0  => x"00", 
         datain_a1  => x"00",
         datain_a2  => x"00",
         datain_a3  => x"00",
         dataout_a  => readdata_cache(i),
         we_a       => '0',    
         be_a       => "1111",     
                  
         addr_b     => memmux_addr_b,   
         datain_b0  => memmux_datain( 7 downto  0), 
         datain_b1  => memmux_datain(15 downto  8),
         datain_b2  => memmux_datain(23 downto 16),
         datain_b3  => memmux_datain(31 downto 24),
         dataout_b  => open,
         we_b       => memmux_we(i),    
         be_b       => memmux_be     
      );
   end generate;
   
   read_data <= readdata_cache(cache_mux) when CANROTATE = '0' else read_data_rotated;
                
   
   memory_addr_a <= to_integer(unsigned(read_addr(RAMSIZEBITS + 1 downto 2)));

   process (clk)
   begin
      if rising_edge(clk) then
         
         read_done         <= '0';
         read_checked      <= '0';
         write_checked     <= '0';
         mem_read_ena      <= '0';
         memory_we         <= (others => '0');
         memmux_we         <= (others => '0');

         if (ds_on = '0') then
            
            rrb   <= (others => (others => '0'));
            tags  <= (others => (others =>(others => '1')));
            state <= IDLE;
            
         else

            case(state) is
            
               when IDLE =>
                  read_cached   <= '0';
                  write_cached  <= '0';
                  if (read_enable = '1') then
                     state         <= FETCH_WAIT;
                     fetch_count   <= 4;
                     mem_read_addr <= read_addr(21 downto 5) & "00000";
                     mem_read_ena  <= '1';
                     memory_addr_b <= unsigned(read_addr(RAMSIZEBITS + 1 downto 5)) & "000";
                     read_checked  <= '1';
                     memory_be     <= "1111";
                     cache_mux     <= to_integer(rrb(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB)))));
                     for i in 0 to ASSOCIATIVITY - 1 loop
                        if (tags(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB))), i) = '0' & read_addr(ADDRBITS downto SUBTAGBITS)) then
                           mem_read_ena <= '0';
                           cache_mux    <= i;
                           read_cached  <= '1';
                           if (CANROTATE = '1') then
                              state <= ROTATE;
                           else
                              state        <= IDLE;
                              read_done    <= '1';
                           end if;

                        end if;
                     end loop;
                  elsif (write_enable = '1') then
                     write_checked <= '1';
                     for i in 0 to ASSOCIATIVITY - 1 loop
                        if (tags(to_integer(unsigned(write_addr(LINEMASKMSB downto LINEMASKLSB))), i) = '0' & write_addr(ADDRBITS downto SUBTAGBITS)) then  
                           write_cached  <= '1';
                        end if;
                     end loop;
                  end if;
                  
               when ROTATE =>
                  state        <= IDLE;
                  read_done    <= '1';
                  if (read_acc = ACCESS_8BIT) then
                     case (read_addr(1 downto 0)) is
                        when "00" => read_data_rotated <= x"000000" & readdata_cache(cache_mux)(7 downto 0);
                        when "01" => read_data_rotated <= x"000000" & readdata_cache(cache_mux)(15 downto 8);
                        when "10" => read_data_rotated <= x"000000" & readdata_cache(cache_mux)(23 downto 16);
                        when "11" => read_data_rotated <= x"000000" & readdata_cache(cache_mux)(31 downto 24);
                        when others => null;
                     end case;
                  elsif (read_acc = ACCESS_16BIT) then
                     case (read_addr(1 downto 0)) is
                        when "00" => read_data_rotated <= x"0000" & readdata_cache(cache_mux)(15 downto 0);
                        when "01" => read_data_rotated <= readdata_cache(cache_mux)(7 downto 0) & x"0000" & readdata_cache(cache_mux)(15 downto 8);
                        when "10" => read_data_rotated <= x"0000" & readdata_cache(cache_mux)(31 downto 16);
                        when "11" => read_data_rotated <= readdata_cache(cache_mux)(23 downto 16) & x"0000" & readdata_cache(cache_mux)(31 downto 24);
                        when others => null;
                     end case;
                  else
                     case (read_addr(1 downto 0)) is
                        when "00" => read_data_rotated <= readdata_cache(cache_mux);
                        when "01" => read_data_rotated <= readdata_cache(cache_mux)(7 downto 0)  & readdata_cache(cache_mux)(31 downto 8);
                        when "10" => read_data_rotated <= readdata_cache(cache_mux)(15 downto 0) & readdata_cache(cache_mux)(31 downto 16);
                        when "11" => read_data_rotated <= readdata_cache(cache_mux)(23 downto 0) & readdata_cache(cache_mux)(31 downto 24);
                        when others => null;
                     end case;
                  end if;
               
                  
               when FETCH_WAIT => 
                  if (mem_read_done = '1') then
                     memory_datain96      <= mem_read_data(127 downto 32);
                     memory_datain        <= mem_read_data(31 downto 0);
                     memory_we(cache_mux) <= '1';
                     state                <= FILLCACHE;
                     fillcount            <= 0;
                  end if;
                  
               when FILLCACHE =>
                  if (snoop_we = '0') then
                     memory_we(cache_mux) <= '1';
                     memory_datain        <= memory_datain96(31 downto 0);
                     memory_datain96      <= (95 downto 64 => '0') & memory_datain96(95 downto 32);
                     fillcount            <= fillcount + 1;
                     if (fillcount = 2) then
                        if (fetch_count = LINESIZE) then
                           state <= READCACHE_NEXT_1;
                        else
                           state         <= FETCH_WAIT;
                           fetch_count   <= fetch_count + 4;
                           mem_read_addr <= std_logic_vector(unsigned(mem_read_addr) + 16);
                           mem_read_ena  <= '1';
                        end if;
                     end if;
                  end if;
                  
               when READCACHE_NEXT_1 =>
                  state <= READCACHE_NEXT_2;
                  tags(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB))), to_integer(rrb(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB)))))) <= '0' & read_addr(ADDRBITS downto SUBTAGBITS);
                  rrb(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB)))) <= rrb(to_integer(unsigned(read_addr(LINEMASKMSB downto LINEMASKLSB)))) + 1;
              
               when READCACHE_NEXT_2 =>
                  state <= READCACHE_OUT;
              
               when READCACHE_OUT =>
                  if (CANROTATE = '1') then
                     state <= ROTATE;
                  else
                     state     <= IDLE;
                     read_done <= '1';
                  end if;
              
               when WAIT_CANCEL =>
                  if (mem_read_done = '1') then
                     state     <= IDLE;
                     read_done <= '1';
                  end if;
              
            end case; 
            
            if (memory_we /= "0000") then
               memory_addr_b <= memory_addr_b + 1;
            end if;
            
            snoop_next <= '0';
            if (memory_we /= "0000") then
               memmux_addr_b <= to_integer(memory_addr_b);
               memmux_datain <= memory_datain;
               memmux_we     <= memory_we;    
               memmux_be     <= memory_be; 
               snoop_next    <= snoop_we;
            elsif (snoop_we = '1' or snoop_next = '1') then
               memmux_addr_b <= to_integer(unsigned(snoop_Adr(RAMSIZEBITS + 1 downto 2)));
               memmux_datain <= snoop_data;
               memmux_we     <= "0000";
               memmux_be     <= snoop_be;
               for i in 0 to ASSOCIATIVITY - 1 loop
                  if (tags(to_integer(unsigned(snoop_Adr(LINEMASKMSB downto LINEMASKLSB))), i) = '0' & snoop_Adr(ADDRBITS downto SUBTAGBITS)) then  
                     memmux_we(i) <= '1';
                  end if;
               end loop;
            end if;
            
         end if;

      end if;
   end process;
   
end architecture;




























