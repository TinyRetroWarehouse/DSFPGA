-----------------------------------------------------------------
--------------- Export Package  --------------------------------
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

package pvcd_export is

   type t_exportregs is array(0 to 17) of std_logic_vector(31 downto 0);

   type cpu_export_type is record
      regs            : t_exportregs;
      opcode          : std_logic_vector(31 downto 0);
      flag_Negative   : std_logic;
      flag_Carry      : std_logic;
      flag_Zero       : std_logic;
      flag_V_Overflow : std_logic;
      flag_Q          : std_logic;
      newticks        : std_logic_vector(15 downto 0);
      thumbmode       : std_logic;
      armmode         : std_logic_vector(7 downto 0);
      irpdisable      : std_logic;
      R13_USR         : std_logic_vector(31 downto 0);
      R14_USR         : std_logic_vector(31 downto 0);  
      R13_IRQ         : std_logic_vector(31 downto 0);
      R14_IRQ         : std_logic_vector(31 downto 0);
      R13_SVC         : std_logic_vector(31 downto 0);
      R14_SVC         : std_logic_vector(31 downto 0);
      SPSR_IRQ        : std_logic_vector(31 downto 0);
      SPSR_SVC        : std_logic_vector(31 downto 0);
   end record;
   
   type t_exporttimer is array(0 to 3) of std_logic_vector(31 downto 0);
  
end package;

-----------------------------------------------------------------
--------------- Export module    --------------------------------
-----------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     
use STD.textio.all;

use work.pvcd_export.all;

