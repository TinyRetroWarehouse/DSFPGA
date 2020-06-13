library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;
use work.pvcd_export.all;

entity ds_top is
   generic
   (
      is_simu                   : std_logic;
      ds_nogpu                  : std_logic;
      Softmap_DS_WRAM_ADDR      : integer; -- count:   1048576 -- all 32bit used
      Softmap_DS_FIRMWARE_ADDR  : integer; -- count:     65536 -- all 32bit used
      Softmap_DS_SAVERAM_ADDR   : integer; -- count:   1048576 -- low  8bit used
      Softmap_DS_SAVESTATE_ADDR : integer; -- count:   2097152 -- all 32bit used
      Softmap_DS_GAMEROM_ADDR   : integer  -- count:  67108864 -- all 32bit used
   );
   port 
   (
      clk100             : in     std_logic;  
      -- settings                 
      DS_on              : in     std_logic;  -- switching from off to on = reset
      DS_lockspeed       : in     std_logic;  -- 1 = 100% speed, 0 = max speed
      CyclePrecalc       : in     std_logic_vector(15 downto 0); -- ??? seems to be ok to keep fullspeed for all games
      FreeRunningClock   : in     std_logic;  -- internal clock will advance with 66Mhz
      EnableCpu          : in     std_logic;
      Bootloader         : in     std_logic; -- automatic bootloader when switching on
      PC9Entry           : in     std_logic_vector(31 downto 0);
      PC7Entry           : in     std_logic_vector(31 downto 0);
      ChipID             : in     std_logic_vector(31 downto 0);
      save_state         : in     std_logic;
      load_state         : in     std_logic;
      -- debug ports
      CyclesMissing      : buffer std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      CyclesVsyncSpeed9  : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      CyclesVsyncSpeed7  : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      CyclesVsyncIdle9   : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      CyclesVsyncIdle7   : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      DebugCycling       : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      DebugCPU9          : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      DebugCPU7          : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      DebugDMA9          : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      DebugDMA7          : out    std_logic_vector(31 downto 0); -- debug only for speed measurement, keep open
      -- Keys - all active high   
      KeyA               : in     std_logic; 
      KeyB               : in     std_logic;
      KeyX               : in     std_logic;
      KeyY               : in     std_logic;
      KeySelect          : in     std_logic;
      KeyStart           : in     std_logic;
      KeyRight           : in     std_logic;
      KeyLeft            : in     std_logic;
      KeyUp              : in     std_logic;
      KeyDown            : in     std_logic;
      KeyR               : in     std_logic;
      KeyL               : in     std_logic;
      Touch              : in     std_logic;
      TouchX             : in     std_logic_vector(7 downto 0);
      TouchY             : in     std_logic_vector(7 downto 0);
      -- debug interface          
      DS9_BusAddr        : in     std_logic_vector(27 downto 0); -- can't access bios...probably not required
      DS9_BusRnW         : in     std_logic;
      DS9_BusACC         : in     std_logic_vector(1 downto 0);
      DS9_BusWriteData   : in     std_logic_vector(31 downto 0);
      DS9_BusReadData    : out    std_logic_vector(31 downto 0);
      DS9_Bus_written    : in     std_logic;
      DS7_BusAddr        : in     std_logic_vector(27 downto 0);
      DS7_BusRnW         : in     std_logic;
      DS7_BusACC         : in     std_logic_vector(1 downto 0);
      DS7_BusWriteData   : in     std_logic_vector(31 downto 0);
      DS7_BusReadData    : out    std_logic_vector(31 downto 0);
      DS7_Bus_written    : in     std_logic;
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
      sound_out_right    : out   std_logic_vector(15 downto 0) := (others => '0')
   );
end entity;

