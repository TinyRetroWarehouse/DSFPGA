library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;

library MEM;

entity ds_bootloader is
   generic
   (
      is_simu                   : std_logic;
      Softmap_DS_WRAM_ADDR      : integer; -- count:   1048576 -- all 32bit used
      Softmap_DS_FIRMWARE_ADDR  : integer; -- count:     65536 -- all 32bit used
      Softmap_DS_SAVERAM_ADDR   : integer; -- count:    262144 -- all 32bit used
      Softmap_DS_SAVESTATE_ADDR : integer; -- count:   2097152 -- all 32bit used
      Softmap_DS_GAMEROM_ADDR   : integer  -- count:  67108864 -- all 32bit used
   );
   port 
   (
      clk100               : in     std_logic; 
      ds_on                : in     std_logic; 
      ds_on_1              : out    std_logic := '0'; 
      reset                : out    std_logic := '0'; 
      Bootloader           : in     std_logic;
         
      load                 : in     std_logic;
      sleep_savestate      : out    std_logic := '0';
      bus_ena_in_9         : in     std_logic;
      bus_ena_in_7         : in     std_logic;
   
      Externram_force      : out    std_logic := '0'; 
      Externram_Adr        : out    std_logic_vector(28 downto 0);
      Externram_rnw        : out    std_logic;
      Externram_ena        : out    std_logic;
      Externram_128        : out    std_logic;
      Externram_be         : out    std_logic_vector(3 downto 0);
      Externram_dout       : out    std_logic_vector(31 downto 0);
      Externram_dout128    : out    std_logic_vector(127 downto 0);
      Externram_din        : in     std_logic_vector(31 downto 0);
      Externram_din128     : in     std_logic_vector(127 downto 0);
      Externram_done       : in     std_logic;
      
      Internbus9_Addr      : buffer std_logic_vector(31 downto 0);
      Internbus9_RnW       : out    std_logic;
      Internbus9_ena       : out    std_logic := '0';
      Internbus9_ACC       : out    std_logic_vector(1 downto 0);
      Internbus9_WriteData : out    std_logic_vector(31 downto 0);
      Internbus9_ReadData  : in     std_logic_vector(31 downto 0);
      Internbus9_done      : in     std_logic;
      
      Internbus7_Addr      : buffer std_logic_vector(31 downto 0);
      Internbus7_RnW       : out    std_logic;
      Internbus7_ena       : out    std_logic := '0';
      Internbus7_ACC       : out    std_logic_vector(1 downto 0);
      Internbus7_WriteData : out    std_logic_vector(31 downto 0);
      Internbus7_ReadData  : in     std_logic_vector(31 downto 0);
      Internbus7_done      : in     std_logic
   );
end entity;

