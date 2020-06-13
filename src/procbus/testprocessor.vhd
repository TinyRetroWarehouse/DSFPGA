library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;

entity eTestprocessor  is
   port 
   (
      clk             : in     std_logic;
      debugaccess     : in     std_logic;

      ftdi_d          : inout  std_logic_vector(7 downto 0);
      ftdi_rdn        : out    std_logic := '1';
      ftdi_rxen       : in     std_logic;
      ftdi_siwun      : out    std_logic;
      ftdi_txen       : in     std_logic;
      ftdi_wrn        : out    std_logic := '1';
               
      bus_in          : out proc_bus_intype := ((others => '0'), (others => '0'), '0', '0');
      bus_Dout        : in  std_logic_vector(proc_buswidth-1 downto 0);
      bus_done        : in  std_logic;
      
      timeout_error   : buffer std_logic := '0'
   );
end entity;

architecture arch of eTestprocessor is
   
   type tState is
   (
      IDLE,
      RECEIVELENGTH,
      BLOCKWRITE,
      BLOCKWRITE_WAIT,
      BLOCKREAD_READ,
      BLOCKREAD_WAIT,
      BLOCKREAD_SEND
   );
   signal state : tState := IDLE;
   
   signal receive_command  : std_logic_vector(31 downto 0);
   signal receive_byte_nr  : integer range 0 to 4 := 0;
   
   signal rx_valid         : std_logic;
   signal rx_byte          : std_logic_vector(7 downto 0);
   
   signal transmit_command : std_logic_vector(31 downto 0);
   signal transmit_byte_nr : integer range 0 to 4 := 4;
   signal sendbyte         : std_logic_vector(7 downto 0) := (others => '0');
   signal tx_enable        : std_logic := '0';
   signal tx_busy          : std_logic;
   
   signal blocklength_m1   : integer range 0 to 255 := 0;
   signal workcount        : integer range 0 to 255 := 0;
   signal addr_buffer      : std_logic_vector(proc_busadr - 1 downto 0) := (others => '0');
   
   constant TIMEOUTVALUE : integer := 100000000;
   signal timeout          : integer range 0 to TIMEOUTVALUE := 0;

   -- FTDI
   type t_ftdi_state is
   (
      IDLE,
      READING,
      WRITING,
      WAITWRITE
   );
   signal ftdi_state : t_ftdi_state := IDLE;
   
   signal ftdi_slow : integer range 0 to 31;
   
   signal ftdi_rxen_1 : std_logic := '1';
   signal ftdi_rxen_2 : std_logic := '1';   
   signal ftdi_txen_1 : std_logic := '1';
   signal ftdi_txen_2 : std_logic := '1';
   signal ftdi_d_1    : std_logic_vector(7 downto 0);
   signal ftdi_d_2    : std_logic_vector(7 downto 0);

   signal receive_ready : std_logic := '0';

