library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library procbus;
use procbus.pProc_bus.all;
use procbus.pRegmap.all;

library reg_map;
use reg_map.pReg_ds.all;

entity ds is
   generic
   (
      is_simu  : std_logic;
      ds_nogpu : std_logic
   );
   port 
   (
      clk100             : in    std_logic;   
      
      bus_in             : in  proc_bus_intype;
      bus_Dout           : out std_logic_vector(proc_buswidth-1 downto 0);
      bus_done           : out std_logic;
      
      -- RAM access
      DS_RAM_Adr         : out    std_logic_vector(28 downto 0);
      DS_RAM_rnw         : out    std_logic;
      DS_RAM_ena         : out    std_logic;
      DS_RAM_be          : out    std_logic_vector(3 downto 0);
      DS_RAM_128         : out    std_logic;
      DS_RAM_dout        : out    std_logic_vector(31 downto 0);
      DS_RAM_dout128     : out    std_logic_vector(127 downto 0);
      DS_RAM_din         : in     std_logic_vector(31 downto 0);
      DS_RAM_din128      : in     std_logic_vector(127 downto 0);
      DS_RAM_done        : in     std_logic;
      -- display data
      pixel_out1_x       : out   integer range 0 to 255;
      pixel_out1_y       : out   integer range 0 to 191;
      pixel_out1_data    : out   std_logic_vector(17 downto 0);  -- RGB data for framebuffer 
      pixel_out1_we      : out   std_logic;                      -- new pixel for framebuffer 
      pixel_out2_x       : out   integer range 0 to 255;
      pixel_out2_y       : out   integer range 0 to 191;
      pixel_out2_data    : out   std_logic_vector(17 downto 0);  -- RGB data for framebuffer 
      pixel_out2_we      : out   std_logic;                      -- new pixel for framebuffer 
      -- sound                            
      sound_out_left     : out   std_logic_vector(15 downto 0) := (others => '0');
      sound_out_right    : out   std_logic_vector(15 downto 0) := (others => '0');
      -- touch
      TouchX             : out   std_logic_vector(7 downto 0);
      TouchY             : out   std_logic_vector(7 downto 0)
   );
end entity;