architecture arch of ds_top is

   -- ################################
   -- ########## Registers
   -- ################################
   
   signal ds_bus9       : proc_bus_ds_type;  
   signal ds_bus7       : proc_bus_ds_type;  
   
   signal ds_bus9_data  : std_logic_vector(31 downto 0);
   signal ds_bus7_data  : std_logic_vector(31 downto 0);
   
   type t_reg_wired_or9 is array(0 to 41) of std_logic_vector(31 downto 0);
   signal reg_wired_or9 : t_reg_wired_or9;
   type t_reg_wired_or7 is array(0 to 14) of std_logic_vector(31 downto 0);
   signal reg_wired_or7 : t_reg_wired_or7;
   
   signal REG_MemControl1_VRAM_A_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_A_MST   .upper downto work.pReg_ds_system_9.MemControl1_VRAM_A_MST   .lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_A_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_A_Offset.upper downto work.pReg_ds_system_9.MemControl1_VRAM_A_Offset.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_A_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_A_Enable.upper downto work.pReg_ds_system_9.MemControl1_VRAM_A_Enable.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_B_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_B_MST   .upper downto work.pReg_ds_system_9.MemControl1_VRAM_B_MST   .lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_B_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_B_Offset.upper downto work.pReg_ds_system_9.MemControl1_VRAM_B_Offset.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_B_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_B_Enable.upper downto work.pReg_ds_system_9.MemControl1_VRAM_B_Enable.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_C_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_C_MST   .upper downto work.pReg_ds_system_9.MemControl1_VRAM_C_MST   .lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_C_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_C_Offset.upper downto work.pReg_ds_system_9.MemControl1_VRAM_C_Offset.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_C_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_C_Enable.upper downto work.pReg_ds_system_9.MemControl1_VRAM_C_Enable.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_D_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_D_MST   .upper downto work.pReg_ds_system_9.MemControl1_VRAM_D_MST   .lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_D_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_D_Offset.upper downto work.pReg_ds_system_9.MemControl1_VRAM_D_Offset.lower) := (others => '0'); 
   signal REG_MemControl1_VRAM_D_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl1_VRAM_D_Enable.upper downto work.pReg_ds_system_9.MemControl1_VRAM_D_Enable.lower) := (others => '0'); 

   signal REG_MemControl2                    : std_logic_vector(work.pReg_ds_system_9.MemControl2              .upper downto work.pReg_ds_system_9.MemControl2              .lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_E_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_E_MST   .upper downto work.pReg_ds_system_9.MemControl2_VRAM_E_MST   .lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_E_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_E_Offset.upper downto work.pReg_ds_system_9.MemControl2_VRAM_E_Offset.lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_E_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_E_Enable.upper downto work.pReg_ds_system_9.MemControl2_VRAM_E_Enable.lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_F_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_F_MST   .upper downto work.pReg_ds_system_9.MemControl2_VRAM_F_MST   .lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_F_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_F_Offset.upper downto work.pReg_ds_system_9.MemControl2_VRAM_F_Offset.lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_F_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_F_Enable.upper downto work.pReg_ds_system_9.MemControl2_VRAM_F_Enable.lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_G_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_G_MST   .upper downto work.pReg_ds_system_9.MemControl2_VRAM_G_MST   .lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_G_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_G_Offset.upper downto work.pReg_ds_system_9.MemControl2_VRAM_G_Offset.lower) := (others => '0'); 
   signal REG_MemControl2_VRAM_G_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl2_VRAM_G_Enable.upper downto work.pReg_ds_system_9.MemControl2_VRAM_G_Enable.lower) := (others => '0'); 
   signal REG_MemControl2_WRAM               : std_logic_vector(work.pReg_ds_system_9.MemControl2_WRAM         .upper downto work.pReg_ds_system_9.MemControl2_WRAM         .lower) := (others => '0'); 
 
   signal REG_MemControl3                    : std_logic_vector(work.pReg_ds_system_9.MemControl3              .upper downto work.pReg_ds_system_9.MemControl3              .lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_H_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_H_MST   .upper downto work.pReg_ds_system_9.MemControl3_VRAM_H_MST   .lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_H_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_H_Offset.upper downto work.pReg_ds_system_9.MemControl3_VRAM_H_Offset.lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_H_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_H_Enable.upper downto work.pReg_ds_system_9.MemControl3_VRAM_H_Enable.lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_I_MST         : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_I_MST   .upper downto work.pReg_ds_system_9.MemControl3_VRAM_I_MST   .lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_I_Offset      : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_I_Offset.upper downto work.pReg_ds_system_9.MemControl3_VRAM_I_Offset.lower) := (others => '0'); 
   signal REG_MemControl3_VRAM_I_Enable      : std_logic_vector(work.pReg_ds_system_9.MemControl3_VRAM_I_Enable.upper downto work.pReg_ds_system_9.MemControl3_VRAM_I_Enable.lower) := (others => '0');
   
   signal REG_DMA0FILL                       : std_logic_vector(work.pReg_ds_dma_9.DMA0FILL                    .upper downto work.pReg_ds_dma_9.DMA0FILL                    .lower) := (others => '0'); 
   signal REG_DMA1FILL                       : std_logic_vector(work.pReg_ds_dma_9.DMA1FILL                    .upper downto work.pReg_ds_dma_9.DMA1FILL                    .lower) := (others => '0'); 
   signal REG_DMA2FILL                       : std_logic_vector(work.pReg_ds_dma_9.DMA2FILL                    .upper downto work.pReg_ds_dma_9.DMA2FILL                    .lower) := (others => '0'); 
   signal REG_DMA3FILL                       : std_logic_vector(work.pReg_ds_dma_9.DMA3FILL                    .upper downto work.pReg_ds_dma_9.DMA3FILL                    .lower) := (others => '0'); 
   
   signal REG_POSTFLG_Power_Down_Mode        : std_logic_vector(work.pReg_ds_system_7.POSTFLG_Power_Down_Mode  .upper downto work.pReg_ds_system_7.POSTFLG_Power_Down_Mode  .lower) := (others => '0'); 
 
   signal REG_POSTFLG_Power_Down_Mode_written : std_logic;
 
 
   -- ################################
   -- ########## Memories
   -- ################################
   
   signal DS_RAM_Int_Adr         : std_logic_vector(28 downto 0);
   signal DS_RAM_Int_rnw         : std_logic;
   signal DS_RAM_Int_ena         : std_logic;
   signal DS_RAM_Int_be          : std_logic_vector(3 downto 0);
   signal DS_RAM_Int_128         : std_logic;
   signal DS_RAM_Int_dout        : std_logic_vector(31 downto 0);
   signal DS_RAM_Int_dout128     : std_logic_vector(127 downto 0);
   
   signal DS_RAM_boot_mux        : std_logic;
   signal DS_RAM_boot_Adr        : std_logic_vector(28 downto 0);
   signal DS_RAM_boot_rnw        : std_logic;
   signal DS_RAM_boot_ena        : std_logic;
   signal DS_RAM_boot_be         : std_logic_vector(3 downto 0);
   signal DS_RAM_boot_128        : std_logic;
   signal DS_RAM_boot_dout       : std_logic_vector(31 downto 0);
   signal DS_RAM_boot_dout128    : std_logic_vector(127 downto 0);
 
   -- ################################
   -- ########## ARM 9
   -- ################################
   signal cpu9_bus_data_Adr              : std_logic_vector(31 downto 0) := ( Others => '0');
   signal cpu9_bus_data_rnw              : std_logic;
   signal cpu9_bus_data_ena              : std_logic;
   signal cpu9_bus_data_acc              : std_logic_vector(1 downto 0);
   signal cpu9_bus_data_dout             : std_logic_vector(31 downto 0);
   signal cpu9_bus_data_din              : std_logic_vector(31 downto 0);
   signal cpu9_bus_data_done             : std_logic;
        
   signal cpu9_bus_code_Adr              : std_logic_vector(31 downto 0) := ( Others => '0');
   signal cpu9_bus_code_ena              : std_logic;
   signal cpu9_bus_code_acc              : std_logic_vector(1 downto 0);
   signal cpu9_bus_code_din              : std_logic_vector(31 downto 0);
   signal cpu9_bus_code_done             : std_logic;
        
   signal ITCM_data_addr                 : natural range 0 to 8191;
   signal ITCM_data_datain               : std_logic_vector(31 downto 0);
   signal ITCM_data_dataout              : std_logic_vector(31 downto 0);
   signal ITCM_data_we                   : std_logic := '0';
   signal ITCM_data_be                   : std_logic_vector(3 downto 0);
        
   signal ITCM_code_addr                 : natural range 0 to 8191;
   signal ITCM_code_dataout              : std_logic_vector(31 downto 0);
                 
   signal DTCMRegion                     : std_logic_vector(31 downto 0);
                 
   signal BIOS9_data_addr                : std_logic_vector(9 downto 0);
   signal BIOS9_data_dataout             : std_logic_vector(31 downto 0);
        
   signal BIOS9_code_addr                : std_logic_vector(9 downto 0);
   signal BIOS9_code_dataout             : std_logic_vector(31 downto 0);
        
   signal mem_bus9_iscpu                 : std_logic;
   signal mem_bus9_Adr                   : std_logic_vector(31 downto 0);
   signal mem_bus9_rnw                   : std_logic;
   signal mem_bus9_ena                   : std_logic;
   signal mem_bus9_acc                   : std_logic_vector(1 downto 0);
   signal mem_bus9_dout                  : std_logic_vector(31 downto 0);
   signal mem_bus9_din                   : std_logic_vector(31 downto 0);
   signal mem_bus9_done                  : std_logic;
              
   signal Externram9data_Adr             : std_logic_vector(28 downto 0);
   signal Externram9data_rnw             : std_logic;
   signal Externram9data_ena             : std_logic;
   signal Externram9data_be              : std_logic_vector(3 downto 0);
   signal Externram9data_dout            : std_logic_vector(31 downto 0);
   signal Externram9data_din             : std_logic_vector(31 downto 0);
   signal Externram9data_din128          : std_logic_vector(127 downto 0);
   signal Externram9data_done            : std_logic;
        
   signal Externram9code_Adr             : std_logic_vector(28 downto 0);
   signal Externram9code_ena             : std_logic;
   signal Externram9code_din             : std_logic_vector(31 downto 0);
   signal Externram9code_din128          : std_logic_vector(127 downto 0);
   signal Externram9code_done            : std_logic;
   
   signal snoop_Adr                      : std_logic_vector(21 downto 0); -- snoop only for sram!
   signal snoop_data                     : std_logic_vector(31 downto 0);
   signal snoop_we                       : std_logic;
   signal snoop_be                       : std_logic_vector(3 downto 0);
           
   signal WramSmallCodeLo9_addr          : natural range 0 to 4095;
   signal WramSmallCodeLo9_dataout       : std_logic_vector(31 downto 0);
   signal WramSmallCodeHi9_addr          : natural range 0 to 4095;
   signal WramSmallCodeHi9_dataout       : std_logic_vector(31 downto 0);
        
   signal WramSmallDataLo9_addr          : natural range 0 to 4095;
   signal WramSmallDataLo9_datain        : std_logic_vector(31 downto 0);
   signal WramSmallDataLo9_dataout       : std_logic_vector(31 downto 0);
   signal WramSmallDataLo9_we            : std_logic := '0';
   signal WramSmallDataLo9_be            : std_logic_vector(3 downto 0);
   signal WramSmallDataHi9_addr          : natural range 0 to 4095;
   signal WramSmallDataHi9_datain        : std_logic_vector(31 downto 0);
   signal WramSmallDataHi9_dataout       : std_logic_vector(31 downto 0);
   signal WramSmallDataHi9_we            : std_logic := '0';
   signal WramSmallDataHi9_be            : std_logic_vector(3 downto 0);
        
   signal IPC_fifo_9_enable              : std_logic;    
   signal IPC_fifo_9_data                : std_logic_vector(31 downto 0);      
           
   signal dma_on9                        : std_logic;
   signal CPU_bus_idle9                  : std_logic := '1';
   signal dma_soon9                      : std_logic;
              
   signal dma_bus9_Adr                   : std_logic_vector(31 downto 0);
   signal dma_bus9_rnw                   : std_logic;
   signal dma_bus9_ena                   : std_logic;
   signal dma_bus9_acc                   : std_logic_vector(1 downto 0);
   signal dma_bus9_dout                  : std_logic_vector(31 downto 0);
   signal dma_bus9_din                   : std_logic_vector(31 downto 0);
   signal dma_bus9_done                  : std_logic;
   signal dma_bus9_unread                : std_logic;
              
   signal dma_cycles_out9                : unsigned(7 downto 0);
   signal dma_cycles_valid9              : std_logic;
   
   signal halt9                          : std_logic;
   signal cpuirqdone9                    : std_logic;
   
   signal irq9_pending                   : std_logic;
   signal irq9_disable                   : std_logic;
   signal cpu_irq9                       : std_logic;
   signal IRQ9_LCD_V_Blank               : std_logic;   
   signal IRQ9_LCD_H_Blank               : std_logic;
   signal IRQ9_LCD_V_Counter_Match       : std_logic;
   signal IRQ9_Timer_0_Overflow          : std_logic;
   signal IRQ9_Timer_1_Overflow          : std_logic;
   signal IRQ9_Timer_2_Overflow          : std_logic;
   signal IRQ9_Timer_3_Overflow          : std_logic;
   signal IRQ9_DMA_0                     : std_logic;
   signal IRQ9_DMA_1                     : std_logic;
   signal IRQ9_DMA_2                     : std_logic;
   signal IRQ9_DMA_3                     : std_logic;
   signal IRQ9_Keypad                    : std_logic;
   signal IRQ9_GBA_Slot                  : std_logic;
   signal IRQ9_IPC_Sync                  : std_logic;
   signal IRQ9_IPC_Send_FIFO_Empty       : std_logic;
   signal IRQ9_IPC_Recv_FIFO_Not_Empty   : std_logic;
   signal IRQ9_NDS_Slot_TransferComplete : std_logic;
   signal IRQ9_NDS_Slot_IREQ_MC          : std_logic;
   signal IRQ9_Geometry_Command_FIFO     : std_logic;
         
   signal haltbus                        : std_logic;
   signal haltbus_divider                : std_logic;
   signal haltbus_sqrt                   : std_logic;
   
   signal gc9_dma_request                : std_logic;
   signal gc9_dma_size                   : integer range 0 to 128;                            
   signal gc9_gamecard_read              : std_logic;
   signal gc9_romaddress                 : std_logic_vector(31 downto 0);
   signal gc9_readtype                   : integer range 0 to 2;
   
   signal auxspi9_addr                   : std_logic_vector(31 downto 0);
   signal auxspi9_dataout                : std_logic_vector( 7 downto 0);
   signal auxspi9_request                : std_logic;
   signal auxspi9_rnw                    : std_logic;
   signal auxspi9_datain                 : std_logic_vector( 7 downto 0);
   signal auxspi9_done                   : std_logic;
       
   -- debug and control  
   signal debug_bus9_active              : std_logic := '0';
                                  
   signal debug_bus9_Adr                 : std_logic_vector(31 downto 0);
   signal debug_bus9_rnw                 : std_logic;
   signal debug_bus9_ena                 : std_logic;
   signal debug_bus9_acc                 : std_logic_vector(1 downto 0);
   signal debug_bus9_dout                : std_logic_vector(31 downto 0); 
   
   signal bootbus9_Addr                  : std_logic_vector(31 downto 0);
   signal bootbus9_RnW                   : std_logic;
   signal bootbus9_ena                   : std_logic;
   signal bootbus9_ACC                   : std_logic_vector(1 downto 0);
   signal bootbus9_WriteData             : std_logic_vector(31 downto 0);
   signal bootbus9_ReadData              : std_logic_vector(31 downto 0);
   signal bootbus9_done                  : std_logic;
   
   
   -- ################################
   -- ########## ARM 7
   -- ################################
   signal pc_in_bios7                    : std_logic;
                                         
   signal cpu7_bus_Adr                   : std_logic_vector(31 downto 0) := ( Others => '0');
   signal cpu7_bus_rnw                   : std_logic;
   signal cpu7_bus_ena                   : std_logic;
   signal cpu7_bus_acc                   : std_logic_vector(1 downto 0);
   signal cpu7_bus_dout                  : std_logic_vector(31 downto 0);
   signal cpu7_bus_din                   : std_logic_vector(31 downto 0);
   signal cpu7_bus_done                  : std_logic;
                                         
   signal mem_bus7_Adr                   : std_logic_vector(31 downto 0);
   signal mem_bus7_rnw                   : std_logic;
   signal mem_bus7_ena                   : std_logic;
   signal mem_bus7_acc                   : std_logic_vector(1 downto 0);
   signal mem_bus7_dout                  : std_logic_vector(31 downto 0);
   signal mem_bus7_din                   : std_logic_vector(31 downto 0);
   signal mem_bus7_done                  : std_logic;
                                         
   signal Externram7_Adr                 : std_logic_vector(28 downto 0);
   signal Externram7_rnw                 : std_logic;
   signal Externram7_ena                 : std_logic;
   signal Externram7_be                  : std_logic_vector(3 downto 0);
   signal Externram7_dout                : std_logic_vector(31 downto 0);
   signal Externram7_din                 : std_logic_vector(31 downto 0);
   signal Externram7_din128              : std_logic_vector(127 downto 0);
   signal Externram7_done                : std_logic;
   
   signal Externram7_muxed_Adr           : std_logic_vector(28 downto 0);
   signal Externram7_muxed_rnw           : std_logic;
   signal Externram7_muxed_ena           : std_logic;
   signal Externram7_muxed_be            : std_logic_vector(3 downto 0);
   signal Externram7_muxed_dout          : std_logic_vector(31 downto 0);
                                         
   signal WramSmallLo7_addr              : natural range 0 to 4095;
   signal WramSmallLo7_datain            : std_logic_vector(31 downto 0);
   signal WramSmallLo7_dataout           : std_logic_vector(31 downto 0);
   signal WramSmallLo7_we                : std_logic := '0';
   signal WramSmallLo7_be                : std_logic_vector(3 downto 0);
   signal WramSmallHi7_addr              : natural range 0 to 4095;
   signal WramSmallHi7_datain            : std_logic_vector(31 downto 0);
   signal WramSmallHi7_dataout           : std_logic_vector(31 downto 0);
   signal WramSmallHi7_we                : std_logic := '0';
   signal WramSmallHi7_be                : std_logic_vector(3 downto 0);
                                         
   signal IPC_fifo_7_enable              : std_logic;    
   signal IPC_fifo_7_data                : std_logic_vector(31 downto 0); 
                                         
   signal dma_on7                        : std_logic;
   signal CPU_bus_idle7                  : std_logic;
   signal dma_soon7                      : std_logic;
                                         
   signal dma_bus7_Adr                   : std_logic_vector(31 downto 0);
   signal dma_bus7_rnw                   : std_logic;
   signal dma_bus7_ena                   : std_logic;
   signal dma_bus7_acc                   : std_logic_vector(1 downto 0);
   signal dma_bus7_dout                  : std_logic_vector(31 downto 0);
   signal dma_bus7_din                   : std_logic_vector(31 downto 0);
   signal dma_bus7_done                  : std_logic;
   signal dma_bus7_unread                : std_logic;
   
   signal dma_cycles_out7                : unsigned(7 downto 0);
   signal dma_cycles_valid7              : std_logic;
   
   signal new_halt7                      : std_logic;
   signal halt7                          : std_logic;
   signal cpuirqdone7                    : std_logic;
   
   signal irq7_pending                   : std_logic;
   signal irq7_disable                   : std_logic;
   signal cpu_irq7                       : std_logic;
   signal IRQ7_LCD_V_Blank               : std_logic;   
   signal IRQ7_LCD_H_Blank               : std_logic;
   signal IRQ7_LCD_V_Counter_Match       : std_logic;
   signal IRQ7_Timer_0_Overflow          : std_logic;
   signal IRQ7_Timer_1_Overflow          : std_logic;
   signal IRQ7_Timer_2_Overflow          : std_logic;
   signal IRQ7_Timer_3_Overflow          : std_logic;
   signal IRQ7_SIO_RCNT_RTC              : std_logic;
   signal IRQ7_DMA_0                     : std_logic;
   signal IRQ7_DMA_1                     : std_logic;
   signal IRQ7_DMA_2                     : std_logic;
   signal IRQ7_DMA_3                     : std_logic;
   signal IRQ7_Keypad                    : std_logic;
   signal IRQ7_GBA_Slot                  : std_logic;
   signal IRQ7_IPC_Sync                  : std_logic;
   signal IRQ7_IPC_Send_FIFO_Empty       : std_logic;
   signal IRQ7_IPC_Recv_FIFO_Not_Empty   : std_logic;
   signal IRQ7_NDS_Slot_TransferComplete : std_logic;
   signal IRQ7_NDS_Slot_IREQ_MC          : std_logic;
   signal IRQ7_Screens_unfolding         : std_logic;
   signal IRQ7_SPI_bus                   : std_logic;
   signal IRQ7_Wifi                      : std_logic;
   
   signal spi_done                       : std_logic;
   signal spi_active                     : std_logic;
   signal firmware_read                  : std_logic;
   signal firmware_addr                  : std_logic_vector(28 downto 0);
   
   signal gc7_dma_request                : std_logic;
   signal gc7_dma_size                   : integer range 0 to 128;                            
   signal gc7_gamecard_read              : std_logic;
   signal gc7_romaddress                 : std_logic_vector(31 downto 0);
   signal gc7_readtype                   : integer range 0 to 2;
   
   signal auxspi7_addr                   : std_logic_vector(31 downto 0);
   signal auxspi7_dataout                : std_logic_vector( 7 downto 0);
   signal auxspi7_request                : std_logic;
   signal auxspi7_rnw                    : std_logic;
   signal auxspi7_datain                 : std_logic_vector( 7 downto 0);
   signal auxspi7_done                   : std_logic;
   
   signal sounddata_req_ena              : std_logic;
   signal sounddata_req_addr             : std_logic_vector(31 downto 0);
   signal sounddata_req_done             : std_logic;
   signal sounddata_req_data             : std_logic_vector(31 downto 0);
   
   -- debug and control
   signal debug_bus7_active     : std_logic := '0';
                                
   signal debug_bus7_Adr        : std_logic_vector(31 downto 0);
   signal debug_bus7_rnw        : std_logic;
   signal debug_bus7_ena        : std_logic;
   signal debug_bus7_acc        : std_logic_vector(1 downto 0);
   signal debug_bus7_dout       : std_logic_vector(31 downto 0); 
   
   signal bootbus7_Addr         : std_logic_vector(31 downto 0);
   signal bootbus7_RnW          : std_logic;
   signal bootbus7_ena          : std_logic;
   signal bootbus7_ACC          : std_logic_vector(1 downto 0);
   signal bootbus7_WriteData    : std_logic_vector(31 downto 0);
   signal bootbus7_ReadData     : std_logic_vector(31 downto 0);
   signal bootbus7_done         : std_logic;
   
   
   -- ################################
   -- ########## GPU
   -- ################################
   
   signal Palette_addr         : natural range 0 to 127;
   signal Palette_datain       : std_logic_vector(31 downto 0);
   signal Palette_dataout_bgA  : std_logic_vector(31 downto 0);
   signal Palette_dataout_objA : std_logic_vector(31 downto 0);
   signal Palette_dataout_bgB  : std_logic_vector(31 downto 0);
   signal Palette_dataout_objB : std_logic_vector(31 downto 0);
   signal Palette_we_bgA       : std_logic := '0';
   signal Palette_we_objA      : std_logic := '0';
   signal Palette_we_bgB       : std_logic := '0';
   signal Palette_we_objB      : std_logic := '0';
   signal Palette_be           : std_logic_vector(3 downto 0);
   
   signal OAMRam_addr          : natural range 0 to 255;
   signal OAMRam_datain        : std_logic_vector(31 downto 0);
   signal OAMRam_dataout_A     : std_logic_vector(31 downto 0);
   signal OAMRam_dataout_B     : std_logic_vector(31 downto 0);
   signal OAMRam_we_A          : std_logic := '0';
   signal OAMRam_we_B          : std_logic := '0';
   signal OAMRam_be            : std_logic_vector(3 downto 0);
   
   signal hblank_trigger       : std_logic;
   signal vblank_trigger       : std_logic;
   signal MemDisplay_trigger   : std_logic;
   
   -- ################################
   -- ########## WRAM Small
   -- ################################
   
   signal WramSmallLo_addr     : natural range 0 to 4095;
   signal WramSmallLo_datain   : std_logic_vector(31 downto 0);
   signal WramSmallLo_dataout  : std_logic_vector(31 downto 0);
   signal WramSmallLo_we       : std_logic;
   signal WramSmallLo_be       : std_logic_vector(3 downto 0);
   signal WramSmallHi_addr     : natural range 0 to 4095;
   signal WramSmallHi_datain   : std_logic_vector(31 downto 0);
   signal WramSmallHi_dataout  : std_logic_vector(31 downto 0);
   signal WramSmallHi_we       : std_logic;
   signal WramSmallHi_be       : std_logic_vector(3 downto 0);
   
   -- ################################
   -- ########## VRAM
   -- ################################
   
   signal Vram_enable_A        : std_logic;
   signal Vram_enable_B        : std_logic;
   signal Vram_enable_C        : std_logic;
   signal Vram_enable_D        : std_logic;
   signal Vram_enable_E        : std_logic;
   signal Vram_enable_F        : std_logic;
   signal Vram_enable_G        : std_logic;
   signal Vram_enable_H        : std_logic;
   signal Vram_enable_I        : std_logic;
   
   signal VRam_9_addr          : std_logic_vector(23 downto 0);
   signal VRam_9_datain        : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_A     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_B     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_C     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_D     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_E     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_F     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_G     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_H     : std_logic_vector(31 downto 0);
   signal VRam_9_dataout_I     : std_logic_vector(31 downto 0);
   signal VRam_9_we            : std_logic := '0';
   signal VRam_9_be            : std_logic_vector(3 downto 0);
   signal VRam_9_active_A      : std_logic;
   signal VRam_9_active_B      : std_logic;
   signal VRam_9_active_C      : std_logic;
   signal VRam_9_active_D      : std_logic;
   signal VRam_9_active_E      : std_logic;
   signal VRam_9_active_F      : std_logic;
   signal VRam_9_active_G      : std_logic;
   signal VRam_9_active_H      : std_logic;
   signal VRam_9_active_I      : std_logic;
   
   signal VRam_7_addr          : std_logic_vector(23 downto 0);
   signal VRam_7_datain        : std_logic_vector(31 downto 0);
   signal VRam_7_dataout_C     : std_logic_vector(31 downto 0);
   signal VRam_7_dataout_D     : std_logic_vector(31 downto 0);
   signal VRam_7_we            : std_logic := '0';
   signal VRam_7_be            : std_logic_vector(3 downto 0);
   signal VRam_7_active_C      : std_logic;
   signal VRam_7_active_D      : std_logic;
   
   signal VRam_req_A           : std_logic;
   signal VRam_req_B           : std_logic;
   signal VRam_req_C           : std_logic;
   signal VRam_req_D           : std_logic;
   signal VRam_req_E           : std_logic;
   signal VRam_req_F           : std_logic;
   signal VRam_req_G           : std_logic;
   signal VRam_req_H           : std_logic;
   signal VRam_req_I           : std_logic;
   signal VRam_addr_A          : std_logic_vector(16 downto 0);
   signal VRam_addr_B          : std_logic_vector(16 downto 0);
   signal VRam_addr_C          : std_logic_vector(16 downto 0);
   signal VRam_addr_D          : std_logic_vector(16 downto 0);
   signal VRam_addr_E          : std_logic_vector(15 downto 0);
   signal VRam_addr_F          : std_logic_vector(13 downto 0);
   signal VRam_addr_G          : std_logic_vector(13 downto 0);
   signal VRam_addr_H          : std_logic_vector(14 downto 0);
   signal VRam_addr_I          : std_logic_vector(13 downto 0);
   signal VRam_dataout_A       : std_logic_vector(31 downto 0);
   signal VRam_dataout_B       : std_logic_vector(31 downto 0);
   signal VRam_dataout_C       : std_logic_vector(31 downto 0);
   signal VRam_dataout_D       : std_logic_vector(31 downto 0);
   signal VRam_dataout_E       : std_logic_vector(31 downto 0);
   signal VRam_dataout_F       : std_logic_vector(31 downto 0);
   signal VRam_dataout_G       : std_logic_vector(31 downto 0);
   signal VRam_dataout_H       : std_logic_vector(31 downto 0);
   signal VRam_dataout_I       : std_logic_vector(31 downto 0);
   signal VRam_valid_A         : std_logic;
   signal VRam_valid_B         : std_logic;
   signal VRam_valid_C         : std_logic;
   signal VRam_valid_D         : std_logic;
   signal VRam_valid_E         : std_logic;
   signal VRam_valid_F         : std_logic;
   signal VRam_valid_G         : std_logic;
   signal VRam_valid_H         : std_logic;
   signal VRam_valid_I         : std_logic;

   -- ################################
   -- ########## savestates
   -- ################################   
      
   signal savestate_bus        : proc_bus_ds_type;
   signal loading_savestate    : std_logic := '0';

   -- ################################
   -- ########## Cycling
   -- ################################
   signal ds_on_1              : std_logic;
   signal reset                : std_logic;
   
   signal new_cycles           : unsigned(7 downto 0);
   signal new_cycles_valid     : std_logic;  
   
   signal free_running_counter : integer range 0 to 2 := 0;
   signal free_running_next    : std_logic := '0';
   
   signal ds_step              : std_logic := '0';
   signal do_step9             : std_logic := '0';
   signal do_step7             : std_logic := '0';
   signal dma_step9            : std_logic := '0';
   signal dma_step7            : std_logic := '0';
   signal done_9               : std_logic;
   signal done_7               : std_logic;
   signal donewait             : std_logic_vector(1 downto 0) := "00";
   
   signal totalticks           : unsigned(20 downto 0) := (others => '0');
   signal CPU9_totalticks      : unsigned(20 downto 0) := (others => '0');
   signal CPU7_totalticks      : unsigned(20 downto 0) := (others => '0');
   
   signal new_cycles9          : unsigned(7 downto 0);
   signal new_cycles9_valid    : std_logic;  
   signal new_cycles7          : unsigned(7 downto 0);
   signal new_cycles7_valid    : std_logic;  
   
   signal next_event           : unsigned(15 downto 0);
   type t_nexteventall is array(0 to 1) of unsigned(15 downto 0);
   signal nexteventall : t_nexteventall;
   signal settleticks : integer range 0 to 2;
   
   signal waitsettle_all : std_logic;
   signal waitsettle_IPC : std_logic;
   
   signal haltcnt              : integer range 0 to 2;
   signal irq_cnt              : integer range 0 to 2;
   
   signal sleep_savestate      : std_logic;
   
   type tcyclestate is
   (
      IDLE,
      REDUCECYCLES,
      WAITSETTLE,
      WAITDMA,
      WAITIRQ,
      WAITHALT,
      WAITCPUS
   );
   signal cyclestate : tcyclestate := IDLE;
   
   signal cycles_ahead9   : integer range -1024 to 1023 := 0;
   signal cycles_ahead7   : integer range -1024 to 1023 := 0;
   signal WaitAhead9      : std_logic := '0';
   signal WaitAhead7      : std_logic := '0';
   
   signal cycle_slowdown  : std_logic := '0';
   signal new_missing     : std_logic := '0';
   signal cycles_ahead    : integer range 0 to 1023 := 0;
   signal cycles_66_100   : integer range 0 to 2 := 0;
   
   signal VSyncCounter    : integer range 0 to 1685375 := 0;
   signal vsyncspeedpoint : std_logic := '0';
   signal CyclesVsync9    : unsigned(31 downto 0) := (others => '0');
   signal CyclesVsync7    : unsigned(31 downto 0) := (others => '0');
   signal CyclesIdle9     : unsigned(31 downto 0) := (others => '0');
   signal CyclesIdle7     : unsigned(31 downto 0) := (others => '0');

   -- ################################
   -- ########## VCD export
   -- ################################   

   signal new_export       : std_logic := '0';
   signal commandcount     : integer;
   
   signal export_cpu9      : cpu_export_type;
   signal export_cpu7      : cpu_export_type;
                           
   signal export_timer9    : t_exporttimer;
   signal export_timer7    : t_exporttimer;
                           
   signal DISPSTAT_debug   : std_logic_vector(31 downto 0);
   signal debug_dma_count9 : std_logic_vector(31 downto 0);
   signal debug_dma_count7 : std_logic_vector(31 downto 0);
   
   signal IF_intern9       : std_logic_vector(31 downto 0);
   signal IF_intern7       : std_logic_vector(31 downto 0);

