library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pRegmap_ds.all;
use work.pProc_bus_ds.all;
use work.pReg_savestates.all;

entity ds_timer_module is
   generic
   (
      is_simu                : std_logic;
      index                  : integer;
      Reg_L                  : regmap_type;
      Reg_H_Prescaler        : regmap_type;
      Reg_H_Count_up         : regmap_type;
      Reg_H_Timer_IRQ_Enable : regmap_type;
      Reg_H_Timer_Start_Stop : regmap_type
   );
   port 
   (
      clk100              : in  std_logic; 
      ds_on               : in  std_logic;
      reset               : in  std_logic;      
      
      savestate_bus       : in  proc_bus_ds_type;
      loading_savestate   : in  std_logic;
      
      ds_bus              : in  proc_bus_ds_type;
      ds_bus_data         : out std_logic_vector(31 downto 0); 
      
      new_cycles          : in  unsigned(7 downto 0);
      new_cycles_valid    : in  std_logic;
      countup_in          : in  std_logic;
      
      tick                : out std_logic := '0';
      IRP_Timer           : out std_logic := '0';
      
      next_event          : out unsigned(15 downto 0);
      
      debugout            : out std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_timer_module is

   signal L_Counter_Reload   : std_logic_vector(Reg_L                 .upper downto Reg_L                 .lower) := (others => '0');
   signal H_Prescaler        : std_logic_vector(Reg_H_Prescaler       .upper downto Reg_H_Prescaler       .lower) := (others => '0');
   signal H_Count_up         : std_logic_vector(Reg_H_Count_up        .upper downto Reg_H_Count_up        .lower) := (others => '0');
   signal H_Timer_IRQ_Enable : std_logic_vector(Reg_H_Timer_IRQ_Enable.upper downto Reg_H_Timer_IRQ_Enable.lower) := (others => '0');
   signal H_Timer_Start_Stop : std_logic_vector(Reg_H_Timer_Start_Stop.upper downto Reg_H_Timer_Start_Stop.lower) := (others => '0');
                      
   type t_reg_wired_or is array(0 to 4) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
                      
   signal H_Timer_Start_Stop_written : std_logic;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

   signal counter_readback : std_logic_vector(15 downto 0) := (others => '0');
   signal counter          : unsigned(16 downto 0) := (others => '0');
   signal prescalecounter  : unsigned(11 downto 0) := (others => '0');
   signal prescaleborder   : integer range 2 to 2048 := 2;
   signal timer_on         : std_logic := '0';
   signal timer_on_next    : std_logic := '0';
   
   -- savestate
   signal SAVESTATE_TIMER      : std_logic_vector(30 downto 0);
   signal SAVESTATE_TIMER_BACK : std_logic_vector(30 downto 0);
   
   
begin 

   SAVESTATE_TIMER_BACK(0)            <= timer_on;       
   SAVESTATE_TIMER_BACK(1)            <= timer_on_next;  
   SAVESTATE_TIMER_BACK(18 downto 2)  <= std_logic_vector(counter);        
   SAVESTATE_TIMER_BACK(30 downto 19) <= std_logic_vector(prescalecounter);

   iSAVESTATE_TIMER : entity work.eProcReg_ds generic map (REG_SAVESTATE_TIMER, index) port map (clk100, savestate_bus, open, SAVESTATE_TIMER_BACK, SAVESTATE_TIMER);


   iL_Counter_Reload   : entity work.eProcReg_ds generic map ( Reg_L                  ) port map  (clk100, ds_bus, reg_wired_or(0), counter_readback   , L_Counter_Reload  );  
   iH_Prescaler        : entity work.eProcReg_ds generic map ( Reg_H_Prescaler        ) port map  (clk100, ds_bus, reg_wired_or(1), H_Prescaler        , H_Prescaler       );  
   iH_Count_up         : entity work.eProcReg_ds generic map ( Reg_H_Count_up         ) port map  (clk100, ds_bus, reg_wired_or(2), H_Count_up         , H_Count_up        );   
   iH_Timer_IRQ_Enable : entity work.eProcReg_ds generic map ( Reg_H_Timer_IRQ_Enable ) port map  (clk100, ds_bus, reg_wired_or(3), H_Timer_IRQ_Enable , H_Timer_IRQ_Enable);  
   iH_Timer_Start_Stop : entity work.eProcReg_ds generic map ( Reg_H_Timer_Start_Stop ) port map  (clk100, ds_bus, reg_wired_or(4), H_Timer_Start_Stop , H_Timer_Start_Stop , H_Timer_Start_Stop_written );  
   
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   counter_readback <= std_logic_vector(counter(15 downto 0));
   
   debugout <= x"00" & H_Timer_Start_Stop & H_Timer_IRQ_Enable & "000" & H_Count_up & H_Prescaler & counter_readback;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         tick       <= '0';
         IRP_Timer  <= '0';
         next_event <= (others => '1');

         if (reset = '1') then
      
            timer_on         <= SAVESTATE_TIMER(0);
            timer_on_next    <= SAVESTATE_TIMER(1);
            counter          <= unsigned(SAVESTATE_TIMER(18 downto 2));
            prescalecounter  <= unsigned(SAVESTATE_TIMER(30 downto 19));
      
         elsif (ds_on = '1') then
         
            -- set_settings
            if (H_Timer_Start_Stop_written = '1' and loading_savestate = '0') then
               if (H_Timer_Start_Stop = "1" and timer_on = '0') then
                  counter         <= '0' & unsigned(L_Counter_Reload);
                  prescalecounter <= (others => '0');
               end if;
               --timer_on_next <= H_Timer_Start_Stop(H_Timer_Start_Stop'left);
               timer_on <= H_Timer_Start_Stop(H_Timer_Start_Stop'left);
            end if;
            
            case (to_integer(unsigned(H_Prescaler))) is
               when 0 => prescaleborder <= 2;
               when 1 => prescaleborder <= 128;
               when 2 => prescaleborder <= 512;
               when 3 => prescaleborder <= 2048;
               when others => null;
            end case;

            --work
            
            --if (new_cycles_valid = '1') then
            --   timer_on <= timer_on_next;
            --end if;
         
            --if (timer_on = '1' and timer_on_next = '1') then
            if (timer_on = '1') then
               if (H_Count_up = "1" and countup_in = '1') then
                  counter <= counter + 1;
               elsif ((H_Count_up = "0" or index = 0) and new_cycles_valid = '1') then
                  if (prescalecounter + new_cycles >= prescaleborder) then
                     prescalecounter <= prescalecounter + new_cycles - prescaleborder;
                     counter         <= counter + 1;
                  else 
                     prescalecounter <= prescalecounter + new_cycles;
                  end if;
               elsif (prescalecounter >= prescaleborder) then
                  prescalecounter <= prescalecounter - prescaleborder;
                  counter <= counter + 1;
               elsif (counter(16) = '1') then
                  counter <= counter - 16#10000# + unsigned(L_Counter_Reload);
                  tick    <= '1';
                  if (H_Timer_IRQ_Enable = "1") then
                     IRP_Timer <= '1';
                  end if;
               end if;
                        
               if (counter(15 downto 0) = x"FFFF" and (H_Count_up = "0" or index = 0)) then            
                  next_event <= x"0" & (to_unsigned(prescaleborder, 12) - prescalecounter);
               end if;
               
            end if;   
            
         end if;
      
      end if;
   end process;
  

end architecture;





