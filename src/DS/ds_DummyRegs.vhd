library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_DummyRegs is
   port 
   (
      clk100                        : in  std_logic;        
      ds_bus9                       : in  proc_bus_ds_type;
      ds_bus9_data                  : out std_logic_vector(31 downto 0); 
      ds_bus7                       : in  proc_bus_ds_type;
      ds_bus7_data                  : out std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_DummyRegs is
   
   -- EXMEMCNT
   signal Reg9_EXMEMCNT_GBASlot_SRAM_Access_Time     : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_GBASlot_SRAM_Access_Time    .upper downto work.pReg_ds_system_9.EXMEMCNT_GBASlot_SRAM_Access_Time    .lower) := (others => '0');
   signal Reg9_EXMEMCNT_GBASlot_ROM_1st_Access_Time  : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_1st_Access_Time .upper downto work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_1st_Access_Time .lower) := (others => '0');
   signal Reg9_EXMEMCNT_GBASlot_ROM_2nd_Access_Time  : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_2nd_Access_Time .upper downto work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_2nd_Access_Time .lower) := (others => '0');
   signal Reg9_EXMEMCNT_GBASlot_PHI_pin_out          : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_GBASlot_PHI_pin_out         .upper downto work.pReg_ds_system_9.EXMEMCNT_GBASlot_PHI_pin_out         .lower) := (others => '0');
   signal Reg9_EXMEMCNT_GBASlot_Access_Rights        : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_GBASlot_Access_Rights       .upper downto work.pReg_ds_system_9.EXMEMCNT_GBASlot_Access_Rights       .lower) := (others => '0');
   signal Reg9_EXMEMCNT_NDSSlot_Access_Rights        : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_NDSSlot_Access_Rights       .upper downto work.pReg_ds_system_9.EXMEMCNT_NDSSlot_Access_Rights       .lower) := (others => '0');
   signal Reg9_EXMEMCNT_SET                          : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_SET                         .upper downto work.pReg_ds_system_9.EXMEMCNT_SET                         .lower) := (others => '0');
   signal Reg9_EXMEMCNT_MainMem_Interface_Mode       : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_MainMem_Interface_Mode      .upper downto work.pReg_ds_system_9.EXMEMCNT_MainMem_Interface_Mode      .lower) := (others => '0');
   signal Reg9_EXMEMCNT_MainMem_Access_Priority      : std_logic_vector(work.pReg_ds_system_9.EXMEMCNT_MainMem_Access_Priority     .upper downto work.pReg_ds_system_9.EXMEMCNT_MainMem_Access_Priority     .lower) := (others => '0');
 
   signal Reg7_EXMEMSTAT_GBASlot_SRAM_Access_Time    : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_GBASlot_SRAM_Access_Time   .upper downto work.pReg_ds_system_7.EXMEMSTAT_GBASlot_SRAM_Access_Time   .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_GBASlot_ROM_1st_Access_Time : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_1st_Access_Time.upper downto work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_1st_Access_Time.lower) := (others => '0');
   signal Reg7_EXMEMSTAT_GBASlot_ROM_2nd_Access_Time : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_2nd_Access_Time.upper downto work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_2nd_Access_Time.lower) := (others => '0');
   signal Reg7_EXMEMSTAT_GBASlot_PHI_pin_out         : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_GBASlot_PHI_pin_out        .upper downto work.pReg_ds_system_7.EXMEMSTAT_GBASlot_PHI_pin_out        .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_GBASlot_Access_Rights       : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_GBASlot_Access_Rights      .upper downto work.pReg_ds_system_7.EXMEMSTAT_GBASlot_Access_Rights      .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_NDSSlot_Access_Rights       : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_NDSSlot_Access_Rights      .upper downto work.pReg_ds_system_7.EXMEMSTAT_NDSSlot_Access_Rights      .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_SET                         : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_SET                        .upper downto work.pReg_ds_system_7.EXMEMSTAT_SET                        .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_MainMem_Interface_Mode      : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_MainMem_Interface_Mode     .upper downto work.pReg_ds_system_7.EXMEMSTAT_MainMem_Interface_Mode     .lower) := (others => '0');
   signal Reg7_EXMEMSTAT_MainMem_Access_Priority     : std_logic_vector(work.pReg_ds_system_7.EXMEMSTAT_MainMem_Access_Priority    .upper downto work.pReg_ds_system_7.EXMEMSTAT_MainMem_Access_Priority    .lower) := (others => '0');
  
   -- POSTFLG
   signal Reg9_POSTFLG_Flag                          : std_logic_vector(work.pReg_ds_system_9.POSTFLG_Flag                         .upper downto work.pReg_ds_system_9.POSTFLG_Flag                         .lower) := (others => '0');
   signal Reg9_POSTFLG_RW                            : std_logic_vector(work.pReg_ds_system_9.POSTFLG_RW                           .upper downto work.pReg_ds_system_9.POSTFLG_RW                           .lower) := (others => '0');
   
   -- POWCNT1
   signal Reg9_POWCNT1_Enable_Flag_for_both_LCDs     : std_logic_vector(work.pReg_ds_system_9.POWCNT1_Enable_Flag_for_both_LCDs    .upper downto work.pReg_ds_system_9.POWCNT1_Enable_Flag_for_both_LCDs    .lower) := (others => '0');
   signal Reg9_POWCNT1_2D_Graphics_Engine_A          : std_logic_vector(work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_A         .upper downto work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_A         .lower) := (others => '0');
   signal Reg9_POWCNT1_3D_Rendering_Engine           : std_logic_vector(work.pReg_ds_system_9.POWCNT1_3D_Rendering_Engine          .upper downto work.pReg_ds_system_9.POWCNT1_3D_Rendering_Engine          .lower) := (others => '0');
   signal Reg9_POWCNT1_3D_Geometry_Engine            : std_logic_vector(work.pReg_ds_system_9.POWCNT1_3D_Geometry_Engine           .upper downto work.pReg_ds_system_9.POWCNT1_3D_Geometry_Engine           .lower) := (others => '0');
   signal Reg9_POWCNT1_2D_Graphics_Engine_B          : std_logic_vector(work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_B         .upper downto work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_B         .lower) := (others => '0');
   signal Reg9_POWCNT1_Display_Swap                  : std_logic_vector(work.pReg_ds_system_9.POWCNT1_Display_Swap                 .upper downto work.pReg_ds_system_9.POWCNT1_Display_Swap                 .lower) := (others => '0');

   -- RTC_reg
   signal Reg7_RTC_reg_Data_IO                       : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Data_IO                      .upper downto work.pReg_ds_system_7.RTC_reg_Data_IO                      .lower) := (others => '0');
   signal Reg7_RTC_reg_Clock                         : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Clock                        .upper downto work.pReg_ds_system_7.RTC_reg_Clock                        .lower) := (others => '0');
   signal Reg7_RTC_reg_Select                        : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Select                       .upper downto work.pReg_ds_system_7.RTC_reg_Select                       .lower) := (others => '0');
   signal Reg7_RTC_reg_Unused_IO_Line3               : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Unused_IO_Line3              .upper downto work.pReg_ds_system_7.RTC_reg_Unused_IO_Line3              .lower) := (others => '0');
   signal Reg7_RTC_reg_Data_Direction                : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Data_Direction               .upper downto work.pReg_ds_system_7.RTC_reg_Data_Direction               .lower) := (others => '0');
   signal Reg7_RTC_reg_Clock_Direction               : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Clock_Direction              .upper downto work.pReg_ds_system_7.RTC_reg_Clock_Direction              .lower) := (others => '0');
   signal Reg7_RTC_reg_Select_Direction              : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Select_Direction             .upper downto work.pReg_ds_system_7.RTC_reg_Select_Direction             .lower) := (others => '0');
   signal Reg7_RTC_reg_Direction_unused3             : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Direction_unused3            .upper downto work.pReg_ds_system_7.RTC_reg_Direction_unused3            .lower) := (others => '0');
   signal Reg7_RTC_reg_Unused_IO_Lines811            : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Unused_IO_Lines811           .upper downto work.pReg_ds_system_7.RTC_reg_Unused_IO_Lines811           .lower) := (others => '0');
   signal Reg7_RTC_reg_Direction_unused811           : std_logic_vector(work.pReg_ds_system_7.RTC_reg_Direction_unused811          .upper downto work.pReg_ds_system_7.RTC_reg_Direction_unused811          .lower) := (others => '0');

   -- wired or
   type t_reg_wired_or9 is array(0 to 16) of std_logic_vector(31 downto 0);
   signal reg_wired_or9 : t_reg_wired_or9;
   
   type t_reg_wired_or7 is array(0 to 19) of std_logic_vector(31 downto 0);
   signal reg_wired_or7 : t_reg_wired_or7;
  
  
