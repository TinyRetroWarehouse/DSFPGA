library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_memorymux7 is
   generic
   (
      is_simu                   : std_logic;
      Softmap_DS_SAVERAM_ADDR   : integer; -- count:    262144 -- all 32bit used
      Softmap_DS_GAMEROM_ADDR   : integer  -- count:  67108864 -- all 32bit used
   );
   port 
   (
      clk100               : in  std_logic; 
      DS_on                : in  std_logic;
      reset                : in  std_logic;
      
      ds_bus_out           : out proc_bus_ds_type;  
      ds_bus_in            : in  std_logic_vector(31 downto 0);
             
      pc_in_bios           : in  std_logic;
             
      mem_bus_Adr          : in  std_logic_vector(31 downto 0);
      mem_bus_rnw          : in  std_logic;
      mem_bus_ena          : in  std_logic;
      mem_bus_acc          : in  std_logic_vector(1 downto 0);
      mem_bus_dout         : in  std_logic_vector(31 downto 0);
      mem_bus_din          : out std_logic_vector(31 downto 0) := (others => '0');
      mem_bus_done         : out std_logic;
      
      Externram_Adr        : out std_logic_vector(28 downto 0);
      Externram_rnw        : out std_logic;
      Externram_ena        : out std_logic := '0';
      Externram_be         : out std_logic_vector(3 downto 0);
      Externram_dout       : out std_logic_vector(31 downto 0);
      Externram_din        : in  std_logic_vector(31 downto 0);
      Externram_done       : in  std_logic;
      
      WramSmall_Mux        : in  std_logic_vector(1 downto 0);
      WramSmallLo_addr     : out natural range 0 to 4095;
      WramSmallLo_datain   : out std_logic_vector(31 downto 0);
      WramSmallLo_dataout  : in  std_logic_vector(31 downto 0);
      WramSmallLo_we       : out std_logic := '0';
      WramSmallLo_be       : out std_logic_vector(3 downto 0);
      WramSmallHi_addr     : out natural range 0 to 4095;
      WramSmallHi_datain   : out std_logic_vector(31 downto 0);
      WramSmallHi_dataout  : in  std_logic_vector(31 downto 0);
      WramSmallHi_we       : out std_logic := '0';
      WramSmallHi_be       : out std_logic_vector(3 downto 0);
      
      VRam_addr            : out std_logic_vector(23 downto 0) := (others => '0');
      VRam_datain          : out std_logic_vector(31 downto 0);
      VRam_dataout_C       : in  std_logic_vector(31 downto 0);
      VRam_dataout_D       : in  std_logic_vector(31 downto 0);
      VRam_we              : out std_logic := '0';
      VRam_be              : out std_logic_vector(3 downto 0);
      VRam_active_C        : in  std_logic;
      VRam_active_D        : in  std_logic;
       
      IPC_fifo_enable      : out std_logic := '0';    
      IPC_fifo_data        : in  std_logic_vector(31 downto 0);
      
      spi_done             : in  std_logic;
      
      gc_read              : out std_logic := '0';
      gc_romaddress        : in  std_logic_vector(31 downto 0);
      gc_readtype          : in  integer range 0 to 2;
      gc_chipID            : in  std_logic_vector(31 downto 0);
      
      auxspi_addr          : in  std_logic_vector(31 downto 0);
      auxspi_dataout       : in  std_logic_vector( 7 downto 0);
      auxspi_request       : in  std_logic;
      auxspi_rnw           : in  std_logic;
      auxspi_datain        : out std_logic_vector( 7 downto 0);
      auxspi_done          : out std_logic := '0'
   );
end entity;

