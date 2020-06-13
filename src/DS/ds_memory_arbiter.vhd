library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

entity ds_memory_arbiter is
   generic
   (
      ports      : integer := 16;
      addrbits   : integer;
      databits   : integer := 32;
      timeoutcnt : integer := 1023
   );
   port 
   (
      clk100        : in  std_logic;
      
      request       : in  std_logic_vector(0 to ports - 1);
      valid         : out std_logic_vector(0 to ports - 1) := (others => '0');
      
      addr_in_0     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_1     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_2     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_3     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_4     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_5     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_6     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_7     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_8     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_9     : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_10    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_11    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_12    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_13    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_14    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      addr_in_15    : in  std_logic_vector(addrbits - 1 downto 0) := (others => '0');
      data_out_0    : out std_logic_vector(databits - 1 downto 0);
      data_out_1    : out std_logic_vector(databits - 1 downto 0);
      data_out_2    : out std_logic_vector(databits - 1 downto 0);
      data_out_3    : out std_logic_vector(databits - 1 downto 0);
      data_out_4    : out std_logic_vector(databits - 1 downto 0);
      data_out_5    : out std_logic_vector(databits - 1 downto 0);
      data_out_6    : out std_logic_vector(databits - 1 downto 0);
      data_out_7    : out std_logic_vector(databits - 1 downto 0);
      data_out_8    : out std_logic_vector(databits - 1 downto 0);
      data_out_9    : out std_logic_vector(databits - 1 downto 0);
      data_out_10   : out std_logic_vector(databits - 1 downto 0);
      data_out_11   : out std_logic_vector(databits - 1 downto 0);
      data_out_12   : out std_logic_vector(databits - 1 downto 0);
      data_out_13   : out std_logic_vector(databits - 1 downto 0);
      data_out_14   : out std_logic_vector(databits - 1 downto 0);
      data_out_15   : out std_logic_vector(databits - 1 downto 0);
      
      addr_out      : out std_logic_vector;
      read_ena      : out std_logic := '0'; 
      data_rec      : in  std_logic_vector;
      data_valid    : in  std_logic
   );
end entity;

architecture arch of ds_memory_arbiter is
   
   type t_addr_all is array(0 to 15) of std_logic_vector(addr_in_0'left downto 0);
   signal addr_all : t_addr_all;
   
   signal idle            : std_logic := '1';
   signal choosen         : integer range 0 to ports - 1 := 0;
   signal ena_latch       : std_logic_vector(0 to ports - 1) := (others => '0');
   
   signal timeout         : integer range 0 to timeoutcnt := 0;
   signal timeout_trigger : std_logic := '0';
   
begin 

   addr_all( 0) <= addr_in_0;
   addr_all( 1) <= addr_in_1;
   addr_all( 2) <= addr_in_2;
   addr_all( 3) <= addr_in_3;
   addr_all( 4) <= addr_in_4;
   addr_all( 5) <= addr_in_5;
   addr_all( 6) <= addr_in_6;
   addr_all( 7) <= addr_in_7;
   addr_all( 8) <= addr_in_8;
   addr_all( 9) <= addr_in_9;
   addr_all(10) <= addr_in_10;
   addr_all(11) <= addr_in_11;
   addr_all(12) <= addr_in_12;
   addr_all(13) <= addr_in_13;
   addr_all(14) <= addr_in_14;
   addr_all(15) <= addr_in_15;
   
   data_out_0  <= data_rec;
   data_out_1  <= data_rec;
   data_out_2  <= data_rec;
   data_out_3  <= data_rec;
   data_out_4  <= data_rec;
   data_out_5  <= data_rec;
   data_out_6  <= data_rec;
   data_out_7  <= data_rec;
   data_out_8  <= data_rec;
   data_out_9  <= data_rec;
   data_out_10 <= data_rec;
   data_out_11 <= data_rec;
   data_out_12 <= data_rec;
   data_out_13 <= data_rec;
   data_out_14 <= data_rec;
   data_out_15 <= data_rec;
   
   gvalid0  : if ports > 0  generate begin valid( 0) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  0) else '0'; end generate;
   gvalid1  : if ports > 1  generate begin valid( 1) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  1) else '0'; end generate;
   gvalid2  : if ports > 2  generate begin valid( 2) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  2) else '0'; end generate;
   gvalid3  : if ports > 3  generate begin valid( 3) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  3) else '0'; end generate;
   gvalid4  : if ports > 4  generate begin valid( 4) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  4) else '0'; end generate;
   gvalid5  : if ports > 5  generate begin valid( 5) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  5) else '0'; end generate;
   gvalid6  : if ports > 6  generate begin valid( 6) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  6) else '0'; end generate;
   gvalid7  : if ports > 7  generate begin valid( 7) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  7) else '0'; end generate;
   gvalid8  : if ports > 8  generate begin valid( 8) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  8) else '0'; end generate;
   gvalid9  : if ports > 9  generate begin valid( 9) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen =  9) else '0'; end generate;
   gvalid10 : if ports > 10 generate begin valid(10) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 10) else '0'; end generate;
   gvalid11 : if ports > 11 generate begin valid(11) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 11) else '0'; end generate;
   gvalid12 : if ports > 12 generate begin valid(12) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 12) else '0'; end generate;
   gvalid13 : if ports > 13 generate begin valid(13) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 13) else '0'; end generate;
   gvalid14 : if ports > 14 generate begin valid(14) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 14) else '0'; end generate;
   gvalid15 : if ports > 15 generate begin valid(15) <= '1' when (((data_valid = '1' and idle = '0') or timeout_trigger = '1') and choosen = 15) else '0'; end generate;
   
   process (clk100)
      variable next_requester : integer range 0 to ports - 1 := 0;
      variable next_request   : std_logic := '0';   
   begin
      if rising_edge(clk100) then
      
         read_ena <= '0';

         for i in 0 to ports - 1 loop
            if (request(i) = '1') then
               ena_latch(i)  <= '1';
            end if;
         end loop;
         
         next_request := '0';
         for i in 0 to ports - 1 loop
            if (next_request = '0') then
               if (ena_latch(i) = '1' or request(i) = '1') then
                  next_requester := i;
                  next_request   := '1';
               end if;
            end if;
         end loop;
         
         timeout_trigger <= '0';
         if (idle = '0') then
            if (timeout < timeoutcnt) then
               timeout <= timeout + 1;
            else
               idle            <= '1';
               timeout_trigger <= '1';
            end if;
         end if;
         
         if ((idle = '1' or data_valid = '1') and next_request = '1') then
            idle                      <= '0';
            ena_latch(next_requester) <= '0';
            choosen                   <= next_requester;
            addr_out                  <= addr_all(next_requester);
            read_ena                  <= '1';
            timeout                   <= 0;
         elsif (data_valid = '1') then
            idle  <= '1';
         end if;
         
      end if;
   end process;

end architecture;





