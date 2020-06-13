library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

entity ds_timer is
   generic
   (
      is_simu                    : std_logic;
      TM0CNT_L                   : regmap_type;
      TM0CNT_H                   : regmap_type;
      TM0CNT_H_Prescaler         : regmap_type;
      TM0CNT_H_Count_up          : regmap_type;
      TM0CNT_H_Timer_IRQ_Enable  : regmap_type;
      TM0CNT_H_Timer_Start_Stop  : regmap_type;
      TM1CNT_L                   : regmap_type;
      TM1CNT_H                   : regmap_type;
      TM1CNT_H_Prescaler         : regmap_type;
      TM1CNT_H_Count_up          : regmap_type;
      TM1CNT_H_Timer_IRQ_Enable  : regmap_type;
      TM1CNT_H_Timer_Start_Stop  : regmap_type;
      TM2CNT_L                   : regmap_type;
      TM2CNT_H                   : regmap_type;
      TM2CNT_H_Prescaler         : regmap_type;
      TM2CNT_H_Count_up          : regmap_type;
      TM2CNT_H_Timer_IRQ_Enable  : regmap_type;
      TM2CNT_H_Timer_Start_Stop  : regmap_type;
      TM3CNT_L                   : regmap_type;
      TM3CNT_H                   : regmap_type;
      TM3CNT_H_Prescaler         : regmap_type;
      TM3CNT_H_Count_up          : regmap_type;
      TM3CNT_H_Timer_IRQ_Enable  : regmap_type;
      TM3CNT_H_Timer_Start_Stop  : regmap_type 
   );
   port 
   (
      clk100            : in  std_logic;  
      ds_on             : in  std_logic;
      reset             : in  std_logic;
                        
      savestate_bus     : in  proc_bus_ds_type;
      loading_savestate : in  std_logic;
      
      ds_bus            : in  proc_bus_ds_type;
      ds_bus_data       : out std_logic_vector(31 downto 0); 
      
      new_cycles        : in  unsigned(7 downto 0);
      new_cycles_valid  : in  std_logic;
      IRP_Timer0        : out std_logic;
      IRP_Timer1        : out std_logic;
      IRP_Timer2        : out std_logic;
      IRP_Timer3        : out std_logic;
      
      next_event        : out unsigned(15 downto 0);
             
      debugout0         : out std_logic_vector(31 downto 0);
      debugout1         : out std_logic_vector(31 downto 0);
      debugout2         : out std_logic_vector(31 downto 0);
      debugout3         : out std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_timer is
   
   signal timerticks : std_logic_vector(3 downto 0);
   
   type t_reg_wired_or is array(0 to 3) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
   
   type t_nexteventall is array(0 to 3) of unsigned(15 downto 0);
   signal nexteventall : t_nexteventall;
 
begin 

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;

   ids_timer_module0 : entity work.ds_timer_module
   generic map
   (
      is_simu                => is_simu,
      index                  => 0, 
      Reg_L                  => TM0CNT_L,
      Reg_H_Prescaler        => TM0CNT_H_Prescaler       ,
      Reg_H_Count_up         => TM0CNT_H_Count_up        ,
      Reg_H_Timer_IRQ_Enable => TM0CNT_H_Timer_IRQ_Enable,
      Reg_H_Timer_Start_Stop => TM0CNT_H_Timer_Start_Stop   
   )                                  
   port map
   (
      clk100            => clk100,   
      ds_on             => ds_on,  
      reset             => reset,
                        
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus,
      ds_bus_data       => reg_wired_or(0),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      countup_in        => '0',
                        
      tick              => timerticks(0),
      IRP_Timer         => IRP_Timer0,
      
      next_event        => nexteventall(0),
                        
      debugout          => debugout0
   );
   
   ids_timer_module1 : entity work.ds_timer_module
   generic map
   (
      is_simu                => is_simu,
      index                  => 1, 
      Reg_L                  => TM1CNT_L,
      Reg_H_Prescaler        => TM1CNT_H_Prescaler       ,
      Reg_H_Count_up         => TM1CNT_H_Count_up        ,
      Reg_H_Timer_IRQ_Enable => TM1CNT_H_Timer_IRQ_Enable,
      Reg_H_Timer_Start_Stop => TM1CNT_H_Timer_Start_Stop   
   )                                  
   port map
   (
      clk100            => clk100,   
      ds_on             => ds_on,
      reset             => reset,
                        
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus,
      ds_bus_data       => reg_wired_or(1),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      countup_in        => timerticks(0),
                        
      tick              => timerticks(1),
      IRP_Timer         => IRP_Timer1,
      
      next_event        => nexteventall(1),
                        
      debugout          => debugout1      
   );
   
   ids_timer_module2 : entity work.ds_timer_module
   generic map
   (
      is_simu                => is_simu,
      index                  => 2, 
      Reg_L                  => TM2CNT_L,
      Reg_H_Prescaler        => TM2CNT_H_Prescaler       ,
      Reg_H_Count_up         => TM2CNT_H_Count_up        ,
      Reg_H_Timer_IRQ_Enable => TM2CNT_H_Timer_IRQ_Enable,
      Reg_H_Timer_Start_Stop => TM2CNT_H_Timer_Start_Stop   
   )                                  
   port map
   (
      clk100            => clk100,
      ds_on             => ds_on,  
      reset             => reset,
                        
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus,
      ds_bus_data       => reg_wired_or(2),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      countup_in        => timerticks(1),
                        
      tick              => timerticks(2),
      IRP_Timer         => IRP_Timer2,
      
      next_event        => nexteventall(2),
                        
      debugout          => debugout2      
   );
   
   ids_timer_module3 : entity work.ds_timer_module
   generic map
   (
      is_simu                => is_simu,
      index                  => 3, 
      Reg_L                  => TM3CNT_L,
      Reg_H_Prescaler        => TM3CNT_H_Prescaler       ,
      Reg_H_Count_up         => TM3CNT_H_Count_up        ,
      Reg_H_Timer_IRQ_Enable => TM3CNT_H_Timer_IRQ_Enable,
      Reg_H_Timer_Start_Stop => TM3CNT_H_Timer_Start_Stop   
   )                                  
   port map
   (
      clk100            => clk100,   
      ds_on             => ds_on, 
      reset             => reset,
                        
      savestate_bus     => savestate_bus,
      loading_savestate => loading_savestate,
      
      ds_bus            => ds_bus,
      ds_bus_data       => reg_wired_or(3),
                        
      new_cycles        => new_cycles,      
      new_cycles_valid  => new_cycles_valid,
      countup_in        => timerticks(2),
                        
      tick              => timerticks(3),
      IRP_Timer         => IRP_Timer3,
      
      next_event        => nexteventall(3),
                        
      debugout          => debugout3      
   );
    
   process (clk100)
      variable mintime : unsigned(15 downto 0);
   begin
      if rising_edge(clk100) then
         mintime := nexteventall(0);
         for i in 1 to 3 loop
            if (nexteventall(i) < mintime) then
               mintime := nexteventall(i);
            end if;
         end loop;
         next_event <= mintime;
      end if;
   end process;

end architecture;





