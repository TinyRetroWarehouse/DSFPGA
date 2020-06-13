library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;
use work.pReg_savestates.all;

entity ds_IRQ is
   generic
   (
      IME    : regmap_type;
      IE     : regmap_type;
      IF_ALL : regmap_type
   ); 
   port 
   (
      clk100                        : in  std_logic;  
      ds_on                         : in  std_logic;
      reset                         : in  std_logic;
      
      savestate_bus                 : in  proc_bus_ds_type;
               
      ds_bus                        : in  proc_bus_ds_type; 
      ds_bus_data                   : out std_logic_vector(31 downto 0);       
      
      cpu_irq                       : out std_logic := '0';
      
      IRQ_LCD_V_Blank               : in  std_logic;
      IRQ_LCD_H_Blank               : in  std_logic;
      IRQ_LCD_V_Counter_Match       : in  std_logic;
      IRQ_Timer_0_Overflow          : in  std_logic;
      IRQ_Timer_1_Overflow          : in  std_logic;
      IRQ_Timer_2_Overflow          : in  std_logic;
      IRQ_Timer_3_Overflow          : in  std_logic;
      IRQ_SIO_RCNT_RTC              : in  std_logic;
      IRQ_DMA_0                     : in  std_logic;
      IRQ_DMA_1                     : in  std_logic;
      IRQ_DMA_2                     : in  std_logic;
      IRQ_DMA_3                     : in  std_logic;
      IRQ_Keypad                    : in  std_logic;
      IRQ_GBA_Slot                  : in  std_logic;
      IRQ_IPC_Sync                  : in  std_logic;
      IRQ_IPC_Send_FIFO_Empty       : in  std_logic;
      IRQ_IPC_Recv_FIFO_Not_Empty   : in  std_logic;
      IRQ_NDS_Slot_TransferComplete : in  std_logic;
      IRQ_NDS_Slot_IREQ_MC          : in  std_logic;
      IRQ_Geometry_Command_FIFO     : in  std_logic;
      IRQ_Screens_unfolding         : in  std_logic;
      IRQ_SPI_bus                   : in  std_logic;
      IRQ_Wifi                      : in  std_logic;
      
      IF_debug                      : out std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_IRQ is
  
   signal REG_IME       : std_logic_vector(IME   .upper downto IME   .lower) := (others => '0');
   signal REG_IE        : std_logic_vector(IE    .upper downto IE    .lower) := (others => '0');                                                                                                                                                                                                                                                                                                 
   signal REG_IF_ALL    : std_logic_vector(IF_ALL.upper downto IF_ALL.lower) := (others => '0');        
                  
   type t_reg_wired_or is array(0 to 2) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
                  
   signal IRPFLags      : std_logic_vector(24 downto 0) := (others => '0');
   signal IF_written    : std_logic;
   
   signal SAVESTATE_IRP : std_logic_vector(24 downto 0) := (others => '0');
  
begin 
   
   iREG_IME        : entity work.eProcReg_ds generic map (IME   ) port map  (clk100, ds_bus, reg_wired_or(0), REG_IME    , REG_IME    ); 
   iREG_IE         : entity work.eProcReg_ds generic map (IE    ) port map  (clk100, ds_bus, reg_wired_or(1), REG_IE     , REG_IE     );
   iREG_IF_ALL     : entity work.eProcReg_ds generic map (IF_ALL) port map  (clk100, ds_bus, reg_wired_or(2), IRPFLags(IF_ALL.upper downto 0), REG_IF_ALL , IF_written);     
  
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
  
   iSAVESTATE_IRP  : entity work.eProcReg_ds generic map (REG_SAVESTATE_IRP  ) port map (clk100, savestate_bus, open, IRPFLags , SAVESTATE_IRP);
  
   process (clk100)
   begin
      if rising_edge(clk100) then
   
         cpu_irq <= '0';
   
         if (reset = '1') then -- reset
   
            IRPFLags <= SAVESTATE_IRP;
   
         elsif (ds_on = '1') then
         
            if (IF_written = '1') then
               IRPFLags(IF_ALL.upper downto 0) <= IRPFLags(IF_ALL.upper downto 0) and not REG_IF_ALL;
            end if;
      
            if (IRQ_LCD_V_Blank               = '1')   then IRPFLags( 0) <= '1'; end if;
            if (IRQ_LCD_H_Blank               = '1')   then IRPFLags( 1) <= '1'; end if;
            if (IRQ_LCD_V_Counter_Match       = '1')   then IRPFLags( 2) <= '1'; end if;
            if (IRQ_Timer_0_Overflow          = '1')   then IRPFLags( 3) <= '1'; end if;
            if (IRQ_Timer_1_Overflow          = '1')   then IRPFLags( 4) <= '1'; end if;
            if (IRQ_Timer_2_Overflow          = '1')   then IRPFLags( 5) <= '1'; end if;
            if (IRQ_Timer_3_Overflow          = '1')   then IRPFLags( 6) <= '1'; end if;
            if (IRQ_SIO_RCNT_RTC              = '1')   then IRPFLags( 7) <= '1'; end if;
            if (IRQ_DMA_0                     = '1')   then IRPFLags( 8) <= '1'; end if;
            if (IRQ_DMA_1                     = '1')   then IRPFLags( 9) <= '1'; end if;
            if (IRQ_DMA_2                     = '1')   then IRPFLags(10) <= '1'; end if;
            if (IRQ_DMA_3                     = '1')   then IRPFLags(11) <= '1'; end if;
            if (IRQ_Keypad                    = '1')   then IRPFLags(12) <= '1'; end if;
            if (IRQ_GBA_Slot                  = '1')   then IRPFLags(13) <= '1'; end if;
            if (IRQ_IPC_Sync                  = '1')   then IRPFLags(16) <= '1'; end if;
            if (IRQ_IPC_Send_FIFO_Empty       = '1')   then IRPFLags(17) <= '1'; end if;
            if (IRQ_IPC_Recv_FIFO_Not_Empty   = '1')   then IRPFLags(18) <= '1'; end if;
            if (IRQ_NDS_Slot_TransferComplete = '1')   then IRPFLags(19) <= '1'; end if;
            if (IRQ_NDS_Slot_IREQ_MC          = '1')   then IRPFLags(20) <= '1'; end if;
            if (IRQ_Geometry_Command_FIFO     = '1')   then IRPFLags(21) <= '1'; end if;
            if (IRQ_Screens_unfolding         = '1')   then IRPFLags(22) <= '1'; end if;
            if (IRQ_SPI_bus                   = '1')   then IRPFLags(23) <= '1'; end if;
            if (IRQ_Wifi                      = '1')   then IRPFLags(24) <= '1'; end if;

            if (unsigned((IRPFLags(IF_ALL.upper downto 0) and REG_IE(IF_ALL.upper downto 0))) /= 0 and REG_IME(0) = '1') then
               cpu_irq <= '1';
            end if;
            
         end if;

      end if;
   end process;
   
   IF_debug <= (31 downto 25 => '0') & IRPFLags;

end architecture;