entity ds_vcd_export is
   port 
   (
      clk100           : in std_logic;
      new_export       : in std_logic;
      
      commandcount     : out integer;
      
      export_cpu9      : in cpu_export_type;
      export_cpu7      : in cpu_export_type;

      totalticks9      : in unsigned(20 downto 0);
      totalticks7      : in unsigned(20 downto 0);      
      
      export_timer9    : in t_exporttimer;
      export_timer7    : in t_exporttimer;
      
      IF_intern9       : in std_logic_vector(31 downto 0);
      IF_intern7       : in std_logic_vector(31 downto 0);
      
      memory9_1        : in std_logic_vector(31 downto 0);
      memory9_2        : in std_logic_vector(31 downto 0);
      memory9_3        : in std_logic_vector(31 downto 0);
      memory7_1        : in std_logic_vector(31 downto 0);
      memory7_2        : in std_logic_vector(31 downto 0);
      memory7_3        : in std_logic_vector(31 downto 0);
      
      dmatranfers9     : in std_logic_vector(31 downto 0);
      dmatranfers7     : in std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_vcd_export is
     
   procedure print_bits
   (
      line_out : inout line; 
      var      : in    std_logic_vector 
   ) is
      variable first : boolean; 
   begin
      write(line_out, string'("b"));
      first := true;
      for i in var'left downto 0 loop
         if (var(i) = '1') then
            write(line_out, string'("1"));
            first := false;
         elsif (first = false) then
            write(line_out, string'("0"));
         end if;
      end loop;  
   end procedure;
   
   procedure print_fixed_bits
   (
      line_out : inout line; 
      var      : in    std_logic_vector 
   ) is
      variable first : boolean; 
   begin
      write(line_out, string'("b"));
      for i in var'left downto 0 loop
         if (var(i) = '1') then
            write(line_out, string'("1"));
         else
            write(line_out, string'("0"));
         end if;
      end loop;  
   end procedure;
   
   procedure print_bit
   (
      line_out : inout line; 
      var      : in    std_logic
   ) is
   begin
      if (var = '1') then
         write(line_out, string'("b1"));
      else
         write(line_out, string'("b0"));
      end if;     
   end procedure;
   
   signal tc          : integer := 0;
     
begin  
 
-- synthesis translate_off
   process
   
      file outfile         : text;
      variable f_status    : FILE_OPEN_STATUS;
      variable line_out    : line;
      variable recordcount : integer := 0;
      
      constant filenamebase    : string := "R:\debug_";
      variable filename        : string(1 to 26);
      
      variable nh : std_logic;
      
      variable new_instr9 : std_logic;
      variable new_instr7 : std_logic;
      
      variable old_cpu9    : cpu_export_type;
      variable old_cpu7    : cpu_export_type;
      
      variable old_totalticks9 : unsigned(20 downto 0);
      variable old_totalticks7 : unsigned(20 downto 0);     
      
      variable old_export_timer9_newticks : std_logic_vector(15 downto 0);
      variable old_export_timer7_newticks : std_logic_vector(15 downto 0);
      
      variable old_export_timer9 : t_exporttimer;
      variable old_export_timer7 : t_exporttimer;
      
      variable old_IF_intern9 : std_logic_vector(31 downto 0);
      variable old_IF_intern7 : std_logic_vector(31 downto 0);
      
      variable old_memory9_1 : std_logic_vector(31 downto 0);
      variable old_memory9_2 : std_logic_vector(31 downto 0);
      variable old_memory9_3 : std_logic_vector(31 downto 0);
      variable old_memory7_1 : std_logic_vector(31 downto 0);
      variable old_memory7_2 : std_logic_vector(31 downto 0);
      variable old_memory7_3 : std_logic_vector(31 downto 0);
      
      variable old_dmatranfers9 : std_logic_vector(31 downto 0);
      variable old_dmatranfers7 : std_logic_vector(31 downto 0);
      
   begin
   
      filename := filenamebase & to_hstring(to_unsigned(tc, 32)) & "_fpga.vcd";
      file_open(f_status, outfile, filename, write_mode);

      old_cpu9.regs := (others => (others => '0'));
      old_cpu7.regs := (others => (others => '0'));
      
      old_export_timer9_newticks := (others => '0');
      old_export_timer7_newticks := (others => '0');
      
      old_export_timer9 := (others => (others => '0'));
      old_export_timer7 := (others => (others => '0'));
      
      old_IF_intern9 := (others => '0');
      old_IF_intern7 := (others => '0');
      
      old_memory9_1 := (others => '0');
      old_memory9_2 := (others => '0');
      old_memory9_3 := (others => '0');
      old_memory7_1 := (others => '0');
      old_memory7_2 := (others => '0');
      old_memory7_3 := (others => '0');
      
      old_dmatranfers9 := (others => '0');
      old_dmatranfers7 := (others => '0');
      
      while (true) loop
         wait until rising_edge(clk100);
         
         if (new_export = '1') then
         
            wait until rising_edge(clk100); -- wait for timer
                     
            nh := '0';
            if (tc mod 200000 = 0) then
               nh := '1';
               old_totalticks9 := (others => '0');
               old_totalticks7 := (others => '0');
               
               filename := filenamebase & to_hstring(to_unsigned(tc, 32)) & "_fpga.vcd";
               file_close(outfile);
               file_open(f_status, outfile, filename, write_mode);
               file_close(outfile);
               file_open(f_status, outfile, filename, append_mode);
               
               write(line_out, string'("$date Feb 29, 2134 $end")); writeline(outfile, line_out);
               write(line_out, string'("$version 0.1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$comment no $end")); writeline(outfile, line_out);
               write(line_out, string'("$timescale 1ps $end")); writeline(outfile, line_out);
               write(line_out, string'("$scope module logic $end")); writeline(outfile, line_out);
               
               write(line_out, string'("$var wire 32 0R0 cpu0_reg0 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R1 cpu0_reg1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R2 cpu0_reg2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R3 cpu0_reg3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R4 cpu0_reg4 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R5 cpu0_reg5 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R6 cpu0_reg6 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R7 cpu0_reg7 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R8 cpu0_reg8 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R9 cpu0_reg9 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R10 cpu0_reg10 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R11 cpu0_reg11 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R12 cpu0_reg12 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R13 cpu0_reg13 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R14 cpu0_reg14 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R15 cpu0_reg15 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0O cpu0_Opcode $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0FN cpu0_Flag_Neg $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0FC cpu0_Flag_Carry $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0FZ cpu0_Flag_Zero $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0FV cpu0_Flag_Overflow $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0FQ cpu0_Flag_Q $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 16 0TK cpu0_Ticks $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 0PF cpu0_Prefetch $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0AT cpu0_isThumb $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 0M cpu0_Mode $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 0I cpu0_IRQ_disable $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 16 0IF cpu0_IRQ_Flags $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 0IW cpu0_IRQ_wait $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0T0 cpu0_Timer_0 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0T1 cpu0_Timer_1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0T2 cpu0_Timer_2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0T3 cpu0_Timer_3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0M1 cpu0_Memory_1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0M2 cpu0_Memory_2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0M3 cpu0_Memory_3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0DMA cpu0_DMA_count $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R16 cpu0_reg16 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R17 cpu0_reg17 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R13u cpu0_R13usr $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R14u cpu0_R14usr $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R13i cpu0_R13irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R14i cpu0_R14irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R13s cpu0_R13svc $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0R14s cpu0_R14svc $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0SPi cpu0_SPSR_irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 0SPs cpu0_SPSR_svc $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R0 cpu1_reg0 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R1 cpu1_reg1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R2 cpu1_reg2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R3 cpu1_reg3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R4 cpu1_reg4 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R5 cpu1_reg5 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R6 cpu1_reg6 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R7 cpu1_reg7 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R8 cpu1_reg8 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R9 cpu1_reg9 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R10 cpu1_reg10 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R11 cpu1_reg11 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R12 cpu1_reg12 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R13 cpu1_reg13 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R14 cpu1_reg14 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R15 cpu1_reg15 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1O cpu1_Opcode $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1FN cpu1_Flag_Neg $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1FC cpu1_Flag_Carry $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1FZ cpu1_Flag_Zero $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1FV cpu1_Flag_Overflow $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1FQ cpu1_Flag_Q $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 16 1TK cpu1_Ticks $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 1PF cpu1_Prefetch $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1AT cpu1_isThumb $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 1M cpu1_Mode $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 1 1I cpu1_IRQ_disable $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 16 1IF cpu1_IRQ_Flags $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 8 1IW cpu1_IRQ_wait $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1T0 cpu1_Timer_0 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1T1 cpu1_Timer_1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1T2 cpu1_Timer_2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1T3 cpu1_Timer_3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1M1 cpu1_Memory_1 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1M2 cpu1_Memory_2 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1M3 cpu1_Memory_3 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1DMA cpu1_DMA_count $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R16 cpu1_reg16 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R17 cpu1_reg17 $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R13u cpu1_R13usr $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R14u cpu1_R14usr $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R13i cpu1_R13irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R14i cpu1_R14irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R13s cpu1_R13svc $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1R14s cpu1_R14svc $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1SPi cpu1_SPSR_irq $end")); writeline(outfile, line_out);
               write(line_out, string'("$var wire 32 1SPs cpu1_SPSR_svc $end")); writeline(outfile, line_out);
               
               write(line_out, string'("$upscope $end")); writeline(outfile, line_out);
               write(line_out, string'("$enddefinitions $end")); writeline(outfile, line_out);
               
            end if;

            write(line_out, string'("#")); write(line_out, tc); writeline(outfile, line_out);

            -- cpu 9
            new_instr9 := '0';
            if (export_cpu9.regs(15) /= old_cpu9.regs(15)) then new_instr9 := '1'; end if;

            for i in 0 to 15 loop
               if (nh = '1' or old_cpu9.regs(i) /= export_cpu9.regs(i)) then
                  print_bits(line_out, std_logic_vector(export_cpu9.regs(i)));
                  write(line_out, string'(" 0R"));
                  write(line_out, i);
                  writeline(outfile, line_out);
                  old_cpu9.regs(i) := export_cpu9.regs(i);
               end if;
            end loop;
            
            if (nh = '1' or export_cpu9.opcode /= old_cpu9.opcode) then
               if (export_cpu9.thumbmode = '1') then 
                  print_bits(line_out, std_logic_vector(export_cpu9.opcode(15 downto 0)));
               else
                  print_bits(line_out, std_logic_vector(export_cpu9.opcode));
               end if;
               write(line_out, string'(" 0O"));
               writeline(outfile, line_out);
               old_cpu9.opcode := export_cpu9.opcode;
            end if;
            
            if (nh = '1' or export_cpu9.flag_Negative /= old_cpu9.flag_Negative) then print_bit(line_out, export_cpu9.flag_Negative); write(line_out, string'(" 0FN")); writeline(outfile, line_out); old_cpu9.flag_Negative := export_cpu9.flag_Negative; end if;
            if (nh = '1' or export_cpu9.flag_Carry /= old_cpu9.flag_Carry) then print_bit(line_out, export_cpu9.flag_Carry); write(line_out, string'(" 0FC")); writeline(outfile, line_out); old_cpu9.flag_Carry := export_cpu9.flag_Carry; end if;
            if (nh = '1' or export_cpu9.flag_Zero /= old_cpu9.flag_Zero) then print_bit(line_out, export_cpu9.flag_Zero); write(line_out, string'(" 0FZ")); writeline(outfile, line_out); old_cpu9.flag_Zero := export_cpu9.flag_Zero; end if;
            if (nh = '1' or export_cpu9.flag_V_Overflow /= old_cpu9.flag_V_Overflow) then print_bit(line_out, export_cpu9.flag_V_Overflow); write(line_out, string'(" 0FV")); writeline(outfile, line_out); old_cpu9.flag_V_Overflow := export_cpu9.flag_V_Overflow; end if;
            if (nh = '1' or export_cpu9.flag_Q /= old_cpu9.flag_Q) then print_bit(line_out, export_cpu9.flag_Q); write(line_out, string'(" 0FQ")); writeline(outfile, line_out); old_cpu9.flag_Q := export_cpu9.flag_Q; end if;
            
            if (totalticks9 < old_totalticks9) then old_totalticks9(20) := '0'; end if;
            if (nh = '1' or totalticks9 /= old_totalticks9) then print_bits(line_out, std_logic_vector(totalticks9 - old_totalticks9)); write(line_out, string'(" 0TK")); writeline(outfile, line_out); old_totalticks9 := totalticks9; end if;
            
            --if (nh = '1' or export_cpu9.busprefetch /= old_cpu9.busprefetch) then print_fixed_bits(line_out, export_cpu9.busprefetch); write(line_out, string'(" 0PF")); writeline(outfile, line_out); old_cpu9.busprefetch := export_cpu9.busprefetch; end if;
            if (nh = '1' or export_cpu9.thumbmode /= old_cpu9.thumbmode) then print_bit(line_out, export_cpu9.thumbmode); write(line_out, string'(" 0AT")); writeline(outfile, line_out); old_cpu9.thumbmode := export_cpu9.thumbmode; end if;
            if (nh = '1' or export_cpu9.armmode /= old_cpu9.armmode) then print_fixed_bits(line_out, export_cpu9.armmode); write(line_out, string'(" 0M")); writeline(outfile, line_out); old_cpu9.armmode := export_cpu9.armmode; end if;
            if (nh = '1' or export_cpu9.irpdisable /= old_cpu9.irpdisable) then print_bit(line_out, export_cpu9.irpdisable); write(line_out, string'(" 0I")); writeline(outfile, line_out); old_cpu9.irpdisable := export_cpu9.irpdisable; end if;
            if (nh = '1' or IF_intern9 /= old_IF_intern9) then print_fixed_bits(line_out, IF_intern9); write(line_out, string'(" 0IF")); writeline(outfile, line_out); old_IF_intern9 := IF_intern9; end if;
            --if (nh = '1' or export_cpu9.irp_wait /= old_cpu9.irp_wait) then print_fixed_bits(line_out, export_cpu9.irp_wait); write(line_out, string'(" 0IW")); writeline(outfile, line_out); old_cpu9.irp_wait := export_cpu9.irp_wait; end if;
            
            --if (nh = '1' or export_timer9(0) /= old_export_timer9(0)) then print_fixed_bits(line_out, export_timer9(0)); write(line_out, string'(" 0T0")); writeline(outfile, line_out); old_export_timer9(0) := export_timer9(0); end if;
            --if (nh = '1' or export_timer9(1) /= old_export_timer9(1)) then print_fixed_bits(line_out, export_timer9(1)); write(line_out, string'(" 0T1")); writeline(outfile, line_out); old_export_timer9(1) := export_timer9(1); end if;
            --if (nh = '1' or export_timer9(2) /= old_export_timer9(2)) then print_fixed_bits(line_out, export_timer9(2)); write(line_out, string'(" 0T2")); writeline(outfile, line_out); old_export_timer9(2) := export_timer9(2); end if;
            --if (nh = '1' or export_timer9(3) /= old_export_timer9(3)) then print_fixed_bits(line_out, export_timer9(3)); write(line_out, string'(" 0T3")); writeline(outfile, line_out); old_export_timer9(3) := export_timer9(3); end if;
            
            if (nh = '1' or memory9_1 /= old_memory9_1) then print_fixed_bits(line_out, memory9_1); write(line_out, string'(" 0M1")); writeline(outfile, line_out); old_memory9_1 := memory9_1; end if;
            if (nh = '1' or memory9_2 /= old_memory9_2) then print_fixed_bits(line_out, memory9_2); write(line_out, string'(" 0M2")); writeline(outfile, line_out); old_memory9_2 := memory9_2; end if;
            if (nh = '1' or memory9_3 /= old_memory9_3) then print_fixed_bits(line_out, memory9_3); write(line_out, string'(" 0M3")); writeline(outfile, line_out); old_memory9_3 := memory9_3; end if;
            
            if (nh = '1' or dmatranfers9 /= old_dmatranfers9) then print_fixed_bits(line_out, dmatranfers9); write(line_out, string'(" 0DMA")); writeline(outfile, line_out); old_dmatranfers9 := dmatranfers9; end if;
            
            if (nh = '1' or export_cpu9.regs(16) /= old_cpu9.regs(16) ) then print_fixed_bits(line_out, export_cpu9.regs(16) ); write(line_out, string'(" 0R16")); writeline(outfile, line_out); old_cpu9.regs(16) := export_cpu9.regs(16) ; end if;
            
            if (nh = '1' or export_cpu9.R13_USR  /= old_cpu9.R13_USR  ) then print_fixed_bits(line_out, export_cpu9.R13_USR  ); write(line_out, string'(" 0R13u")); writeline(outfile, line_out); old_cpu9.R13_USR  := export_cpu9.R13_USR  ; end if;
            if (nh = '1' or export_cpu9.R14_USR  /= old_cpu9.R14_USR  ) then print_fixed_bits(line_out, export_cpu9.R14_USR  ); write(line_out, string'(" 0R14u")); writeline(outfile, line_out); old_cpu9.R14_USR  := export_cpu9.R14_USR  ; end if;
            if (nh = '1' or export_cpu9.R13_IRQ  /= old_cpu9.R13_IRQ  ) then print_fixed_bits(line_out, export_cpu9.R13_IRQ  ); write(line_out, string'(" 0R13i")); writeline(outfile, line_out); old_cpu9.R13_IRQ  := export_cpu9.R13_IRQ  ; end if;
            if (nh = '1' or export_cpu9.R14_IRQ  /= old_cpu9.R14_IRQ  ) then print_fixed_bits(line_out, export_cpu9.R14_IRQ  ); write(line_out, string'(" 0R14i")); writeline(outfile, line_out); old_cpu9.R14_IRQ  := export_cpu9.R14_IRQ  ; end if;
            if (nh = '1' or export_cpu9.R13_SVC  /= old_cpu9.R13_SVC  ) then print_fixed_bits(line_out, export_cpu9.R13_SVC  ); write(line_out, string'(" 0R13s")); writeline(outfile, line_out); old_cpu9.R13_SVC  := export_cpu9.R13_SVC  ; end if;
            if (nh = '1' or export_cpu9.R14_SVC  /= old_cpu9.R14_SVC  ) then print_fixed_bits(line_out, export_cpu9.R14_SVC  ); write(line_out, string'(" 0R14s")); writeline(outfile, line_out); old_cpu9.R14_SVC  := export_cpu9.R14_SVC  ; end if;
            if (nh = '1' or export_cpu9.SPSR_IRQ /= old_cpu9.SPSR_IRQ ) then print_fixed_bits(line_out, export_cpu9.SPSR_IRQ ); write(line_out, string'(" 0SPi"));  writeline(outfile, line_out); old_cpu9.SPSR_IRQ := export_cpu9.SPSR_IRQ ; end if;
            if (nh = '1' or export_cpu9.SPSR_SVC /= old_cpu9.SPSR_SVC ) then print_fixed_bits(line_out, export_cpu9.SPSR_SVC ); write(line_out, string'(" 0SPs"));  writeline(outfile, line_out); old_cpu9.SPSR_SVC := export_cpu9.SPSR_SVC ; end if;
            
            -- cpu 7
            new_instr7 := '0';
            if (export_cpu7.regs(15) /= old_cpu7.regs(15)) then new_instr7 := '1'; end if;

            for i in 0 to 15 loop
               if (nh = '1' or old_cpu7.regs(i) /= export_cpu7.regs(i)) then
                  print_bits(line_out, std_logic_vector(export_cpu7.regs(i)));
                  write(line_out, string'(" 1R"));
                  write(line_out, i);
                  writeline(outfile, line_out);
                  old_cpu7.regs(i) := export_cpu7.regs(i);
               end if;
            end loop;
            
            if (nh = '1' or export_cpu7.opcode /= old_cpu7.opcode) then
               if (export_cpu7.thumbmode = '1') then 
                  print_bits(line_out, std_logic_vector(export_cpu7.opcode(15 downto 0)));
               else
                  print_bits(line_out, std_logic_vector(export_cpu7.opcode));
               end if;
               write(line_out, string'(" 1O"));
               writeline(outfile, line_out);
               old_cpu7.opcode := export_cpu7.opcode;
            end if;
            
            if (nh = '1' or export_cpu7.flag_Negative /= old_cpu7.flag_Negative) then print_bit(line_out, export_cpu7.flag_Negative); write(line_out, string'(" 1FN")); writeline(outfile, line_out); old_cpu7.flag_Negative := export_cpu7.flag_Negative; end if;
            if (nh = '1' or export_cpu7.flag_Carry /= old_cpu7.flag_Carry) then print_bit(line_out, export_cpu7.flag_Carry); write(line_out, string'(" 1FC")); writeline(outfile, line_out); old_cpu7.flag_Carry := export_cpu7.flag_Carry; end if;
            if (nh = '1' or export_cpu7.flag_Zero /= old_cpu7.flag_Zero) then print_bit(line_out, export_cpu7.flag_Zero); write(line_out, string'(" 1FZ")); writeline(outfile, line_out); old_cpu7.flag_Zero := export_cpu7.flag_Zero; end if;
            if (nh = '1' or export_cpu7.flag_V_Overflow /= old_cpu7.flag_V_Overflow) then print_bit(line_out, export_cpu7.flag_V_Overflow); write(line_out, string'(" 1FV")); writeline(outfile, line_out); old_cpu7.flag_V_Overflow := export_cpu7.flag_V_Overflow; end if;
            if (nh = '1' or export_cpu7.flag_Q /= old_cpu7.flag_Q) then print_bit(line_out, export_cpu7.flag_Q); write(line_out, string'(" 1FQ")); writeline(outfile, line_out); old_cpu7.flag_Q := export_cpu7.flag_Q; end if;
            
            if (totalticks7 < old_totalticks7) then old_totalticks7(20) := '0'; end if;
            if (nh = '1' or totalticks7 /= old_totalticks7) then print_bits(line_out, std_logic_vector(totalticks7 - old_totalticks7)); write(line_out, string'(" 1TK")); writeline(outfile, line_out); old_totalticks7 := totalticks7; end if;
            
            --if (nh = '1' or export_cpu7.busprefetch /= old_cpu7.busprefetch) then print_fixed_bits(line_out, export_cpu7.busprefetch); write(line_out, string'(" 1PF")); writeline(outfile, line_out); old_cpu7.busprefetch := export_cpu7.busprefetch; end if;
            if (nh = '1' or export_cpu7.thumbmode /= old_cpu7.thumbmode) then print_bit(line_out, export_cpu7.thumbmode); write(line_out, string'(" 1AT")); writeline(outfile, line_out); old_cpu7.thumbmode := export_cpu7.thumbmode; end if;
            if (nh = '1' or export_cpu7.armmode /= old_cpu7.armmode) then print_fixed_bits(line_out, export_cpu7.armmode); write(line_out, string'(" 1M")); writeline(outfile, line_out); old_cpu7.armmode := export_cpu7.armmode; end if;
            if (nh = '1' or export_cpu7.irpdisable /= old_cpu7.irpdisable) then print_bit(line_out, export_cpu7.irpdisable); write(line_out, string'(" 1I")); writeline(outfile, line_out); old_cpu7.irpdisable := export_cpu7.irpdisable; end if;
            if (nh = '1' or IF_intern7 /= old_IF_intern7) then print_fixed_bits(line_out, IF_intern7); write(line_out, string'(" 1IF")); writeline(outfile, line_out); old_IF_intern7 := IF_intern7; end if;
            --if (nh = '1' or export_cpu7.irp_wait /= old_cpu7.irp_wait) then print_fixed_bits(line_out, export_cpu7.irp_wait); write(line_out, string'(" 1IW")); writeline(outfile, line_out); old_cpu7.irp_wait := export_cpu7.irp_wait; end if;
            
            --if (nh = '1' or export_timer7(0) /= old_export_timer7(0)) then print_fixed_bits(line_out, export_timer7(0)); write(line_out, string'(" 1T0")); writeline(outfile, line_out); old_export_timer7(0) := export_timer7(0); end if;
            --if (nh = '1' or export_timer7(1) /= old_export_timer7(1)) then print_fixed_bits(line_out, export_timer7(1)); write(line_out, string'(" 1T1")); writeline(outfile, line_out); old_export_timer7(1) := export_timer7(1); end if;
            --if (nh = '1' or export_timer7(2) /= old_export_timer7(2)) then print_fixed_bits(line_out, export_timer7(2)); write(line_out, string'(" 1T2")); writeline(outfile, line_out); old_export_timer7(2) := export_timer7(2); end if;
            --if (nh = '1' or export_timer7(3) /= old_export_timer7(3)) then print_fixed_bits(line_out, export_timer7(3)); write(line_out, string'(" 1T3")); writeline(outfile, line_out); old_export_timer7(3) := export_timer7(3); end if;
            
            if (nh = '1' or memory7_1 /= old_memory7_1) then print_fixed_bits(line_out, memory7_1); write(line_out, string'(" 1M1")); writeline(outfile, line_out); old_memory7_1 := memory7_1; end if;
            if (nh = '1' or memory7_2 /= old_memory7_2) then print_fixed_bits(line_out, memory7_2); write(line_out, string'(" 1M2")); writeline(outfile, line_out); old_memory7_2 := memory7_2; end if;
            if (nh = '1' or memory7_3 /= old_memory7_3) then print_fixed_bits(line_out, memory7_3); write(line_out, string'(" 1M3")); writeline(outfile, line_out); old_memory7_3 := memory7_3; end if;
            
            if (nh = '1' or dmatranfers7 /= old_dmatranfers7) then print_fixed_bits(line_out, dmatranfers7); write(line_out, string'(" 1DMA")); writeline(outfile, line_out); old_dmatranfers7 := dmatranfers7; end if;
            
            if (nh = '1' or export_cpu7.regs(16) /= old_cpu7.regs(16) ) then print_fixed_bits(line_out, export_cpu7.regs(16) ); write(line_out, string'(" 1R16")); writeline(outfile, line_out); old_cpu7.regs(16) := export_cpu7.regs(16) ; end if;

            if (nh = '1' or export_cpu7.R13_USR  /= old_cpu7.R13_USR  ) then print_fixed_bits(line_out, export_cpu7.R13_USR  ); write(line_out, string'(" 1R13u")); writeline(outfile, line_out); old_cpu7.R13_USR  := export_cpu7.R13_USR  ; end if;
            if (nh = '1' or export_cpu7.R14_USR  /= old_cpu7.R14_USR  ) then print_fixed_bits(line_out, export_cpu7.R14_USR  ); write(line_out, string'(" 1R14u")); writeline(outfile, line_out); old_cpu7.R14_USR  := export_cpu7.R14_USR  ; end if;
            if (nh = '1' or export_cpu7.R13_IRQ  /= old_cpu7.R13_IRQ  ) then print_fixed_bits(line_out, export_cpu7.R13_IRQ  ); write(line_out, string'(" 1R13i")); writeline(outfile, line_out); old_cpu7.R13_IRQ  := export_cpu7.R13_IRQ  ; end if;
            if (nh = '1' or export_cpu7.R14_IRQ  /= old_cpu7.R14_IRQ  ) then print_fixed_bits(line_out, export_cpu7.R14_IRQ  ); write(line_out, string'(" 1R14i")); writeline(outfile, line_out); old_cpu7.R14_IRQ  := export_cpu7.R14_IRQ  ; end if;
            if (nh = '1' or export_cpu7.R13_SVC  /= old_cpu7.R13_SVC  ) then print_fixed_bits(line_out, export_cpu7.R13_SVC  ); write(line_out, string'(" 1R13s")); writeline(outfile, line_out); old_cpu7.R13_SVC  := export_cpu7.R13_SVC  ; end if;
            if (nh = '1' or export_cpu7.R14_SVC  /= old_cpu7.R14_SVC  ) then print_fixed_bits(line_out, export_cpu7.R14_SVC  ); write(line_out, string'(" 1R14s")); writeline(outfile, line_out); old_cpu7.R14_SVC  := export_cpu7.R14_SVC  ; end if;
            if (nh = '1' or export_cpu7.SPSR_IRQ /= old_cpu7.SPSR_IRQ ) then print_fixed_bits(line_out, export_cpu7.SPSR_IRQ ); write(line_out, string'(" 1SPi"));  writeline(outfile, line_out); old_cpu7.SPSR_IRQ := export_cpu7.SPSR_IRQ ; end if;
            if (nh = '1' or export_cpu7.SPSR_SVC /= old_cpu7.SPSR_SVC ) then print_fixed_bits(line_out, export_cpu7.SPSR_SVC ); write(line_out, string'(" 1SPs"));  writeline(outfile, line_out); old_cpu7.SPSR_SVC := export_cpu7.SPSR_SVC ; end if;
            
            recordcount := recordcount + 1;
            tc          <= tc + 1;
            
            if (recordcount mod 1000 = 0) then
               file_close(outfile);
               file_open(f_status, outfile, filename, append_mode);
               recordcount := 0;
            end if;
         
         end if;
         
         commandcount <= tc;
         
      end loop;
      
   end process;
-- synthesis translate_on

end architecture;