architecture arch of ds_bootloader is

   -- Bootloader
   type tstate is
   (
      INITRESET,
      START,
      PARSEHEADER,
      ARM9CODE_WAITREAD,
      ARM9CODE_WAITWRITE,
      ARM7CODE_WAITREAD,
      ARM7CODE_WAITWRITE,
      BOOTDONE,
      
      LOAD_WAITSETTLE,
      LOAD_HEADERAMOUNTCHECK,
      --LOADINTERNALS_READ,
      --LOADINTERNALS_WRITEFIRST,
      --LOADINTERNALS_WRITE,
      --LOADREGISTER_READ,
      --LOADREGISTER_WRITEFIRST,
      --LOADREGISTER_WRITE,
      LOADMEMORY_NEXT,
      LOADMEMORY_READ,
      LOADMEMORY_WRITE
   );
   signal state : tstate := START;
   
   signal boot_ram_Adr     : std_logic_vector(28 downto 0) := (others => '0');
   signal boot_ram_rnw     : std_logic := '0';
   signal boot_ram_ena     : std_logic := '0';
   signal boot_ram_be      : std_logic_vector(3 downto 0);
   signal boot_ram_128     : std_logic := '0';
   signal boot_ram_dout    : std_logic_vector(31 downto 0) := (others => '0');
   signal boot_ram_dout128 : std_logic_vector(127 downto 0) := (others => '0');
   
   signal boot_readpos   : unsigned(23 downto 0); -- 256Mbyte roms
   signal boot_writepos  : unsigned(23 downto 0);
   signal boot_readbase  : integer;
   signal boot_writebase : integer;
   signal boot_count     : integer range 0 to 268435455;
   signal boot_firstread : std_logic := '0';
   
   signal cardSize       : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM9_CODE_SRC  : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM9_CODE_PC   : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM9_CODE_DST  : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM9_CODE_SIZE : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM7_CODE_SRC  : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM7_CODE_PC   : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM7_CODE_DST  : std_logic_vector(31 downto 0) := (others => '0');
   signal ARM7_CODE_SIZE : std_logic_vector(31 downto 0) := (others => '0');
   
   -- savestates
   constant STATESIZE      : integer := 16#135004#;
   
   constant SETTLECOUNT    : integer := 100;
   constant HEADERCOUNT    : integer := 4;
   constant INTERNALSCOUNT : integer := 1024;
   constant REGISTERCOUNT  : integer := 2048;
   
   constant SAVETYPESCOUNT : integer := 10;
   signal savetype_counter : integer range 0 to SAVETYPESCOUNT;
   type t_savetype is record
      addr    : std_logic_vector(31 downto 0);
      count   : integer;
      isArm9  : std_logic;
      gpuonly : std_logic;
   end record;
   type t_savetypes is array(0 to SAVETYPESCOUNT - 1) of t_savetype;
   constant savetypes : t_savetypes := 
   (
   --    addr     count(dw) isArm9 GPUonly
      (x"02000000", 1048576, '1',    '0'), -- WRAM_Large
      (x"03000000",   16384, '0',    '0'), -- WRAM_Small_64
      (x"03800000",    8192, '0',    '0'), -- WRAM_Small_32
      (x"06800000",  167936, '1',    '1'), -- VRam
      (x"07000000",     512, '1',    '1'), -- OAM
      (x"05000000",     512, '1',    '1'), -- Palette
      (x"01000000",    8192, '1',    '0'), -- ITCM
      (x"00000000",    4096, '1',    '0'), -- DTCM
      (x"04000000",    4096, '1',    '1'), -- Reg9
      (x"04000000",    4096, '0',    '1')  -- Reg7
   );
   
   signal count         : integer range 0 to 1048576 := 0;
   signal maxcount      : integer range 0 to 1048576;
   signal data_isArm9   : std_logic;
                        
   signal settle        : integer range 0 to SETTLECOUNT := 0;
                        
   signal wordcount     : integer range 0 to 3;
   signal DataBuffer    : std_logic_vector(95 downto 0);
   
   signal header_amount : unsigned(31 downto 0) := (others => '0');

