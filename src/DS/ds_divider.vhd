library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library MEM;

use work.pProc_bus_ds.all;

entity ds_divider is
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

architecture arch of ds_divider is
   
   signal REG9_DIVCNT_Division_Mode    : std_logic_vector(work.pReg_ds_system_9.DIVCNT_Division_Mode   .upper downto work.pReg_ds_system_9.DIVCNT_Division_Mode   .lower) := (others => '0');
   signal REG9_DIVCNT_Division_by_zero : std_logic_vector(work.pReg_ds_system_9.DIVCNT_Division_by_zero.upper downto work.pReg_ds_system_9.DIVCNT_Division_by_zero.lower) := (others => '0');
   signal REG9_DIVCNT_Busy             : std_logic_vector(work.pReg_ds_system_9.DIVCNT_Busy            .upper downto work.pReg_ds_system_9.DIVCNT_Busy            .lower) := (others => '0');
   signal REG9_DIV_NUMER_Low           : std_logic_vector(work.pReg_ds_system_9.DIV_NUMER_Low          .upper downto work.pReg_ds_system_9.DIV_NUMER_Low          .lower) := (others => '0');
   signal REG9_DIV_NUMER_High          : std_logic_vector(work.pReg_ds_system_9.DIV_NUMER_High         .upper downto work.pReg_ds_system_9.DIV_NUMER_High         .lower) := (others => '0');
   signal REG9_DIV_DENOM_Low           : std_logic_vector(work.pReg_ds_system_9.DIV_DENOM_Low          .upper downto work.pReg_ds_system_9.DIV_DENOM_Low          .lower) := (others => '0');
   signal REG9_DIV_DENOM_High          : std_logic_vector(work.pReg_ds_system_9.DIV_DENOM_High         .upper downto work.pReg_ds_system_9.DIV_DENOM_High         .lower) := (others => '0');
   signal REG9_DIV_RESULT_Low          : std_logic_vector(work.pReg_ds_system_9.DIV_RESULT_Low         .upper downto work.pReg_ds_system_9.DIV_RESULT_Low         .lower) := (others => '0');
   signal REG9_DIV_RESULT_High         : std_logic_vector(work.pReg_ds_system_9.DIV_RESULT_High        .upper downto work.pReg_ds_system_9.DIV_RESULT_High        .lower) := (others => '0');
   signal REG9_DIVREM_RESULT_Low       : std_logic_vector(work.pReg_ds_system_9.DIVREM_RESULT_Low      .upper downto work.pReg_ds_system_9.DIVREM_RESULT_Low      .lower) := (others => '0');
   signal REG9_DIVREM_RESULT_High      : std_logic_vector(work.pReg_ds_system_9.DIVREM_RESULT_High     .upper downto work.pReg_ds_system_9.DIVREM_RESULT_High     .lower) := (others => '0');

   type t_reg_wired_or is array(0 to 10) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   signal REG9_DIVCNT_Division_Mode_written : std_logic;
   signal REG9_DIV_NUMER_Low_written        : std_logic;
   signal REG9_DIV_NUMER_High_written       : std_logic;
   signal REG9_DIV_DENOM_Low_written        : std_logic;
   signal REG9_DIV_DENOM_High_written       : std_logic;
   signal REG9_DIV_RESULT_Low_written       : std_logic;
   signal REG9_DIV_RESULT_High_written      : std_logic;
   signal REG9_DIVREM_RESULT_Low_written    : std_logic;
   signal REG9_DIVREM_RESULT_High_written   : std_logic;
   
   signal any_written : std_logic;
   
   signal workcnt     : integer range 0 to 68 := 0;
   signal working     : std_logic := '0';
  
   -- internal divider
   constant bits_per_cycle : integer := 1;
   
   signal start     : STD_LOGIC := '0';
   signal done      : STD_LOGIC := '0';
   signal dividend  : signed(63 downto 0);
   signal divisor   : signed(63 downto 0);
   signal quotient  : signed(63 downto 0);
   signal remainder : signed(63 downto 0);
   
   signal dividend_u  : unsigned(dividend'length downto 0);
   signal divisor_u   : unsigned(divisor'length downto 0);
   signal quotient_u  : unsigned(quotient'length downto 0);
   signal Akku        : unsigned (divisor'left + 1 downto divisor'right);
   signal QPointer    : integer range quotient_u'range;
   signal done_buffer : std_logic := '0';

begin 
   
   iREG9_DIVCNT_Division_Mode    : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIVCNT_Division_Mode   ) port map  (clk100, ds_bus, reg_wired_or( 0), REG9_DIVCNT_Division_Mode    , REG9_DIVCNT_Division_Mode   , REG9_DIVCNT_Division_Mode_written   ); 
   iREG9_DIVCNT_Division_by_zero : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIVCNT_Division_by_zero) port map  (clk100, ds_bus, reg_wired_or( 1), REG9_DIVCNT_Division_by_zero); 
   iREG9_DIVCNT_Busy             : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIVCNT_Busy            ) port map  (clk100, ds_bus, reg_wired_or( 2), REG9_DIVCNT_Busy); 
   iREG9_DIV_NUMER_Low           : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_NUMER_Low          ) port map  (clk100, ds_bus, reg_wired_or( 3), REG9_DIV_NUMER_Low           , REG9_DIV_NUMER_Low          , REG9_DIV_NUMER_Low_written          ); 
   iREG9_DIV_NUMER_High          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_NUMER_High         ) port map  (clk100, ds_bus, reg_wired_or( 4), REG9_DIV_NUMER_High          , REG9_DIV_NUMER_High         , REG9_DIV_NUMER_High_written         ); 
   iREG9_DIV_DENOM_Low           : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_DENOM_Low          ) port map  (clk100, ds_bus, reg_wired_or( 5), REG9_DIV_DENOM_Low           , REG9_DIV_DENOM_Low          , REG9_DIV_DENOM_Low_written          ); 
   iREG9_DIV_DENOM_High          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_DENOM_High         ) port map  (clk100, ds_bus, reg_wired_or( 6), REG9_DIV_DENOM_High          , REG9_DIV_DENOM_High         , REG9_DIV_DENOM_High_written         ); 
   iREG9_DIV_RESULT_Low          : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_RESULT_Low         ) port map  (clk100, ds_bus, reg_wired_or( 7), REG9_DIV_RESULT_Low    ); 
   iREG9_DIV_RESULT_High         : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIV_RESULT_High        ) port map  (clk100, ds_bus, reg_wired_or( 8), REG9_DIV_RESULT_High   ); 
   iREG9_DIVREM_RESULT_Low       : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIVREM_RESULT_Low      ) port map  (clk100, ds_bus, reg_wired_or( 9), REG9_DIVREM_RESULT_Low ); 
   iREG9_DIVREM_RESULT_High      : entity work.eProcReg_ds generic map (work.pReg_ds_system_9.DIVREM_RESULT_High     ) port map  (clk100, ds_bus, reg_wired_or(10), REG9_DIVREM_RESULT_High); 
    
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
    
   any_written <= REG9_DIVCNT_Division_Mode_written or REG9_DIV_NUMER_Low_written or REG9_DIV_NUMER_High_written or  REG9_DIV_DENOM_Low_written or REG9_DIV_DENOM_High_written;
   
   REG9_DIV_RESULT_Low     <= std_logic_vector(quotient(31 downto  0));
   REG9_DIV_RESULT_High    <= std_logic_vector(quotient(63 downto 32));
   REG9_DIVREM_RESULT_Low  <= std_logic_vector(remainder(31 downto  0));
   REG9_DIVREM_RESULT_High <= std_logic_vector(remainder(63 downto 32));
   
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
               REG9_DIVCNT_Busy <= "0";
            end if;
         
            if (any_written = '1') then
               REG9_DIVCNT_Busy <= "1";
               start            <= '1';
               working          <= '1';
               case (to_integer(unsigned(REG9_DIVCNT_Division_Mode))) is
                  when 0 => -- 32/32
                     workcnt  <= 36;
                     dividend <= resize(signed(REG9_DIV_NUMER_Low), 64);
                     divisor  <= resize(signed(REG9_DIV_DENOM_Low), 64);
                     
                  when 1 => -- 64/32
                     workcnt  <= 68;
                     dividend(63 downto 32) <= signed(REG9_DIV_NUMER_High);
                     dividend (31 downto 0) <= signed(REG9_DIV_NUMER_Low);
                     divisor                <= resize(signed(REG9_DIV_DENOM_Low), 64);
            
                  when 2 => -- 64/64
                     workcnt  <= 68;
                     dividend(63 downto 32) <= signed(REG9_DIV_NUMER_High);
                     dividend (31 downto 0) <= signed(REG9_DIV_NUMER_Low);
                     divisor(63 downto 32) <= signed(REG9_DIV_DENOM_High);
                     divisor (31 downto 0) <= signed(REG9_DIV_DENOM_Low);
                     
                  when others => null;
               end case;
               
               REG9_DIVCNT_Division_by_zero <= "0";
               if (unsigned(REG9_DIV_DENOM_Low) = 0 and unsigned(REG9_DIV_DENOM_High) = 0) then
                  REG9_DIVCNT_Division_by_zero <= "1";
               end if;
               
            end if;
            
            if (ds_bus.ena = '1' and ds_bus.rnw = '1' and working = '1') then
               if (unsigned(ds_bus.adr) >= 16#2A0# and  unsigned(ds_bus.adr) <= 16#2AC#) then
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
      variable XPointer    : integer range dividend_u'range;
      variable QPointerNew : integer range quotient_u'range;
      variable AkkuNew     : unsigned (divisor'left + 1 downto divisor'right);
      variable Rdy_i       : std_logic;
      variable Q_bits      : std_logic_vector(bits_per_cycle-1 downto 0);
      variable Diff        : unsigned (AkkuNew'range);
   begin
      if rising_edge(clk100) then

         done_buffer <= '0';
         
         -- == Initialize loop ===============================================
         if start = '1' then
            
            dividend_u  <= '0' & unsigned(abs(dividend));
            divisor_u   <= '0' & unsigned(abs(divisor));
            
            QPointerNew := quotient_u'left;
            XPointer    := dividend_u'left;
            Rdy_i       := '0';
            --AkkuNew     := (Akku'left downto 1 => '0') & dividend(XPointer);
            AkkuNew     := (others => '0');
         -- == Repeat for every Digit in Q ===================================
         elsif Rdy_i = '0' then
            AkkuNew := Akku;
            QPointerNew := QPointer;        
            
            for i in 1 to bits_per_cycle loop
             
               -- Calculate output digit and new Akku ---------------------------
               Diff := AkkuNew - divisor_u;
               if Diff(Diff'left) = '0' then              -- Does Y fit in Akku?
                  Q_bits(bits_per_cycle-i)   := '1';                         -- YES: Digit is '1'
                  AkkuNew := unsigned(shift_left(Diff,1));--      Diff -> Akku
               else                                       --    
                  Q_bits(bits_per_cycle-i)   := '0';                         -- NO : Digit is '0'
                  AkkuNew := unsigned(Shift_left(AkkuNew,1));--      Shift Akku
               end if;
               -- ---------------------------------------------------------------
               if XPointer > dividend'right then                 -- divisor read completely?
                  XPointer := XPointer - 1;               -- NO : Put next digit
                  AkkuNew(AkkuNew'right) := dividend_u(XPointer);  --      in Akku         
               else
                  AkkuNew(AkkuNew'right) := '0'        ;  -- YES: Read Zeros (post point)      
               end if;
               -- ---------------------------------------------------------------
               if QPointerNew > quotient'right then                 -- Has this been the last cycle?
                  QPointerNew := QPointerNew - 1;               -- NO : Prepare next cycle
               else                                       -- 
                  Rdy_i := '1';                             -- YES: work done
                  done_buffer <= '1';
               end if;
               
            end loop; 
            
            quotient_u(QPointer downto QPointer-(bits_per_cycle-1)) <= unsigned(Q_bits);
         end if;

         QPointer  <= QPointerNew;
         Akku      <= AkkuNew;
         
         if ((dividend(dividend'left) xor divisor(divisor'left)) = '1') then
            quotient <= -signed(quotient_u(quotient'left downto 0));
         else
            quotient <= signed(quotient_u(quotient'left downto 0));
         end if;
         if (dividend(dividend'left) = '1') then
            remainder <= -signed(AkkuNew(remainder'left + 1 downto remainder'right + 1));
         else
            remainder <= signed(AkkuNew(remainder'left + 1 downto remainder'right + 1));
         end if;
         
         done <= done_buffer;
            
      end if;
      
      
      
   end process;
   

end architecture;