architecture arch of ds is

   -- settings
   signal ds_on             : std_logic_vector(Reg_DS_on.upper             downto Reg_DS_on.lower)             := (others => '0');
   signal ds_lockspeed      : std_logic_vector(Reg_DS_lockspeed.upper      downto Reg_DS_lockspeed.lower)      := (others => '0');
   signal ds_freerunclock   : std_logic_vector(Reg_DS_freerunclock.upper   downto Reg_DS_freerunclock.lower)   := (others => '0');
   signal ds_enablecpu      : std_logic_vector(Reg_DS_enablecpu.upper      downto Reg_DS_enablecpu.lower)      := (others => '0');
   signal ds_cputurbo       : std_logic_vector(Reg_DS_cputurbo.upper       downto Reg_DS_cputurbo.lower)       := (others => '0');
   signal ds_bootloader     : std_logic_vector(Reg_DS_bootloader.upper     downto Reg_DS_bootloader.lower)     := (others => '0');
                            
   signal ds_PC9Entry       : std_logic_vector(Reg_DS_PC9Entry.upper       downto Reg_DS_PC9Entry.lower)       := (others => '0');
   signal ds_PC7Entry       : std_logic_vector(Reg_DS_PC7Entry.upper       downto Reg_DS_PC7Entry.lower)       := (others => '0');
   signal ds_ChipID         : std_logic_vector(Reg_DS_ChipID  .upper       downto Reg_DS_ChipID  .lower)       := (others => '0');
                            
   signal ds_SaveState      : std_logic_vector(Reg_DS_SaveState.upper      downto Reg_DS_SaveState.lower)      := (others => '0');
   signal ds_LoadState      : std_logic_vector(Reg_DS_LoadState.upper      downto Reg_DS_LoadState.lower)      := (others => '0');
                            
   signal CyclePrecalc      : std_logic_vector(Reg_DS_CyclePrecalc.upper   downto Reg_DS_CyclePrecalc.lower);
   signal CyclesMissing     : std_logic_vector(Reg_DS_CyclesMissing.upper  downto Reg_DS_CyclesMissing.lower)  := (others => '0');
   signal CyclesVsyncSpeed9 : std_logic_vector(Reg_DS_VsyncSpeed9.upper    downto Reg_DS_VsyncSpeed9.lower);               
   signal CyclesVsyncSpeed7 : std_logic_vector(Reg_DS_VsyncSpeed7.upper    downto Reg_DS_VsyncSpeed7.lower);              
   signal CyclesVsyncIdle9  : std_logic_vector(Reg_DS_VsyncIdle9.upper     downto Reg_DS_VsyncIdle9.lower);               
   signal CyclesVsyncIdle7  : std_logic_vector(Reg_DS_VsyncIdle7.upper     downto Reg_DS_VsyncIdle7.lower);               
                           
   signal ds_Bus9Addr       : std_logic_vector(Reg_DS_Bus9Addr     .upper downto Reg_DS_Bus9Addr     .lower) := (others => '0');
   signal ds_Bus9RnW        : std_logic_vector(Reg_DS_Bus9RnW      .upper downto Reg_DS_Bus9RnW      .lower) := (others => '0');
   signal ds_Bus9ACC        : std_logic_vector(Reg_DS_Bus9ACC      .upper downto Reg_DS_Bus9ACC      .lower) := (others => '0');
   signal ds_Bus9WriteData  : std_logic_vector(Reg_DS_Bus9WriteData.upper downto Reg_DS_Bus9WriteData.lower) := (others => '0');
   signal ds_Bus9ReadData   : std_logic_vector(Reg_DS_Bus9ReadData .upper downto Reg_DS_Bus9ReadData .lower) := (others => '0');
   signal ds_Bus9_written   : std_logic;   
                            
   signal ds_Bus7Addr       : std_logic_vector(Reg_DS_Bus7Addr     .upper downto Reg_DS_Bus7Addr     .lower) := (others => '0');
   signal ds_Bus7RnW        : std_logic_vector(Reg_DS_Bus7RnW      .upper downto Reg_DS_Bus7RnW      .lower) := (others => '0');
   signal ds_Bus7ACC        : std_logic_vector(Reg_DS_Bus7ACC      .upper downto Reg_DS_Bus7ACC      .lower) := (others => '0');
   signal ds_Bus7WriteData  : std_logic_vector(Reg_DS_Bus7WriteData.upper downto Reg_DS_Bus7WriteData.lower) := (others => '0');
   signal ds_Bus7ReadData   : std_logic_vector(Reg_DS_Bus7ReadData .upper downto Reg_DS_Bus7ReadData .lower) := (others => '0');
   signal ds_Bus7_written   : std_logic;   
   
   
   signal ds_KeyUp     : std_logic_vector(Reg_DS_KeyUp    .upper downto Reg_DS_KeyUp    .lower) := (others => '0');
   signal ds_KeyDown   : std_logic_vector(Reg_DS_KeyDown  .upper downto Reg_DS_KeyDown  .lower) := (others => '0');
   signal ds_KeyLeft   : std_logic_vector(Reg_DS_KeyLeft  .upper downto Reg_DS_KeyLeft  .lower) := (others => '0');
   signal ds_KeyRight  : std_logic_vector(Reg_DS_KeyRight .upper downto Reg_DS_KeyRight .lower) := (others => '0');
   signal ds_KeyA      : std_logic_vector(Reg_DS_KeyA     .upper downto Reg_DS_KeyA     .lower) := (others => '0');
   signal ds_KeyB      : std_logic_vector(Reg_DS_KeyB     .upper downto Reg_DS_KeyB     .lower) := (others => '0');
   signal ds_KeyX      : std_logic_vector(Reg_DS_KeyX     .upper downto Reg_DS_KeyX     .lower) := (others => '0');
   signal ds_KeyY      : std_logic_vector(Reg_DS_KeyY     .upper downto Reg_DS_KeyY     .lower) := (others => '0');
   signal ds_KeyL      : std_logic_vector(Reg_DS_KeyL     .upper downto Reg_DS_KeyL     .lower) := (others => '0');
   signal ds_KeyR      : std_logic_vector(Reg_DS_KeyR     .upper downto Reg_DS_KeyR     .lower) := (others => '0');
   signal ds_KeyStart  : std_logic_vector(Reg_DS_KeyStart .upper downto Reg_DS_KeyStart .lower) := (others => '0');
   signal ds_KeySelect : std_logic_vector(Reg_DS_KeySelect.upper downto Reg_DS_KeySelect.lower) := (others => '0');
   signal ds_Touch     : std_logic_vector(Reg_DS_Touch    .upper downto Reg_DS_Touch    .lower) := (others => '0');
   signal ds_TouchX    : std_logic_vector(Reg_DS_TouchX   .upper downto Reg_DS_TouchX   .lower) := (others => '0');
   signal ds_TouchY    : std_logic_vector(Reg_DS_TouchY   .upper downto Reg_DS_TouchY   .lower) := (others => '0');
   
   signal DS_DebugCycling : std_logic_vector(Reg_DS_DebugCycling.upper downto Reg_DS_DebugCycling.lower) := (others => '0');
   signal DS_DebugCPU9    : std_logic_vector(Reg_DS_DebugCPU9   .upper downto Reg_DS_DebugCPU9   .lower) := (others => '0');
   signal DS_DebugCPU7    : std_logic_vector(Reg_DS_DebugCPU7   .upper downto Reg_DS_DebugCPU7   .lower) := (others => '0');
   signal DS_DebugDMA9    : std_logic_vector(Reg_DS_DebugDMA9   .upper downto Reg_DS_DebugDMA9   .lower) := (others => '0');
   signal DS_DebugDMA7    : std_logic_vector(Reg_DS_DebugDMA7   .upper downto Reg_DS_DebugDMA7   .lower) := (others => '0');
   
