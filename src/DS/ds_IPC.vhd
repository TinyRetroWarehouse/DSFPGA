library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_IPC is
   port 
   (
      clk100                        : in  std_logic;  
      ds_on                         : in  std_logic;
      reset                         : in  std_logic;
      
      waitsettle                    : out std_logic := '0';                   
               
      ds_bus9                       : in  proc_bus_ds_type;
      ds_bus9_data                  : out std_logic_vector(31 downto 0); 
      ds_bus7                       : in  proc_bus_ds_type;
      ds_bus7_data                  : out std_logic_vector(31 downto 0); 
          
      fiforead_9_enable             : in  std_logic;    
      fiforead_9_data               : out std_logic_vector(31 downto 0);      
      
      fiforead_7_enable             : in  std_logic;    
      fiforead_7_data               : out std_logic_vector(31 downto 0);     
                                          
      IRQ_IPC9_Sync                 : out std_logic := '0';
      IRQ_IPC9_Send_FIFO_Empty      : out std_logic := '0';
      IRQ_IPC9_Recv_FIFO_Not_Empty  : out std_logic := '0';
                                          
      IRQ_IPC7_Sync                 : out std_logic := '0';
      IRQ_IPC7_Send_FIFO_Empty      : out std_logic := '0';
      IRQ_IPC7_Recv_FIFO_Not_Empty  : out std_logic := '0'
   );
end entity;