begin 
   
   -- EXMEMCNT
   iREG9_EXMEMCNT_GBASlot_SRAM_Access_Time     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_GBASlot_SRAM_Access_Time    ) port map  (clk100, ds_bus9, reg_wired_or9( 0), REG9_EXMEMCNT_GBASlot_SRAM_Access_Time    , REG9_EXMEMCNT_GBASlot_SRAM_Access_Time    ); 
   iREG9_EXMEMCNT_GBASlot_ROM_1st_Access_Time  : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_1st_Access_Time ) port map  (clk100, ds_bus9, reg_wired_or9( 1), REG9_EXMEMCNT_GBASlot_ROM_1st_Access_Time , REG9_EXMEMCNT_GBASlot_ROM_1st_Access_Time ); 
   iREG9_EXMEMCNT_GBASlot_ROM_2nd_Access_Time  : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_GBASlot_ROM_2nd_Access_Time ) port map  (clk100, ds_bus9, reg_wired_or9( 2), REG9_EXMEMCNT_GBASlot_ROM_2nd_Access_Time , REG9_EXMEMCNT_GBASlot_ROM_2nd_Access_Time ); 
   iREG9_EXMEMCNT_GBASlot_PHI_pin_out          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_GBASlot_PHI_pin_out         ) port map  (clk100, ds_bus9, reg_wired_or9( 3), REG9_EXMEMCNT_GBASlot_PHI_pin_out         , REG9_EXMEMCNT_GBASlot_PHI_pin_out         ); 
   iREG9_EXMEMCNT_GBASlot_Access_Rights        : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_GBASlot_Access_Rights       ) port map  (clk100, ds_bus9, reg_wired_or9( 4), REG9_EXMEMCNT_GBASlot_Access_Rights       , REG9_EXMEMCNT_GBASlot_Access_Rights       ); 
   iREG9_EXMEMCNT_NDSSlot_Access_Rights        : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_NDSSlot_Access_Rights       ) port map  (clk100, ds_bus9, reg_wired_or9( 5), REG9_EXMEMCNT_NDSSlot_Access_Rights       , REG9_EXMEMCNT_NDSSlot_Access_Rights       ); 
   iREG9_EXMEMCNT_SET                          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_SET                         ) port map  (clk100, ds_bus9, reg_wired_or9( 6), REG9_EXMEMCNT_SET                         , REG9_EXMEMCNT_SET                         ); 
   iREG9_EXMEMCNT_MainMem_Interface_Mode       : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_MainMem_Interface_Mode      ) port map  (clk100, ds_bus9, reg_wired_or9( 7), REG9_EXMEMCNT_MainMem_Interface_Mode      );      
   iREG9_EXMEMCNT_MainMem_Access_Priority      : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.EXMEMCNT_MainMem_Access_Priority     ) port map  (clk100, ds_bus9, reg_wired_or9( 8), REG9_EXMEMCNT_MainMem_Access_Priority     , REG9_EXMEMCNT_MainMem_Access_Priority     ); 
   
   iREG7_EXMEMSTAT_GBASlot_SRAM_Access_Time    : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_GBASlot_SRAM_Access_Time   ) port map  (clk100, ds_bus7, reg_wired_or7( 0), REG7_EXMEMSTAT_GBASlot_SRAM_Access_Time   , REG7_EXMEMSTAT_GBASlot_SRAM_Access_Time   ); 
   iREG7_EXMEMSTAT_GBASlot_ROM_1st_Access_Time : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_1st_Access_Time) port map  (clk100, ds_bus7, reg_wired_or7( 1), REG7_EXMEMSTAT_GBASlot_ROM_1st_Access_Time, REG7_EXMEMSTAT_GBASlot_ROM_1st_Access_Time); 
   iREG7_EXMEMSTAT_GBASlot_ROM_2nd_Access_Time : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_GBASlot_ROM_2nd_Access_Time) port map  (clk100, ds_bus7, reg_wired_or7( 2), REG7_EXMEMSTAT_GBASlot_ROM_2nd_Access_Time, REG7_EXMEMSTAT_GBASlot_ROM_2nd_Access_Time); 
   iREG7_EXMEMSTAT_GBASlot_PHI_pin_out         : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_GBASlot_PHI_pin_out        ) port map  (clk100, ds_bus7, reg_wired_or7( 3), REG7_EXMEMSTAT_GBASlot_PHI_pin_out        , REG7_EXMEMSTAT_GBASlot_PHI_pin_out        ); 
   iREG7_EXMEMSTAT_GBASlot_Access_Rights       : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_GBASlot_Access_Rights      ) port map  (clk100, ds_bus7, reg_wired_or7( 4), REG7_EXMEMSTAT_GBASlot_Access_Rights      ); 
   iREG7_EXMEMSTAT_NDSSlot_Access_Rights       : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_NDSSlot_Access_Rights      ) port map  (clk100, ds_bus7, reg_wired_or7( 5), REG7_EXMEMSTAT_NDSSlot_Access_Rights      ); 
   iREG7_EXMEMSTAT_SET                         : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_SET                        ) port map  (clk100, ds_bus7, reg_wired_or7( 6), REG7_EXMEMSTAT_SET                        ); 
   iREG7_EXMEMSTAT_MainMem_Interface_Mode      : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_MainMem_Interface_Mode     ) port map  (clk100, ds_bus7, reg_wired_or7( 7), REG7_EXMEMSTAT_MainMem_Interface_Mode     ); 
   iREG7_EXMEMSTAT_MainMem_Access_Priority     : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.EXMEMSTAT_MainMem_Access_Priority    ) port map  (clk100, ds_bus7, reg_wired_or7( 8), REG7_EXMEMSTAT_MainMem_Access_Priority    ); 

   Reg7_EXMEMSTAT_GBASlot_Access_Rights   <= Reg9_EXMEMCNT_GBASlot_Access_Rights;  
   Reg7_EXMEMSTAT_NDSSlot_Access_Rights   <= Reg9_EXMEMCNT_NDSSlot_Access_Rights;  
   Reg7_EXMEMSTAT_SET                     <= Reg9_EXMEMCNT_SET;                    
   Reg7_EXMEMSTAT_MainMem_Interface_Mode  <= Reg9_EXMEMCNT_MainMem_Interface_Mode;
   Reg7_EXMEMSTAT_MainMem_Access_Priority <= Reg9_EXMEMCNT_MainMem_Access_Priority;
   
   -- POSTFLG
   iREG9_POSTFLG_Flag                          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POSTFLG_Flag                         ) port map  (clk100, ds_bus9, reg_wired_or9( 9), "1"             ); 
   iREG9_POSTFLG_RW                            : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POSTFLG_RW                           ) port map  (clk100, ds_bus9, reg_wired_or9(10), Reg9_POSTFLG_RW , Reg9_POSTFLG_RW); 

   -- POWCNT1
   iREG9_POWCNT1_Enable_Flag_for_both_LCDs     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_Enable_Flag_for_both_LCDs    ) port map  (clk100, ds_bus9, reg_wired_or9(11), REG9_POWCNT1_Enable_Flag_for_both_LCDs    , REG9_POWCNT1_Enable_Flag_for_both_LCDs    ); 
   iREG9_POWCNT1_2D_Graphics_Engine_A          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_A         ) port map  (clk100, ds_bus9, reg_wired_or9(12), REG9_POWCNT1_2D_Graphics_Engine_A         , REG9_POWCNT1_2D_Graphics_Engine_A         ); 
   iREG9_POWCNT1_3D_Rendering_Engine           : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_3D_Rendering_Engine          ) port map  (clk100, ds_bus9, reg_wired_or9(13), REG9_POWCNT1_3D_Rendering_Engine          , REG9_POWCNT1_3D_Rendering_Engine          ); 
   iREG9_POWCNT1_3D_Geometry_Engine            : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_3D_Geometry_Engine           ) port map  (clk100, ds_bus9, reg_wired_or9(14), REG9_POWCNT1_3D_Geometry_Engine           , REG9_POWCNT1_3D_Geometry_Engine           ); 
   iREG9_POWCNT1_2D_Graphics_Engine_B          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_2D_Graphics_Engine_B         ) port map  (clk100, ds_bus9, reg_wired_or9(15), REG9_POWCNT1_2D_Graphics_Engine_B         , REG9_POWCNT1_2D_Graphics_Engine_B         ); 
   iREG9_POWCNT1_Display_Swap                  : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.POWCNT1_Display_Swap                 ) port map  (clk100, ds_bus9, reg_wired_or9(16), REG9_POWCNT1_Display_Swap                 , REG9_POWCNT1_Display_Swap                 ); 
   
   -- BIOSPROT
   iREG7_BIOSPROT                              : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.BIOSPROT                             ) port map  (clk100, ds_bus7, reg_wired_or7( 9), x"1205"); 

   -- RTC_reg
   iREG7_RTC_reg_Data_IO                       : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Data_IO                      ) port map  (clk100, ds_bus7, reg_wired_or7(10), REG7_RTC_reg_Data_IO                      , REG7_RTC_reg_Data_IO                      ); 
   iREG7_RTC_reg_Clock                         : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Clock                        ) port map  (clk100, ds_bus7, reg_wired_or7(11), REG7_RTC_reg_Clock                        , REG7_RTC_reg_Clock                        ); 
   iREG7_RTC_reg_Select                        : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Select                       ) port map  (clk100, ds_bus7, reg_wired_or7(12), REG7_RTC_reg_Select                       , REG7_RTC_reg_Select                       ); 
   iREG7_RTC_reg_Unused_IO_Line3               : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Unused_IO_Line3              ) port map  (clk100, ds_bus7, reg_wired_or7(13), REG7_RTC_reg_Unused_IO_Line3              , REG7_RTC_reg_Unused_IO_Line3              ); 
   iREG7_RTC_reg_Data_Direction                : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Data_Direction               ) port map  (clk100, ds_bus7, reg_wired_or7(14), REG7_RTC_reg_Data_Direction               , REG7_RTC_reg_Data_Direction               ); 
   iREG7_RTC_reg_Clock_Direction               : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Clock_Direction              ) port map  (clk100, ds_bus7, reg_wired_or7(15), REG7_RTC_reg_Clock_Direction              , REG7_RTC_reg_Clock_Direction              ); 
   iREG7_RTC_reg_Select_Direction              : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Select_Direction             ) port map  (clk100, ds_bus7, reg_wired_or7(16), REG7_RTC_reg_Select_Direction             , REG7_RTC_reg_Select_Direction             ); 
   iREG7_RTC_reg_Direction_unused3             : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Direction_unused3            ) port map  (clk100, ds_bus7, reg_wired_or7(17), REG7_RTC_reg_Direction_unused3            , REG7_RTC_reg_Direction_unused3            ); 
   iREG7_RTC_reg_Unused_IO_Lines811            : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Unused_IO_Lines811           ) port map  (clk100, ds_bus7, reg_wired_or7(18), REG7_RTC_reg_Unused_IO_Lines811           , REG7_RTC_reg_Unused_IO_Lines811           ); 
   iREG7_RTC_reg_Direction_unused811           : entity work.eProcReg_ds generic map (work.pReg_ds_system_7.RTC_reg_Direction_unused811          ) port map  (clk100, ds_bus7, reg_wired_or7(19), REG7_RTC_reg_Direction_unused811          , REG7_RTC_reg_Direction_unused811          );  
   
   -- wired or
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

end architecture;