architecture arch of ds_memorymux7 is

   type tState is
   (
      IDLE,
      READBIOS,
      READLARGERAM,
      READWRAMSMALL_INT,
      READWRAMSMALL_EXT,
      READDSBUS,
      READVRAM,
      READIPCFIFO,
      READGAMECARD,
      ROTATE,
      WRITELARGERAM,
      WRITESPI,
      AUXSPIWAITCMD,
      AUXSPIWAITCMD2,
      AUXSPICMD,
      AUXSPIWAITRAM
   );
   signal state : tState := IDLE;
   
   signal read_delay      : std_logic := '0';
   
   signal acc_save        : std_logic_vector(1 downto 0);
   
   signal wramsmallswitch : std_logic;
   
   signal return_rotate   : std_logic_vector(1 downto 0);
   signal rotate_data     : std_logic_vector(31 downto 0);
   
   -- WramSmallInt
   signal WramSmall_int_addr    : natural range 0 to 16383;
   signal WramSmall_int_datain  : std_logic_vector(31 downto 0);
   signal WramSmall_int_dataout : std_logic_vector(31 downto 0);
   signal WramSmall_int_we      : std_logic := '0';
   signal WramSmall_int_be      : std_logic_vector(3 downto 0);
   
   -- BIOS
   signal BIOS_addr      : std_logic_vector(11 downto 0);
   signal BIOS_dataout   : std_logic_vector(31 downto 0);
   
