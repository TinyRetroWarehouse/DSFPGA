library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_memorymux9data is
   generic
   (
      is_simu                   : std_logic;
      Softmap_DS_SAVERAM_ADDR   : integer; -- count:    262144 -- all 32bit used
      Softmap_DS_GAMEROM_ADDR   : integer  -- count:  67108864 -- all 32bit used
   );
   port 
   (
      clk100               : in     std_logic; 
      DS_on                : in     std_logic;
      reset                : in     std_logic;
      DTCMRegion           : in     std_logic_vector(31 downto 0);
      
      ds_bus_out           : out    proc_bus_ds_type;  
      ds_bus_in            : in     std_logic_vector(31 downto 0);
      haltbus              : in     std_logic;
           
      mem_bus_iscpu        : in     std_logic;                     
      mem_bus_Adr          : in     std_logic_vector(31 downto 0);
      mem_bus_rnw          : in     std_logic;
      mem_bus_ena          : in     std_logic;
      mem_bus_acc          : in     std_logic_vector(1 downto 0);
      mem_bus_dout         : in     std_logic_vector(31 downto 0);
      mem_bus_din          : out    std_logic_vector(31 downto 0) := (others => '0');
      mem_bus_done         : out    std_logic;
      
      ITCM_addr            : out    natural range 0 to 8191;
      ITCM_datain          : out    std_logic_vector(31 downto 0);
      ITCM_dataout         : in     std_logic_vector(31 downto 0);
      ITCM_we              : out    std_logic := '0';
      ITCM_be              : out    std_logic_vector(3 downto 0);
            
      BIOS_addr            : out    std_logic_vector(9 downto 0);
      BIOS_dataout         : in     std_logic_vector(31 downto 0);
      
      Externram_Adr        : out    std_logic_vector(28 downto 0);
      Externram_rnw        : out    std_logic;
      Externram_ena        : out    std_logic := '0';
      Externram_be         : out    std_logic_vector(3 downto 0);
      Externram_dout       : out    std_logic_vector(31 downto 0);
      Externram_din        : in     std_logic_vector(31 downto 0);
      Externram_done       : in     std_logic;
      
      WramSmall_Mux        : in     std_logic_vector(1 downto 0);
      WramSmallLo_addr     : out    natural range 0 to 4095;
      WramSmallLo_datain   : out    std_logic_vector(31 downto 0);
      WramSmallLo_dataout  : in     std_logic_vector(31 downto 0);
      WramSmallLo_we       : out    std_logic := '0';
      WramSmallLo_be       : out    std_logic_vector(3 downto 0);
      WramSmallHi_addr     : out    natural range 0 to 4095;
      WramSmallHi_datain   : out    std_logic_vector(31 downto 0);
      WramSmallHi_dataout  : in     std_logic_vector(31 downto 0);
      WramSmallHi_we       : out    std_logic := '0';
      WramSmallHi_be       : out    std_logic_vector(3 downto 0);
      
      Palette_addr         : out    natural range 0 to 127;
      Palette_datain       : out    std_logic_vector(31 downto 0);
      Palette_dataout_bgA  : in     std_logic_vector(31 downto 0);
      Palette_dataout_objA : in     std_logic_vector(31 downto 0);
      Palette_dataout_bgB  : in     std_logic_vector(31 downto 0);
      Palette_dataout_objB : in     std_logic_vector(31 downto 0);
      Palette_we_bgA       : out    std_logic := '0';
      Palette_we_objA      : out    std_logic := '0';
      Palette_we_bgB       : out    std_logic := '0';
      Palette_we_objB      : out    std_logic := '0';
      Palette_be           : out    std_logic_vector(3 downto 0);
      
      VRam_addr            : out    std_logic_vector(23 downto 0) := (others => '0');
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
      VRam_we              : out    std_logic := '0';
      VRam_be              : out    std_logic_vector(3 downto 0);
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
      OAMRam_datain        : out    std_logic_vector(31 downto 0);
      OAMRam_dataout_A     : in     std_logic_vector(31 downto 0);
      OAMRam_dataout_B     : in     std_logic_vector(31 downto 0);
      OAMRam_we_A          : out    std_logic := '0';
      OAMRam_we_B          : out    std_logic := '0';
      OAMRam_be            : out    std_logic_vector(3 downto 0);
      
      IPC_fifo_enable      : out   std_logic := '0';    
      IPC_fifo_data        : in    std_logic_vector(31 downto 0);
      
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

architecture arch of ds_memorymux9data is

   type tState is
   (
      IDLE,
      READDTCM,
      READITCM,
      READLARGERAM,
      READWRAMSMALL,
      READDSBUS,
      READDSBUS_1,
      READPALETTE,
      READVRAM,
      READOAM,
      READBIOS,
      READIPCFIFO,
      READGAMECARD,
      ROTATE,
      WRITELARGERAM,
      AUXSPIWAITCMD,
      AUXSPIWAITCMD2,
      AUXSPICMD,
      AUXSPIWAITRAM
   );
   signal state : tState := IDLE;
   
   signal read_delay       : std_logic := '0';
      
   signal acc_save         : std_logic_vector(1 downto 0);
      
   signal return_rotate    : std_logic_vector(1 downto 0);
   signal rotate_data      : std_logic_vector(31 downto 0);
   
   signal wramsmallswitch  : std_logic;
   signal palettemux       : integer range 0 to 3;
   signal oammux           : integer range 0 to 1;
      
   -- DSBUS 
   signal dsbus_data       : std_logic_vector(31 downto 0);
   
   -- DTCM
   signal DTCM_addr        : natural range 0 to 4095;
   signal DTCM_datain      : std_logic_vector(31 downto 0);
   signal DTCM_dataout     : std_logic_vector(31 downto 0);
   signal DTCM_we          : std_logic := '0';
   signal DTCM_be          : std_logic_vector(3 downto 0);
   
   
begin 

   iDTCM : entity MEM.SyncRamByteEnable
   generic map
   (
      ADDR_WIDTH => 12
   )
   port map
   (
      clk        => clk100,
      
      addr      => DTCM_addr,   
      datain0   => DTCM_datain( 7 downto  0), 
      datain1   => DTCM_datain(15 downto  8),
      datain2   => DTCM_datain(23 downto 16),
      datain3   => DTCM_datain(31 downto 24),
      dataout   => DTCM_dataout,
      we        => DTCM_we,    
      be        => DTCM_be          
   );
   DTCM_addr <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));

   BIOS_addr <= mem_bus_Adr(11 downto 2);

   ITCM_addr <= to_integer(unsigned(mem_bus_Adr(14 downto 2)));

   WramSmallLo_addr <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));
   WramSmallHi_addr <= to_integer(unsigned(mem_bus_Adr(13 downto 2)));

   Palette_addr <= to_integer(unsigned(mem_bus_Adr(8 downto 2)));
   
   OAMRam_addr  <= to_integer(unsigned(mem_bus_Adr(9 downto 2)));

   process (clk100)
      variable byteenable : std_logic_vector(3 downto 0);
      variable writedata  : std_logic_vector(31 downto 0);
   begin
      if rising_edge(clk100) then
      
         mem_bus_done    <= '0';
         DTCM_we         <= '0';
         ITCM_we         <= '0';
         Externram_ena   <= '0';
         WramSmallLo_we  <= '0';
         WramSmallHi_we  <= '0';
         Palette_we_bgA  <= '0';
         Palette_we_objA <= '0';
         Palette_we_bgB  <= '0';
         Palette_we_objB <= '0';
         VRam_we         <= '0';
         OAMRam_we_A     <= '0';
         OAMRam_we_B     <= '0';
         
         ds_bus_out.ena  <= '0';
         ds_bus_out.rst  <= reset;
         
         IPC_fifo_enable <= '0';
         
         gc_read         <= '0';
         
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
      
         if (reset = '1') then  
         
            state           <= IDLE;
            
         else
       
            if (read_delay = '1') then
               read_delay <= '0';
            end if;
       
            case state is
         
               when IDLE =>
         
                  if (mem_bus_ena = '1') then
                  
                     acc_save       <= mem_bus_acc;
                     return_rotate  <= mem_bus_Adr(1 downto 0);
                     
                     if (mem_bus_iscpu = '1' and (mem_bus_Adr(31 downto 14)) = DTCMRegion(31 downto 14)) then
                     
                        if (mem_bus_rnw = '1') then
                           state        <= READDTCM;
                        else
                           DTCM_we      <= '1';
                           DTCM_datain  <= writedata;
                           DTCM_be      <= byteenable;
                           mem_bus_done <= '1';
                        end if;
                     
                     else
              
                        if (mem_bus_rnw = '1') then  -- read
                     
                           case (mem_bus_Adr(31 downto 24)) is
                              
                              when x"00" | x"01" =>
                                 if (mem_bus_iscpu = '1') then
                                    state        <= READITCM;
                                 else
                                    mem_bus_din  <= (others => '0');
                                    mem_bus_done <= '1';
                                 end if;
                           
                              when x"02" =>
                                 state          <= READLARGERAM;
                                 Externram_Adr  <= (28 downto 22 => '0') & mem_bus_Adr(21 downto 2) & "00";
                                 Externram_rnw  <= '1';
                                 Externram_ena  <= '1';
                                 
                              when x"03" =>
                                 state           <= READWRAMSMALL;
                                 wramsmallswitch <= mem_bus_Adr(14);                             
                                 
                              when x"04" =>
                                 if (unsigned(mem_bus_Adr(23 downto 0)) <= x"00106C") then
                                    ds_bus_out.adr <= (ds_bus_out.adr'left downto 13 => '0') & mem_bus_Adr(12 downto 2) & "00";
                                    ds_bus_out.acc <= mem_bus_acc;
                                    ds_bus_out.rnw <= '1';
                                    ds_bus_out.ena <= '1';
                                    state          <= READDSBUS;
                                    read_delay     <= '1';
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
                        
                        else -- write
   
                           case (mem_bus_Adr(31 downto 24)) is
                           
                              when x"00" | x"01" =>
                                 mem_bus_done <= '1';
                                 if (mem_bus_iscpu = '1') then
                                    ITCM_we      <= '1';
                                    ITCM_datain  <= writedata;
                                    ITCM_be      <= byteenable;
                                 end if;
                              
                              when x"02" =>
                                 state          <= WRITELARGERAM;
                                 Externram_Adr  <= (28 downto 22 => '0') & mem_bus_Adr(21 downto 2) & "00";
                                 Externram_rnw  <= '0';
                                 Externram_ena  <= '1';
                                 Externram_dout <= writedata;
                                 Externram_be   <= byteenable;
                                 
                              when x"03" =>
                                 mem_bus_done       <= '1';
                                 WramSmallLo_datain <= writedata;
                                 WramSmallLo_be     <= byteenable;
                                 WramSmallHi_datain <= writedata;
                                 WramSmallHi_be     <= byteenable;
                                 case (WramSmall_Mux) is
                                    when "00" =>
                                       if (mem_bus_Adr(14) = '1') then
                                          WramSmallHi_we <= '1';
                                       else
                                          WramSmallLo_we <= '1';
                                       end if;
                                    when "01" => WramSmallHi_we <= '1';
                                    when "10" => WramSmallLo_we <= '1';
                                    when others => null;
                                 end case;
                                 
                              when x"04" => 
                                 if (unsigned(mem_bus_Adr(23 downto 0)) <= x"00106C") then
                                    ds_bus_out.adr  <= (ds_bus_out.adr'left downto 13 => '0') & mem_bus_Adr(12 downto 2) & "00";
                                    ds_bus_out.Din  <= writedata;
                                    ds_bus_out.acc  <= mem_bus_acc;
                                    ds_bus_out.rnw  <= '0';
                                    ds_bus_out.ena  <= '1';
                                    ds_bus_out.BEna <= byteenable;
                                 end if;
                                 
                                 if (unsigned(mem_bus_Adr(23 downto 2) & "00") = x"0001A0" and byteenable(2) = '1') then
                                    state  <= AUXSPIWAITCMD;
                                 else
                                    mem_bus_done <= '1';
                                 end if;
                                 
                              when x"05" =>
                                 mem_bus_done <= '1';
                                 if (mem_bus_acc = ACCESS_8BIT) then
                                    if (mem_bus_Adr(1) = '1') then
                                       Palette_datain <= mem_bus_dout(7 downto 0) & mem_bus_dout(7 downto 0) & x"0000";
                                       Palette_be     <= "1100";
                                    else
                                       Palette_datain <= x"0000" & mem_bus_dout(7 downto 0) & mem_bus_dout(7 downto 0);
                                       Palette_be     <= "0011";
                                    end if;
                                 else
                                    Palette_datain <= writedata;
                                    Palette_be     <= byteenable;
                                 end if;
                                 case(mem_bus_Adr(10 downto 9)) is
                                    when "00" => Palette_we_bgA  <= '1';
                                    when "01" => Palette_we_objA <= '1';
                                    when "10" => Palette_we_bgB  <= '1';
                                    when "11" => Palette_we_objB <= '1';
                                    when others => null;
                                 end case;
                                 
                              when x"06" =>
                                 if (mem_bus_acc /= ACCESS_8BIT) then
                                    VRam_we      <= '1';
                                 end if;
                                 VRam_addr    <= mem_bus_Adr(23 downto 0);
                                 VRam_datain  <= writedata;
                                 VRam_be      <= byteenable;
                                 mem_bus_done <= '1'; 
                              
                              when x"07" =>
                                 mem_bus_done <= '1';
                                 OAMRam_datain <= writedata;
                                 OAMRam_be     <= byteenable;
                                 if (mem_bus_acc /= ACCESS_8BIT) then
                                    case(mem_bus_Adr(10)) is
                                       when '0' => OAMRam_we_A <= '1';
                                       when '1' => OAMRam_we_B <= '1';
                                       when others => null;
                                    end case;
                                 end if;
                              
                              when others => mem_bus_done <= '1';
                              
                           end case;
                        
                        end if;
                        
                     end if;
               
                  end if;
                  
               when READDTCM =>
                  state        <= ROTATE;
                  rotate_data  <= DTCM_dataout;               
                  
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
                  
               when READDSBUS =>
                  if (read_delay = '0' and haltbus = '0') then
                     state      <= READDSBUS_1;
                     dsbus_data <= ds_bus_in;
                  end if;
                  
               when READDSBUS_1 =>
                  rotate_data <= dsbus_data;
                  state       <= rotate;
                  
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
                        when "01" => mem_bus_din <= rotate_data(7 downto 0)  & rotate_data(31 downto 8);
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