begin 

   -- registers
   iReg_DS_on             : entity procbus.eProcReg generic map (Reg_DS_on      )       port map (clk100, bus_in, bus_Dout, bus_done, ds_on, ds_on);      
   iReg_DS_lockspeed      : entity procbus.eProcReg generic map (Reg_DS_lockspeed)      port map (clk100, bus_in, bus_Dout, bus_done, ds_lockspeed, ds_lockspeed);   
   iReg_DS_freerunclock   : entity procbus.eProcReg generic map (Reg_DS_freerunclock)   port map (clk100, bus_in, bus_Dout, bus_done, ds_freerunclock, ds_freerunclock);   
   iReg_DS_enablecpu      : entity procbus.eProcReg generic map (Reg_DS_enablecpu)      port map (clk100, bus_in, bus_Dout, bus_done, ds_enablecpu, ds_enablecpu);   
   iReg_DS_cputurbo       : entity procbus.eProcReg generic map (Reg_DS_cputurbo)       port map (clk100, bus_in, bus_Dout, bus_done, ds_cputurbo, ds_cputurbo);  
   iReg_DS_bootloader     : entity procbus.eProcReg generic map (Reg_DS_bootloader)     port map (clk100, bus_in, bus_Dout, bus_done, ds_bootloader, ds_bootloader);  
   
   iReg_DS_PC9Entry       : entity procbus.eProcReg generic map (Reg_DS_PC9Entry)       port map (clk100, bus_in, bus_Dout, bus_done, ds_PC9Entry, ds_PC9Entry);   
   iReg_DS_PC7Entry       : entity procbus.eProcReg generic map (Reg_DS_PC7Entry)       port map (clk100, bus_in, bus_Dout, bus_done, ds_PC7Entry, ds_PC7Entry);   
   iReg_DS_ChipID         : entity procbus.eProcReg generic map (Reg_DS_ChipID)         port map (clk100, bus_in, bus_Dout, bus_done, ds_ChipID  , ds_ChipID);   
                          
   iReg_DS_SaveState      : entity procbus.eProcReg generic map (Reg_DS_SaveState )     port map (clk100, bus_in, bus_Dout, bus_done, ds_SaveState , ds_SaveState );   
   iReg_DS_LoadState      : entity procbus.eProcReg generic map (Reg_DS_LoadState )     port map (clk100, bus_in, bus_Dout, bus_done, ds_LoadState , ds_LoadState );   
                             
   iReg_CyclesMissing     : entity procbus.eProcReg generic map (Reg_DS_CyclesMissing)  port map (clk100, bus_in, bus_Dout, bus_done, CyclesMissing);  
   iReg_CyclePrecalc      : entity procbus.eProcReg generic map (Reg_DS_CyclePrecalc)   port map (clk100, bus_in, bus_Dout, bus_done, CyclePrecalc, CyclePrecalc);  
   iReg_DS_VsyncSpeed9    : entity procbus.eProcReg generic map (Reg_DS_VsyncSpeed9)    port map (clk100, bus_in, bus_Dout, bus_done, CyclesVsyncSpeed9);  
   iReg_DS_VsyncSpeed7    : entity procbus.eProcReg generic map (Reg_DS_VsyncSpeed7)    port map (clk100, bus_in, bus_Dout, bus_done, CyclesVsyncSpeed7);   
   iReg_DS_VsyncIdle9     : entity procbus.eProcReg generic map (Reg_DS_VsyncIdle9)     port map (clk100, bus_in, bus_Dout, bus_done, CyclesVsyncIdle9);  
   iReg_DS_VsyncIdle7     : entity procbus.eProcReg generic map (Reg_DS_VsyncIdle7)     port map (clk100, bus_in, bus_Dout, bus_done, CyclesVsyncIdle7);  
                             
   iReg_DS_Bus9Addr       : entity procbus.eProcReg generic map (Reg_DS_Bus9Addr     ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus9Addr     , ds_Bus9Addr     , ds_Bus9_written);  
   iReg_DS_Bus9RnW        : entity procbus.eProcReg generic map (Reg_DS_Bus9RnW      ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus9RnW      , ds_Bus9RnW      );  
   iReg_DS_Bus9ACC        : entity procbus.eProcReg generic map (Reg_DS_Bus9ACC      ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus9ACC      , ds_Bus9ACC      );  
   iReg_DS_Bus9WriteData  : entity procbus.eProcReg generic map (Reg_DS_Bus9WriteData) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus9WriteData, ds_Bus9WriteData);  
   iReg_DS_Bus9ReadData   : entity procbus.eProcReg generic map (Reg_DS_Bus9ReadData ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus9ReadData);  

   iReg_DS_Bus7Addr       : entity procbus.eProcReg generic map (Reg_DS_Bus7Addr     ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus7Addr     , ds_Bus7Addr     , ds_Bus7_written);  
   iReg_DS_Bus7RnW        : entity procbus.eProcReg generic map (Reg_DS_Bus7RnW      ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus7RnW      , ds_Bus7RnW      );  
   iReg_DS_Bus7ACC        : entity procbus.eProcReg generic map (Reg_DS_Bus7ACC      ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus7ACC      , ds_Bus7ACC      );  
   iReg_DS_Bus7WriteData  : entity procbus.eProcReg generic map (Reg_DS_Bus7WriteData) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus7WriteData, ds_Bus7WriteData);  
   iReg_DS_Bus7ReadData   : entity procbus.eProcReg generic map (Reg_DS_Bus7ReadData ) port map (clk100, bus_in, bus_Dout, bus_done, ds_Bus7ReadData);  

   iReg_Gameboy_KeyUp     : entity procbus.eProcReg generic map (Reg_DS_KeyUp    ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyUp    , ds_KeyUp    );  
   iReg_Gameboy_KeyDown   : entity procbus.eProcReg generic map (Reg_DS_KeyDown  ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyDown  , ds_KeyDown  );  
   iReg_Gameboy_KeyLeft   : entity procbus.eProcReg generic map (Reg_DS_KeyLeft  ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyLeft  , ds_KeyLeft  );  
   iReg_Gameboy_KeyRight  : entity procbus.eProcReg generic map (Reg_DS_KeyRight ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyRight , ds_KeyRight );  
   iReg_Gameboy_KeyA      : entity procbus.eProcReg generic map (Reg_DS_KeyA     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyA     , ds_KeyA     );  
   iReg_Gameboy_KeyB      : entity procbus.eProcReg generic map (Reg_DS_KeyB     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyB     , ds_KeyB     );  
   iReg_Gameboy_KeyX      : entity procbus.eProcReg generic map (Reg_DS_KeyX     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyX     , ds_KeyX     );  
   iReg_Gameboy_KeyY      : entity procbus.eProcReg generic map (Reg_DS_KeyY     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyY     , ds_KeyY     );  
   iReg_Gameboy_KeyL      : entity procbus.eProcReg generic map (Reg_DS_KeyL     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyL     , ds_KeyL     );  
   iReg_Gameboy_KeyR      : entity procbus.eProcReg generic map (Reg_DS_KeyR     ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyR     , ds_KeyR     );  
   iReg_Gameboy_KeyStart  : entity procbus.eProcReg generic map (Reg_DS_KeyStart ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeyStart , ds_KeyStart );  
   iReg_Gameboy_KeySelect : entity procbus.eProcReg generic map (Reg_DS_KeySelect) port map  (clk100, bus_in, bus_Dout, bus_done, ds_KeySelect, ds_KeySelect); 
   iReg_Gameboy_Touch     : entity procbus.eProcReg generic map (Reg_DS_Touch    ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_Touch    , ds_Touch    ); 
   iReg_Gameboy_TouchX    : entity procbus.eProcReg generic map (Reg_DS_TouchX   ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_TouchX   , ds_TouchX   ); 
   iReg_Gameboy_TouchY    : entity procbus.eProcReg generic map (Reg_DS_TouchY   ) port map  (clk100, bus_in, bus_Dout, bus_done, ds_TouchY   , ds_TouchY   ); 
   
   iReg_DS_DebugCycling   : entity procbus.eProcReg generic map (Reg_DS_DebugCycling) port map  (clk100, bus_in, bus_Dout, bus_done, DS_DebugCycling); 
   iReg_DS_DebugCPU9      : entity procbus.eProcReg generic map (Reg_DS_DebugCPU9   ) port map  (clk100, bus_in, bus_Dout, bus_done, DS_DebugCPU9   ); 
   iReg_DS_DebugCPU7      : entity procbus.eProcReg generic map (Reg_DS_DebugCPU7   ) port map  (clk100, bus_in, bus_Dout, bus_done, DS_DebugCPU7   ); 
   iReg_DS_DebugDMA9      : entity procbus.eProcReg generic map (Reg_DS_DebugDMA9   ) port map  (clk100, bus_in, bus_Dout, bus_done, DS_DebugDMA9   ); 
   iReg_DS_DebugDMA7      : entity procbus.eProcReg generic map (Reg_DS_DebugDMA7   ) port map  (clk100, bus_in, bus_Dout, bus_done, DS_DebugDMA7   ); 
      
   TouchX <= ds_TouchX;
   TouchY <= ds_TouchY;   
      
   ids_top : entity work.ds_top
   generic map
   (
      is_simu                   => is_simu,
      ds_nogpu                  => ds_nogpu,
      Softmap_DS_WRAM_ADDR      => 0,
      Softmap_DS_FIRMWARE_ADDR  => 16#800000#,  --0x200000 * 4
      Softmap_DS_SAVERAM_ADDR   => 16#1000000#, --0x400000 * 4
      Softmap_DS_SAVESTATE_ADDR => 16#1800000#, --0x600000 * 4
      Softmap_DS_GAMEROM_ADDR   => 16#10000000# --0x4000000 * 4
   )
   port map
   (
      clk100             => clk100,
      -- settings                 
      DS_on              => DS_on(0),
      DS_lockspeed       => ds_lockspeed(0),
      CyclePrecalc       => CyclePrecalc,
      FreeRunningClock   => ds_freerunclock(0),
      EnableCpu          => ds_enablecpu(0),
      Bootloader         => ds_bootloader(0),
      PC9Entry           => ds_PC9Entry,
      PC7Entry           => ds_PC7Entry,
      ChipID             => ds_ChipID,
      save_state         => ds_SaveState(0),
      load_state         => ds_LoadState(0),
      -- debug ports
      CyclesMissing      => CyclesMissing,
      CyclesVsyncSpeed9  => CyclesVsyncSpeed9,
      CyclesVsyncSpeed7  => CyclesVsyncSpeed7,
      CyclesVsyncIdle9   => CyclesVsyncIdle9,
      CyclesVsyncIdle7   => CyclesVsyncIdle7,
      DebugCycling       => DS_DebugCycling,
      DebugCPU9          => DS_DebugCPU9,   
      DebugCPU7          => DS_DebugCPU7,   
      DebugDMA9          => DS_DebugDMA9,   
      DebugDMA7          => DS_DebugDMA7,   
      -- Keys - all active high   
      KeyA               => DS_KeyA(DS_KeyA'left),
      KeyB               => DS_KeyB(DS_KeyB'left),
      KeyX               => DS_KeyX(DS_KeyX'left),
      KeyY               => DS_KeyY(DS_KeyY'left),
      KeySelect          => DS_KeySelect(DS_KeySelect'left),
      KeyStart           => DS_KeyStart(DS_KeyStart'left),
      KeyRight           => DS_KeyRight(DS_KeyRight'left),
      KeyLeft            => DS_KeyLeft(DS_KeyLeft'left),
      KeyUp              => DS_KeyUp(DS_KeyUp'left),
      KeyDown            => DS_KeyDown(DS_KeyDown'left),
      KeyR               => DS_KeyR(DS_KeyR'left),
      KeyL               => DS_KeyL(DS_KeyL'left),
      Touch              => ds_Touch(ds_Touch'left), 
      TouchX             => ds_TouchX,
      TouchY             => ds_TouchY,
      -- debug interface          
      DS9_BusAddr        => ds_Bus9Addr,     
      DS9_BusRnW         => ds_Bus9RnW(ds_Bus9RnW'left),      
      DS9_BusACC         => ds_Bus9ACC,      
      DS9_BusWriteData   => ds_Bus9WriteData,
      DS9_BusReadData    => ds_Bus9ReadData, 
      DS9_Bus_written    => ds_Bus9_written, 
      DS7_BusAddr        => ds_Bus7Addr,     
      DS7_BusRnW         => ds_Bus7RnW(ds_Bus7RnW'left),      
      DS7_BusACC         => ds_Bus7ACC,     
      DS7_BusWriteData   => ds_Bus7WriteData,
      DS7_BusReadData    => ds_Bus7ReadData, 
      DS7_Bus_written    => ds_Bus7_written, 
      -- RAM access
      DS_RAM_Adr         => DS_RAM_Adr, 
      DS_RAM_rnw         => DS_RAM_rnw, 
      DS_RAM_ena         => DS_RAM_ena, 
      DS_RAM_be          => DS_RAM_be, 
      DS_RAM_128         => DS_RAM_128, 
      DS_RAM_dout        => DS_RAM_dout,
      DS_RAM_dout128     => DS_RAM_dout128,
      DS_RAM_din         => DS_RAM_din, 
      DS_RAM_din128      => DS_RAM_din128, 
      DS_RAM_done        => DS_RAM_done,
      -- display data
      pixel_out1_x       => pixel_out1_x,    
      pixel_out1_y       => pixel_out1_y,    
      pixel_out1_data    => pixel_out1_data, 
      pixel_out1_we      => pixel_out1_we,   
      pixel_out2_x       => pixel_out2_x,    
      pixel_out2_y       => pixel_out2_y,    
      pixel_out2_data    => pixel_out2_data, 
      pixel_out2_we      => pixel_out2_we,   
      -- sound                            
      sound_out_left     => sound_out_left, 
      sound_out_right    => sound_out_right
   );
   

end architecture;