begin 

   ids_bios7 : entity work.ds_bios7
   port map
   (
      clk     => clk100,
      address => BIOS_addr,
      data    => BIOS_dataout
   );
   BIOS_addr <= mem_bus_Adr(13 downto 2);

   iWramSmallInt : entity MEM.SyncRamByteEnable
   generic map
   (
      ADDR_WIDTH => 14
   )
   port map
   (
      clk      => clk100,
      
      addr     => WramSmall_int_addr,
      datain0  => WramSmall_int_datain( 7 downto  0),
      datain1  => WramSmall_int_datain(15 downto  8),
      datain2  => WramSmall_int_datain(23 downto 16),
      datain3  => WramSmall_int_datain(31 downto 24),
      dataout  => WramSmall_int_dataout,
      we       => WramSmall_int_we,
      be       => WramSmall_int_be
   );
   WramSmall_int_addr <= to_integer(unsigned(mem_bus_Adr(15 downto 2)));

   WramSmallLo_addr   <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));
   WramSmallHi_addr   <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));
   
   process (clk100)
      variable byteenable : std_logic_vector(3 downto 0);
      variable writedata  : std_logic_vector(31 downto 0);
   begin
      if rising_edge(clk100) then
      
         mem_bus_done      <= '0';
         Externram_ena     <= '0';
         WramSmallLo_we    <= '0';
         WramSmallHi_we    <= '0';
         WramSmall_int_we  <= '0';
         VRam_we           <= '0';
         
         ds_bus_out.ena    <= '0';
         ds_bus_out.rst    <= reset;
         
         IPC_fifo_enable   <= '0';
         
         gc_read           <= '0';
         auxspi_done       <= '0';
      
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
              
                     if (mem_bus_rnw = '1') then  -- read
                     
                        return_rotate <= mem_bus_Adr(1 downto 0);
                  
                        case (mem_bus_Adr(31 downto 24)) is
                           
                           when x"00" =>
                              state  <= READBIOS;
                        
                           when x"02" =>
                              state          <= READLARGERAM;
                              Externram_Adr  <= (28 downto 22 => '0') & mem_bus_Adr(21 downto 2) & "00";
                              Externram_rnw  <= '1';
                              Externram_ena  <= '1';
                              
                           when x"03" =>
                              wramsmallswitch <= mem_bus_Adr(14);               
                              if (unsigned(mem_bus_Adr(23 downto 0)) < x"800000") then
                                 state <= READWRAMSMALL_EXT;
                              else
                                 state <= READWRAMSMALL_INT;
                              end if;
                              
                           when x"04" =>
                              if (unsigned(mem_bus_Adr(23 downto 0)) < x"001000") then
                                 ds_bus_out.adr <= (ds_bus_out.adr'left downto 12 => '0') & mem_bus_Adr(11 downto 2) & "00";
                                 ds_bus_out.acc <= mem_bus_acc;
                                 ds_bus_out.rnw <= '1';
                                 ds_bus_out.ena <= '1';
                                 state <= READDSBUS;
                              elsif (mem_bus_Adr(23 downto 0) = x"100000") then
                                 state           <= READIPCFIFO;
                                 read_delay      <= '1';
                                 IPC_fifo_enable <= '1';
                              elsif (mem_bus_Adr(23 downto 0) = x"100010") then
                                 state           <= READGAMECARD;
                                 if (gc_readtype = 1) then
                                    Externram_Adr  <= std_logic_vector(to_unsigned(Softmap_DS_GAMEROM_ADDR, 29) + unsigned(gc_romaddress(28 downto 0)));
                                    Externram_rnw  <= '1';
                                    Externram_ena  <= '1';
                                 end if;
                              else
                                 mem_bus_din  <= (others => '0');
                                 mem_bus_done <= '1';
                              end if;
                              
                           when x"06" =>
                              state      <= READVRAM;
                              VRam_addr  <= mem_bus_Adr(23 downto 0);
                              read_delay <= '1';
                              
                           when x"08" | x"09" | x"0A" | x"0B" | x"0C" |x"0D" | x"0E" | x"0F" =>
                              state       <= ROTATE;
                              rotate_data <= (others => '1');
                        
                           when others =>
                              mem_bus_din  <= (others => '0');
                              mem_bus_done <= '1';
                        
                        end case;
                     
                     else -- write
                     
                        -- generic rotate data and set byteenable
                        byteenable := "1111";
                        writedata  := mem_bus_dout;
                        case (mem_bus_acc) is 
                           when ACCESS_8BIT => 
                              case(mem_bus_Adr(1 downto 0)) is
                                 when "00" => byteenable := "0001";
                                 when "01" => byteenable := "0010"; writedata(15 downto  8) := mem_bus_dout(7 downto 0);
                                 when "10" => byteenable := "0100"; writedata(23 downto 16) := mem_bus_dout(7 downto 0);
                                 when "11" => byteenable := "1000"; writedata(31 downto 24) := mem_bus_dout(7 downto 0);
                                 when others => null;
                              end case;
                           when ACCESS_16BIT =>
                              if (mem_bus_Adr(1) = '1') then
                                 writedata(31 downto 16) := mem_bus_dout(15 downto 0);
                                 byteenable   := "1100";
                              else
                                 byteenable   := "0011";
                              end if;
                           when others => byteenable := "1111";
                        end case;
                     
                        case (mem_bus_Adr(31 downto 24)) is
                           
                           when x"02" =>
                              state          <= WRITELARGERAM;
                              Externram_Adr  <= (28 downto 22 => '0') & mem_bus_Adr(21 downto 2) & "00";
                              Externram_rnw  <= '0';
                              Externram_ena  <= '1';
                              Externram_dout <= writedata;
                              Externram_be   <= byteenable;
                              
                           when x"03" =>
                              mem_bus_done         <= '1';
                              WramSmallLo_datain   <= writedata;
                              WramSmallLo_be       <= byteenable;
                              WramSmallHi_datain   <= writedata;
                              WramSmallHi_be       <= byteenable;
                              WramSmall_int_datain <= writedata;
                              WramSmall_int_be     <= byteenable;
                              if (unsigned(mem_bus_Adr(23 downto 0)) < x"800000" and WramSmall_Mux /= "00") then
                                 case (WramSmall_Mux) is
                                    when "01" => WramSmallLo_we         <= '1';
                                    when "10" => WramSmallHi_we         <= '1';
                                    when "11" =>
                                       if (mem_bus_Adr(14) = '1') then
                                          WramSmallHi_we         <= '1';
                                       else
                                          WramSmallLo_we         <= '1';
                                       end if;
                                    when others => null;
                                 end case;
                              else
                                 WramSmall_int_we     <= '1';
                              end if;
                              
                           when x"04" => 
                              if (unsigned(mem_bus_Adr(23 downto 0)) <= x"00106C") then
                                 ds_bus_out.adr  <= (ds_bus_out.adr'left downto 13 => '0') & mem_bus_Adr(12 downto 2) & "00";
                                 ds_bus_out.Din  <= writedata;
                                 ds_bus_out.acc  <= mem_bus_acc;
                                 ds_bus_out.rnw  <= '0';
                                 ds_bus_out.ena  <= '1';
                                 ds_bus_out.BEna <= byteenable;
                              end if;
                              
                              if (unsigned(mem_bus_Adr(23 downto 2) & "00") = x"0001C0") then
                                 state  <= WRITESPI;
                              elsif (unsigned(mem_bus_Adr(23 downto 2) & "00") = x"0001A0" and byteenable(2) = '1') then
                                 state  <= AUXSPIWAITCMD;
                              else
                                 mem_bus_done <= '1';
                              end if;
                              
                           when x"06" =>
                              VRam_we      <= '1';
                              VRam_addr    <= mem_bus_Adr(23 downto 0);
                              VRam_datain  <= writedata;
                              VRam_be      <= byteenable;
                              mem_bus_done <= '1'; 
                           
                           when others => mem_bus_done <= '1';
                           
                        end case;
                     
                     end if;
               
                  end if;
                  
               when READBIOS =>
                  state       <= ROTATE;
                  if (pc_in_bios = '1') then
                     rotate_data <= BIOS_dataout; 
                  else
                     rotate_data <= (others => '1');
                  end if;
                  
               when READLARGERAM =>
                  if (Externram_done = '1') then
                     state        <= ROTATE;
                     rotate_data  <= Externram_din;
                  end if;
                  
               when READWRAMSMALL_INT =>
                  state        <= ROTATE;
                  rotate_data  <= WramSmall_int_dataout;
                  
               when READWRAMSMALL_EXT =>
                  state        <= ROTATE;
                  case (WramSmall_Mux) is
                     when "00" => rotate_data <= WramSmall_int_dataout;
                     when "01" => rotate_data <= WramSmallLo_dataout;
                     when "10" => rotate_data <= WramSmallHi_dataout;
                     when "11" =>
                        if (wramsmallswitch = '1') then
                           rotate_data <= WramSmallHi_dataout;
                        else
                           rotate_data <= WramSmallLo_dataout;
                        end if;
                     when others => null;
                  end case;
                  
               when READDSBUS =>
                  rotate_data <= ds_bus_in;
                  state <= rotate;
                  
               when READVRAM =>
                  if (read_delay = '0') then
                     state        <= ROTATE;
                     if    (VRam_active_C = '1') then rotate_data  <= VRAM_dataout_C;
                     elsif (VRam_active_D = '1') then rotate_data  <= VRAM_dataout_D;
                     else  rotate_data <= (others => '0');
                     end if;
                  end if;
                  
               when READIPCFIFO =>
                  if (read_delay = '0') then
                     state       <= ROTATE;
                     rotate_data <= IPC_fifo_data;
                  end if;
                  
               when READGAMECARD =>
                  case (gc_readtype) is
                     when 1      => if (Externram_done = '1') then state <= ROTATE; rotate_data <= Externram_din; gc_read <= '1'; end if;
                     when 2      => state <= ROTATE; rotate_data <= gc_chipID; gc_read <= '1';
                     when others => state <= ROTATE; rotate_data <= (others => '0');
                  end case;
                  
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
               
               -- writing
               
               when WRITELARGERAM =>
                  if (Externram_done = '1') then
                     state        <= IDLE;
                     mem_bus_done <= '1'; 
                  end if;
                  
               when WRITESPI =>
                  if (spi_done = '1') then
                     state        <= IDLE;
                     mem_bus_done <= '1';
                  end if;
           
               -- auxspi
               when AUXSPIWAITCMD =>
                  state <= AUXSPIWAITCMD2;
                  
               when AUXSPIWAITCMD2 =>
                  state <= AUXSPICMD;
               
               when AUXSPICMD =>
                  if (auxspi_request = '1') then
                     state <= AUXSPIWAITRAM;
                     Externram_Adr  <= std_logic_vector(to_unsigned(Softmap_DS_SAVERAM_ADDR, 29) + (unsigned(auxspi_addr(26 downto 0)) & "00"));
                     Externram_rnw  <= auxspi_rnw;
                     Externram_dout <= x"000000" & auxspi_dataout;
                     Externram_be   <= "0001";
                     Externram_ena  <= '1';
                  else
                     state        <= IDLE;
                     mem_bus_done <= '1';
                  end if;
               
               when AUXSPIWAITRAM =>
                  if (Externram_done = '1') then
                     state        <= IDLE;
                     mem_bus_done <= '1';
                     if (auxspi_rnw = '1') then
                        auxspi_done   <= '1';
                        auxspi_datain <= Externram_din(7 downto 0);
                     end if;
                  end if;
           
            end case;
            
         end if;
      
      end if;
   end process;
   

end architecture;





