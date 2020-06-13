library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_sqrt is
   port 
   (
      clk100               : in  std_logic;  
      ds_on                : in  std_logic;
      reset                : in  std_logic;
               
      ds_bus               : in  proc_bus_ds_type; 
      ds_bus_data          : out std_logic_vector(31 downto 0);       
      haltbus              : out std_logic := '0';
      
      new_cycles           : in  unsigned(7 downto 0);
      new_cycles_valid     : in  std_logic
   );
end entity;

architecture arch of ds_sqrt is
   
   signal REG9_SQRTCN_Mode     : std_logic_vector(work.pReg_ds_system_9.SQRTCN_Mode    .upper downto work.pReg_ds_system_9.SQRTCN_Mode    .lower) := (others => '0');
   signal REG9_SQRTCN_Busy     : std_logic_vector(work.pReg_ds_system_9.SQRTCN_Busy    .upper downto work.pReg_ds_system_9.SQRTCN_Busy    .lower) := (others => '0');
   signal REG9_SQRT_RESULT     : std_logic_vector(work.pReg_ds_system_9.SQRT_RESULT    .upper downto work.pReg_ds_system_9.SQRT_RESULT    .lower) := (others => '0');
   signal REG9_SQRT_PARAM_Low  : std_logic_vector(work.pReg_ds_system_9.SQRT_PARAM_Low .upper downto work.pReg_ds_system_9.SQRT_PARAM_Low .lower) := (others => '0');
   signal REG9_SQRT_PARAM_High : std_logic_vector(work.pReg_ds_system_9.SQRT_PARAM_High.upper downto work.pReg_ds_system_9.SQRT_PARAM_High.lower) := (others => '0');

   type t_reg_wired_or is array(0 to 4) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   signal REG9_SQRTCN_Mode_written     : std_logic;
   signal REG9_SQRT_PARAM_Low_written  : std_logic;
   signal REG9_SQRT_PARAM_High_written : std_logic;

   signal any_written : std_logic;
   
   signal workcnt     : integer range 0 to 26 := 0;
   signal working     : std_logic := '0';
  
   -- internal sqrt
   signal start     : std_logic := '0';
   signal done      : std_logic := '0';
   signal paramfull : unsigned(63 downto 0); 
   
   signal finish    : std_logic := '0';
   signal op        : unsigned(63 downto 0); 
   signal result    : unsigned(63 downto 0);
   signal one       : unsigned(63 downto 0);
   
begin 
   
   iREG9_SQRTCN_Mode     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.SQRTCN_Mode    ) port map  (clk100, ds_bus, reg_wired_or(0), REG9_SQRTCN_Mode     , REG9_SQRTCN_Mode     , REG9_SQRTCN_Mode_written    ); 
   iREG9_SQRTCN_Busy     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.SQRTCN_Busy    ) port map  (clk100, ds_bus, reg_wired_or(1), REG9_SQRTCN_Busy     ); 
   iREG9_SQRT_RESULT     : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.SQRT_RESULT    ) port map  (clk100, ds_bus, reg_wired_or(2), REG9_SQRT_RESULT     ); 
   iREG9_SQRT_PARAM_Low  : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.SQRT_PARAM_Low ) port map  (clk100, ds_bus, reg_wired_or(3), REG9_SQRT_PARAM_Low  , REG9_SQRT_PARAM_Low  , REG9_SQRT_PARAM_Low_written ); 
   iREG9_SQRT_PARAM_High : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.SQRT_PARAM_High) port map  (clk100, ds_bus, reg_wired_or(4), REG9_SQRT_PARAM_High , REG9_SQRT_PARAM_High , REG9_SQRT_PARAM_High_written); 

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;

   any_written <= REG9_SQRTCN_Mode_written or REG9_SQRT_PARAM_Low_written or REG9_SQRT_PARAM_High_written;
   
   REG9_SQRT_RESULT <= std_logic_vector(result(31 downto 0));
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         if (reset = '1') then
         
            workcnt <= 0;
            working <= '0';
         
         else
      
            start <= '0';
         
            if (new_cycles_valid = '1') then
               if (new_cycles < workcnt) then
                  workcnt <= workcnt - to_integer(new_cycles);
               else
                  workcnt <= 0;
               end if;
            end if;
            
            if (workcnt = 0) then
               REG9_SQRTCN_Busy <= "0";
            end if;
         
            if (any_written = '1') then
               REG9_SQRTCN_Busy <= "1";
               start            <= '1';
               working          <= '1';
               workcnt          <= 26;
               if (REG9_SQRTCN_Mode = "0") then -- 32
                  paramfull <= x"00000000" & unsigned(REG9_SQRT_PARAM_Low);
               else 
                  paramfull(63 downto 32) <= unsigned(REG9_SQRT_PARAM_High);
                  paramfull(31 downto  0) <= unsigned(REG9_SQRT_PARAM_Low);
               end if;
               
            end if;
            
            if (ds_bus.ena = '1' and ds_bus.rnw = '1' and working = '1') then
               if (unsigned(ds_bus.adr) = 16#2B4#) then
                  haltbus <= '1';
               end if;
            end if;
   
            if (done = '1') then
               haltbus   <= '0';
               working   <= '0';
            end if;
            
         end if;

      end if;
   end process;
   
   
   process (clk100) is
      variable res : unsigned(63 downto 0);
   begin
      if rising_edge(clk100) then

         done <= '0';

         if (start = '1') then
            
            finish <= '0';
            op     <= paramfull;
            one    <= "01" & (61 downto 0 => '0');
            result <= (others => '0');
            
         elsif (finish = '0') then
         
            res    := result;
            if (op >= res + one) then
               op     <= op - (result + one);
               res    := result + (one(62 downto 0) & '0');
            end if;
            result <= '0' & res(63 downto 1);
            one    <= "00" & one(63 downto 2);
               
            if (one(0) = '1') then
               finish <= '1';
               done   <= '1';
            end if;

         end if;

      end if;
      
   end process;
   

end architecture;