begin

   process (clk)
   begin
      if rising_edge(clk) then
   
         bus_in.ena      <= '0';
         tx_enable       <= '0';
         timeout_error   <= '0';
   
         receive_ready <= '0';
         if (state = IDLE or state = RECEIVELENGTH or state = BLOCKWRITE) then
            receive_ready <= '1';
         end if;
         
         if (timeout < TIMEOUTVALUE) then
            timeout <= timeout + 1;
         end if;
   
         case state is
         
            -- receive register command
            when IDLE =>
               blocklength_m1  <= 0;
               workcount       <= 0;
               timeout         <= 0;
            
               if (rx_valid = '1') then
                  receive_command((receive_byte_nr*8)+7 downto (receive_byte_nr*8)) <= rx_byte;
                  if (receive_byte_nr < 3) then
                     receive_byte_nr <= receive_byte_nr + 1;
                  else
                     receive_byte_nr <= 0;
                     addr_buffer  <= rx_byte(3 downto 0) & receive_command(23 downto 0);
                     bus_in.rnw   <= rx_byte(6);
                     
                     if (rx_byte(7) = '0') then -- non block mode
                        if (rx_byte(6) = '1') then
                           state <= BLOCKREAD_READ;
                        else
                           state <= BLOCKWRITE;
                        end if;
                     else -- block mode
                        state           <= RECEIVELENGTH;
                     end if;
                  end if;
               end if;
               
            when RECEIVELENGTH =>
               if (timeout = TIMEOUTVALUE) then
                  state         <= IDLE;
                  timeout_error <= '1';
               end if;
               
               if (rx_valid = '1') then
                  blocklength_m1 <= to_integer(unsigned(rx_byte));
                  if (receive_command(30) = '1') then
                     state <= BLOCKREAD_READ;
                  else
                     state <= BLOCKWRITE;
                  end if;
               end if;
            
            -- write
            when BLOCKWRITE =>
               if (timeout = TIMEOUTVALUE) then
                  state         <= IDLE;
                  timeout_error <= '1';
               end if;
            
               if (rx_valid = '1') then
                  receive_command((receive_byte_nr*8)+7 downto (receive_byte_nr*8)) <= rx_byte;
                  if (receive_byte_nr < 3) then
                     receive_byte_nr <= receive_byte_nr + 1;
                  else
                     receive_byte_nr <= 0;
                     bus_in.adr  <= addr_buffer;
                     bus_in.Din  <= rx_byte & receive_command(23 downto 0);
                     bus_in.ena  <= '1';
                     addr_buffer <= std_logic_vector(unsigned(addr_buffer) + 1);
                     state       <= BLOCKWRITE_WAIT;
                  end if;
               end if;
               
            when BLOCKWRITE_WAIT =>
               if (timeout = TIMEOUTVALUE) then
                  state         <= IDLE;
                  timeout_error <= '1';
               end if;
            
               if (bus_done = '1') then
                  if (workcount >= blocklength_m1) then
                     state  <= IDLE;
                  else
                     workcount <= workcount + 1;
                     state     <= BLOCKWRITE;
                  end if;
               end if;
            
            -- read
            when BLOCKREAD_READ =>
               bus_in.adr   <= addr_buffer;
               bus_in.ena   <= '1';
               addr_buffer  <= std_logic_vector(unsigned(addr_buffer) + 1);
               state        <= BLOCKREAD_WAIT;
               
            when BLOCKREAD_WAIT =>
               if (timeout = TIMEOUTVALUE) then
                  state         <= IDLE;
                  timeout_error <= '1';
               end if;
            
               if (bus_done = '1') then
                  transmit_command <= bus_Dout;
                  transmit_byte_nr <= 0;
                  state            <= BLOCKREAD_SEND;
               end if;
            
            when BLOCKREAD_SEND =>
               if (timeout = TIMEOUTVALUE) then
                  state         <= IDLE;
                  timeout_error <= '1';
               end if;
            
               if (tx_busy = '0') then
                  transmit_byte_nr <= transmit_byte_nr + 1;
                  sendbyte <= transmit_command((transmit_byte_nr*8)+7 downto (transmit_byte_nr*8));
                  tx_enable <= '1';
                  if (transmit_byte_nr = 3) then
                     if (workcount >= blocklength_m1) then
                        state  <= IDLE;
                     else
                        workcount <= workcount + 1;
                        state     <= BLOCKREAD_READ;
                     end if;
                  end if;
               end if;

         end case;
   
      end if;
   end process;
   
   
   -- FTDI 
   
   tx_busy <= ftdi_txen_2 when (tx_enable = '0' and ftdi_state = IDLE and ftdi_slow = 0) else '1';
   
   process (clk)
   begin
      if rising_edge(clk) then
         
         rx_valid   <= '0';
         
         ftdi_rxen_1 <= ftdi_rxen;
         ftdi_rxen_2 <= ftdi_rxen_1;         
         ftdi_txen_1 <= ftdi_txen;
         ftdi_txen_2 <= ftdi_txen_1;
         ftdi_d_1    <= ftdi_d;
         ftdi_d_2    <= ftdi_d_1;
         
         if (ftdi_slow > 0) then
            ftdi_slow <= ftdi_slow - 1;
         else
         
            case (ftdi_state) is
            
               when IDLE =>
                  if (receive_ready = '1' and ftdi_rxen_2 = '0') then
                     ftdi_state <= READING;
                     ftdi_slow  <= 4;
                     ftdi_rdn   <= '0';
                  elsif (tx_enable = '1') then
                     ftdi_state <= WRITING;
                     ftdi_slow  <= 1;   
                  end if;
                  
               when READING =>
                  ftdi_state <= IDLE;
                  ftdi_slow  <= 4;
                  ftdi_rdn   <= '1';   
                  rx_byte    <= ftdi_d_2;
                  rx_valid   <= debugaccess;
                  
               when WRITING =>
                  ftdi_state <= WAITWRITE;
                  ftdi_slow  <= 4;
                  ftdi_wrn   <= '0';
               
               when WAITWRITE =>
                  ftdi_state <= IDLE;
                  ftdi_slow  <= 4;
                  ftdi_wrn   <= '1';
       
            end case;
            
         end if;
            
      end if;
   end process;
   
   ftdi_siwun <= '1';
   
   ftdi_d <= sendbyte when (ftdi_state = WRITING or ftdi_state = WAITWRITE) else (others => 'Z');
   
end architecture;