architecture arch of ds_IPC is
   
   -- regs
   
   -- sync
   signal REG9_IPCSYNC_Data_to_IPCSYNC               : std_logic_vector(work.pReg_ds_system_9.IPCSYNC_Data_to_IPCSYNC              .upper downto work.pReg_ds_system_9.IPCSYNC_Data_to_IPCSYNC        .lower) := (others => '0');
   signal REG9_IPCSYNC_IRQ_to_remote_CPU             : std_logic_vector(work.pReg_ds_system_9.IPCSYNC_IRQ_to_remote_CPU            .upper downto work.pReg_ds_system_9.IPCSYNC_IRQ_to_remote_CPU      .lower) := (others => '0');
   signal REG9_IPCSYNC_Ena_IRQ_from_remote_CPU       : std_logic_vector(work.pReg_ds_system_9.IPCSYNC_Ena_IRQ_from_remote_CPU      .upper downto work.pReg_ds_system_9.IPCSYNC_Ena_IRQ_from_remote_CPU.lower) := (others => '0');
                                                                                                                                    
   signal REG7_IPCSYNC_Data_to_IPCSYNC               : std_logic_vector(work.pReg_ds_system_7.IPCSYNC_Data_to_IPCSYNC              .upper downto work.pReg_ds_system_7.IPCSYNC_Data_to_IPCSYNC        .lower) := (others => '0');
   signal REG7_IPCSYNC_IRQ_to_remote_CPU             : std_logic_vector(work.pReg_ds_system_7.IPCSYNC_IRQ_to_remote_CPU            .upper downto work.pReg_ds_system_7.IPCSYNC_IRQ_to_remote_CPU      .lower) := (others => '0');
   signal REG7_IPCSYNC_Ena_IRQ_from_remote_CPU       : std_logic_vector(work.pReg_ds_system_7.IPCSYNC_Ena_IRQ_from_remote_CPU      .upper downto work.pReg_ds_system_7.IPCSYNC_Ena_IRQ_from_remote_CPU.lower) := (others => '0');

   signal REG9_IPCSYNC_IRQ_to_remote_CPU_written     : std_logic;
   signal REG7_IPCSYNC_IRQ_to_remote_CPU_written     : std_logic;

   -- fifo
   signal REG9_IPCFIFOCNT_Send_Fifo_Empty_Status     : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_Status    .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_Status    .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Send_Fifo_Full_Status      : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Full_Status     .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Full_Status     .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ        : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_IRQ       .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_IRQ       .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Send_Fifo_Clear            : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Clear           .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Clear           .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Receive_Fifo_Empty         : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Empty        .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Empty        .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Receive_Fifo_Full          : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Full         .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Full         .lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ.upper downto work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ.lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Error_Reset                : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Error_Read_Empty_Send_Full.upper downto work.pReg_ds_system_9.IPCFIFOCNT_Error_Read_Empty_Send_Full.lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Error_Read_Empty_Send_Full.upper downto work.pReg_ds_system_9.IPCFIFOCNT_Error_Read_Empty_Send_Full.lower) := (others => '0');
   signal REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo   : std_logic_vector(work.pReg_ds_system_9.IPCFIFOCNT_Enable_Send_Receive_Fifo  .upper downto work.pReg_ds_system_9.IPCFIFOCNT_Enable_Send_Receive_Fifo  .lower) := (others => '0');
                                                                                                                                                                         
   signal REG9_IPCFIFOSEND                           : std_logic_vector(work.pReg_ds_system_9.IPCFIFOSEND                          .upper downto work.pReg_ds_system_9.IPCFIFOSEND                          .lower) := (others => '0');

   signal REG7_IPCFIFOCNT_Send_Fifo_Empty_Status     : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_Status    .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_Status    .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Send_Fifo_Full_Status      : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Full_Status     .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Full_Status     .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ        : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_IRQ       .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_IRQ       .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Send_Fifo_Clear            : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Clear           .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Clear           .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Receive_Fifo_Empty         : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Empty        .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Empty        .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Receive_Fifo_Full          : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Full         .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Full         .lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ.upper downto work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ.lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Error_Reset                : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Error_Read_Empty_Send_Full.upper downto work.pReg_ds_system_7.IPCFIFOCNT_Error_Read_Empty_Send_Full.lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Error_Read_Empty_Send_Full.upper downto work.pReg_ds_system_7.IPCFIFOCNT_Error_Read_Empty_Send_Full.lower) := (others => '0');
   signal REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo   : std_logic_vector(work.pReg_ds_system_7.IPCFIFOCNT_Enable_Send_Receive_Fifo  .upper downto work.pReg_ds_system_7.IPCFIFOCNT_Enable_Send_Receive_Fifo  .lower) := (others => '0');
                                                                                                                                                                       
   signal REG7_IPCFIFOSEND                           : std_logic_vector(work.pReg_ds_system_7.IPCFIFOSEND                          .upper downto work.pReg_ds_system_7.IPCFIFOSEND                          .lower) := (others => '0');

   signal REG9_IPCFIFOCNT_Send_Fifo_Clear_written    : std_logic;
   signal REG7_IPCFIFOCNT_Send_Fifo_Clear_written    : std_logic;
   signal REG9_IPCFIFOCNT_Error_Reset_written        : std_logic;
   signal REG7_IPCFIFOCNT_Error_Reset_written        : std_logic;
   signal REG9_IPCFIFOSEND_written                   : std_logic;
   signal REG7_IPCFIFOSEND_written                   : std_logic;

   type t_reg_wired_or is array(0 to 10) of std_logic_vector(31 downto 0);
   signal reg_wired_or9 : t_reg_wired_or;
   signal reg_wired_or7 : t_reg_wired_or;

   -- internal
   signal Fifo9_reset   : std_logic := '0';
   signal Fifo9_Din     : std_logic_vector(31 downto 0);
   signal Fifo9_Wr      : std_logic; 
   signal Fifo9_Full    : std_logic;
   signal Fifo9_Dout    : std_logic_vector(31 downto 0);
   signal Fifo9_Rd      : std_logic;
   signal Fifo9_Empty   : std_logic;
   
   signal Fifo7_reset   : std_logic := '0';
   signal Fifo7_Din     : std_logic_vector(31 downto 0);
   signal Fifo7_Wr      : std_logic; 
   signal Fifo7_Full    : std_logic;
   signal Fifo7_Dout    : std_logic_vector(31 downto 0);
   signal Fifo7_Rd      : std_logic;
   signal Fifo7_Empty   : std_logic;

   signal IRQ_IPC9_Send_FIFO_Empty_old     : std_logic := '0';
   signal IRQ_IPC9_Recv_FIFO_Not_Empty_old : std_logic := '0';   
   signal IRQ_IPC7_Send_FIFO_Empty_old     : std_logic := '0';
   signal IRQ_IPC7_Recv_FIFO_Not_Empty_old : std_logic := '0';
   
   signal waitsettle_cnt : integer range 0 to 2;
   
  
