library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_joypad is
   port 
   (
      clk100       : in  std_logic;  
      ds_on        : in  std_logic;
      reset        : in  std_logic;
               
      ds_bus9      : in  proc_bus_ds_type;
      ds_bus9_data : out std_logic_vector(31 downto 0); 
      ds_bus7      : in  proc_bus_ds_type;
      ds_bus7_data : out std_logic_vector(31 downto 0); 
      
      IRP_Joypad9  : out std_logic := '0';
      IRP_Joypad7  : out std_logic := '0';
                   
      KeyA         : in  std_logic;
      KeyB         : in  std_logic;
      KeyX         : in  std_logic;
      KeyY         : in  std_logic;
      KeySelect    : in  std_logic;
      KeyStart     : in  std_logic;
      KeyRight     : in  std_logic;
      KeyLeft      : in  std_logic;
      KeyUp        : in  std_logic;
      KeyDown      : in  std_logic;
      KeyR         : in  std_logic;
      KeyL         : in  std_logic;
      Touch        : in  std_logic;
                         
      commandcount : in  integer
   );
end entity;

architecture arch of ds_joypad is

   signal REG9_KEYINPUT : std_logic_vector(work.pReg_ds_keypad_9.KEYINPUT.upper downto work.pReg_ds_keypad_9.KEYINPUT.lower) := (others => '0');
   signal REG9_KEYCNT   : std_logic_vector(work.pReg_ds_keypad_9.KEYCNT  .upper downto work.pReg_ds_keypad_9.KEYCNT  .lower) := (others => '0');
   
   signal REG7_KEYINPUT : std_logic_vector(work.pReg_ds_keypad_7.KEYINPUT.upper downto work.pReg_ds_keypad_7.KEYINPUT.lower) := (others => '0');
   signal REG7_KEYCNT   : std_logic_vector(work.pReg_ds_keypad_7.KEYCNT  .upper downto work.pReg_ds_keypad_7.KEYCNT  .lower) := (others => '0');
                                                                                                                     
   signal REG7_RCNT     : std_logic_vector(work.pReg_ds_keypad_7.RCNT    .upper downto work.pReg_ds_keypad_7.RCNT    .lower) := (others => '0');
   signal REG7_EXTKEYIN : std_logic_vector(work.pReg_ds_keypad_7.EXTKEYIN.upper downto work.pReg_ds_keypad_7.EXTKEYIN.lower) := (others => '0');
   
   type t_reg_wired_or9 is array(0 to 1) of std_logic_vector(31 downto 0);
   signal reg_wired_or9 : t_reg_wired_or9;
   type t_reg_wired_or7 is array(0 to 3) of std_logic_vector(31 downto 0);
   signal reg_wired_or7 : t_reg_wired_or7;
   
   signal Keys    : std_logic_vector(work.pReg_ds_keypad_9.KEYINPUT.upper downto work.pReg_ds_keypad_9.KEYINPUT.lower) := (others => '0');
   signal Keys_1  : std_logic_vector(work.pReg_ds_keypad_9.KEYINPUT.upper downto work.pReg_ds_keypad_9.KEYINPUT.lower) := (others => '0');
   
   signal Ext_keys : std_logic_vector(7 downto 0);
   
begin 

   iREG9_KEYINPUT : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.KEYINPUT) port map  (clk100, ds_bus9, reg_wired_or9( 0), REG9_KEYINPUT); 
   iREG9_KEYCNT   : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.KEYCNT  ) port map  (clk100, ds_bus9, reg_wired_or9( 1), REG9_KEYCNT  , REG9_KEYCNT  ); 
    
   iREG7_KEYINPUT : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.KEYINPUT) port map  (clk100, ds_bus7, reg_wired_or7( 0), REG7_KEYINPUT); 
   iREG7_KEYCNT   : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.KEYCNT  ) port map  (clk100, ds_bus7, reg_wired_or7( 1), REG7_KEYCNT  , REG7_KEYCNT  ); 
                                                                                                                                 
   iREG7_RCNT     : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.RCNT    ) port map  (clk100, ds_bus7, reg_wired_or7( 2), REG7_RCNT    , REG7_RCNT    ); 
   iREG7_EXTKEYIN : entity work.eProcReg_ds generic map (work.pReg_ds_keypad_7.EXTKEYIN) port map  (clk100, ds_bus7, reg_wired_or7( 3), REG7_EXTKEYIN); 

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

   REG9_KEYINPUT <= Keys;
   REG7_KEYINPUT <= Keys;
   
   REG7_EXTKEYIN <= Ext_keys;
   
   process (clk100)
   begin
      if rising_edge(clk100) then

         IRP_Joypad9 <= '0';
         IRP_Joypad7 <= '0';
         
         Keys_1 <= Keys;
         
         Keys(0) <= not KeyA; 
         Keys(1) <= not KeyB;
         Keys(2) <= not KeySelect;
         Keys(3) <= not KeyStart;
         Keys(4) <= not KeyRight;
         Keys(5) <= not KeyLeft;
         Keys(6) <= not KeyUp;
         Keys(7) <= not KeyDown;
         Keys(8) <= not KeyR;
         Keys(9) <= not KeyL;
         
         if (Keys_1 /= Keys) then
            if (REG9_KEYCNT(30) = '1') then
               if (REG9_KEYCNT(31) = '1') then -- logical and
                  if ((not Keys(9 downto 0)) = REG9_KEYCNT(25 downto 16)) then
                     IRP_Joypad9 <= '1';
                  end if;
               else -- logical or
                  if (unsigned((not Keys(9 downto 0)) and REG9_KEYCNT(25 downto 16)) /= 0) then
                     IRP_Joypad9 <= '1';
                  end if;
               end if;
            end if;
         end if;
         
         if (Keys_1 /= Keys) then
            if (REG7_KEYCNT(30) = '1') then
               if (REG7_KEYCNT(31) = '1') then -- logical and
                  if ((not Keys(9 downto 0)) = REG7_KEYCNT(25 downto 16)) then
                     IRP_Joypad7 <= '1';
                  end if;
               else -- logical or
                  if (unsigned((not Keys(9 downto 0)) and REG7_KEYCNT(25 downto 16)) /= 0) then
                     IRP_Joypad7 <= '1';
                  end if;
               end if;
            end if;
         end if;
         
         Ext_keys(0) <= not KeyX;
         Ext_keys(1) <= not KeyY;
         Ext_keys(2) <= '1'; -- unused
         Ext_keys(3) <= '1'; -- debug
         Ext_keys(4) <= '1'; -- unsued
         Ext_keys(5) <= '1'; -- unsued
         Ext_keys(6) <= not Touch;
         Ext_keys(7) <= '0'; -- hinge
         
         
         -- debug only
         
         --if (commandcount = 0      ) then Keys(3) <= '1'; end if;
         --if (commandcount = 200000 ) then Keys(3) <= '0'; end if;
         --if (commandcount = 400000 ) then Keys(3) <= '1'; end if;
         --if (commandcount = 700000 ) then Keys(3) <= '0'; end if;
         --if (commandcount = 1000000) then Keys(3) <= '1'; end if;
         --if (commandcount = 1300000) then Keys(3) <= '0'; end if;
         --if (commandcount = 1600000) then Keys(3) <= '1'; end if;
         --if (commandcount = 2000000) then Keys(3) <= '0'; end if;
         --if (commandcount = 2300000) then Keys(3) <= '1'; end if;
         --if (commandcount = 2600000) then Keys(3) <= '0'; end if;
         --if (commandcount = 2900000) then Keys(3) <= '1'; end if;

         --end if;
      
      end if;
   end process; 
    

end architecture;