begin 

   -- ################################
   -- ########## Registers
   -- ################################
   
   process (reg_wired_or9)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or9(0);
      for i in 1 to (reg_wired_or9'length - 1) loop
         wired_or := wired_or or reg_wired_or9(i);
      end loop;
      ds_bus9_data <= wired_or;
   end process;
      
   process (reg_wired_or7)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or7(0);
      for i in 1 to (reg_wired_or7'length - 1) loop
         wired_or := wired_or or reg_wired_or7(i);
      end loop;
      ds_bus7_data <= wired_or;
   End Process;

   iMemControl1_VRAM_A_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_A_MST   ) port map  (clk100, ds_bus9, reg_wired_or9( 0), REG_MemControl1_VRAM_A_MST   , REG_MemControl1_VRAM_A_MST   );
   iMemControl1_VRAM_A_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_A_Offset) port map  (clk100, ds_bus9, reg_wired_or9( 1), REG_MemControl1_VRAM_A_Offset, REG_MemControl1_VRAM_A_Offset);
   iMemControl1_VRAM_A_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_A_Enable) port map  (clk100, ds_bus9, reg_wired_or9( 2), REG_MemControl1_VRAM_A_Enable, REG_MemControl1_VRAM_A_Enable);
   iMemControl1_VRAM_B_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_B_MST   ) port map  (clk100, ds_bus9, reg_wired_or9( 3), REG_MemControl1_VRAM_B_MST   , REG_MemControl1_VRAM_B_MST   );
   iMemControl1_VRAM_B_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_B_Offset) port map  (clk100, ds_bus9, reg_wired_or9( 4), REG_MemControl1_VRAM_B_Offset, REG_MemControl1_VRAM_B_Offset);
   iMemControl1_VRAM_B_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_B_Enable) port map  (clk100, ds_bus9, reg_wired_or9( 5), REG_MemControl1_VRAM_B_Enable, REG_MemControl1_VRAM_B_Enable);
   iMemControl1_VRAM_C_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_C_MST   ) port map  (clk100, ds_bus9, reg_wired_or9( 6), REG_MemControl1_VRAM_C_MST   , REG_MemControl1_VRAM_C_MST   );
   iMemControl1_VRAM_C_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_C_Offset) port map  (clk100, ds_bus9, reg_wired_or9( 7), REG_MemControl1_VRAM_C_Offset, REG_MemControl1_VRAM_C_Offset);
   iMemControl1_VRAM_C_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_C_Enable) port map  (clk100, ds_bus9, reg_wired_or9( 8), REG_MemControl1_VRAM_C_Enable, REG_MemControl1_VRAM_C_Enable);
   iMemControl1_VRAM_D_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_D_MST   ) port map  (clk100, ds_bus9, reg_wired_or9( 9), REG_MemControl1_VRAM_D_MST   , REG_MemControl1_VRAM_D_MST   );
   iMemControl1_VRAM_D_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_D_Offset) port map  (clk100, ds_bus9, reg_wired_or9(10), REG_MemControl1_VRAM_D_Offset, REG_MemControl1_VRAM_D_Offset);
   iMemControl1_VRAM_D_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl1_VRAM_D_Enable) port map  (clk100, ds_bus9, reg_wired_or9(11), REG_MemControl1_VRAM_D_Enable, REG_MemControl1_VRAM_D_Enable);
                                                                                                                                   
   iMemControl2_VRAM_E_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_E_MST   ) port map  (clk100, ds_bus9, reg_wired_or9(12), REG_MemControl2_VRAM_E_MST   , REG_MemControl2_VRAM_E_MST   );
   iMemControl2_VRAM_E_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_E_Offset) port map  (clk100, ds_bus9, reg_wired_or9(13), REG_MemControl2_VRAM_E_Offset, REG_MemControl2_VRAM_E_Offset);
   iMemControl2_VRAM_E_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_E_Enable) port map  (clk100, ds_bus9, reg_wired_or9(14), REG_MemControl2_VRAM_E_Enable, REG_MemControl2_VRAM_E_Enable);
   iMemControl2_VRAM_F_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_F_MST   ) port map  (clk100, ds_bus9, reg_wired_or9(15), REG_MemControl2_VRAM_F_MST   , REG_MemControl2_VRAM_F_MST   );
   iMemControl2_VRAM_F_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_F_Offset) port map  (clk100, ds_bus9, reg_wired_or9(16), REG_MemControl2_VRAM_F_Offset, REG_MemControl2_VRAM_F_Offset);
   iMemControl2_VRAM_F_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_F_Enable) port map  (clk100, ds_bus9, reg_wired_or9(17), REG_MemControl2_VRAM_F_Enable, REG_MemControl2_VRAM_F_Enable);
   iMemControl2_VRAM_G_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_G_MST   ) port map  (clk100, ds_bus9, reg_wired_or9(18), REG_MemControl2_VRAM_G_MST   , REG_MemControl2_VRAM_G_MST   );
   iMemControl2_VRAM_G_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_G_Offset) port map  (clk100, ds_bus9, reg_wired_or9(19), REG_MemControl2_VRAM_G_Offset, REG_MemControl2_VRAM_G_Offset);
   iMemControl2_VRAM_G_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_VRAM_G_Enable) port map  (clk100, ds_bus9, reg_wired_or9(20), REG_MemControl2_VRAM_G_Enable, REG_MemControl2_VRAM_G_Enable);
   iMemControl2_WRAM          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl2_WRAM         ) port map  (clk100, ds_bus9, reg_wired_or9(21), REG_MemControl2_WRAM         , REG_MemControl2_WRAM         );
                                                                                                                                         
   iMemControl3_VRAM_H_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_H_MST   ) port map  (clk100, ds_bus9, reg_wired_or9(22), REG_MemControl3_VRAM_H_MST   , REG_MemControl3_VRAM_H_MST   );
   iMemControl3_VRAM_H_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_H_Offset) port map  (clk100, ds_bus9, reg_wired_or9(23), REG_MemControl3_VRAM_H_Offset, REG_MemControl3_VRAM_H_Offset);
   iMemControl3_VRAM_H_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_H_Enable) port map  (clk100, ds_bus9, reg_wired_or9(24), REG_MemControl3_VRAM_H_Enable, REG_MemControl3_VRAM_H_Enable);
   iMemControl3_VRAM_I_MST    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_I_MST   ) port map  (clk100, ds_bus9, reg_wired_or9(25), REG_MemControl3_VRAM_I_MST   , REG_MemControl3_VRAM_I_MST   );
   iMemControl3_VRAM_I_Offset : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_I_Offset) port map  (clk100, ds_bus9, reg_wired_or9(26), REG_MemControl3_VRAM_I_Offset, REG_MemControl3_VRAM_I_Offset);
   iMemControl3_VRAM_I_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.MemControl3_VRAM_I_Enable) port map  (clk100, ds_bus9, reg_wired_or9(27), REG_MemControl3_VRAM_I_Enable, REG_MemControl3_VRAM_I_Enable);
   
   iDMA0FILL                  : entity work.eProcReg_ds generic map (work.pReg_ds_dma_9.DMA0FILL)                     port map  (clk100, ds_bus9, reg_wired_or9(37), REG_DMA0FILL                 , REG_DMA0FILL                 );
   iDMA1FILL                  : entity work.eProcReg_ds generic map (work.pReg_ds_dma_9.DMA1FILL)                     port map  (clk100, ds_bus9, reg_wired_or9(38), REG_DMA1FILL                 , REG_DMA1FILL                 );
   iDMA2FILL                  : entity work.eProcReg_ds generic map (work.pReg_ds_dma_9.DMA2FILL)                     port map  (clk100, ds_bus9, reg_wired_or9(39), REG_DMA2FILL                 , REG_DMA2FILL                 );
   iDMA3FILL                  : entity work.eProcReg_ds generic map (work.pReg_ds_dma_9.DMA3FILL)                     port map  (clk100, ds_bus9, reg_wired_or9(40), REG_DMA3FILL                 , REG_DMA3FILL                 );
   
   iRAMSTAT_VRAMSTAT_C_7      : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RAMSTAT_VRAMSTAT_C       ) port map  (clk100, ds_bus7, open             , "0"); -- done only set by register at bit 0
   iRAMSTAT_VRAMSTAT_D_7      : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RAMSTAT_VRAMSTAT_D       ) port map  (clk100, ds_bus7, open             , "0");
   iMemControl2_WRAM_7        : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.MemControl2_WRAM         ) port map  (clk100, ds_bus7, reg_wired_or7( 0), REG_MemControl2_WRAM);   
                                                                                                                    
   iPOSTFLG_Flag              : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.POSTFLG_Flag             ) port map  (clk100, ds_bus7, reg_wired_or7( 8), "1");   
   iPOSTFLG_Power_Down_Mode   : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.POSTFLG_Power_Down_Mode  ) port map  (clk100, ds_bus7, reg_wired_or7( 9), REG_POSTFLG_Power_Down_Mode  , REG_POSTFLG_Power_Down_Mode  , REG_POSTFLG_Power_Down_Mode_written);   
   iPOWCNT2_Sound             : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.POWCNT2_Sound            ) port map  (clk100, ds_bus7, reg_wired_or7(10), "1"); -- todo: should this really be fixed?    
   iPOWCNT2_Wifi              : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.POWCNT2_Wifi             ) port map  (clk100, ds_bus7, reg_wired_or7(11), "0"); -- todo: should this really be fixed?    

   new_halt7 <= REG_POSTFLG_Power_Down_Mode_written; -- todo: only when REG_POSTFLG_Power_Down_Mode = 2 ?

   -- ################################
   -- ########## Memories
   -- ################################
    
   Externram7_muxed_Adr  <= firmware_addr when spi_active = '1' else Externram7_Adr; 
   Externram7_muxed_rnw  <= '1'           when spi_active = '1' else Externram7_rnw; 
   Externram7_muxed_ena  <= firmware_read when spi_active = '1' else Externram7_ena; 
   Externram7_muxed_be   <= "1111"        when spi_active = '1' else Externram7_be;  
   Externram7_muxed_dout <= x"00000000"   when spi_active = '1' else Externram7_dout;
    
   DS_RAM_Adr     <= DS_RAM_Boot_Adr     when DS_RAM_Boot_mux = '1' else DS_RAM_Int_Adr;  
   DS_RAM_rnw     <= DS_RAM_Boot_rnw     when DS_RAM_Boot_mux = '1' else DS_RAM_Int_rnw;  
   DS_RAM_ena     <= DS_RAM_Boot_ena     when DS_RAM_Boot_mux = '1' else DS_RAM_Int_ena;  
   DS_RAM_be      <= DS_RAM_Boot_be      when DS_RAM_Boot_mux = '1' else DS_RAM_Int_be;    
   DS_RAM_128     <= DS_RAM_Boot_128     when DS_RAM_Boot_mux = '1' else DS_RAM_Int_128;   
   DS_RAM_dout    <= DS_RAM_Boot_dout    when DS_RAM_Boot_mux = '1' else DS_RAM_Int_dout;  
   DS_RAM_dout128 <= DS_RAM_Boot_dout128 when DS_RAM_Boot_mux = '1' else DS_RAM_Int_dout128;
    
    
    
   ids_externram_mux : entity work.ds_externram_mux
   port map
   (
      clk100                => clk100,
      reset                 => reset,
                            
      Externram9data_Adr    => Externram9data_Adr ,
      Externram9data_rnw    => Externram9data_rnw ,
      Externram9data_ena    => Externram9data_ena ,
      Externram9data_be     => Externram9data_be  ,
      Externram9data_dout   => Externram9data_dout,
      Externram9data_din    => Externram9data_din ,
      Externram9data_din128 => Externram9data_din128 ,
      Externram9data_done   => Externram9data_done,
                            
      Externram9code_Adr    => Externram9code_Adr ,
      Externram9code_ena    => Externram9code_ena ,
      Externram9code_din    => Externram9code_din ,
      Externram9code_din128 => Externram9code_din128 ,
      Externram9code_done   => Externram9code_done,
                                              
      Externram7_Adr        => Externram7_muxed_Adr ,
      Externram7_rnw        => Externram7_muxed_rnw ,
      Externram7_ena        => Externram7_muxed_ena ,
      Externram7_be         => Externram7_muxed_be  ,
      Externram7_dout       => Externram7_muxed_dout,
      Externram7_din        => Externram7_din ,
      Externram7_din128     => Externram7_din128 ,
      Externram7_done       => Externram7_done,
                                              
      Externram_Adr         => DS_RAM_Int_Adr  ,
      Externram_rnw         => DS_RAM_Int_rnw  ,
      Externram_ena         => DS_RAM_Int_ena  ,
      Externram_be          => DS_RAM_Int_be   ,
      Externram_128         => DS_RAM_Int_128  ,
      Externram_dout        => DS_RAM_Int_dout ,
      Externram_dout128     => DS_RAM_Int_dout128,
      Externram_din         => DS_RAM_din  ,
      Externram_din128      => DS_RAM_din128,
      Externram_done        => DS_RAM_done,
                            
      snoop_Adr             => snoop_Adr, 
      snoop_data            => snoop_data,
      snoop_we              => snoop_we,  
      snoop_be              => snoop_be   
   );
   
   ids_bootloader : entity work.ds_bootloader
   generic map
   (
      is_simu                   => is_simu,
      Softmap_DS_WRAM_ADDR      => Softmap_DS_WRAM_ADDR,    
      Softmap_DS_FIRMWARE_ADDR  => Softmap_DS_FIRMWARE_ADDR,
      Softmap_DS_SAVERAM_ADDR   => Softmap_DS_SAVERAM_ADDR, 
      Softmap_DS_SAVESTATE_ADDR => Softmap_DS_SAVESTATE_ADDR, 
      Softmap_DS_GAMEROM_ADDR   => Softmap_DS_GAMEROM_ADDR 
   )
   port map
   (
      clk100               => clk100,
      ds_on                => ds_on,
      ds_on_1              => ds_on_1,
      reset                => reset,
      Bootloader           => Bootloader,
      
      load                 => load_state,
      sleep_savestate      => sleep_savestate,
      bus_ena_in_9         => mem_bus9_ena,
      bus_ena_in_7         => mem_bus7_ena,
      
      Externram_force      => DS_RAM_Boot_mux ,
      Externram_Adr        => DS_RAM_Boot_Adr,
      Externram_rnw        => DS_RAM_Boot_rnw,
      Externram_ena        => DS_RAM_Boot_ena,
      Externram_be         => DS_RAM_Boot_be,
      Externram_128        => DS_RAM_Boot_128,
      Externram_dout       => DS_RAM_Boot_dout,
      Externram_dout128    => DS_RAM_Boot_dout128,
      Externram_din        => DS_RAM_din,
      Externram_din128     => DS_RAM_din128,
      Externram_done       => DS_RAM_done,
      
      Internbus9_Addr      => bootbus9_Addr,     
      Internbus9_RnW       => bootbus9_RnW,      
      Internbus9_ena       => bootbus9_ena,      
      Internbus9_ACC       => bootbus9_ACC,      
      Internbus9_WriteData => bootbus9_WriteData,
      Internbus9_ReadData  => bootbus9_ReadData, 
      Internbus9_done      => bootbus9_done,  
      
      Internbus7_Addr      => bootbus7_Addr,     
      Internbus7_RnW       => bootbus7_RnW,      
      Internbus7_ena       => bootbus7_ena,      
      Internbus7_ACC       => bootbus7_ACC,      
      Internbus7_WriteData => bootbus7_WriteData,
      Internbus7_ReadData  => bootbus7_ReadData, 
      Internbus7_done      => bootbus7_done  
   );
   
   iWramSmallLo : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 13
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => WramSmallCodeLo9_addr,   
      datain_a0  => x"00", 
      datain_a1  => x"00",
      datain_a2  => x"00",
      datain_a3  => x"00",
      dataout_a  => WramSmallCodeLo9_dataout,
      we_a       => '0',    
      be_a       => "1111",     
		           
      addr_b     => WramSmallLo_addr,   
      datain_b0  => WramSmallLo_datain( 7 downto  0), 
      datain_b1  => WramSmallLo_datain(15 downto  8),
      datain_b2  => WramSmallLo_datain(23 downto 16),
      datain_b3  => WramSmallLo_datain(31 downto 24),
      dataout_b  => WramSmallLo_dataout,
      we_b       => WramSmallLo_we,    
      be_b       => WramSmallLo_be     
   );
   
   WramSmallLo_addr     <= WramSmallDataLo9_addr   when REG_MemControl2_WRAM(REG_MemControl2_WRAM'right) = '0' else WramSmallLo7_addr;  
   WramSmallLo_datain   <= WramSmallDataLo9_datain when REG_MemControl2_WRAM(REG_MemControl2_WRAM'right) = '0' else WramSmallLo7_datain;
   WramSmallLo_we       <= WramSmallDataLo9_we     when REG_MemControl2_WRAM(REG_MemControl2_WRAM'right) = '0' else WramSmallLo7_we;    
   WramSmallLo_be       <= WramSmallDataLo9_be     when REG_MemControl2_WRAM(REG_MemControl2_WRAM'right) = '0' else WramSmallLo7_be; 

   WramSmallDataLo9_dataout <= WramSmallLo_dataout;
   WramSmallLo7_dataout     <= WramSmallLo_dataout;
   
   iWramSmallHi : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 13
   )
   port map
   (
      clk        => clk100,
      
      addr_a     => WramSmallCodeHi9_addr,   
      datain_a0  => x"00", 
      datain_a1  => x"00",
      datain_a2  => x"00",
      datain_a3  => x"00",
      dataout_a  => WramSmallCodeHi9_dataout,
      we_a       => '0',    
      be_a       => "1111",     
		           
      addr_b     => WramSmallHi_addr,   
      datain_b0  => WramSmallHi_datain( 7 downto  0), 
      datain_b1  => WramSmallHi_datain(15 downto  8),
      datain_b2  => WramSmallHi_datain(23 downto 16),
      datain_b3  => WramSmallHi_datain(31 downto 24),
      dataout_b  => WramSmallHi_dataout,
      we_b       => WramSmallHi_we,    
      be_b       => WramSmallHi_be     
   );

   WramSmallHi_addr     <= WramSmallDataHi9_addr   when REG_MemControl2_WRAM(REG_MemControl2_WRAM'left) = '0' else WramSmallHi7_addr;  
   WramSmallHi_datain   <= WramSmallDataHi9_datain when REG_MemControl2_WRAM(REG_MemControl2_WRAM'left) = '0' else WramSmallHi7_datain;
   WramSmallHi_we       <= WramSmallDataHi9_we     when REG_MemControl2_WRAM(REG_MemControl2_WRAM'left) = '0' else WramSmallHi7_we;    
   WramSmallHi_be       <= WramSmallDataHi9_be     when REG_MemControl2_WRAM(REG_MemControl2_WRAM'left) = '0' else WramSmallHi7_be; 

   WramSmallDataHi9_dataout <= WramSmallHi_dataout;
   WramSmallHi7_dataout     <= WramSmallHi_dataout;
   
   -- ################################
   -- ########## Common modules
   -- ################################
   
   ids_DummyRegs : entity work.ds_DummyRegs
   port map
   (
      clk100        => clk100,
      ds_bus9       => ds_bus9,
      ds_bus9_data  => reg_wired_or9(36),
      ds_bus7       => ds_bus7,
      ds_bus7_data  => reg_wired_or7(12)
   );
   
   ids_joypad : entity work.ds_joypad
   port map
   (
      clk100        => clk100, 
      ds_on         => ds_on_1,  
      reset         => reset,  
                              
      ds_bus9       => ds_bus9,
      ds_bus9_data  => reg_wired_or9(34),
      ds_bus7       => ds_bus7,
      ds_bus7_data  => reg_wired_or7(7),
      
      IRP_Joypad9   => IRQ9_Keypad,
      IRP_Joypad7   => IRQ7_Keypad,
                    
      KeyA          => KeyA,     
      KeyB          => KeyB,     
      KeyX          => KeyX,     
      KeyY          => KeyY,     
      KeySelect     => KeySelect,
      KeyStart      => KeyStart, 
      KeyRight      => KeyRight, 
      KeyLeft       => KeyLeft,  
      KeyUp         => KeyUp,    
      KeyDown       => KeyDown,  
      KeyR          => KeyR,     
      KeyL          => KeyL,
      Touch         => Touch,  

      commandcount  => commandcount
   );
   
   ids_IPC: entity work.ds_IPC
   port map
   (
      clk100                        => clk100, 
      ds_on                         => ds_on_1,  
      reset                         => reset,  
      
      waitsettle                    => waitsettle_IPC,
                                              
      ds_bus9                       => ds_bus9,
      ds_bus9_data                  => reg_wired_or9(28),
      ds_bus7                       => ds_bus7,
      ds_bus7_data                  => reg_wired_or7(1),
          
      fiforead_9_enable             => IPC_fifo_9_enable,
      fiforead_9_data               => IPC_fifo_9_data,      
                                    
      fiforead_7_enable             => IPC_fifo_7_enable,
      fiforead_7_data               => IPC_fifo_7_data,      
                                            
      IRQ_IPC9_Sync                 => IRQ9_IPC_Sync,
      IRQ_IPC9_Send_FIFO_Empty      => IRQ9_IPC_Send_FIFO_Empty,
      IRQ_IPC9_Recv_FIFO_Not_Empty  => IRQ9_IPC_Recv_FIFO_Not_Empty,
                                    
      IRQ_IPC7_Sync                 => IRQ7_IPC_Sync,
      IRQ_IPC7_Send_FIFO_Empty      => IRQ7_IPC_Send_FIFO_Empty,
      IRQ_IPC7_Recv_FIFO_Not_Empty  => IRQ7_IPC_Recv_FIFO_Not_Empty
   );

   -- ################################
   -- ########## ARM 9
   -- ################################
   
   mem_bus9_iscpu  <= not CPU_bus_idle9;
   mem_bus9_Adr    <= debug_bus9_Adr  when debug_bus9_active = '1' else dma_bus9_Adr  when CPU_bus_idle9 = '1' else cpu9_bus_data_Adr;
   mem_bus9_rnw    <= debug_bus9_rnw  when debug_bus9_active = '1' else dma_bus9_rnw  when CPU_bus_idle9 = '1' else cpu9_bus_data_rnw;
   mem_bus9_ena    <= debug_bus9_ena  when debug_bus9_active = '1' else dma_bus9_ena  when CPU_bus_idle9 = '1' else cpu9_bus_data_ena; 
   mem_bus9_acc    <= debug_bus9_acc  when debug_bus9_active = '1' else dma_bus9_acc  when CPU_bus_idle9 = '1' else cpu9_bus_data_acc;
   mem_bus9_dout   <= debug_bus9_dout when debug_bus9_active = '1' else dma_bus9_dout when CPU_bus_idle9 = '1' else cpu9_bus_data_dout;
            
   dma_bus9_din    <= mem_bus9_din;
   dma_bus9_done   <= mem_bus9_done;
   dma_bus9_unread <= '0';
   
   cpu9_bus_data_din  <= mem_bus9_din;
   cpu9_bus_data_done <= mem_bus9_done;
   
   
   ids_bios9 : entity work.ds_bios9
   port map
   (
      clk       => clk100,
      address_a => BIOS9_data_addr,   
      data_a    => BIOS9_data_dataout,
      address_b => BIOS9_code_addr,   
      data_b    => BIOS9_code_dataout
   );

   iITCM : entity MEM.SyncRamDualByteEnable
   generic map
   (
      ADDR_WIDTH => 13
   )
   port map
   (
      clk       => clk100,
      
      addr_a    => ITCM_data_addr,
      datain_a0 => ITCM_data_datain( 7 downto  0),
      datain_a1 => ITCM_data_datain(15 downto  8),
      datain_a2 => ITCM_data_datain(23 downto 16),
      datain_a3 => ITCM_data_datain(31 downto 24),
      dataout_a => ITCM_data_dataout,
      we_a      => ITCM_data_we,
      be_a      => ITCM_data_be,
               
      addr_b    => ITCM_code_addr,
      datain_b0 => x"00",
      datain_b1 => x"00",
      datain_b2 => x"00",
      datain_b3 => x"00",
      dataout_b => ITCM_code_dataout,
      we_b      => '0',
      be_b      => "1111"
   );
            
   haltbus <= haltbus_divider or haltbus_sqrt;
            
   ids_memorymux9data : entity work.ds_memorymux9data
   generic map 
   (
      is_simu                 => is_simu,
      Softmap_DS_SAVERAM_ADDR => Softmap_DS_SAVERAM_ADDR,
      Softmap_DS_GAMEROM_ADDR => Softmap_DS_GAMEROM_ADDR
   )
   port map
   (
      clk100               => clk100,
      DS_on                => DS_on_1,
      reset                => reset,
      DTCMRegion           => DTCMRegion,
      
      ds_bus_out           => ds_bus9,
      ds_bus_in            => ds_bus9_data,
      haltbus              => haltbus,
                                    
      mem_bus_iscpu        => mem_bus9_iscpu,
      mem_bus_Adr          => mem_bus9_Adr, 
      mem_bus_rnw          => mem_bus9_rnw,
      mem_bus_ena          => mem_bus9_ena, 
      mem_bus_acc          => mem_bus9_acc, 
      mem_bus_dout         => mem_bus9_dout,
      mem_bus_din          => mem_bus9_din, 
      mem_bus_done         => mem_bus9_done,
      
      ITCM_addr            => ITCM_data_addr,   
      ITCM_datain          => ITCM_data_datain, 
      ITCM_dataout         => ITCM_data_dataout,
      ITCM_we              => ITCM_data_we,     
      ITCM_be              => ITCM_data_be,     
            
      BIOS_addr            => BIOS9_data_addr,   
      BIOS_dataout         => BIOS9_data_dataout,

      Externram_Adr        => Externram9data_Adr, 
      Externram_rnw        => Externram9data_rnw, 
      Externram_ena        => Externram9data_ena, 
      Externram_be         => Externram9data_be, 
      Externram_dout       => Externram9data_dout,
      Externram_din        => Externram9data_din, 
      Externram_done       => Externram9data_done,
      
      WramSmall_Mux        => REG_MemControl2_WRAM,
      WramSmallLo_addr     => WramSmallDataLo9_addr,   
      WramSmallLo_datain   => WramSmallDataLo9_datain, 
      WramSmallLo_dataout  => WramSmallDataLo9_dataout,
      WramSmallLo_we       => WramSmallDataLo9_we,     
      WramSmallLo_be       => WramSmallDataLo9_be,     
      WramSmallHi_addr     => WramSmallDataHi9_addr,   
      WramSmallHi_datain   => WramSmallDataHi9_datain, 
      WramSmallHi_dataout  => WramSmallDataHi9_dataout,
      WramSmallHi_we       => WramSmallDataHi9_we,     
      WramSmallHi_be       => WramSmallDataHi9_be,    

      Palette_addr         => Palette_addr,        
      Palette_datain       => Palette_datain,      
      Palette_dataout_bgA  => Palette_dataout_bgA, 
      Palette_dataout_objA => Palette_dataout_objA,
      Palette_dataout_bgB  => Palette_dataout_bgB, 
      Palette_dataout_objB => Palette_dataout_objB,
      Palette_we_bgA       => Palette_we_bgA,      
      Palette_we_objA      => Palette_we_objA,     
      Palette_we_bgB       => Palette_we_bgB,      
      Palette_we_objB      => Palette_we_objB,     
      Palette_be           => Palette_be,
      
      VRam_addr            => VRam_9_addr,     
      VRam_datain          => VRam_9_datain,   
      VRam_dataout_A       => VRam_9_dataout_A,
      VRam_dataout_B       => VRam_9_dataout_B,
      VRam_dataout_C       => VRam_9_dataout_C,
      VRam_dataout_D       => VRam_9_dataout_D,
      VRam_dataout_E       => VRam_9_dataout_E,
      VRam_dataout_F       => VRam_9_dataout_F,
      VRam_dataout_G       => VRam_9_dataout_G,
      VRam_dataout_H       => VRam_9_dataout_H,
      VRam_dataout_I       => VRam_9_dataout_I,
      VRam_we              => VRam_9_we,       
      VRam_be              => VRam_9_be,       
      VRam_active_A        => VRam_9_active_A, 
      VRam_active_B        => VRam_9_active_B, 
      VRam_active_C        => VRam_9_active_C, 
      VRam_active_D        => VRam_9_active_D, 
      VRam_active_E        => VRam_9_active_E, 
      VRam_active_F        => VRam_9_active_F, 
      VRam_active_G        => VRam_9_active_G, 
      VRam_active_H        => VRam_9_active_H, 
      VRam_active_I        => VRam_9_active_I, 

      OAMRam_addr          => OAMRam_addr,     
      OAMRam_datain        => OAMRam_datain,   
      OAMRam_dataout_A     => OAMRam_dataout_A,
      OAMRam_dataout_B     => OAMRam_dataout_B,
      OAMRam_we_A          => OAMRam_we_A,     
      OAMRam_we_B          => OAMRam_we_B,     
      OAMRam_be            => OAMRam_be,

      IPC_fifo_enable      => IPC_fifo_9_enable,
      IPC_fifo_data        => IPC_fifo_9_data,
         
      gc_read              => gc9_gamecard_read,
      gc_romaddress        => gc9_romaddress,   
      gc_readtype          => gc9_readtype, 
      gc_chipID            => ChipID,
      
      auxspi_addr          => auxspi9_addr,   
      auxspi_dataout       => auxspi9_dataout,
      auxspi_request       => auxspi9_request,
      auxspi_rnw           => auxspi9_rnw,    
      auxspi_datain        => auxspi9_datain, 
      auxspi_done          => auxspi9_done 
   );                  
    
   ids_memorymux9code : entity work.ds_memorymux9code
   port map
   (
      clk100               => clk100,
      DS_on                => DS_on_1,
      reset                => reset,
                       
      mem_bus_Adr          => cpu9_bus_code_Adr, 
      mem_bus_ena          => cpu9_bus_code_ena, 
      mem_bus_acc          => cpu9_bus_code_acc, 
      mem_bus_din          => cpu9_bus_code_din, 
      mem_bus_done         => cpu9_bus_code_done,
      
      ITCM_addr            => ITCM_code_addr,   
      ITCM_dataout         => ITCM_code_dataout,
            
      BIOS_addr            => BIOS9_code_addr,   
      BIOS_dataout         => BIOS9_code_dataout,
      
      Externram_Adr        => Externram9code_Adr,
      Externram_ena        => Externram9code_ena,
      Externram_din        => Externram9code_din,
      Externram_done       => Externram9code_done,
      
      WramSmall_Mux        => REG_MemControl2_WRAM,
      WramSmallLo_addr     => WramSmallCodeLo9_addr,
      WramSmallLo_dataout  => WramSmallCodeLo9_dataout,
      WramSmallHi_addr     => WramSmallCodeHi9_addr,
      WramSmallHi_dataout  => WramSmallCodeHi9_dataout,
      
      -- todo allow obscure memories for code
      Palette_addr         => open,
      Palette_dataout_bgA  => x"00000000",
      Palette_dataout_objA => x"00000000",
      Palette_dataout_bgB  => x"00000000",
      Palette_dataout_objB => x"00000000",
      
      VRam_addr            => open,
      VRam_datain          => open,
      VRam_dataout_A       => x"00000000",
      VRam_dataout_B       => x"00000000",
      VRam_dataout_C       => x"00000000",
      VRam_dataout_D       => x"00000000",
      VRam_dataout_E       => x"00000000",
      VRam_dataout_F       => x"00000000",
      VRam_dataout_G       => x"00000000",
      VRam_dataout_H       => x"00000000",
      VRam_dataout_I       => x"00000000",
      VRam_active_A        => '0',
      VRam_active_B        => '0',
      VRam_active_C        => '0',
      VRam_active_D        => '0',
      VRam_active_E        => '0',
      VRam_active_F        => '0',
      VRam_active_G        => '0',
      VRam_active_H        => '0',
      VRam_active_I        => '0',
      
      OAMRam_addr          => open,
      OAMRam_dataout_A     => x"00000000",
      OAMRam_dataout_B     => x"00000000"
   );
    
   ids_dma9 : entity work.ds_dma
   generic map
   (
      isArm9                       => '1',
      DMA0SAD                      => work.pReg_ds_dma_9.DMA0SAD                     ,
      DMA0DAD                      => work.pReg_ds_dma_9.DMA0DAD                     ,
      DMA0CNT_L                    => work.pReg_ds_dma_9.DMA0CNT_L                   ,
      DMA0CNT_H                    => work.pReg_ds_dma_9.DMA0CNT_H                   ,
      DMA0CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_9.DMA0CNT_H_Dest_Addr_Control ,
      DMA0CNT_H_Source_Adr_Control => work.pReg_ds_dma_9.DMA0CNT_H_Source_Adr_Control,
      DMA0CNT_H_DMA_Repeat         => work.pReg_ds_dma_9.DMA0CNT_H_DMA_Repeat        ,
      DMA0CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_9.DMA0CNT_H_DMA_Transfer_Type ,
      DMA0CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_9.DMA0CNT_H_DMA_Start_Timing  ,
      DMA0CNT_H_IRQ_on             => work.pReg_ds_dma_9.DMA0CNT_H_IRQ_on            ,
      DMA0CNT_H_DMA_Enable         => work.pReg_ds_dma_9.DMA0CNT_H_DMA_Enable        ,
      DMA1SAD                      => work.pReg_ds_dma_9.DMA1SAD                     ,
      DMA1DAD                      => work.pReg_ds_dma_9.DMA1DAD                     ,
      DMA1CNT_L                    => work.pReg_ds_dma_9.DMA1CNT_L                   ,
      DMA1CNT_H                    => work.pReg_ds_dma_9.DMA1CNT_H                   ,
      DMA1CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_9.DMA1CNT_H_Dest_Addr_Control ,
      DMA1CNT_H_Source_Adr_Control => work.pReg_ds_dma_9.DMA1CNT_H_Source_Adr_Control,
      DMA1CNT_H_DMA_Repeat         => work.pReg_ds_dma_9.DMA1CNT_H_DMA_Repeat        ,
      DMA1CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_9.DMA1CNT_H_DMA_Transfer_Type ,
      DMA1CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_9.DMA1CNT_H_DMA_Start_Timing  ,
      DMA1CNT_H_IRQ_on             => work.pReg_ds_dma_9.DMA1CNT_H_IRQ_on            ,
      DMA1CNT_H_DMA_Enable         => work.pReg_ds_dma_9.DMA1CNT_H_DMA_Enable        ,
      DMA2SAD                      => work.pReg_ds_dma_9.DMA2SAD                     ,
      DMA2DAD                      => work.pReg_ds_dma_9.DMA2DAD                     ,
      DMA2CNT_L                    => work.pReg_ds_dma_9.DMA2CNT_L                   ,
      DMA2CNT_H                    => work.pReg_ds_dma_9.DMA2CNT_H                   ,
      DMA2CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_9.DMA2CNT_H_Dest_Addr_Control ,
      DMA2CNT_H_Source_Adr_Control => work.pReg_ds_dma_9.DMA2CNT_H_Source_Adr_Control,
      DMA2CNT_H_DMA_Repeat         => work.pReg_ds_dma_9.DMA2CNT_H_DMA_Repeat        ,
      DMA2CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_9.DMA2CNT_H_DMA_Transfer_Type ,
      DMA2CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_9.DMA2CNT_H_DMA_Start_Timing  ,
      DMA2CNT_H_IRQ_on             => work.pReg_ds_dma_9.DMA2CNT_H_IRQ_on            ,
      DMA2CNT_H_DMA_Enable         => work.pReg_ds_dma_9.DMA2CNT_H_DMA_Enable        ,
      DMA3SAD                      => work.pReg_ds_dma_9.DMA3SAD                     ,
      DMA3DAD                      => work.pReg_ds_dma_9.DMA3DAD                     ,
      DMA3CNT_L                    => work.pReg_ds_dma_9.DMA3CNT_L                   ,
      DMA3CNT_H                    => work.pReg_ds_dma_9.DMA3CNT_H                   ,
      DMA3CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_9.DMA3CNT_H_Dest_Addr_Control ,
      DMA3CNT_H_Source_Adr_Control => work.pReg_ds_dma_9.DMA3CNT_H_Source_Adr_Control,
      DMA3CNT_H_DMA_Repeat         => work.pReg_ds_dma_9.DMA3CNT_H_DMA_Repeat        ,
      DMA3CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_9.DMA3CNT_H_DMA_Transfer_Type ,
      DMA3CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_9.DMA3CNT_H_DMA_Start_Timing  ,
      DMA3CNT_H_IRQ_on             => work.pReg_ds_dma_9.DMA3CNT_H_IRQ_on            ,
      DMA3CNT_H_DMA_Enable         => work.pReg_ds_dma_9.DMA3CNT_H_DMA_Enable                    
   )
   port map
   (
      clk100              => clk100,
      reset               => reset,
                           
      savestate_bus       => savestate_bus,
      loading_savestate   => loading_savestate,
      
      ds_bus              => ds_bus9,
      ds_bus_data         => reg_wired_or9(29),
      
      new_cycles          => new_cycles,      
      new_cycles_valid    => new_cycles_valid,
      
      IRP_DMA0            => IRQ9_DMA_0,
      IRP_DMA1            => IRQ9_DMA_1,
      IRP_DMA2            => IRQ9_DMA_2,
      IRP_DMA3            => IRQ9_DMA_3,
      lastread_dma        => open,
      
      dma_on              => dma_on9,
      CPU_bus_idle        => CPU_bus_idle9,
      do_step             => dma_step9,
      dma_soon            => dma_soon9,
      
      hblank_trigger      => hblank_trigger,
      vblank_trigger      => vblank_trigger,
      MemDisplay_trigger  => MemDisplay_trigger,
      cardtrans_trigger   => gc9_dma_request,
      cardtrans_size      => gc9_dma_size,
      
      sounddata_req_ena   => '0', 
      sounddata_req_addr  => x"00000000",
      sounddata_req_done  => open,
      sounddata_req_data  => open,

      dma_cycles_out      => dma_cycles_out9,  
      dma_cycles_valid    => dma_cycles_valid9,
      
      dma_bus_Adr         => dma_bus9_Adr, 
      dma_bus_rnw         => dma_bus9_rnw, 
      dma_bus_ena         => dma_bus9_ena, 
      dma_bus_acc         => dma_bus9_acc, 
      dma_bus_dout        => dma_bus9_dout,
      dma_bus_din         => dma_bus9_din, 
      dma_bus_done        => dma_bus9_done,
      dma_bus_unread      => dma_bus9_unread,
      
      debug_dma           => DebugDMA9,
      debug_dma_count     => debug_dma_count9
   );
   
   ids_timer9 : entity work.ds_timer
   generic map
   (
      is_simu                    => is_simu                  ,
      TM0CNT_L                   => work.pReg_ds_timer_9.TM0CNT_L                 ,
      TM0CNT_H                   => work.pReg_ds_timer_9.TM0CNT_H                 ,
      TM0CNT_H_Prescaler         => work.pReg_ds_timer_9.TM0CNT_H_Prescaler       ,
      TM0CNT_H_Count_up          => work.pReg_ds_timer_9.TM0CNT_H_Count_up        ,
      TM0CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_9.TM0CNT_H_Timer_IRQ_Enable,
      TM0CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_9.TM0CNT_H_Timer_Start_Stop,
      TM1CNT_L                   => work.pReg_ds_timer_9.TM1CNT_L                 ,
      TM1CNT_H                   => work.pReg_ds_timer_9.TM1CNT_H                 ,
      TM1CNT_H_Prescaler         => work.pReg_ds_timer_9.TM1CNT_H_Prescaler       ,
      TM1CNT_H_Count_up          => work.pReg_ds_timer_9.TM1CNT_H_Count_up        ,
      TM1CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_9.TM1CNT_H_Timer_IRQ_Enable,
      TM1CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_9.TM1CNT_H_Timer_Start_Stop,
      TM2CNT_L                   => work.pReg_ds_timer_9.TM2CNT_L                 ,
      TM2CNT_H                   => work.pReg_ds_timer_9.TM2CNT_H                 ,
      TM2CNT_H_Prescaler         => work.pReg_ds_timer_9.TM2CNT_H_Prescaler       ,
      TM2CNT_H_Count_up          => work.pReg_ds_timer_9.TM2CNT_H_Count_up        ,
      TM2CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_9.TM2CNT_H_Timer_IRQ_Enable,
      TM2CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_9.TM2CNT_H_Timer_Start_Stop,
      TM3CNT_L                   => work.pReg_ds_timer_9.TM3CNT_L                 ,
      TM3CNT_H                   => work.pReg_ds_timer_9.TM3CNT_H                 ,
      TM3CNT_H_Prescaler         => work.pReg_ds_timer_9.TM3CNT_H_Prescaler       ,
      TM3CNT_H_Count_up          => work.pReg_ds_timer_9.TM3CNT_H_Count_up        ,
      TM3CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_9.TM3CNT_H_Timer_IRQ_Enable,
      TM3CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_9.TM3CNT_H_Timer_Start_Stop
   )
   port map
   (
      clk100            => clk100,
      ds_on             => DS_on_1,
      reset             => reset,
                            
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus9,
      ds_bus_data       => reg_wired_or9(30),
      
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      IRP_Timer0        => IRQ9_Timer_0_Overflow,
      IRP_Timer1        => IRQ9_Timer_1_Overflow,
      IRP_Timer2        => IRQ9_Timer_2_Overflow,
      IRP_Timer3        => IRQ9_Timer_3_Overflow,
      
      next_event        => nexteventall(0),
                        
      debugout0         => export_timer9(0),
      debugout1         => export_timer9(1),
      debugout2         => export_timer9(2),
      debugout3         => export_timer9(3)
   );
   
   ids_IRQ9 : entity work.ds_IRQ
   generic map
   (
      IME    => work.pReg_ds_system_9.IME,
      IE     => work.pReg_ds_system_9.IE,
      IF_ALL => work.pReg_ds_system_9.IF_ALL
   )
   port map
   (
      clk100                        => clk100,
      ds_on                         => DS_on_1,
      reset                         => reset,
                                        
      savestate_bus                 => savestate_bus,
               
      ds_bus                        => ds_bus9,
      ds_bus_data                   => reg_wired_or9(31),
      
      cpu_irq                       => irq9_pending,
      
      IRQ_LCD_V_Blank               => IRQ9_LCD_V_Blank,              
      IRQ_LCD_H_Blank               => IRQ9_LCD_H_Blank,              
      IRQ_LCD_V_Counter_Match       => IRQ9_LCD_V_Counter_Match,      
      IRQ_Timer_0_Overflow          => IRQ9_Timer_0_Overflow,         
      IRQ_Timer_1_Overflow          => IRQ9_Timer_1_Overflow,         
      IRQ_Timer_2_Overflow          => IRQ9_Timer_2_Overflow,         
      IRQ_Timer_3_Overflow          => IRQ9_Timer_3_Overflow,         
      IRQ_SIO_RCNT_RTC              => '0',             
      IRQ_DMA_0                     => IRQ9_DMA_0,                    
      IRQ_DMA_1                     => IRQ9_DMA_1,                    
      IRQ_DMA_2                     => IRQ9_DMA_2,                    
      IRQ_DMA_3                     => IRQ9_DMA_3,                    
      IRQ_Keypad                    => IRQ9_Keypad,                  
      IRQ_GBA_Slot                  => IRQ9_GBA_Slot,                -- todo  
      IRQ_IPC_Sync                  => IRQ9_IPC_Sync,                 
      IRQ_IPC_Send_FIFO_Empty       => IRQ9_IPC_Send_FIFO_Empty,      
      IRQ_IPC_Recv_FIFO_Not_Empty   => IRQ9_IPC_Recv_FIFO_Not_Empty,  
      IRQ_NDS_Slot_TransferComplete => IRQ9_NDS_Slot_TransferComplete,
      IRQ_NDS_Slot_IREQ_MC          => IRQ9_NDS_Slot_IREQ_MC,          -- todo 
      IRQ_Geometry_Command_FIFO     => IRQ9_Geometry_Command_FIFO,     -- todo 
      IRQ_Screens_unfolding         => '0',        
      IRQ_SPI_bus                   => '0',                  
      IRQ_Wifi                      => '0',

      IF_debug                      => IF_intern9      
   );
   
   IRQ9_GBA_Slot                  <= '0';
   IRQ9_NDS_Slot_IREQ_MC          <= '0';
   IRQ9_Geometry_Command_FIFO     <= '0';
   
   ids_divider : entity work.ds_divider
   port map
   (
      clk100               => clk100,
      ds_on                => ds_on_1, 
      reset                => reset, 
                           
      ds_bus               => ds_bus9,
      ds_bus_data          => reg_wired_or9(32),
      haltbus              => haltbus_divider,
                           
      new_cycles           => new_cycles,      
      new_cycles_valid     => new_cycles_valid
   );
   
   ids_sqrt : entity work.ds_sqrt
   port map
   (
      clk100               => clk100,
      ds_on                => ds_on_1, 
      reset                => reset, 
                           
      ds_bus               => ds_bus9,
      ds_bus_data          => reg_wired_or9(33),
      haltbus              => haltbus_sqrt,
                           
      new_cycles           => new_cycles,      
      new_cycles_valid     => new_cycles_valid
   );
   
   ids_gamecard9 : entity work.ds_gamecard
   generic map
   (
      AUXSPICNT_SPI_Baudrate        => work.pReg_ds_system_9.AUXSPICNT_SPI_Baudrate       ,
      AUXSPICNT_SPI_Hold_Chipselect => work.pReg_ds_system_9.AUXSPICNT_SPI_Hold_Chipselect,
      AUXSPICNT_SPI_Busy            => work.pReg_ds_system_9.AUXSPICNT_SPI_Busy           ,
      AUXSPICNT_NDS_Slot_Mode       => work.pReg_ds_system_9.AUXSPICNT_NDS_Slot_Mode      ,
      AUXSPICNT_Transfer_Ready_IRQ  => work.pReg_ds_system_9.AUXSPICNT_Transfer_Ready_IRQ ,
      AUXSPICNT_NDS_Slot_Enable     => work.pReg_ds_system_9.AUXSPICNT_NDS_Slot_Enable    ,
      AUXSPIDATA                    => work.pReg_ds_system_9.AUXSPIDATA                   ,
      ROMCTRL_KEY1_gap1_length      => work.pReg_ds_system_9.ROMCTRL_KEY1_gap1_length     ,
      ROMCTRL_KEY2_encrypt_data     => work.pReg_ds_system_9.ROMCTRL_KEY2_encrypt_data    ,
      ROMCTRL_SE                    => work.pReg_ds_system_9.ROMCTRL_SE                   ,
      ROMCTRL_KEY2_Apply_Seed       => work.pReg_ds_system_9.ROMCTRL_KEY2_Apply_Seed      ,
      ROMCTRL_KEY1_gap2_length      => work.pReg_ds_system_9.ROMCTRL_KEY1_gap2_length     ,
      ROMCTRL_KEY2_encrypt_cmd      => work.pReg_ds_system_9.ROMCTRL_KEY2_encrypt_cmd     ,
      ROMCTRL_Data_Word_Status      => work.pReg_ds_system_9.ROMCTRL_Data_Word_Status     ,
      ROMCTRL_Data_Block_size       => work.pReg_ds_system_9.ROMCTRL_Data_Block_size      ,
      ROMCTRL_Transfer_CLK_rate     => work.pReg_ds_system_9.ROMCTRL_Transfer_CLK_rate    ,
      ROMCTRL_KEY1_Gap_CLKs         => work.pReg_ds_system_9.ROMCTRL_KEY1_Gap_CLKs        ,
      ROMCTRL_RESB_Release_Reset    => work.pReg_ds_system_9.ROMCTRL_RESB_Release_Reset   ,
      ROMCTRL_WR                    => work.pReg_ds_system_9.ROMCTRL_WR                   ,
      ROMCTRL_Block_Start_Status    => work.pReg_ds_system_9.ROMCTRL_Block_Start_Status   ,
      Gamecard_bus_Command_1        => work.pReg_ds_system_9.Gamecard_bus_Command_1       ,
      Gamecard_bus_Command_2        => work.pReg_ds_system_9.Gamecard_bus_Command_2       
   )
   port map
   (
      clk100            => clk100,
      reset             => reset,
                         
      ds_bus            => ds_bus9,
      ds_bus_data       => reg_wired_or9(41),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
                        
      IRQ_Slot          => IRQ9_NDS_Slot_TransferComplete,
                        
      dma_request       => gc9_dma_request,
      dma_size          => gc9_dma_size,   
                        
      gamecard_read     => gc9_gamecard_read,
      romaddress        => gc9_romaddress,   
      readtype          => gc9_readtype,

      auxspi_addr       => auxspi9_addr,   
      auxspi_dataout    => auxspi9_dataout,
      auxspi_request    => auxspi9_request,
      auxspi_rnw        => auxspi9_rnw,    
      auxspi_datain     => auxspi9_datain, 
      auxspi_done       => auxspi9_done       
   );

   ids_cpu9 : entity work.ds_cpu
   generic map
   (
      is_simu => is_simu,
      isArm9  => '1'
   )
   port map
   (
      clk100           => clk100,
      ds_on            => DS_on_1,
      reset            => reset,
      
      PCEntry          => PC9Entry,
      
      savestate_bus    => savestate_bus,
      
      OBus_1_Adr       => cpu9_bus_data_Adr, 
      OBus_1_rnw       => cpu9_bus_data_rnw, 
      OBus_1_ena       => cpu9_bus_data_ena, 
      OBus_1_acc       => cpu9_bus_data_acc, 
      OBus_1_dout      => cpu9_bus_data_dout,
      OBus_1_din       => cpu9_bus_data_din, 
      OBus_1_done      => cpu9_bus_data_done,
      
      OBus_2_Adr       => cpu9_bus_code_Adr,
      OBus_2_ena       => cpu9_bus_code_ena,
      OBus_2_acc       => cpu9_bus_code_acc,
      OBus_2_din       => cpu9_bus_code_din,
      OBus_2_done      => cpu9_bus_code_done,
      
      ram128code_data  => Externram9code_din128,
      ram128code_done  => Externram9code_done,      
      ram128data_data  => Externram9data_din128,
      ram128data_done  => Externram9data_done,
      
      snoop_Adr        => snoop_Adr, 
      snoop_data       => snoop_data,
      snoop_we         => snoop_we,  
      snoop_be         => snoop_be, 
      
      bus_lowbits      => open,
      
      settle           => '0',
      dma_on           => dma_on9,
      do_step          => do_step9,
      done             => done_9,
      CPU_bus_idle     => CPU_bus_idle9,
      PC_in_BIOS       => open,
      lastread         => open,
      jump_out         => open,
      
      DTCMRegion       => DTCMRegion,
      
      new_cycles_out   => new_cycles9,
      new_cycles_valid => new_cycles9_valid,
      
      cpu_IRQ          => cpu_irq9,
      new_halt         => '0',
      halt_out         => halt9,
      irq_out          => cpuirqdone9,
      irq_off          => irq9_disable,
      
      debug_cpu_mixed  => DebugCPU9,
      
      exportdata       => export_cpu9
   );
                      
   ------------- debug bus
   process (clk100)
   begin
      if rising_edge(clk100) then
   
         debug_bus9_ena    <= '0';
         if (DS9_Bus_written = '1') then
            debug_bus9_active <= '1';
            debug_bus9_Adr    <= x"0" & DS9_BusAddr;
            debug_bus9_rnw    <= DS9_BusRnW;
            debug_bus9_ena    <= '1';
            debug_bus9_acc    <= DS9_BusACC;
            debug_bus9_dout   <= DS9_BusWriteData;
         elsif (bootbus9_ena = '1') then
            debug_bus9_active <= '1';
            debug_bus9_Adr    <= bootbus9_Addr;
            debug_bus9_rnw    <= bootbus9_RnW;
            debug_bus9_ena    <= '1';
            debug_bus9_acc    <= bootbus9_ACC;
            debug_bus9_dout   <= bootbus9_WriteData;
         end if;
         
         bootbus9_done     <= '0';
         if (debug_bus9_active = '1' and mem_bus9_done = '1') then
            DS9_BusReadData   <= mem_bus9_din;
            bootbus9_ReadData <= mem_bus9_din;
            bootbus9_done     <= '1';
            debug_bus9_active <= '0';
         end if;
         
      end if;
   end process;
   
   
   -- ################################
   -- ########## ARM 7
   -- ################################
   
   mem_bus7_Adr  <=  debug_bus7_Adr  when debug_bus7_active = '1' else dma_bus7_Adr  when CPU_bus_idle7 = '1' else cpu7_bus_Adr;
   mem_bus7_rnw  <=  debug_bus7_rnw  when debug_bus7_active = '1' else dma_bus7_rnw  when CPU_bus_idle7 = '1' else cpu7_bus_rnw;
   mem_bus7_ena  <=  debug_bus7_ena  when debug_bus7_active = '1' else dma_bus7_ena  when CPU_bus_idle7 = '1' else cpu7_bus_ena; 
   mem_bus7_acc  <=  debug_bus7_acc  when debug_bus7_active = '1' else dma_bus7_acc  when CPU_bus_idle7 = '1' else cpu7_bus_acc;
   mem_bus7_dout <=  debug_bus7_dout when debug_bus7_active = '1' else dma_bus7_dout when CPU_bus_idle7 = '1' else cpu7_bus_dout;
                      
   dma_bus7_din    <= mem_bus7_din;
   dma_bus7_done   <= mem_bus7_done;
   dma_bus7_unread <= '0';
   
   cpu7_bus_din    <= mem_bus7_din;
   cpu7_bus_done   <= mem_bus7_done;

                      
   ids_memorymux7 : entity work.ds_memorymux7
   generic map 
   (
      is_simu                 => is_simu,
      Softmap_DS_SAVERAM_ADDR => Softmap_DS_SAVERAM_ADDR,
      Softmap_DS_GAMEROM_ADDR => Softmap_DS_GAMEROM_ADDR
   )
   port map
   (
      clk100               => clk100,
      DS_on                => DS_on_1,
      reset                => reset,
      
      ds_bus_out           => ds_bus7,
      ds_bus_in            => ds_bus7_data,
      
      pc_in_bios           => pc_in_bios7,
                                    
      mem_bus_Adr          => mem_bus7_Adr, 
      mem_bus_rnw          => mem_bus7_rnw,
      mem_bus_ena          => mem_bus7_ena, 
      mem_bus_acc          => mem_bus7_acc, 
      mem_bus_dout         => mem_bus7_dout,
      mem_bus_din          => mem_bus7_din, 
      mem_bus_done         => mem_bus7_done,
      
      Externram_Adr        => Externram7_Adr, 
      Externram_rnw        => Externram7_rnw, 
      Externram_ena        => Externram7_ena, 
      Externram_be         => Externram7_be, 
      Externram_dout       => Externram7_dout,
      Externram_din        => Externram7_din, 
      Externram_done       => Externram7_done,
      
      WramSmall_Mux        => REG_MemControl2_WRAM,
      WramSmallLo_addr     => WramSmallLo7_addr,   
      WramSmallLo_datain   => WramSmallLo7_datain, 
      WramSmallLo_dataout  => WramSmallLo7_dataout,
      WramSmallLo_we       => WramSmallLo7_we,     
      WramSmallLo_be       => WramSmallLo7_be,     
      WramSmallHi_addr     => WramSmallHi7_addr,   
      WramSmallHi_datain   => WramSmallHi7_datain, 
      WramSmallHi_dataout  => WramSmallHi7_dataout,
      WramSmallHi_we       => WramSmallHi7_we,     
      WramSmallHi_be       => WramSmallHi7_be,    
 
      VRam_addr            => VRam_7_addr,     
      VRam_datain          => VRam_7_datain,   
      VRam_dataout_C       => VRam_7_dataout_C,
      VRam_dataout_D       => VRam_7_dataout_D,
      VRam_we              => VRam_7_we,       
      VRam_be              => VRam_7_be,       
      VRam_active_C        => VRam_7_active_C, 
      VRam_active_D        => VRam_7_active_D,

      IPC_fifo_enable      => IPC_fifo_7_enable,
      IPC_fifo_data        => IPC_fifo_7_data,
      
      spi_done             => spi_done,
      
      gc_read              => gc7_gamecard_read,
      gc_romaddress        => gc7_romaddress,   
      gc_readtype          => gc7_readtype, 
      gc_chipID            => ChipID,
      
      auxspi_addr          => auxspi7_addr,   
      auxspi_dataout       => auxspi7_dataout,
      auxspi_request       => auxspi7_request,
      auxspi_rnw           => auxspi7_rnw,    
      auxspi_datain        => auxspi7_datain, 
      auxspi_done          => auxspi7_done 
   );       

   ids_dma7 : entity work.ds_dma
   generic map
   (
      isArm9                       => '0',
      DMA0SAD                      => work.pReg_ds_dma_7.DMA0SAD                     ,
      DMA0DAD                      => work.pReg_ds_dma_7.DMA0DAD                     ,
      DMA0CNT_L                    => work.pReg_ds_dma_7.DMA0CNT_L                   ,
      DMA0CNT_H                    => work.pReg_ds_dma_7.DMA0CNT_H                   ,
      DMA0CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_7.DMA0CNT_H_Dest_Addr_Control ,
      DMA0CNT_H_Source_Adr_Control => work.pReg_ds_dma_7.DMA0CNT_H_Source_Adr_Control,
      DMA0CNT_H_DMA_Repeat         => work.pReg_ds_dma_7.DMA0CNT_H_DMA_Repeat        ,
      DMA0CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_7.DMA0CNT_H_DMA_Transfer_Type ,
      DMA0CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_7.DMA0CNT_H_DMA_Start_Timing  ,
      DMA0CNT_H_IRQ_on             => work.pReg_ds_dma_7.DMA0CNT_H_IRQ_on            ,
      DMA0CNT_H_DMA_Enable         => work.pReg_ds_dma_7.DMA0CNT_H_DMA_Enable        ,
      DMA1SAD                      => work.pReg_ds_dma_7.DMA1SAD                     ,
      DMA1DAD                      => work.pReg_ds_dma_7.DMA1DAD                     ,
      DMA1CNT_L                    => work.pReg_ds_dma_7.DMA1CNT_L                   ,
      DMA1CNT_H                    => work.pReg_ds_dma_7.DMA1CNT_H                   ,
      DMA1CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_7.DMA1CNT_H_Dest_Addr_Control ,
      DMA1CNT_H_Source_Adr_Control => work.pReg_ds_dma_7.DMA1CNT_H_Source_Adr_Control,
      DMA1CNT_H_DMA_Repeat         => work.pReg_ds_dma_7.DMA1CNT_H_DMA_Repeat        ,
      DMA1CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_7.DMA1CNT_H_DMA_Transfer_Type ,
      DMA1CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_7.DMA1CNT_H_DMA_Start_Timing  ,
      DMA1CNT_H_IRQ_on             => work.pReg_ds_dma_7.DMA1CNT_H_IRQ_on            ,
      DMA1CNT_H_DMA_Enable         => work.pReg_ds_dma_7.DMA1CNT_H_DMA_Enable        ,
      DMA2SAD                      => work.pReg_ds_dma_7.DMA2SAD                     ,
      DMA2DAD                      => work.pReg_ds_dma_7.DMA2DAD                     ,
      DMA2CNT_L                    => work.pReg_ds_dma_7.DMA2CNT_L                   ,
      DMA2CNT_H                    => work.pReg_ds_dma_7.DMA2CNT_H                   ,
      DMA2CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_7.DMA2CNT_H_Dest_Addr_Control ,
      DMA2CNT_H_Source_Adr_Control => work.pReg_ds_dma_7.DMA2CNT_H_Source_Adr_Control,
      DMA2CNT_H_DMA_Repeat         => work.pReg_ds_dma_7.DMA2CNT_H_DMA_Repeat        ,
      DMA2CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_7.DMA2CNT_H_DMA_Transfer_Type ,
      DMA2CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_7.DMA2CNT_H_DMA_Start_Timing  ,
      DMA2CNT_H_IRQ_on             => work.pReg_ds_dma_7.DMA2CNT_H_IRQ_on            ,
      DMA2CNT_H_DMA_Enable         => work.pReg_ds_dma_7.DMA2CNT_H_DMA_Enable        ,
      DMA3SAD                      => work.pReg_ds_dma_7.DMA3SAD                     ,
      DMA3DAD                      => work.pReg_ds_dma_7.DMA3DAD                     ,
      DMA3CNT_L                    => work.pReg_ds_dma_7.DMA3CNT_L                   ,
      DMA3CNT_H                    => work.pReg_ds_dma_7.DMA3CNT_H                   ,
      DMA3CNT_H_Dest_Addr_Control  => work.pReg_ds_dma_7.DMA3CNT_H_Dest_Addr_Control ,
      DMA3CNT_H_Source_Adr_Control => work.pReg_ds_dma_7.DMA3CNT_H_Source_Adr_Control,
      DMA3CNT_H_DMA_Repeat         => work.pReg_ds_dma_7.DMA3CNT_H_DMA_Repeat        ,
      DMA3CNT_H_DMA_Transfer_Type  => work.pReg_ds_dma_7.DMA3CNT_H_DMA_Transfer_Type ,
      DMA3CNT_H_DMA_Start_Timing   => work.pReg_ds_dma_7.DMA3CNT_H_DMA_Start_Timing  ,
      DMA3CNT_H_IRQ_on             => work.pReg_ds_dma_7.DMA3CNT_H_IRQ_on            ,
      DMA3CNT_H_DMA_Enable         => work.pReg_ds_dma_7.DMA3CNT_H_DMA_Enable                    
   )
   port map
   (
      clk100              => clk100,
      reset               => reset,
                           
      savestate_bus       => savestate_bus,
      loading_savestate   => loading_savestate,
      
      ds_bus              => ds_bus7,
      ds_bus_data         => reg_wired_or7(2),
      
      new_cycles          => new_cycles,      
      new_cycles_valid    => new_cycles_valid,
      
      IRP_DMA0            => IRQ7_DMA_0,
      IRP_DMA1            => IRQ7_DMA_1,
      IRP_DMA2            => IRQ7_DMA_2,
      IRP_DMA3            => IRQ7_DMA_3,
      lastread_dma        => open,
      
      dma_on              => dma_on7,
      CPU_bus_idle        => CPU_bus_idle7,
      do_step             => dma_step7,
      dma_soon            => dma_soon7,
      
      hblank_trigger      => hblank_trigger,
      vblank_trigger      => vblank_trigger,
      MemDisplay_trigger  => '0',
      cardtrans_trigger   => gc7_dma_request,
      cardtrans_size      => gc7_dma_size,
      
      sounddata_req_ena   => sounddata_req_ena, 
      sounddata_req_addr  => sounddata_req_addr,
      sounddata_req_done  => sounddata_req_done,
      sounddata_req_data  => sounddata_req_data,
      
      dma_cycles_out      => dma_cycles_out7,  
      dma_cycles_valid    => dma_cycles_valid7,
      
      dma_bus_Adr         => dma_bus7_Adr, 
      dma_bus_rnw         => dma_bus7_rnw, 
      dma_bus_ena         => dma_bus7_ena, 
      dma_bus_acc         => dma_bus7_acc, 
      dma_bus_dout        => dma_bus7_dout,
      dma_bus_din         => dma_bus7_din, 
      dma_bus_done        => dma_bus7_done,
      dma_bus_unread      => dma_bus7_unread,
      
      debug_dma           => DebugDMA7,
      debug_dma_count     => debug_dma_count7
   );   
    
   ids_timer7 : entity work.ds_timer
   generic map
   (
      is_simu                    => is_simu                  ,
      TM0CNT_L                   => work.pReg_ds_timer_7.TM0CNT_L                 ,
      TM0CNT_H                   => work.pReg_ds_timer_7.TM0CNT_H                 ,
      TM0CNT_H_Prescaler         => work.pReg_ds_timer_7.TM0CNT_H_Prescaler       ,
      TM0CNT_H_Count_up          => work.pReg_ds_timer_7.TM0CNT_H_Count_up        ,
      TM0CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_7.TM0CNT_H_Timer_IRQ_Enable,
      TM0CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_7.TM0CNT_H_Timer_Start_Stop,
      TM1CNT_L                   => work.pReg_ds_timer_7.TM1CNT_L                 ,
      TM1CNT_H                   => work.pReg_ds_timer_7.TM1CNT_H                 ,
      TM1CNT_H_Prescaler         => work.pReg_ds_timer_7.TM1CNT_H_Prescaler       ,
      TM1CNT_H_Count_up          => work.pReg_ds_timer_7.TM1CNT_H_Count_up        ,
      TM1CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_7.TM1CNT_H_Timer_IRQ_Enable,
      TM1CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_7.TM1CNT_H_Timer_Start_Stop,
      TM2CNT_L                   => work.pReg_ds_timer_7.TM2CNT_L                 ,
      TM2CNT_H                   => work.pReg_ds_timer_7.TM2CNT_H                 ,
      TM2CNT_H_Prescaler         => work.pReg_ds_timer_7.TM2CNT_H_Prescaler       ,
      TM2CNT_H_Count_up          => work.pReg_ds_timer_7.TM2CNT_H_Count_up        ,
      TM2CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_7.TM2CNT_H_Timer_IRQ_Enable,
      TM2CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_7.TM2CNT_H_Timer_Start_Stop,
      TM3CNT_L                   => work.pReg_ds_timer_7.TM3CNT_L                 ,
      TM3CNT_H                   => work.pReg_ds_timer_7.TM3CNT_H                 ,
      TM3CNT_H_Prescaler         => work.pReg_ds_timer_7.TM3CNT_H_Prescaler       ,
      TM3CNT_H_Count_up          => work.pReg_ds_timer_7.TM3CNT_H_Count_up        ,
      TM3CNT_H_Timer_IRQ_Enable  => work.pReg_ds_timer_7.TM3CNT_H_Timer_IRQ_Enable,
      TM3CNT_H_Timer_Start_Stop  => work.pReg_ds_timer_7.TM3CNT_H_Timer_Start_Stop
   )
   port map
   (
      clk100            => clk100,
      ds_on             => DS_on_1,
      reset             => reset,
                            
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus7,
      ds_bus_data       => reg_wired_or7(3),
      
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      IRP_Timer0        => IRQ7_Timer_0_Overflow,
      IRP_Timer1        => IRQ7_Timer_1_Overflow,
      IRP_Timer2        => IRQ7_Timer_2_Overflow,
      IRP_Timer3        => IRQ7_Timer_3_Overflow,
      
      next_event        => nexteventall(1),
                        
      debugout0         => export_timer7(0),
      debugout1         => export_timer7(1),
      debugout2         => export_timer7(2),
      debugout3         => export_timer7(3)
   );
   
   ids_IRQ7 : entity work.ds_IRQ
   generic map
   (
      IME    => work.pReg_ds_system_7.IME,
      IE     => work.pReg_ds_system_7.IE,
      IF_ALL => work.pReg_ds_system_7.IF_ALL
   )
   port map
   (
      clk100                        => clk100,
      ds_on                         => DS_on_1,
      reset                         => reset,
                                        
      savestate_bus                 => savestate_bus,
               
      ds_bus                        => ds_bus7,
      ds_bus_data                   => reg_wired_or7(4),
      
      cpu_irq                       => irq7_pending,
      
      IRQ_LCD_V_Blank               => IRQ7_LCD_V_Blank,              
      IRQ_LCD_H_Blank               => IRQ7_LCD_H_Blank,              
      IRQ_LCD_V_Counter_Match       => IRQ7_LCD_V_Counter_Match,      
      IRQ_Timer_0_Overflow          => IRQ7_Timer_0_Overflow,         
      IRQ_Timer_1_Overflow          => IRQ7_Timer_1_Overflow,         
      IRQ_Timer_2_Overflow          => IRQ7_Timer_2_Overflow,         
      IRQ_Timer_3_Overflow          => IRQ7_Timer_3_Overflow,         
      IRQ_SIO_RCNT_RTC              => IRQ7_SIO_RCNT_RTC,   -- todo          
      IRQ_DMA_0                     => IRQ7_DMA_0,                    
      IRQ_DMA_1                     => IRQ7_DMA_1,                    
      IRQ_DMA_2                     => IRQ7_DMA_2,                    
      IRQ_DMA_3                     => IRQ7_DMA_3,                    
      IRQ_Keypad                    => IRQ7_Keypad,                  
      IRQ_GBA_Slot                  => IRQ7_GBA_Slot,     -- todo             
      IRQ_IPC_Sync                  => IRQ7_IPC_Sync,                 
      IRQ_IPC_Send_FIFO_Empty       => IRQ7_IPC_Send_FIFO_Empty,      
      IRQ_IPC_Recv_FIFO_Not_Empty   => IRQ7_IPC_Recv_FIFO_Not_Empty,  
      IRQ_NDS_Slot_TransferComplete => IRQ7_NDS_Slot_TransferComplete,
      IRQ_NDS_Slot_IREQ_MC          => IRQ7_NDS_Slot_IREQ_MC,          -- todo 
      IRQ_Geometry_Command_FIFO     => '0',    
      IRQ_Screens_unfolding         => IRQ7_Screens_unfolding,        -- todo 
      IRQ_SPI_bus                   => IRQ7_SPI_bus,                  -- todo 
      IRQ_Wifi                      => IRQ7_Wifi,                     -- todo 
      
      IF_debug                      => IF_intern7 
   );
   
   IRQ7_SIO_RCNT_RTC              <= '0';
   IRQ7_GBA_Slot                  <= '0';
   IRQ7_NDS_Slot_IREQ_MC          <= '0';
   IRQ7_Screens_unfolding         <= '0';
   IRQ7_SPI_bus                   <= '0';
   IRQ7_Wifi                      <= '0';
   
   ids_SPI_intern : entity work.ds_SPI_intern
   generic map
   (
      Softmap_DS_FIRMWARE_ADDR => Softmap_DS_FIRMWARE_ADDR
   )
   port map
   (
      clk100          => clk100,
      ds_on           => DS_on_1,
      reset           => reset,
      
      ds_bus          => ds_bus7,
      ds_bus_data     => reg_wired_or7(5),

      Touch           => Touch,  
      TouchX          => TouchX,
      TouchY          => TouchY,
    
      spi_done        => spi_done,
      spi_active      => spi_active,      
      firmware_read   => firmware_read,
      firmware_addr   => firmware_addr,
      firmware_data   => Externram7_din, 
      firmware_done   => Externram7_done
   );
   
   ids_gamecard7 : entity work.ds_gamecard
   generic map
   (
      AUXSPICNT_SPI_Baudrate        => work.pReg_ds_system_7.AUXSPICNT_SPI_Baudrate       ,
      AUXSPICNT_SPI_Hold_Chipselect => work.pReg_ds_system_7.AUXSPICNT_SPI_Hold_Chipselect,
      AUXSPICNT_SPI_Busy            => work.pReg_ds_system_7.AUXSPICNT_SPI_Busy           ,
      AUXSPICNT_NDS_Slot_Mode       => work.pReg_ds_system_7.AUXSPICNT_NDS_Slot_Mode      ,
      AUXSPICNT_Transfer_Ready_IRQ  => work.pReg_ds_system_7.AUXSPICNT_Transfer_Ready_IRQ ,
      AUXSPICNT_NDS_Slot_Enable     => work.pReg_ds_system_7.AUXSPICNT_NDS_Slot_Enable    ,
      AUXSPIDATA                    => work.pReg_ds_system_7.AUXSPIDATA                   ,
      ROMCTRL_KEY1_gap1_length      => work.pReg_ds_system_7.ROMCTRL_KEY1_gap1_length     ,
      ROMCTRL_KEY2_encrypt_data     => work.pReg_ds_system_7.ROMCTRL_KEY2_encrypt_data    ,
      ROMCTRL_SE                    => work.pReg_ds_system_7.ROMCTRL_SE                   ,
      ROMCTRL_KEY2_Apply_Seed       => work.pReg_ds_system_7.ROMCTRL_KEY2_Apply_Seed      ,
      ROMCTRL_KEY1_gap2_length      => work.pReg_ds_system_7.ROMCTRL_KEY1_gap2_length     ,
      ROMCTRL_KEY2_encrypt_cmd      => work.pReg_ds_system_7.ROMCTRL_KEY2_encrypt_cmd     ,
      ROMCTRL_Data_Word_Status      => work.pReg_ds_system_7.ROMCTRL_Data_Word_Status     ,
      ROMCTRL_Data_Block_size       => work.pReg_ds_system_7.ROMCTRL_Data_Block_size      ,
      ROMCTRL_Transfer_CLK_rate     => work.pReg_ds_system_7.ROMCTRL_Transfer_CLK_rate    ,
      ROMCTRL_KEY1_Gap_CLKs         => work.pReg_ds_system_7.ROMCTRL_KEY1_Gap_CLKs        ,
      ROMCTRL_RESB_Release_Reset    => work.pReg_ds_system_7.ROMCTRL_RESB_Release_Reset   ,
      ROMCTRL_WR                    => work.pReg_ds_system_7.ROMCTRL_WR                   ,
      ROMCTRL_Block_Start_Status    => work.pReg_ds_system_7.ROMCTRL_Block_Start_Status   ,
      Gamecard_bus_Command_1        => work.pReg_ds_system_7.Gamecard_bus_Command_1       ,
      Gamecard_bus_Command_2        => work.pReg_ds_system_7.Gamecard_bus_Command_2       
   )
   port map
   (
      clk100            => clk100,
      reset             => reset,
                         
      ds_bus            => ds_bus7,
      ds_bus_data       => reg_wired_or7(13),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
                        
      IRQ_Slot          => IRQ7_NDS_Slot_TransferComplete,
                        
      dma_request       => gc7_dma_request,
      dma_size          => gc7_dma_size,   
                        
      gamecard_read     => gc7_gamecard_read,
      romaddress        => gc7_romaddress,   
      readtype          => gc7_readtype,

      auxspi_addr       => auxspi7_addr,   
      auxspi_dataout    => auxspi7_dataout,
      auxspi_request    => auxspi7_request,
      auxspi_rnw        => auxspi7_rnw,    
      auxspi_datain     => auxspi7_datain, 
      auxspi_done       => auxspi7_done   
   );
   
   ids_sound : entity work.ds_sound
   port map
   (
      clk100              => clk100,          
      reset               => reset,           
                                             
      ds_bus              => ds_bus7,          
      ds_bus_data         => reg_wired_or7(14),      
                                             
      new_cycles          => new_cycles,      
      new_cycles_valid    => new_cycles_valid,
      
      sound_out_L         => sound_out_left,
      sound_out_R         => sound_out_right,
                                   
      req_ena             => sounddata_req_ena, 
      req_addr            => sounddata_req_addr,
      req_done            => sounddata_req_done,
      req_data            => sounddata_req_data
   );
   
   ids_cpu7 : entity work.ds_cpu
   generic map
   (
      is_simu => is_simu,
      isArm9  => '0'
   )
   port map
   (
      clk100           => clk100,
      ds_on            => DS_on_1,
      reset            => reset,
      
      PCEntry          => PC7Entry,
      
      savestate_bus    => savestate_bus,
      
      OBus_1_Adr       => cpu7_bus_Adr, 
      OBus_1_rnw       => cpu7_bus_rnw, 
      OBus_1_ena       => cpu7_bus_ena, 
      OBus_1_acc       => cpu7_bus_acc, 
      OBus_1_dout      => cpu7_bus_dout,
      OBus_1_din       => cpu7_bus_din, 
      OBus_1_done      => cpu7_bus_done,
      
      OBus_2_Adr       => open,
      OBus_2_ena       => open,
      OBus_2_acc       => open,
      OBus_2_din       => x"00000000",
      OBus_2_done      => '0',
      
      ram128code_data  => Externram7_din128,
      ram128code_done  => Externram7_done,      
      ram128data_data  => Externram7_din128,
      ram128data_done  => Externram7_done,
      
      snoop_Adr        => snoop_Adr, 
      snoop_data       => snoop_data,
      snoop_we         => snoop_we,  
      snoop_be         => snoop_be,  
      
      bus_lowbits      => open,
      
      settle           => '0',
      dma_on           => dma_on7,
      do_step          => do_step7,
      done             => done_7,
      CPU_bus_idle     => CPU_bus_idle7,
      PC_in_BIOS       => pc_in_bios7,
      lastread         => open,
      jump_out         => open,
      
      DTCMRegion       => open,
      
      new_cycles_out   => new_cycles7,
      new_cycles_valid => new_cycles7_valid,
      
      cpu_IRQ          => cpu_irq7,
      new_halt         => new_halt7,
      halt_out         => halt7,
      irq_out          => cpuirqdone7,
      irq_off          => irq7_disable,
      
      debug_cpu_mixed  => DebugCPU7,
      
      exportdata       => export_cpu7
   );
                      
   ------------- debug bus
   process (clk100)
   begin
      if rising_edge(clk100) then
   
         debug_bus7_ena    <= '0';
         if (DS7_Bus_written = '1') then
            debug_bus7_active <= '1';
            debug_bus7_Adr    <= x"0" & DS7_BusAddr;
            debug_bus7_rnw    <= DS7_BusRnW;
            debug_bus7_ena    <= '1';
            debug_bus7_acc    <= DS7_BusACC;
            debug_bus7_dout   <= DS7_BusWriteData;
         elsif (bootbus7_ena = '1') then
            debug_bus7_active <= '1';
            debug_bus7_Adr    <= bootbus7_Addr;
            debug_bus7_rnw    <= bootbus7_RnW;
            debug_bus7_ena    <= '1';
            debug_bus7_acc    <= bootbus7_ACC;
            debug_bus7_dout   <= bootbus7_WriteData;
         end if;
         
         bootbus7_done <= '0';   
         if (debug_bus7_active = '1' and mem_bus7_done = '1') then
            DS7_BusReadData   <= mem_bus7_din;
            bootbus7_ReadData <= mem_bus7_din;
            bootbus7_done     <= '1';
            debug_bus7_active <= '0';
         end if;
         
      end if;
   end process;
  
   
   -- ################################
   -- ########## GPU
   -- ################################
   
   ids_gpu : entity work.ds_gpu
   generic map
   (
      is_simu   => is_simu,
      ds_nogpu  => ds_nogpu 
   )
   port map
   (
      clk100               => clk100,
      ds_on                => DS_on_1,
      reset                => reset,
      
      ds_bus9              => ds_bus9,
      ds_bus9_data         => reg_wired_or9(35),
      ds_bus7              => ds_bus7,
      ds_bus7_data         => reg_wired_or7(6),
                      
      lockspeed            => '0', --DS_lockspeed,
      maxpixels            => '0',
                  
      pixel_out1_x         => pixel_out1_x,   
      pixel_out1_y         => pixel_out1_y,   
      pixel_out1_data      => pixel_out1_data, 
      pixel_out1_we        => pixel_out1_we,  
      pixel_out2_x         => pixel_out2_x,   
      pixel_out2_y         => pixel_out2_y,   
      pixel_out2_data      => pixel_out2_data, 
      pixel_out2_we        => pixel_out2_we,  
                           
      new_cycles           => new_cycles,      
      new_cycles_valid     => new_cycles_valid,
                                                         
      IRP_HBlank9          => IRQ9_LCD_H_Blank,
      IRP_HBlank7          => IRQ7_LCD_H_Blank,
      IRP_VBlank9          => IRQ9_LCD_V_Blank,
      IRP_VBlank7          => IRQ7_LCD_V_Blank,
      IRP_LCDStat9         => IRQ9_LCD_V_Counter_Match,
      IRP_LCDStat7         => IRQ7_LCD_V_Counter_Match,
                           
      hblank_trigger       => hblank_trigger,
      vblank_trigger       => vblank_trigger,
      MemDisplay_trigger   => MemDisplay_trigger,
                                              
      Palette_addr         => Palette_addr,        
      Palette_datain       => Palette_datain,      
      Palette_dataout_bgA  => Palette_dataout_bgA, 
      Palette_dataout_objA => Palette_dataout_objA,
      Palette_dataout_bgB  => Palette_dataout_bgB, 
      Palette_dataout_objB => Palette_dataout_objB,
      Palette_we_bgA       => Palette_we_bgA,      
      Palette_we_objA      => Palette_we_objA,     
      Palette_we_bgB       => Palette_we_bgB,      
      Palette_we_objB      => Palette_we_objB,     
      Palette_be           => Palette_be,

      OAMRam_addr          => OAMRam_addr,     
      OAMRam_datain        => OAMRam_datain,   
      OAMRam_dataout_A     => OAMRam_dataout_A,
      OAMRam_dataout_B     => OAMRam_dataout_B,
      OAMRam_we_A          => OAMRam_we_A,     
      OAMRam_we_B          => OAMRam_we_B,     
      OAMRam_be            => OAMRam_be,

      vram_ENA_A           => REG_MemControl1_VRAM_A_Enable(REG_MemControl1_VRAM_A_Enable'left),
      vram_MST_A           => REG_MemControl1_VRAM_A_MST,
      vram_Offset_A        => REG_MemControl1_VRAM_A_Offset,
      vram_ENA_B           => REG_MemControl1_VRAM_B_Enable(REG_MemControl1_VRAM_B_Enable'left),
      vram_MST_B           => REG_MemControl1_VRAM_B_MST,
      vram_Offset_B        => REG_MemControl1_VRAM_B_Offset,
      vram_ENA_C           => REG_MemControl1_VRAM_C_Enable(REG_MemControl1_VRAM_C_Enable'left),
      vram_MST_C           => REG_MemControl1_VRAM_C_MST,
      vram_Offset_C        => REG_MemControl1_VRAM_C_Offset,
      vram_ENA_D           => REG_MemControl1_VRAM_D_Enable(REG_MemControl1_VRAM_D_Enable'left),
      vram_MST_D           => REG_MemControl1_VRAM_D_MST,
      vram_Offset_D        => REG_MemControl1_VRAM_D_Offset,
      vram_ENA_E           => REG_MemControl2_VRAM_E_Enable(REG_MemControl2_VRAM_E_Enable'left),
      vram_MST_E           => REG_MemControl2_VRAM_E_MST,
      vram_ENA_F           => REG_MemControl2_VRAM_F_Enable(REG_MemControl2_VRAM_F_Enable'left),
      vram_MST_F           => REG_MemControl2_VRAM_F_MST,
      vram_Offset_F        => REG_MemControl2_VRAM_F_Offset,
      vram_ENA_G           => REG_MemControl2_VRAM_G_Enable(REG_MemControl2_VRAM_G_Enable'left),
      vram_MST_G           => REG_MemControl2_VRAM_G_MST,
      vram_Offset_G        => REG_MemControl2_VRAM_G_Offset,
      vram_ENA_H           => REG_MemControl3_VRAM_H_Enable(REG_MemControl3_VRAM_H_Enable'left),
      vram_MST_H           => REG_MemControl3_VRAM_H_MST,
      vram_ENA_I           => REG_MemControl3_VRAM_I_Enable(REG_MemControl3_VRAM_I_Enable'left),
      vram_MST_I           => REG_MemControl3_VRAM_I_MST,
      
      VRam_req_A           => VRam_req_A,
      VRam_req_B           => VRam_req_B,
      VRam_req_C           => VRam_req_C,
      VRam_req_D           => VRam_req_D,
      VRam_req_E           => VRam_req_E,
      VRam_req_F           => VRam_req_F,
      VRam_req_G           => VRam_req_G,
      VRam_req_H           => VRam_req_H,
      VRam_req_I           => VRam_req_I,
      VRam_addr_A          => VRam_addr_A,   
      VRam_addr_B          => VRam_addr_B,   
      VRam_addr_C          => VRam_addr_C,   
      VRam_addr_D          => VRam_addr_D,   
      VRam_addr_E          => VRam_addr_E,   
      VRam_addr_F          => VRam_addr_F,   
      VRam_addr_G          => VRam_addr_G,   
      VRam_addr_H          => VRam_addr_H,   
      VRam_addr_I          => VRam_addr_I,   
      VRam_dataout_A       => VRam_dataout_A,
      VRam_dataout_B       => VRam_dataout_B,
      VRam_dataout_C       => VRam_dataout_C,
      VRam_dataout_D       => VRam_dataout_D,
      VRam_dataout_E       => VRam_dataout_E,
      VRam_dataout_F       => VRam_dataout_F,
      VRam_dataout_G       => VRam_dataout_G,
      VRam_dataout_H       => VRam_dataout_H,
      VRam_dataout_I       => VRam_dataout_I,
      VRam_valid_A         => VRam_valid_A,
      VRam_valid_B         => VRam_valid_B,
      VRam_valid_C         => VRam_valid_C,
      VRam_valid_D         => VRam_valid_D,
      VRam_valid_E         => VRam_valid_E,
      VRam_valid_F         => VRam_valid_F,
      VRam_valid_G         => VRam_valid_G,
      VRam_valid_H         => VRam_valid_H,
      VRam_valid_I         => VRam_valid_I,
      
      DISPSTAT_debug       => DISPSTAT_debug
   );
   
   -- ################################
   -- ########## VRAM
   -- ################################
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         Vram_enable_A <= REG_MemControl1_VRAM_A_Enable(REG_MemControl1_VRAM_A_Enable'left) or sleep_savestate;
         Vram_enable_B <= REG_MemControl1_VRAM_B_Enable(REG_MemControl1_VRAM_B_Enable'left) or sleep_savestate;
         Vram_enable_C <= REG_MemControl1_VRAM_C_Enable(REG_MemControl1_VRAM_C_Enable'left) or sleep_savestate;
         Vram_enable_D <= REG_MemControl1_VRAM_D_Enable(REG_MemControl1_VRAM_D_Enable'left) or sleep_savestate;
         Vram_enable_E <= REG_MemControl2_VRAM_E_Enable(REG_MemControl2_VRAM_E_Enable'left) or sleep_savestate;
         Vram_enable_F <= REG_MemControl2_VRAM_F_Enable(REG_MemControl2_VRAM_F_Enable'left) or sleep_savestate;
         Vram_enable_G <= REG_MemControl2_VRAM_G_Enable(REG_MemControl2_VRAM_G_Enable'left) or sleep_savestate;
         Vram_enable_H <= REG_MemControl3_VRAM_H_Enable(REG_MemControl3_VRAM_H_Enable'left) or sleep_savestate;
         Vram_enable_I <= REG_MemControl3_VRAM_I_Enable(REG_MemControl3_VRAM_I_Enable'left) or sleep_savestate;
   
      end if;
   end process;
   
   ids_vram_A : entity work.ds_vram_A
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_A,
      MST                  => REG_MemControl1_VRAM_A_MST,
      OFS                  => REG_MemControl1_VRAM_A_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_A,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_A,
      
      VRam_req             => VRam_req_A,
      VRam_addr            => VRam_addr_A,
      VRam_dataout         => VRam_dataout_A,
      Vram_valid           => VRam_valid_A
   );
   
   ids_vram_B : entity work.ds_vram_B
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_B,
      MST                  => REG_MemControl1_VRAM_B_MST,
      OFS                  => REG_MemControl1_VRAM_B_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_B,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_B,
      
      VRam_req             => VRam_req_B,
      VRam_addr            => VRam_addr_B,
      VRam_dataout         => VRam_dataout_B,
      Vram_valid           => VRam_valid_B
   );
   
   ids_vram_C : entity work.ds_vram_C
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_C,
      MST                  => REG_MemControl1_VRAM_C_MST,
      OFS                  => REG_MemControl1_VRAM_C_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_C,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_C,
      
      VRam_cpu7_addr       => VRam_7_addr,   
      VRam_cpu7_datain     => VRam_7_datain, 
      VRam_cpu7_dataout    => VRam_7_dataout_C,
      VRam_cpu7_we         => VRam_7_we,     
      VRam_cpu7_be         => VRam_7_be,     
      VRam_cpu7_active     => VRam_7_active_C,
      
      VRam_req             => VRam_req_C,
      VRam_addr            => VRam_addr_C,
      VRam_dataout         => VRam_dataout_C,
      Vram_valid           => VRam_valid_C
   );
   
   ids_vram_D : entity work.ds_vram_D
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_D,
      MST                  => REG_MemControl1_VRAM_D_MST,
      OFS                  => REG_MemControl1_VRAM_D_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_D,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_D,
      
      VRam_cpu7_addr       => VRam_7_addr,   
      VRam_cpu7_datain     => VRam_7_datain, 
      VRam_cpu7_dataout    => VRam_7_dataout_D,
      VRam_cpu7_we         => VRam_7_we,     
      VRam_cpu7_be         => VRam_7_be,     
      VRam_cpu7_active     => VRam_7_active_D,
      
      VRam_req             => VRam_req_D,
      VRam_addr            => VRam_addr_D,
      VRam_dataout         => VRam_dataout_D,
      Vram_valid           => VRam_valid_D
   );
   
   ids_vram_E : entity work.ds_vram_E
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_E,
      MST                  => REG_MemControl2_VRAM_E_MST,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_E,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_E,
      
      VRam_req             => VRam_req_E,
      VRam_addr            => VRam_addr_E,
      VRam_dataout         => VRam_dataout_E,
      Vram_valid           => VRam_valid_E
   );
   
   ids_vram_F : entity work.ds_vram_F
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_F,
      MST                  => REG_MemControl2_VRAM_F_MST,
      OFS                  => REG_MemControl2_VRAM_F_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_F,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_F,
      
      VRam_req             => VRam_req_F,
      VRam_addr            => VRam_addr_F,
      VRam_dataout         => VRam_dataout_F,
      Vram_valid           => VRam_valid_F
   );
   
   ids_vram_G : entity work.ds_vram_G
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_G,
      MST                  => REG_MemControl2_VRAM_G_MST,
      OFS                  => REG_MemControl2_VRAM_G_Offset,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_G,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_G,
      
      VRam_req             => VRam_req_G,
      VRam_addr            => VRam_addr_G,
      VRam_dataout         => VRam_dataout_G,
      Vram_valid           => VRam_valid_G
   );
   
   ids_vram_H : entity work.ds_vram_H
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_H,
      MST                  => REG_MemControl3_VRAM_H_MST,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_H,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_H,
      
      VRam_req             => VRam_req_H,
      VRam_addr            => VRam_addr_H,
      VRam_dataout         => VRam_dataout_H,
      Vram_valid           => VRam_valid_H
   );
   
   ids_vram_I : entity work.ds_vram_I
   port map
   (
      clk100               => clk100,

      ENABLE               => Vram_enable_I,
      MST                  => REG_MemControl3_VRAM_I_MST,
      
      VRam_cpu9_addr       => VRam_9_addr,   
      VRam_cpu9_datain     => VRam_9_datain, 
      VRam_cpu9_dataout    => VRam_9_dataout_I,
      VRam_cpu9_we         => VRam_9_we,     
      VRam_cpu9_be         => VRam_9_be,     
      VRam_cpu9_active     => VRam_9_active_I,
      
      VRam_req             => VRam_req_I,
      VRam_addr            => VRam_addr_I,
      VRam_dataout         => VRam_dataout_I,
      Vram_valid           => VRam_valid_I
   );
   
   -- ################################
   -- ########## Cycling
   -- ################################
   
   do_step9  <= (EnableCpu and not sleep_savestate) when ((FreeRunningClock = '1' and WaitAhead9 = '0') or (cyclestate = WAITCPUS and donewait(0) = '1' and done_9 = '0')) else '0';
   do_step7  <= (EnableCpu and not sleep_savestate) when ((FreeRunningClock = '1' and WaitAhead7 = '0') or (cyclestate = WAITCPUS and donewait(1) = '1' and done_7 = '0')) else '0';
   
   dma_step9 <= (not sleep_savestate) when (FreeRunningClock = '1' or (cyclestate = WAITDMA and cycle_slowdown = '0')) else '0';
   dma_step7 <= (not sleep_savestate) when (FreeRunningClock = '1' or (cyclestate = WAITDMA and cycle_slowdown = '0')) else '0';
   
   waitsettle_all <= waitsettle_IPC;
   
   process (clk100)
      variable newCPU9ticks      : unsigned(20 downto 0);
      variable newCPU7ticks      : unsigned(20 downto 0);
      variable new_cycles_ahead9 : integer range -1024 to 1023;
      variable new_cycles_ahead7 : integer range -1024 to 1023;
      
      variable new_cycles_ahead  : integer range 0 to 1023;
   begin
      if rising_edge(clk100) then
         
         -- cycle counter
         new_cycles_valid <= '0';
         
         -- lockspeed
         if (DS_lockspeed = '0' or ds_on_1 = '0' or vsyncspeedpoint = '1') then
            CyclesMissing <= (others => '0');
         elsif (new_missing = '1') then
            CyclesMissing <= std_logic_vector(unsigned(CyclesMissing) + 2);
         end if;
         
         new_cycles_ahead := cycles_ahead;
         if (new_cycles_valid = '1') then
            new_cycles_ahead := new_cycles_ahead + to_integer(new_cycles);
         end if;
         
         new_missing     <= '0';
         if (cycles_66_100 < 2) then
            cycles_66_100 <= cycles_66_100 + 1;
         else
            cycles_66_100   <= 0;
            if (new_cycles_ahead > 1) then
               new_cycles_ahead := new_cycles_ahead - 2;
            else
               new_missing <= '1';
            end if;
         end if;
         if (DS_lockspeed = '1') then
            cycles_ahead <= new_cycles_ahead;
         else
            cycles_ahead <= 0;
         end if;
         
         cycle_slowdown <= '1';
         if (cycles_ahead < unsigned(CyclePrecalc)) then
            cycle_slowdown <= '0';
         end if;
         
         -- free running         
         free_running_next <= '0';
         if (free_running_counter < 2) then
            if (FreeRunningClock = '1') then
               free_running_counter <= free_running_counter + 1;
            end if;
         else
            free_running_counter <= 0;
            free_running_next    <= '1';
         end if;
         
         if (free_running_next = '1') then
            new_cycles       <= x"02";
            new_cycles_valid <= '1';
         end if;
         
         -- do step
         ds_step  <= '0'; 
         cpu_irq9 <= '0';    
         cpu_irq7 <= '0';    
         
         new_export <= '0';
         
         next_event <= nexteventall(0);
         if (nexteventall(1) < nexteventall(0)) then
            next_event <= nexteventall(1);
         end if;
         
         -- cycles ahead calculation
         if (FreeRunningClock = '1') then
            new_cycles_ahead9 := cycles_ahead9;
            if (new_cycles9_valid = '1') then
               new_cycles_ahead9 := new_cycles_ahead9 + to_integer(new_cycles9);
            elsif (dma_cycles_valid9 = '1') then
               new_cycles_ahead9 := new_cycles_ahead9 + to_integer(dma_cycles_out9);
            end if;
            if (new_cycles7_valid = '1') then
               new_cycles_ahead9 := new_cycles_ahead9 - to_integer(new_cycles7);
            elsif (dma_cycles_valid7 = '1') then
               new_cycles_ahead9 := new_cycles_ahead9 - to_integer(dma_cycles_out7);
            end if;
            cycles_ahead9 <= new_cycles_ahead9;
            
            new_cycles_ahead7 := cycles_ahead7;
            if (new_cycles7_valid = '1') then
               new_cycles_ahead7 := new_cycles_ahead7 + to_integer(new_cycles7);
            elsif (dma_cycles_valid7 = '1') then
               new_cycles_ahead7 := new_cycles_ahead7 + to_integer(dma_cycles_out7);
            end if;
            if (new_cycles9_valid = '1') then
               new_cycles_ahead7 := new_cycles_ahead7 - to_integer(new_cycles9);
            elsif (dma_cycles_valid9 = '1') then
               new_cycles_ahead7 := new_cycles_ahead7 - to_integer(dma_cycles_out9);
            end if;
            cycles_ahead7 <= new_cycles_ahead7;
         end if;
         
         if (halt9 = '1' or halt7 = '1') then
            cycles_ahead9 <= 0;
            cycles_ahead7 <= 0;
         end if;
         
         -- control
         if (FreeRunningClock = '1' and sleep_savestate = '0') then
            ds_step  <= DS_on_1;
            cpu_irq9 <= irq9_pending;
            cpu_irq7 <= irq7_pending;
            
            WaitAhead9 <= '0';
            WaitAhead7 <= '0';
            if (cycles_ahead9 > 15) then WaitAhead9 <= '1'; end if;
            if (cycles_ahead7 > 15) then WaitAhead7 <= '1'; end if;
            
         else
            case cyclestate is
            
               when IDLE =>
                  if (DS_on_1 = '1' and sleep_savestate = '0' and cycle_slowdown = '0') then
                     if (totalticks(20) = '1' and CPU9_totalticks(20) = '1' and CPU7_totalticks(20) = '1') then
                        cyclestate <= REDUCECYCLES;
                     elsif (dma_soon9 = '1' or dma_on9 = '1' or dma_soon7 = '1' or dma_on7 = '1') then
                        cyclestate  <= WAITDMA;
                     elsif (waitsettle_all = '1' or (new_cycles_valid = '1' and new_cycles >= next_event)) then
                        cyclestate  <= WAITSETTLE;
                        settleticks <= 2;
                     elsif (halt9 = '1' and halt7 = '1' and (irq9_pending = '0' or irq9_disable = '1') and (irq7_pending = '0' or irq7_disable = '1')) then
                        cyclestate <= WAITHALT;
                        haltcnt    <= 2;
                     else
                        if (irq9_pending = '1' and irq9_disable = '0') then
                           cpu_irq9    <= '1';
                           cyclestate  <= WAITIRQ;
                           irq_cnt     <= 2;
                        end if;
                        if (irq7_pending = '1' and irq7_disable = '0') then
                           cpu_irq7    <= '1';
                           cyclestate  <= WAITIRQ;
                           irq_cnt     <= 2;
                        end if;
                        if ((irq9_pending = '0' or irq9_disable = '1') and (irq7_pending = '0' or irq7_disable = '1')) then
                           if (CPU9_totalticks <= totalticks and halt9 = '0') then
                              donewait(0) <= '1';
                              cyclestate  <= WAITCPUS;
                           end if;
                           if (CPU7_totalticks <= totalticks and halt7 = '0') then
                              donewait(1) <= '1';
                              cyclestate  <= WAITCPUS;
                           end if;
                        end if;
                     end if;
                  end if;
                  
               when REDUCECYCLES =>
                  cyclestate          <= IDLE;
                  
               when WAITSETTLE =>
                  if (settleticks > 0) then
                     settleticks <= settleticks - 1;
                  else
                     cyclestate  <= IDLE;
                  end if;
                  
               when WAITDMA =>
                  if (dma_on9 = '0' and dma_on7 = '0') then
                     cyclestate <= IDLE;
                     new_export <= '1';
                  end if;
                  
               when WAITIRQ =>
                  if (irq_cnt > 0) then
                     irq_cnt <= irq_cnt - 1;
                  else
                     cyclestate <= IDLE;
                  end if;
                     
                  if (cpuirqdone9 = '1' or cpuirqdone7 = '1') then
                     new_export <= '1';
                  end if;
                  
               when WAITHALT =>
                  if (haltcnt > 0) then
                     haltcnt <= haltcnt - 1;
                  else
                     cyclestate <= IDLE;
                     new_export <= '1';
                  end if;
                  
               when WAITCPUS =>
                  if ((donewait = "01" and done_9 = '1') or (donewait = "10" and done_7 = '1') or (donewait = "11" and done_9 = '1' and done_7 = '1')) then
                     cyclestate <= IDLE;
                     new_export <= '1';
                  end if;
                  if (done_9 = '1') then donewait(0) <= '0'; end if;
                  if (done_7 = '1') then donewait(1) <= '0'; end if;
            
            end case;
         
            -- new cycles/timing
            case cyclestate is
            
               when REDUCECYCLES =>
                  totalticks(20)      <= '0';
                  CPU9_totalticks(20) <= '0';
                  CPU7_totalticks(20) <= '0';
            
               when WAITDMA =>
                  if (dma_cycles_valid9 = '1' and dma_cycles_valid7 = '1') then
                     new_cycles       <= dma_cycles_out9 + dma_cycles_out7;
                     new_cycles_valid <= '1';
                     totalticks       <= totalticks + dma_cycles_out9 + dma_cycles_out7;
                  elsif (dma_cycles_valid9 = '1') then       
                     new_cycles       <= dma_cycles_out9;
                     new_cycles_valid <= '1';
                     totalticks       <= totalticks + dma_cycles_out9;
                  elsif (dma_cycles_valid7 = '1') then
                     new_cycles       <= dma_cycles_out7;
                     new_cycles_valid <= '1';
                     totalticks       <= totalticks + dma_cycles_out7;
                  end if;
                  if (CPU9_totalticks < totalticks) then
                     CPU9_totalticks <= totalticks;
                  end if;
                  if (CPU7_totalticks < totalticks) then
                     CPU7_totalticks <= totalticks;
                  end if;
                  
               when WAITHALT =>
                  if (haltcnt = 0) then
                     new_cycles       <= x"10";
                     new_cycles_valid <= '1';
                     totalticks       <= totalticks + 16;
                     CPU9_totalticks  <= totalticks + 16;
                     CPU7_totalticks  <= totalticks + 16;
                  end if;
               
               when others =>
                  newCPU9ticks := CPU9_totalticks;
                  newCPU7ticks := CPU7_totalticks;
                  if (new_cycles9_valid = '1') then newCPU9ticks := newCPU9ticks + new_cycles9; end if;     
                  if (new_cycles7_valid = '1') then newCPU7ticks := newCPU7ticks + new_cycles7; end if;           
                  CPU9_totalticks <= newCPU9ticks;
                  CPU7_totalticks <= newCPU7ticks;
                  if (halt9 = '1' and new_cycles9_valid = '0') then CPU9_totalticks <= newCPU7ticks; end if;
                  if (halt7 = '1' and new_cycles7_valid = '0') then CPU7_totalticks <= newCPU9ticks; end if;
                  if (newCPU9ticks < newCPU7ticks or halt7 = '1') then
                     totalticks       <= newCPU9ticks;
                     if (newCPU9ticks > totalticks) then
                        new_cycles       <= to_unsigned(to_integer(newCPU9ticks - totalticks), new_cycles'length);
                        new_cycles_valid <= '1';
                     end if;
                  else
                     totalticks       <= newCPU7ticks;
                     if (newCPU7ticks > totalticks) then
                        new_cycles       <= to_unsigned(to_integer(newCPU7ticks - totalticks), new_cycles'length);
                        new_cycles_valid <= '1';
                     end if;
                  end if;
   
            end case;
            
         end if;
         
         -- reset
         if (reset = '1') then
            cyclestate      <= IDLE;
            donewait        <= "00";
            totalticks      <= (others => '0');
            CPU9_totalticks <= (others => '0');
            CPU7_totalticks <= (others => '0');
            cycles_ahead9   <= 0;
            cycles_ahead7   <= 0;
         end if;
         
         vsyncspeedpoint <= '0';
         if (VSyncCounter < 1685375) then -- vsync time
            VSyncCounter <= VSyncCounter + 1;
         else
            VSyncCounter    <= 0;
            vsyncspeedpoint <= '1';
         end if;
         
         if ((vblank_trigger = '1' and FreeRunningClock = '1') or (vsyncspeedpoint = '1' and FreeRunningClock = '0')) then
            CyclesVsyncSpeed9 <= std_logic_vector(CyclesVsync9);
            CyclesVsyncSpeed7 <= std_logic_vector(CyclesVsync7);
            CyclesVsync9      <= (others => '0');
            CyclesVsync7      <= (others => '0');
            
            CyclesVsyncIdle9  <= std_logic_vector(CyclesIdle9);
            CyclesVsyncIdle7  <= std_logic_vector(CyclesIdle7);
            CyclesIdle9       <= (others => '0');
            CyclesIdle7       <= (others => '0');
         else
            if (halt9 = '1') then CyclesIdle9 <= CyclesIdle9 + 1; end if;
            if (halt7 = '1') then CyclesIdle7 <= CyclesIdle7 + 1; end if;
         
            if (FreeRunningClock = '1') then
               if (new_cycles9_valid = '1') then
                  CyclesVsync9 <= CyclesVsync9 + new_cycles9;
               end if;
               if (dma_cycles_valid9 = '1') then
                  CyclesVsync9 <= CyclesVsync9 + dma_cycles_out9;
               end if;
               
               if (new_cycles7_valid = '1') then
                  CyclesVsync7 <= CyclesVsync7 + new_cycles7;
               end if;
               if (dma_cycles_valid7 = '1') then
                  CyclesVsync7 <= CyclesVsync7 + dma_cycles_out7;
               end if;
            else
               if (new_cycles_valid = '1') then
                  CyclesVsync9 <= CyclesVsync9 + new_cycles;
               end if;
            end if;
         end if;
         
         DebugCycling(0)          <= halt9;
         DebugCycling(1)          <= halt7;
         DebugCycling(2)          <= irq9_pending;
         DebugCycling(3)          <= irq7_pending;
         DebugCycling(4)          <= irq9_disable;
         DebugCycling(5)          <= irq7_disable;
         DebugCycling(6)          <= dma_soon9;
         DebugCycling(7)          <= dma_soon7;
         DebugCycling(8)          <= dma_on9;
         DebugCycling(9)          <= dma_on7;
         DebugCycling(10)         <= WaitAhead9;
         DebugCycling(11)         <= WaitAhead7;
         DebugCycling(12)         <= donewait(0);
         DebugCycling(13)         <= donewait(1);
         DebugCycling(14)         <= cycle_slowdown;
         DebugCycling(15)         <= sleep_savestate;
         DebugCycling(16)         <= new_cycles_valid;
         DebugCycling(17)         <= waitsettle_all;
         DebugCycling(18)         <= CPU_bus_idle9;
         DebugCycling(19)         <= CPU_bus_idle7;
         DebugCycling(20)         <= haltbus;
         DebugCycling(21)         <= '0';
         DebugCycling(22)         <= '0';
         DebugCycling(23)         <= '0';
         DebugCycling(24)         <= '0';
         if (cyclestate = IDLE        ) then DebugCycling(25) <= '1'; else DebugCycling(25) <= '0'; end if;
         if (cyclestate = REDUCECYCLES) then DebugCycling(26) <= '1'; else DebugCycling(26) <= '0'; end if;
         if (cyclestate = WAITSETTLE  ) then DebugCycling(27) <= '1'; else DebugCycling(27) <= '0'; end if;
         if (cyclestate = WAITDMA     ) then DebugCycling(28) <= '1'; else DebugCycling(28) <= '0'; end if;
         if (cyclestate = WAITIRQ     ) then DebugCycling(29) <= '1'; else DebugCycling(29) <= '0'; end if;
         if (cyclestate = WAITHALT    ) then DebugCycling(30) <= '1'; else DebugCycling(30) <= '0'; end if;
         if (cyclestate = WAITCPUS    ) then DebugCycling(31) <= '1'; else DebugCycling(31) <= '0'; end if;
         
      end if;
   end process;
   
   
   gexport : if is_simu = '1' generate
   begin
   
      ids_vcd_export : entity work.ds_vcd_export
      port map
      (
         clk100         => clk100,
         new_export     => new_export,
         
         commandcount   => commandcount,
                        
         export_cpu9    => export_cpu9,
         export_cpu7    => export_cpu7,  
      
         totalticks9    => CPU9_totalticks,
         totalticks7    => CPU7_totalticks,
         
         export_timer9  => export_timer9,
         export_timer7  => export_timer7,
         
         IF_intern9     => IF_intern9,
         IF_intern7     => IF_intern7,
         
         memory9_1      => X"00000000",
         memory9_2      => X"00000000",
         memory9_3      => X"00000000", --DISPSTAT_debug,
         memory7_1      => X"00000000",
         memory7_2      => X"00000000",
         memory7_3      => X"00000000", --DISPSTAT_debug,
                     
         dmatranfers9   => debug_dma_count9,
         dmatranfers7   => debug_dma_count7
      );
   
   
   end generate;
   
   
   

end architecture;