begin 
   
   iREG9_IPCSYNC_Data_from_IPCSYNC             : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCSYNC_Data_from_IPCSYNC            ) port map  (clk100, ds_bus9, reg_wired_or9( 0), REG7_IPCSYNC_Data_to_IPCSYNC              ); 
   iREG9_IPCSYNC_Data_to_IPCSYNC               : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCSYNC_Data_to_IPCSYNC              ) port map  (clk100, ds_bus9, reg_wired_or9( 1), REG9_IPCSYNC_Data_to_IPCSYNC              , REG9_IPCSYNC_Data_to_IPCSYNC               ); 
   iREG9_IPCSYNC_IRQ_to_remote_CPU             : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCSYNC_IRQ_to_remote_CPU            ) port map  (clk100, ds_bus9, open             , "0"                                       , REG9_IPCSYNC_IRQ_to_remote_CPU             , REG9_IPCSYNC_IRQ_to_remote_CPU_written); 
   iREG9_IPCSYNC_Ena_IRQ_from_remote_CPU       : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCSYNC_Ena_IRQ_from_remote_CPU      ) port map  (clk100, ds_bus9, reg_wired_or9( 2), REG9_IPCSYNC_Ena_IRQ_from_remote_CPU      , REG9_IPCSYNC_Ena_IRQ_from_remote_CPU       ); 
                                                                                                                                                                                              
   iREG7_IPCSYNC_Data_from_IPCSYNC             : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCSYNC_Data_from_IPCSYNC            ) port map  (clk100, ds_bus7, reg_wired_or7( 0), REG9_IPCSYNC_Data_to_IPCSYNC              ); 
   iREG7_IPCSYNC_Data_to_IPCSYNC               : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCSYNC_Data_to_IPCSYNC              ) port map  (clk100, ds_bus7, reg_wired_or7( 1), REG7_IPCSYNC_Data_to_IPCSYNC              , REG7_IPCSYNC_Data_to_IPCSYNC               ); 
   iREG7_IPCSYNC_IRQ_to_remote_CPU             : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCSYNC_IRQ_to_remote_CPU            ) port map  (clk100, ds_bus7, open             , "0"                                       , REG7_IPCSYNC_IRQ_to_remote_CPU             , REG7_IPCSYNC_IRQ_to_remote_CPU_written); 
   iREG7_IPCSYNC_Ena_IRQ_from_remote_CPU       : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCSYNC_Ena_IRQ_from_remote_CPU      ) port map  (clk100, ds_bus7, reg_wired_or7( 2), REG7_IPCSYNC_Ena_IRQ_from_remote_CPU      , REG7_IPCSYNC_Ena_IRQ_from_remote_CPU       ); 
                                                                                                                                                                                                                                                                                                                                                            
   iREG9_IPCFIFOCNT_Send_Fifo_Empty_Status     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_Status    ) port map  (clk100, ds_bus9, reg_wired_or9( 3), REG9_IPCFIFOCNT_Send_Fifo_Empty_Status    ); 
   iREG9_IPCFIFOCNT_Send_Fifo_Full_Status      : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Full_Status     ) port map  (clk100, ds_bus9, reg_wired_or9( 4), REG9_IPCFIFOCNT_Send_Fifo_Full_Status     ); 
   iREG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ        : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Empty_IRQ       ) port map  (clk100, ds_bus9, reg_wired_or9( 5), REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ       , REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ        ); 
   iREG9_IPCFIFOCNT_Send_Fifo_Clear            : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Send_Fifo_Clear           ) port map  (clk100, ds_bus9, open             ,"0"                                       , REG9_IPCFIFOCNT_Send_Fifo_Clear            , REG9_IPCFIFOCNT_Send_Fifo_Clear_written); 
   iREG9_IPCFIFOCNT_Receive_Fifo_Empty         : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Empty        ) port map  (clk100, ds_bus9, reg_wired_or9( 6), REG9_IPCFIFOCNT_Receive_Fifo_Empty        ); 
   iREG9_IPCFIFOCNT_Receive_Fifo_Full          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Full         ) port map  (clk100, ds_bus9, reg_wired_or9( 7), REG9_IPCFIFOCNT_Receive_Fifo_Full         ); 
   iREG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ) port map  (clk100, ds_bus9, reg_wired_or9( 8), REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ, REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ ); 
   iREG9_IPCFIFOCNT_Error_Read_Empty_Send_Full : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Error_Read_Empty_Send_Full) port map  (clk100, ds_bus9, reg_wired_or9( 9), REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full, REG9_IPCFIFOCNT_Error_Reset                , REG9_IPCFIFOCNT_Error_Reset_written); 
   iREG9_IPCFIFOCNT_Enable_Send_Receive_Fifo   : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOCNT_Enable_Send_Receive_Fifo  ) port map  (clk100, ds_bus9, reg_wired_or9(10), REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo  , REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo   ); 
                                                                                                                                                                                                                                                                     
   iREG9_IPCFIFOSEND                           : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.IPCFIFOSEND                          ) port map  (clk100, ds_bus9, open             , REG9_IPCFIFOSEND                          , REG9_IPCFIFOSEND                           , REG9_IPCFIFOSEND_written); 
                                                                                                                                                                                 
   iREG7_IPCFIFOCNT_Send_Fifo_Empty_Status     : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_Status    ) port map  (clk100, ds_bus7, reg_wired_or7( 3), REG7_IPCFIFOCNT_Send_Fifo_Empty_Status    ); 
   iREG7_IPCFIFOCNT_Send_Fifo_Full_Status      : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Full_Status     ) port map  (clk100, ds_bus7, reg_wired_or7( 4), REG7_IPCFIFOCNT_Send_Fifo_Full_Status     ); 
   iREG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ        : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Empty_IRQ       ) port map  (clk100, ds_bus7, reg_wired_or7( 5), REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ       , REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ        ); 
   iREG7_IPCFIFOCNT_Send_Fifo_Clear            : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Send_Fifo_Clear           ) port map  (clk100, ds_bus7, open             ,  "0"                                       , REG7_IPCFIFOCNT_Send_Fifo_Clear            , REG7_IPCFIFOCNT_Send_Fifo_Clear_written); 
   iREG7_IPCFIFOCNT_Receive_Fifo_Empty         : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Empty        ) port map  (clk100, ds_bus7, reg_wired_or7( 6), REG7_IPCFIFOCNT_Receive_Fifo_Empty        ); 
   iREG7_IPCFIFOCNT_Receive_Fifo_Full          : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Full         ) port map  (clk100, ds_bus7, reg_wired_or7( 7), REG7_IPCFIFOCNT_Receive_Fifo_Full         ); 
   iREG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ) port map  (clk100, ds_bus7, reg_wired_or7( 8), REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ, REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ ); 
   iREG7_IPCFIFOCNT_Error_Read_Empty_Send_Full : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Error_Read_Empty_Send_Full) port map  (clk100, ds_bus7, reg_wired_or7( 9), REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full, REG7_IPCFIFOCNT_Error_Reset                , REG7_IPCFIFOCNT_Error_Reset_written); 
   iREG7_IPCFIFOCNT_Enable_Send_Receive_Fifo   : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOCNT_Enable_Send_Receive_Fifo  ) port map  (clk100, ds_bus7, reg_wired_or7(10), REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo  , REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo   ); 
                                                                                                                                                                                                                                                                     
   iREG7_IPCFIFOSEND                           : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.IPCFIFOSEND                          ) port map  (clk100, ds_bus7, open             , REG7_IPCFIFOSEND                          , REG7_IPCFIFOSEND                           , REG7_IPCFIFOSEND_written); 
 
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
 
   iFifo9: entity MEM.SyncFifo
   generic map
   (
      SIZE             => 32,
      DATAWIDTH        => 32,
      NEARFULLDISTANCE => 16
   )
   port map
   ( 
      clk      => clk100,
      reset    => Fifo9_reset,
               
      Din      => Fifo9_Din,
      Wr       => Fifo9_Wr,
      Full     => open,
      NearFull => Fifo9_Full,
      
      Dout     => Fifo9_Dout,
      Rd       => Fifo9_Rd,
      Empty    => Fifo9_Empty
   );

   iFifo7: entity MEM.SyncFifo
   generic map
   (
      SIZE             => 32,
      DATAWIDTH        => 32,
      NEARFULLDISTANCE => 16
   )
   port map
   ( 
      clk      => clk100,
      reset    => Fifo7_reset,
               
      Din      => Fifo7_Din,
      Wr       => Fifo7_Wr,
      Full     => open,
      NearFull => Fifo7_Full,
      
      Dout     => Fifo7_Dout,
      Rd       => Fifo7_Rd,
      Empty    => Fifo7_Empty
   );
   
   Fifo9_Rd <= '1' when (fiforead_7_enable = '1' and Fifo9_Empty = '0' and REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") else '0';
   Fifo7_Rd <= '1' when (fiforead_9_enable = '1' and Fifo7_Empty = '0' and REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") else '0';
   
   fiforead_9_data <= Fifo7_Dout;
   fiforead_7_data <= Fifo9_Dout;
   
   -- sync
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         IRQ_IPC9_Sync                <= '0';
         IRQ_IPC7_Sync                <= '0';
                     
         if (ds_on = '1') then
         
            if (REG7_IPCSYNC_IRQ_to_remote_CPU_written = '1' and REG7_IPCSYNC_IRQ_to_remote_CPU = "1" and REG9_IPCSYNC_Ena_IRQ_from_remote_CPU = "1") then
               IRQ_IPC9_Sync <= '1';
            end if;
         
            if (REG9_IPCSYNC_IRQ_to_remote_CPU_written = '1' and REG9_IPCSYNC_IRQ_to_remote_CPU = "1" and REG7_IPCSYNC_Ena_IRQ_from_remote_CPU = "1") then
               IRQ_IPC7_Sync <= '1';
            end if;
            
         end if;
      
      end if;
   end process;
  
   -- fifo
   REG9_IPCFIFOCNT_Send_Fifo_Empty_Status(REG9_IPCFIFOCNT_Send_Fifo_Empty_Status'left) <= Fifo9_empty;
   REG9_IPCFIFOCNT_Send_Fifo_Full_Status(REG9_IPCFIFOCNT_Send_Fifo_Full_Status'left)   <= Fifo9_full;
   REG9_IPCFIFOCNT_Receive_Fifo_Empty(REG9_IPCFIFOCNT_Receive_Fifo_Empty'left)         <= Fifo7_empty;
   REG9_IPCFIFOCNT_Receive_Fifo_Full(REG9_IPCFIFOCNT_Receive_Fifo_Full'left)           <= Fifo7_full;
   
   REG7_IPCFIFOCNT_Send_Fifo_Empty_Status(REG7_IPCFIFOCNT_Send_Fifo_Empty_Status'left) <= Fifo7_empty;
   REG7_IPCFIFOCNT_Send_Fifo_Full_Status(REG7_IPCFIFOCNT_Send_Fifo_Full_Status'left)   <= Fifo7_full;
   REG7_IPCFIFOCNT_Receive_Fifo_Empty(REG7_IPCFIFOCNT_Receive_Fifo_Empty'left)         <= Fifo9_empty;
   REG7_IPCFIFOCNT_Receive_Fifo_Full(REG7_IPCFIFOCNT_Receive_Fifo_Full'left)           <= Fifo9_full;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
                     
         Fifo9_reset <= '0';
         Fifo7_reset <= '0';
         
         Fifo9_Wr <= '0';        
         Fifo7_Wr <= '0';
         
         waitsettle <= '0';
      
         if (reset = '1') then
         
            Fifo9_reset <= '1';
            Fifo7_reset <= '1';
            
            REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "0";
            REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "0";
            
         elsif (ds_on = '1') then
         
            -- settle
            if (fiforead_9_enable = '1' or fiforead_7_enable = '1' or 
             REG9_IPCSYNC_IRQ_to_remote_CPU_written = '1' or REG7_IPCSYNC_IRQ_to_remote_CPU_written = '1' or
             REG9_IPCFIFOCNT_Send_Fifo_Clear_written = '1' or REG7_IPCFIFOCNT_Send_Fifo_Clear_written = '1' or 
             REG9_IPCFIFOSEND_written = '1' or REG7_IPCFIFOSEND_written = '1') then       
               waitsettle_cnt <= 2; 
            end if;             
            
            if (waitsettle_cnt > 0) then
               waitsettle     <= '1';
               waitsettle_cnt <= waitsettle_cnt - 1;
            end if;
             
            -- FIFO 9
            if (REG9_IPCFIFOCNT_Send_Fifo_Clear_written = '1' and REG9_IPCFIFOCNT_Send_Fifo_Clear = "1") then
               Fifo9_reset <= '1';
            end if;
            if (REG9_IPCFIFOCNT_Error_Reset_written = '1' and REG9_IPCFIFOCNT_Error_Reset = "1") then
               REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "0";
            end if;
            
            if (REG9_IPCFIFOSEND_written = '1' and REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") then
               if (Fifo9_Full = '1') then
                  REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "1";
               else
                  Fifo9_Wr  <= '1';
                  Fifo9_Din <= REG9_IPCFIFOSEND;
               end if;
            end if;

            if (fiforead_9_enable = '1' and REG9_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") then
               if (Fifo7_Empty = '1') then
                  REG9_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "1";
               end if;
            end if;
            
            IRQ_IPC9_Send_FIFO_Empty_old     <= REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ(REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ'left) and Fifo9_Empty;
            IRQ_IPC9_Recv_FIFO_Not_Empty_old <= REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ(REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ'left) and not Fifo7_Empty;
         
            -- FIFO 7
            if (REG7_IPCFIFOCNT_Send_Fifo_Clear_written = '1' and REG7_IPCFIFOCNT_Send_Fifo_Clear = "1") then
               Fifo7_reset <= '1';
            end if;
            if (REG7_IPCFIFOCNT_Error_Reset_written = '1' and REG7_IPCFIFOCNT_Error_Reset = "1") then
               REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "0";
            end if;
            
            if (REG7_IPCFIFOSEND_written = '1' and REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") then
               if (Fifo7_Full = '1') then
                  REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "1";
               else
                  Fifo7_Wr  <= '1';
                  Fifo7_Din <= REG7_IPCFIFOSEND;
               end if;
            end if;
            
            if (fiforead_7_enable = '1' and REG7_IPCFIFOCNT_Enable_Send_Receive_Fifo = "1") then
               if (Fifo9_Empty = '1') then
                  REG7_IPCFIFOCNT_Error_Read_Empty_Send_Full <= "1";
               end if;
            end if;
            
            IRQ_IPC7_Send_FIFO_Empty_old     <= REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ(REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ'left) and Fifo7_Empty;
            IRQ_IPC7_Recv_FIFO_Not_Empty_old <= REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ(REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ'left) and not Fifo9_Empty;
            
         end if;
      
      end if;
   end process;
   
   IRQ_IPC9_Send_FIFO_Empty     <= '1' when (REG9_IPCFIFOCNT_Send_Fifo_Empty_IRQ = "1" and Fifo9_Empty = '1' and IRQ_IPC9_Send_FIFO_Empty_old = '0') else '0';
   IRQ_IPC9_Recv_FIFO_Not_Empty <= '1' when (REG9_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ = "1" and Fifo7_Empty = '0' and IRQ_IPC9_Recv_FIFO_Not_Empty_old = '0') else '0';
   
   
   IRQ_IPC7_Send_FIFO_Empty     <= '1' when (REG7_IPCFIFOCNT_Send_Fifo_Empty_IRQ = "1" and Fifo7_Empty = '1' and IRQ_IPC7_Send_FIFO_Empty_old = '0') else '0';
   IRQ_IPC7_Recv_FIFO_Not_Empty <= '1' when (REG7_IPCFIFOCNT_Receive_Fifo_Not_Empty_IRQ = "1" and Fifo9_Empty = '0' and IRQ_IPC7_Recv_FIFO_Not_Empty_old = '0') else '0';

end architecture;