begin 

   Externram_Adr        <= boot_ram_Adr;    
   Externram_rnw        <= boot_ram_rnw;    
   Externram_ena        <= boot_ram_ena;    
   Externram_128        <= boot_ram_128;     
   Externram_be         <= boot_ram_be;    
   Externram_dout       <= boot_ram_dout;   
   Externram_dout128    <= boot_ram_dout128;

   Internbus9_ACC <= ACCESS_32BIT;
   Internbus7_ACC <= ACCESS_32BIT;

   -- bootloader
   boot_ram_be <= "1111";
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         reset        <= '0';
         
         boot_ram_ena   <= '0';
         boot_firstread <= '0';
         
         Internbus9_ena <= '0';
         Internbus7_ena <= '0';
      
         if (ds_on = '0') then
      
            state           <= INITRESET;
            ds_on_1         <= '0';
            sleep_savestate <= '0';
      
         else 
         
            case state is
            
               when INITRESET =>
                  reset         <= '1';
                  if (Bootloader = '1') then
                     state       <= START;
                     Externram_force <= '1';
                  else
                     Externram_force <= '0';
                     state       <= BOOTDONE;
                     ds_on_1         <= '1';
                  end if;
                  boot_readpos  <= to_unsigned(16#14# + 4, 24); -- 0x14 byte => cardsize
                  boot_readbase <= Softmap_DS_GAMEROM_ADDR;
                  boot_ram_128  <= '0';
               
               when START =>   
                  state    <= PARSEHEADER;
                  boot_ram_ena <= '1';
                  boot_ram_Adr <= std_logic_vector(to_unsigned(boot_readbase, 29) + boot_readpos);
                  boot_ram_rnw <= '1';
                  
               when PARSEHEADER =>
                  if (Externram_done = '1') then
                     if (boot_readpos < 16#40#) then
                        boot_readpos <= boot_readpos + 4;
                        boot_ram_ena <= '1';
                        boot_ram_Adr <= std_logic_vector(to_unsigned(boot_readbase, 29) + boot_readpos);
                     else
                        state      <= ARM9CODE_WAITWRITE;
                        boot_firstread <= '1';
                        boot_writebase <= Softmap_DS_WRAM_ADDR;
                        boot_readpos   <= unsigned(ARM9_CODE_SRC(23 downto 2)) & "00"; -- dword aligned
                        boot_writepos  <= unsigned(ARM9_CODE_DST(23 downto 2)) & "00";
                        boot_count     <= to_integer(unsigned(ARM9_CODE_SIZE(31 downto 2)));
                     end if;
                     
                     if (boot_readpos = 16#14# + 4) then cardSize       <= Externram_din; end if;
                     if (boot_readpos = 16#20# + 4) then ARM9_CODE_SRC  <= Externram_din; end if;
                     if (boot_readpos = 16#24# + 4) then ARM9_CODE_PC   <= Externram_din; end if;
                     if (boot_readpos = 16#28# + 4) then ARM9_CODE_DST  <= Externram_din; end if;
                     if (boot_readpos = 16#2C# + 4) then ARM9_CODE_SIZE <= Externram_din; end if;
                     if (boot_readpos = 16#30# + 4) then ARM7_CODE_SRC  <= Externram_din; end if;
                     if (boot_readpos = 16#34# + 4) then ARM7_CODE_PC   <= Externram_din; end if;
                     if (boot_readpos = 16#38# + 4) then ARM7_CODE_DST  <= Externram_din; end if;
                     if (boot_readpos = 16#3C# + 4) then ARM7_CODE_SIZE <= Externram_din; end if;
                  end if;
                  
               when ARM9CODE_WAITREAD =>
                  if (Externram_done = '1') then
                     state        <= ARM9CODE_WAITWRITE;
                     boot_ram_ena     <= '1';
                     boot_ram_Adr     <= std_logic_vector(to_unsigned(boot_writebase, 29) + boot_writepos);
                     boot_ram_rnw     <= '0';
                     boot_ram_dout    <= Externram_din;
                     boot_ram_dout128 <= Externram_din128;
                     if (boot_ram_128 = '1') then
                        boot_writepos <= boot_writepos + 16;
                     else
                        boot_writepos <= boot_writepos + 4;
                     end if;
                  end if;
               
               when ARM9CODE_WAITWRITE =>
                  if (Externram_done = '1' or boot_firstread = '1') then
                     if (boot_count > 0) then
                        boot_ram_ena <= '1';
                        boot_ram_Adr <= std_logic_vector(to_unsigned(boot_readbase, 29) + boot_readpos);
                        boot_ram_rnw <= '1';
                        if (boot_readpos(3 downto 2) = "00" and boot_count >= 4) then
                           boot_count   <= boot_count - 4;
                           boot_readpos <= boot_readpos + 16;
                           boot_ram_128 <= '1';
                        else
                           boot_count   <= boot_count - 1;
                           boot_readpos <= boot_readpos + 4;
                           boot_ram_128 <= '0';
                        end if;
                        state    <= ARM9CODE_WAITREAD;
                     else
                        state      <= ARM7CODE_WAITWRITE;
                        boot_firstread <= '1';
                        boot_readpos   <= unsigned(ARM7_CODE_SRC(23 downto 2)) & "00"; -- dword aligned
                        boot_writepos  <= unsigned(ARM7_CODE_DST(23 downto 2)) & "00";
                        boot_count     <= to_integer(unsigned(ARM7_CODE_SIZE(31 downto 2)));
                     end if;
                  end if;
                  
               when ARM7CODE_WAITREAD =>
                  if (Externram_done = '1') then
                     state        <= ARM7CODE_WAITWRITE;
                     if (ARM7_CODE_DST(27 downto 24) = x"2") then
                        boot_ram_ena     <= '1';
                        boot_ram_Adr     <= std_logic_vector(to_unsigned(boot_writebase, 29) + boot_writepos);
                        boot_ram_rnw     <= '0';
                        boot_ram_dout    <= Externram_din;
                        boot_ram_dout128 <= Externram_din128;
                        if (boot_ram_128 = '1') then
                           boot_writepos <= boot_writepos + 16;
                        else
                           boot_writepos <= boot_writepos + 4;
                        end if;
                     else
                        Internbus7_Addr      <= std_logic_vector(to_unsigned(16#03000000#, 32) + boot_writepos);
                        Internbus7_RnW       <= '0';
                        Internbus7_ena       <= '1';
                        Internbus7_WriteData <= Externram_din;
                        boot_writepos        <= boot_writepos + 4;
                     end if;
                  end if;
               
               when ARM7CODE_WAITWRITE => 
                  if (Externram_done = '1' or boot_firstread = '1' or Internbus7_done = '1') then
                     if (boot_count > 0) then
                        boot_ram_ena <= '1';
                        boot_ram_Adr <= std_logic_vector(to_unsigned(boot_readbase, 29) + boot_readpos);
                        boot_ram_rnw <= '1';
                        if (boot_readpos(3 downto 2) = "00" and boot_count >= 4 and ARM7_CODE_DST(27 downto 24) = x"2") then
                           boot_count   <= boot_count - 4;
                           boot_readpos <= boot_readpos + 16;
                           boot_ram_128 <= '1';
                        else
                           boot_count   <= boot_count - 1;
                           boot_readpos <= boot_readpos + 4;
                           boot_ram_128 <= '0';
                        end if;
                        state    <= ARM7CODE_WAITREAD;
                     else
                        state       <= BOOTDONE;
                        ds_on_1         <= '1';
                        Externram_force <= '0';
                     end if;
                  end if;

               when BOOTDONE =>
                  if (load = '1') then
                     state           <= LOAD_WAITSETTLE;
                     sleep_savestate <= '1';
                  end if;
                  
               -- #################
               -- LOAD
               -- #################
               
               when LOAD_WAITSETTLE =>
                  if (bus_ena_in_9 = '1' or bus_ena_in_7 = '1') then
                     settle <= 0;
                  elsif (settle < SETTLECOUNT) then
                     settle <= settle + 1;
                  else
                     state                <= LOAD_HEADERAMOUNTCHECK;
                     boot_ram_Adr         <= std_logic_vector(to_unsigned(Softmap_DS_SAVESTATE_ADDR, Externram_Adr'length));
                     boot_ram_rnw         <= '1';
                     boot_ram_ena         <= '1';
                     Externram_force      <= '1';
                     Internbus9_RnW       <= '0';
                     Internbus7_RnW       <= '0';
                  end if;
                  
               when LOAD_HEADERAMOUNTCHECK =>
                  if (Externram_done = '1') then
                     if (Externram_din128(31 downto 0) /= x"00000000") then
                        header_amount        <= unsigned(Externram_din128(31 downto 0));
                        state                <= LOADMEMORY_NEXT;
                        boot_ram_Adr         <= std_logic_vector(to_unsigned(Softmap_DS_SAVESTATE_ADDR + HEADERCOUNT * 4, Externram_Adr'length));
                        boot_ram_rnw         <= '1';
                        boot_ram_ena         <= '1';
                        Externram_force      <= '1';
                        count                <= 4;
                        --loading_savestate    <= '1';
                     else
                        state                <= BOOTDONE;
                        sleep_savestate      <= '0';
                        Externram_force      <= '0';
                     end if;
                  end if;
               
               --when LOADINTERNALS_READ =>
               --   if (Externram_done = '1') then
               --      Externram_force       <= '0';
               --      state                <= LOADINTERNALS_WRITEFIRST;
               --      internal_bus_out.Din <= Externram_din128(31 downto 0);
               --      internal_bus_out.ena <= '1';
               --   end if;
               --   
               --when LOADINTERNALS_WRITEFIRST =>
               --   if (internal_bus_out.done = '1') then
               --      state                <= LOADINTERNALS_WRITE;
               --      internal_bus_out.adr <= std_logic_vector(unsigned(internal_bus_out.adr) + 1);
               --      internal_bus_out.Din <= Externram_din128(63 downto 32);
               --      internal_bus_out.ena <= '1';
               --   end if;
               --
               --when LOADINTERNALS_WRITE => 
               --   if (internal_bus_out.done = '1') then
               --      boot_ram_Adr <= std_logic_vector(unsigned(boot_ram_Adr) + 2);
               --      if (count < INTERNALSCOUNT) then
               --         state          <= LOADINTERNALS_READ;
               --         count          <= count + 2;
               --         boot_ram_ena    <= '1';
               --         Externram_force <= '1';
               --         internal_bus_out.adr <= std_logic_vector(unsigned(internal_bus_out.adr) + 1);
               --      else 
               --         state              <= LOADREGISTER_READ;
               --         SAVE_BusAddr       <= x"4000000";
               --         registerram_addr_w <= 0;
               --         count              <= 2;
               --         boot_ram_ena        <= '1';
               --         Externram_force     <= '1';
               --      end if;
               --   end if;
                  
               --when LOADREGISTER_READ =>
               --   if (Externram_done = '1') then
               --      Externram_force       <= '0';
               --      state                <= LOADREGISTER_WRITEFIRST;
               --      SAVE_BusWriteData    <= Externram_din128(31 downto 0);
               --      SAVE_Bus_ena         <= '1';
               --      registerram_DataIn   <= Externram_din128(31 downto 0);
               --      registerram_we       <= "1111";
               --   end if;
               --   
               --when LOADREGISTER_WRITEFIRST => 
               --   if (SAVE_BusReadDone = '1') then
               --      state                <= LOADREGISTER_WRITE;
               --      SAVE_BusAddr         <= std_logic_vector(unsigned(SAVE_BusAddr) + 4);
               --      SAVE_BusWriteData    <= Externram_din128(63 downto 32);
               --      SAVE_Bus_ena         <= '1';
               --      registerram_DataIn   <= Externram_din128(63 downto 32);
               --      registerram_we       <= "1111";
               --      registerram_addr_w   <= registerram_addr_w + 1;
               --   end if;
               --
               --when LOADREGISTER_WRITE => 
               --   if (SAVE_BusReadDone = '1') then
               --      SAVE_BusAddr <= std_logic_vector(unsigned(SAVE_BusAddr) + 4);
               --      boot_ram_Adr <= std_logic_vector(unsigned(boot_ram_Adr) + 2);
               --      if (count < REGISTERCOUNT) then
               --         state              <= LOADREGISTER_READ;
               --         count              <= count + 2;
               --         boot_ram_ena        <= '1';
               --         Externram_force     <= '1';
               --         registerram_addr_w <= registerram_addr_w + 1;
               --      else 
               --         state       <= LOADMEMORY_NEXT;
               --      end if;
               --   end if;
               
               when LOADMEMORY_NEXT =>
                  if (savetype_counter < SAVETYPESCOUNT) then
                     if (is_simu= '1' and savetypes(savetype_counter).gpuonly = '0') then
                        boot_ram_Adr     <= std_logic_vector(unsigned(boot_ram_Adr) + savetypes(savetype_counter).count * 4);
                        savetype_counter <= savetype_counter + 1;
                     else
                        state           <= LOADMEMORY_READ;
                        count           <= 4;
                        maxcount        <= savetypes(savetype_counter).count;
                        Internbus9_Addr <= savetypes(savetype_counter).addr;
                        Internbus7_Addr <= savetypes(savetype_counter).addr;
                        data_isArm9     <= savetypes(savetype_counter).isArm9;
                        boot_ram_ena    <= '1';
                        Externram_force <= '1';
                     end if;
                  else
                     state             <= BOOTDONE;
                     --reset             <= '1';
                     Externram_force   <= '0';
                     --loading_savestate <= '0';
                     sleep_savestate   <= '0';
                  end if;
               
               when LOADMEMORY_READ =>
                  if (Externram_done = '1') then
                     boot_ram_Adr         <= std_logic_vector(unsigned(boot_ram_Adr) + 16);
                     Externram_force      <= '0';
                     state                <= LOADMEMORY_WRITE;
                     DataBuffer           <= Externram_din128(127 downto 32);
                     wordcount            <= 0;
                     Internbus9_WriteData <= Externram_din128(31 downto 0);
                     Internbus7_WriteData <= Externram_din128(31 downto 0);
                     Internbus9_ena       <= data_isArm9;
                     Internbus7_ena       <= not data_isArm9;
                  end if;
                  
               when LOADMEMORY_WRITE =>
                  if (Internbus9_done = '1' or Internbus7_done = '1') then
                     Internbus9_Addr      <= std_logic_vector(unsigned(Internbus9_Addr) + 4);
                     Internbus7_Addr      <= std_logic_vector(unsigned(Internbus7_Addr) + 4);
                     if (wordcount < 3) then
                        wordcount            <= wordcount + 1;
                        Internbus9_WriteData <= DataBuffer(31 downto 0);
                        Internbus7_WriteData <= DataBuffer(31 downto 0);
                        Internbus9_ena       <= data_isArm9;
                        Internbus7_ena       <= not data_isArm9;
                        DataBuffer           <= (31 downto 0 => '0') & DataBuffer(95 downto 32);
                     else
                        if (count < maxcount) then
                           state           <= LOADMEMORY_READ;
                           count           <= count + 4;
                           boot_ram_ena    <= '1';
                           Externram_force <= '1';
                        else 
                           savetype_counter <= savetype_counter + 1;
                           state            <= LOADMEMORY_NEXT;
                        end if;
                     end if;
                  end if;
                  
            end case;
            
         end if;
      
      end if;
   end process;
   
   

end architecture;





