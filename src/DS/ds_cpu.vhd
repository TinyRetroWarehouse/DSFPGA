library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pReg_savestates.all;

use work.pvcd_export.all;

entity ds_cpu is
   generic
   (
      is_simu : std_logic;
      isArm9  : std_logic
   );
   port 
   (
      clk100           : in    std_logic;  
      ds_on            : in    std_logic;
      reset            : in    std_logic;
      
      PCEntry          : in    std_logic_vector(31 downto 0);
      
      savestate_bus    : in    proc_bus_ds_type;
      
      OBus_1_Adr       : out   std_logic_vector(31 downto 0);
      OBus_1_rnw       : out   std_logic;
      OBus_1_ena       : out   std_logic;
      OBus_1_acc       : out   std_logic_vector(1 downto 0);
      OBus_1_dout      : out   std_logic_vector(31 downto 0);
      OBus_1_din       : in    std_logic_vector(31 downto 0);
      OBus_1_done      : in    std_logic;
      
      OBus_2_Adr       : out   std_logic_vector(31 downto 0);
      OBus_2_ena       : out   std_logic;
      OBus_2_acc       : out   std_logic_vector(1 downto 0);
      OBus_2_din       : in    std_logic_vector(31 downto 0);
      OBus_2_done      : in    std_logic;
      
      ram128code_data  : in    std_logic_vector(127 downto 0);
      ram128code_done  : in    std_logic;
      ram128data_data  : in    std_logic_vector(127 downto 0);
      ram128data_done  : in    std_logic;
      
      snoop_Adr        : in    std_logic_vector(21 downto 0);
      snoop_data       : in    std_logic_vector(31 downto 0);
      snoop_we         : in    std_logic;
      snoop_be         : in    std_logic_vector(3 downto 0);
        
      bus_lowbits      : out   std_logic_vector(1 downto 0) := "00";
        
      settle           : in    std_logic;
      dma_on           : in    std_logic;
      do_step          : in    std_logic;
      done             : buffer std_logic := '0';
      CPU_bus_idle     : out   std_logic;
      PC_in_BIOS       : out   std_logic;
      lastread         : out   std_logic_vector(31 downto 0);
      jump_out         : out   std_logic;
      
      DTCMRegion       : out   std_logic_vector(31 downto 0);
      
      new_cycles_out   : buffer unsigned(7 downto 0) := (others => '0');
      new_cycles_valid : buffer std_logic := '0';
      
      cpu_IRQ          : in    std_logic;
      new_halt         : in    std_logic;
      halt_out         : out   std_logic;
      irq_out          : out   std_logic;
      irq_off          : out   std_logic;
      
      debug_cpu_pc     : out   std_logic_vector(31 downto 0);
      debug_cpu_mixed  : out   std_logic_vector(31 downto 0);
      
      exportdata       : out   cpu_export_type
   );
end entity;

architecture arch of ds_cpu is

   constant gbbusadr_bits : integer := ds_proc_busadr;

   -- ####################################
   -- ARM processor regs and states 
   -- ####################################
    
   constant CPUMODE_USER       : std_logic_vector(3 downto 0) := x"0";
   constant CPUMODE_FIQ        : std_logic_vector(3 downto 0) := x"1";
   constant CPUMODE_IRQ        : std_logic_vector(3 downto 0) := x"2";
   constant CPUMODE_SUPERVISOR : std_logic_vector(3 downto 0) := x"3";
   constant CPUMODE_ABORT      : std_logic_vector(3 downto 0) := x"7";
   constant CPUMODE_UNDEFINED  : std_logic_vector(3 downto 0) := x"B";
   constant CPUMODE_SYSTEM     : std_logic_vector(3 downto 0) := x"F";
   
   signal thumbmode        : std_logic := '0';
   signal halt             : std_logic := '0';
         
   signal IRQ_disable      : std_logic := '1';
   signal FIQ_disable      : std_logic := '1';
   
   signal Flag_Zero        : std_logic := '0';
   signal Flag_Carry       : std_logic := '0';
   signal Flag_Negative    : std_logic := '0';
   signal Flag_V_Overflow  : std_logic := '0';
   signal Flag_Q           : std_logic := '0';
   
   signal cpu_mode         : std_logic_vector(3 downto 0) := CPUMODE_SUPERVISOR;
   signal cpu_mode_old     : std_logic_vector(3 downto 0) := (others => '0');

   type t_regs is array(0 to 17) of unsigned(31 downto 0);
   signal regs : t_regs := (others => (others => '0'));
   signal regs_plus_12  : unsigned(31 downto 0);
   signal block_pc_next : unsigned(31 downto 0);

   signal PC               : unsigned(31 downto 0) := (others => '0');

   signal regs_0_8  : unsigned(31 downto 0) := (others => '0');
   signal regs_0_9  : unsigned(31 downto 0) := (others => '0');
   signal regs_0_10 : unsigned(31 downto 0) := (others => '0');
   signal regs_0_11 : unsigned(31 downto 0) := (others => '0');
   signal regs_0_12 : unsigned(31 downto 0) := (others => '0');
   signal regs_0_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_0_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_8  : unsigned(31 downto 0) := (others => '0');
   signal regs_1_9  : unsigned(31 downto 0) := (others => '0');
   signal regs_1_10 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_11 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_12 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_1_17 : unsigned(31 downto 0) := (others => '0');
   signal regs_2_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_2_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_2_17 : unsigned(31 downto 0) := (others => '0');
   signal regs_3_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_3_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_3_17 : unsigned(31 downto 0) := (others => '0');
   signal regs_4_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_4_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_4_17 : unsigned(31 downto 0) := (others => '0');
   signal regs_5_13 : unsigned(31 downto 0) := (others => '0');
   signal regs_5_14 : unsigned(31 downto 0) := (others => '0');
   signal regs_5_17 : unsigned(31 downto 0) := (others => '0');
   
   -- ####################################
   -- busmuxing
   -- ####################################
   
   signal OBus_data_din  : std_logic_vector(31 downto 0);
   signal OBus_data_done : std_logic;
   
   signal OBus_code_din  : std_logic_vector(31 downto 0);
   signal OBus_code_done : std_logic;
   
       
   -- ####################################
   -- internal calculation signals
   -- ####################################
   
   signal jump         : std_logic := '0';
   signal new_pc       : unsigned(31 downto 0) := (others => '0');
   signal branchnext   : std_logic := '0';
   signal blockr15jump : std_logic := '0';
   
   -- ############# Timing ##############
   
   signal decode_fetch_cycles  : integer range 0 to 63  := 0;
   signal execute_fetch_cycles : integer range 0 to 63  := 0;
   signal execute_cycles       : integer range 0 to 255 := 0;
   signal execute_addcycles    : integer range 0 to 31  := 0;
   signal bus_addcycles        : integer range 0 to 127 := 0;
   
   signal dataticksAccess16        : integer range 0 to 32 := 0;
   signal dataticksAccess32        : integer range 0 to 32 := 0;
   signal dataticksAccessSeq32     : integer range 0 to 32 := 0;
   signal codeticksAccess16        : integer range 0 to 32 := 0;
   signal codeticksAccess32        : integer range 0 to 32 := 0;
   signal codeticksAccessSeq16     : integer range 0 to 32 := 0;
   signal codeticksAccessSeq32     : integer range 0 to 32 := 0;
   signal codeticksAccessJump16    : integer range 0 to 32 := 0;
   signal codeticksAccessJump32    : integer range 0 to 32 := 0;
   signal codeticksAccessSeqJump16 : integer range 0 to 32 := 0;
   signal codeticksAccessSeqJump32 : integer range 0 to 32 := 0;
   
   signal codeticksAccess1632    : integer range 0 to 32 := 0;
   signal codeticksAccessSeq1632 : integer range 0 to 32 := 0;
   
   signal codeBaseAccess1632    : integer range 0 to 32 := 0;
   signal codeBaseAccessSeq1632 : integer range 0 to 32 := 0;
   
   type t_timingarray is array(0 to 15) of integer range 0 to 32;
   signal memoryWait16    : t_timingarray;
   signal memoryWait32    : t_timingarray;
   
   signal lastfetchAddress : unsigned(31 downto 0) := (others => '0');
   signal lastAddress      : unsigned(31 downto 0) := (others => '0');
   
   signal fetch_instr_cache  : std_logic;
   signal decode_instr_cache : std_logic;
   
   signal dataaccess_cyclecheck : std_logic := '0';
   
   -- ############# Fetch ##############
   
   signal wait_fetch            : std_logic := '0';   
   signal skip_pending_fetch    : std_logic := '0';   
   signal fetch_req             : std_logic := '0';   
   signal fetch_available       : std_logic := '0'; 
   signal fetch_data            : std_logic_vector(31 downto 0) := (others => '0');  
   
   signal instr_cache_req       : std_logic := '0';   
   signal instr_cache_dataout   : std_logic_vector(31 downto 0);  
   signal instr_cache_datavalid : std_logic;  
   signal instr_cache_readena   : std_logic;  
   signal instr_cache_addr      : std_logic_vector(21 downto 0);  
   signal instr_cache_cached    : std_logic;  
   
   signal fetch_valid           : std_logic;
   signal last_fetch_onbus      : std_logic;
   
   -- ############# Decode ##############
   
   signal decode_request   : std_logic := '0';
   signal decode_ack       : std_logic := '0';
   signal decode_data      : std_logic_vector(31 downto 0) := (others => '0');
   signal decode_PC        : unsigned(31 downto 0) := (others => '0');
   signal decode_condition : std_logic_vector(3 downto 0);
   
   type tState_decode is
   (
      WAITFETCH,
      DECODE_DETAILS,
      DECODE_DONE
   );
   signal state_decode : tState_decode;
   
   -- ############# Execute ##############
   
   signal execute_request : std_logic;
   signal execute_start   : std_logic := '0';
   signal calc_done       : std_logic := '0';
   signal executebus      : std_logic := '0';
   signal execute_PC      : unsigned(31 downto 0) := (others => '0');
   signal execute_PCprev  : unsigned(31 downto 0) := (others => '0');
   signal execute_data    : std_logic_vector(31 downto 0) := (others => '0');
   
   signal halt_cnt        : integer range 0 to 5 := 0;
   signal irq_calc        : std_logic := '0';
   signal irq_delay       : integer range 0 to 4;
   signal irq_triggerhold : std_logic := '0';
   
   signal calc_result               : unsigned(31 downto 0);
   signal writeback_reg             : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_writeback_calc    : std_logic := '0';
   signal execute_writeback_r17     : std_logic := '0';
   signal execute_writeback_userreg : std_logic := '0';
   signal execute_switchregs        : std_logic := '0';
   signal execute_saveregs          : std_logic := '0';
   signal execute_saveState         : std_logic := '0';
   signal execute_SWI               : std_logic := '0';
   signal execute_IRP               : std_logic := '0';
   
   type tState_execute is
   (
      FETCH_OP,
      CALC
   );
   signal state_execute : tState_execute;
   
   -- ############# Functions ##############
   
   type tFunctions is
   (
      opcode_unknown,
      -- arm/combined
      branch_and_exchange,
      data_processing,
      single_data_swap,
      multiply_long,
      multiply,
      halfword_data_transfer_regoffset,
      halfword_data_transfer_immoffset,
      single_data_transfer,
      block_data_transfer,
      branch,
      software_interrupt,
      -- thumb
      long_branch_with_link,
      -- Arm9
      blx_1,
      blx_2,
      clz,
      qaddsuball,
      smulall,
      ldrdstrd,
      coprocessor_data_transfer,
      coprocessor_data_operation,
      coprocessor_register_transfer_read,
      coprocessor_register_transfer_write
   );

   type tFunctions_detail is
   (
      decode_unknown,
      alu_and,
      alu_xor,
      alu_sub,
      alu_add,
      alu_add_withcarry,
      alu_sub_withcarry,
      alu_or,
      alu_mov,
      alu_and_not,
      alu_mov_not,
      mulboth,
      data_processing_MRS,
      data_processing_MSR,
      branch_all,
      data_read,
      data_write,
      block_read,
      block_write,
      software_interrupt_detail,
      long_branch_with_link_low,
      -- Arm9
      count_leading_zeros,
      alu_qadd,
      alu_qsub,
      alu_qdadd,
      alu_qdsub,
      mul_arm9,
      coprocessor_data,
      coprocessor_register_read,
      coprocessor_register_write
   );
   
   type tdatareceivetype is
   (
      RECEIVETYPE_BYTE,
      RECEIVETYPE_DWORD,
      RECEIVETYPE_WORD,
      RECEIVETYPE_SIGNEDBYTE,
      RECEIVETYPE_SIGNEDWORD
   );
   
   signal decode_functions_detail : tFunctions_detail;
   signal decode_datareceivetype  : tdatareceivetype;
   signal decode_clearbit1                : std_logic := '0';
   signal decode_rdest                    : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_Rn_op1                   : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_RM_op2                   : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_alu_use_immi             : std_logic := '0';
   signal decode_alu_use_shift            : std_logic := '0';
   signal decode_immidiate                : unsigned(31 downto 0) := (others => '0');
   signal decode_shiftsettings            : std_logic_vector(7 downto 0) := (others => '0');
   signal decode_shiftcarry               : std_logic := '0';
   signal decode_useoldcarry              : std_logic := '0';
   signal decode_updateflags              : std_logic := '0';
   signal decode_muladd                   : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_mul_signed               : std_logic := '0';
   signal decode_mul_useadd               : std_logic := '0';
   signal decode_mul_long                 : std_logic := '0';
   signal decode_mul_x_hi                 : std_logic := '0';
   signal decode_mul_x_lo                 : std_logic := '0';
   signal decode_mul_y_Hi                 : std_logic := '0';
   signal decode_mul_y_lo                 : std_logic := '0';
   signal decode_mul_48                   : std_logic := '0';
   signal decode_mul_check_q              : std_logic := '0';
   signal decode_writeback                : std_logic := '0';
   signal decode_switch_op                : std_logic := '0';
   signal decode_set_thumbmode            : std_logic := '0';
   signal decode_branch_usereg            : std_logic := '0';
   signal decode_branch_link              : std_logic := '0';
   signal decode_branch_immi              : signed(25 downto 0) := (others => '0');
   signal decode_datatransfer_type        : std_logic_vector(1 downto 0) := (others => '0');
   signal decode_datatransfer_preadd      : std_logic := '0';
   signal decode_datatransfer_addup       : std_logic := '0';
   signal decode_datatransfer_writeback   : std_logic := '0';
   signal decode_datatransfer_addvalue    : unsigned(11 downto 0)  := (others => '0');
   signal decode_datatransfer_shiftval    : std_logic := '0';
   signal decode_datatransfer_regoffset   : std_logic := '0';
   signal decode_datatransfer_swap        : std_logic := '0';
   signal decode_datatransfer_double      : std_logic := '0';
   signal decode_block_usermoderegs       : std_logic := '0';
   signal decode_block_switchmode         : std_logic := '0';
   signal decode_block_addrmod            : integer range -64 to 64 := 0;
   signal decode_block_endmod             : integer range -64 to 64 := 0;
   signal decode_block_addrmod_baseRlist  : integer range -64 to 64 := 0;
   signal decode_block_reglist            : std_logic_vector(15 downto 0) := (others => '0');
   signal decode_block_emptylist          : std_logic := '0';
   signal decode_block_wb_in_reglist      : std_logic := '0';
   signal decode_psr_with_spsr            : std_logic := '0';
   signal decode_force_armswitch          : std_logic := '0';
   signal decode_leaveirp                 : std_logic := '0';
   signal decode_leaveirp_user            : std_logic := '0';
   signal decode_co_opMode                : std_logic_vector(2 downto 0) := (others => '0');
   signal decode_co_SrcDstReg             : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_co_armSrcDstReg          : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_co_Number                : std_logic_vector(3 downto 0) := (others => '0');
   signal decode_co_Info                  : std_logic_vector(2 downto 0) := (others => '0');
   signal decode_co_opRegm                : std_logic_vector(3 downto 0) := (others => '0');
   
   signal execute_functions_detail : tFunctions_detail;
   signal execute_datareceivetype  : tdatareceivetype;
   signal execute_clearbit1               : std_logic := '0';
   signal execute_rdest                   : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_Rn_op1                  : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_RM_op2                  : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_alu_use_immi            : std_logic := '0';
   signal execute_alu_use_shift           : std_logic := '0';
   signal execute_immidiate               : unsigned(31 downto 0) := (others => '0');
   signal execute_shiftsettings           : std_logic_vector(7 downto 0) := (others => '0');
   signal execute_shiftcarry              : std_logic := '0';
   signal execute_useoldcarry             : std_logic := '0';
   signal execute_updateflags             : std_logic := '0';
   signal execute_muladd                  : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_mul_signed              : std_logic := '0';
   signal execute_mul_useadd              : std_logic := '0';
   signal execute_mul_long                : std_logic := '0';
   signal execute_mul_x_hi                : std_logic := '0';
   signal execute_mul_x_lo                : std_logic := '0';
   signal execute_mul_y_hi                : std_logic := '0';
   signal execute_mul_y_lo                : std_logic := '0';
   signal execute_mul_48                  : std_logic := '0';
   signal execute_mul_check_q             : std_logic := '0';
   signal execute_writeback               : std_logic := '0';
   signal execute_switch_op               : std_logic := '0';
   signal execute_set_thumbmode           : std_logic := '0';
   signal execute_branch_usereg           : std_logic := '0';
   signal execute_branch_link             : std_logic := '0';
   signal execute_branch_immi             : signed(25 downto 0) := (others => '0');
   signal execute_datatransfer_type       : std_logic_vector(1 downto 0) := (others => '0');
   signal execute_datatransfer_preadd     : std_logic := '0';
   signal execute_datatransfer_addup      : std_logic := '0';
   signal execute_datatransfer_writeback  : std_logic := '0';
   signal execute_datatransfer_addvalue   : unsigned(11 downto 0)  := (others => '0');
   signal execute_datatransfer_shiftval   : std_logic := '0';
   signal execute_datatransfer_regoffset  : std_logic := '0';
   signal execute_datatransfer_swap       : std_logic := '0';
   signal execute_datatransfer_double     : std_logic := '0';
   signal execute_block_usermoderegs      : std_logic := '0';
   signal execute_block_switchmode        : std_logic := '0';
   signal execute_block_addrmod           : integer range -64 to 64 := 0;
   signal execute_block_endmod            : integer range -64 to 64 := 0;
   signal execute_block_addrmod_baseRlist : integer range -64 to 64 := 0;
   signal execute_block_reglist           : std_logic_vector(15 downto 0) := (others => '0');
   signal execute_block_emptylist         : std_logic := '0';
   signal execute_block_wb_in_reglist     : std_logic := '0';
   signal execute_psr_with_spsr           : std_logic := '0';
   signal execute_force_armswitch         : std_logic := '0';
   signal execute_leaveirp                : std_logic := '0';
   signal execute_leaveirp_user           : std_logic := '0';
   signal execute_co_opMode               : std_logic_vector(2 downto 0) := (others => '0');
   signal execute_co_SrcDstReg            : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_co_armSrcDstReg         : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_co_Number               : std_logic_vector(3 downto 0) := (others => '0');
   signal execute_co_Info                 : std_logic_vector(2 downto 0) := (others => '0');
   signal execute_co_opRegm               : std_logic_vector(3 downto 0) := (others => '0');
   
   -- ############# ALU ##############
   type talu_stage is
   (
      ALUSTART,
      ALUSHIFT,
      ALUSHIFTWAIT,
      ALUSWITCHOP,
      ALUQMUL2,
      ALUCALC,
      ALUSETFLAGS,
      ALULEAVEIRP
   );
   signal alu_stage : talu_stage := ALUSTART;
   
   signal alu_op1           : unsigned(31 downto 0);
   signal alu_op2           : unsigned(31 downto 0);
   signal alu_result        : unsigned(31 downto 0);
   signal alu_result_add    : unsigned(32 downto 0);
   signal alu_shiftercarry  : std_logic;
   signal alu_saturate_max  : std_logic;
   signal alu_saturate_min  : std_logic;
   
   -- ############# Mul ##############
   type tmul_stage is
   (
      MULSTART,
      MULCALCMUL,
      MULADDLOW,
      MULADDHIGH,
      MULSETFLAGS,
      MULWRITEBACK_LOW,
      MULWRITEBACK_HIGH
   );
   signal mul_stage : tmul_stage := MULSTART;
   
   signal mul_op1           : unsigned(31 downto 0);
   signal mul_op2           : unsigned(31 downto 0);
   signal mul_opaddlow      : unsigned(31 downto 0);
   signal mul_opaddhigh     : unsigned(31 downto 0);
   signal mul_result        : unsigned(63 downto 0);
   signal mul_wait          : integer range 0 to 3;
   
   -- ############# SHIFTER ##############
   
   signal shifter_start     : std_logic := '0';       
   signal shiftreg          : unsigned(31 downto 0) := (others => '0');
   signal shiftbyreg        : unsigned( 7 downto 0) := (others => '0');
   signal shiftresult       : unsigned(31 downto 0) := (others => '0');
   signal shiftercarry      : std_logic := '0';
   
   signal shiftwait         : integer range 0 to 2 := 0;
   signal shiftamount       : integer range 0 to 255 := 0;
   signal shiftervalue      : unsigned(31 downto 0) := (others => '0');
   signal shift_rrx         : std_logic := '0';
   
   signal shiftercarry_LSL  : std_logic := '0';
   signal shiftercarry_RSL  : std_logic := '0';
   signal shiftercarry_ARS  : std_logic := '0';
   signal shiftercarry_ROR  : std_logic := '0';
   signal shiftercarry_RRX  : std_logic := '0';

   signal shiftresult_LSL   : unsigned(31 downto 0) := (others => '0');
   signal shiftresult_RSL   : unsigned(31 downto 0) := (others => '0');
   signal shiftresult_ARS   : unsigned(31 downto 0) := (others => '0');
   signal shiftresult_ROR   : unsigned(31 downto 0) := (others => '0');
   signal shiftresult_RRX   : unsigned(31 downto 0) := (others => '0');    
   
   -- ############# BUS ##############
   
   signal bus_fetch_Adr    : std_logic_vector(31 downto 0) := (others => '0');
   signal bus_fetch_rnw    : std_logic;
   signal bus_fetch_ena    : std_logic;
   
   signal bus_execute_Adr  : std_logic_vector(31 downto 0) := (others => '0');
   signal bus_execute_rnw  : std_logic := '0';
   signal bus_execute_ena  : std_logic := '0';
   signal bus_execute_acc  : std_logic_vector(1 downto 0) := (others => '0');
   
   type tbus_stage is
   (
      FETCHADDR,
      BUSSHIFT,
      BUSSHIFTWAIT,
      CALCADDR,
      BUSREQUEST,
      WAITBUS,
      WRITEBACKADDR
   );
   signal data_rw_stage : tbus_stage := FETCHADDR;
   
   signal busaddress       : unsigned(31 downto 0);
   signal busaddmod        : unsigned(31 downto 0);
   signal swap_write       : std_logic;
   signal datadouble_first : std_logic;
   signal first_mem_access : std_logic;
   
   -- ############# Block RW ##############
   
   type tblock_stage is
   (
      BLOCKFETCHADDR,
      BLOCKCHECKNEXT,
      BLOCKWRITE,
      BLOCKWAITWRITE,
      BLOCKREAD,
      BLOCKWAITREAD,
      BLOCKWRITEBACKADDR,
      BLOCKSWITCHMODE
   );
   signal block_rw_stage : tblock_stage := BLOCKFETCHADDR;
   
   signal block_regindex       : integer range 0 to 15;
   signal endaddress           : unsigned(31 downto 0) := (others => '0');
   signal endaddressRlist      : unsigned(31 downto 0) := (others => '0');
   signal block_writevalue     : unsigned(31 downto 0) := (others => '0');
   signal block_reglist        : std_logic_vector(15 downto 0) := (others => '0');
   signal block_switch_pc      : unsigned(31 downto 0) := (others => '0');
   signal block_hasPC          : std_logic := '0';
   signal block_arm9_writeback : std_logic := '0';
   
   -- ############# Datacache ##############
   signal datacache_read_enable       : std_logic := '0';
   signal datacache_read_addr         : std_logic_vector(21 downto 0) := (others => '0');
   signal datacache_read_data         : std_logic_vector(31 downto 0);
   signal datacache_read_done         : std_logic := '0';
   signal datacache_read_checked      : std_logic := '0';
   signal datacache_read_cached       : std_logic := '0';
  
   signal datacache_write_enable      : std_logic := '0';
   signal datacache_write_addr        : std_logic_vector(21 downto 0) := (others => '0');
   signal datacache_write_checked     : std_logic := '0';
   signal datacache_write_cached      : std_logic := '0';
      
   signal datacache_mem_read_ena      : std_logic;
   signal datacache_mem_read_addr     : std_logic_vector(21 downto 0);
   
   signal datacache_readwait          : std_logic := '0';
   
   -- ############# MSR/MRS ##############
   type tMRS_stage is
   (
      MSR_START,
      MSR_SPSR,
      MSR_CPSR
   );
   signal MSR_Stage : tMRS_stage := MSR_START;
   
   signal msr_value            : unsigned(31 downto 0); 
   signal msr_writebackvalue   : unsigned(31 downto 0); 
   
   -- ############# CLZ ##############
   type tclz_stage is
   (
      CLZSTART,
      CLZCALC,
      CLZWRITEBACK
   );
   signal clz_stage : tclz_stage := CLZSTART;
   
   signal clz_workreg : unsigned(31 downto 0);
   signal clz_count   : integer range 0 to 32;
   
   -- ############# Co15 ##############
   signal Co15_ctrl           : unsigned(31 downto 0);
   signal Co15_ICConfig       : unsigned(31 downto 0);
   signal Co15_DCConfig       : unsigned(31 downto 0);
   signal Co15_writeBuffCtrl  : unsigned(31 downto 0);
   signal Co15_IaccessPerm    : unsigned(31 downto 0);
   signal Co15_DaccessPerm    : unsigned(31 downto 0);
   signal Co15_DTCMRegion     : unsigned(31 downto 0);
   
   type t_Co15_protectBaseSize is array(0 to 7) of unsigned(31 downto 0);
   signal Co15_protectBaseSize : t_Co15_protectBaseSize;
   
   signal irpTarget           : unsigned(31 downto 0) := (others => '0');
   signal new_halt_co15       : std_logic := '0';
   
   -- ############# savestates ##############
   signal SAVESTATE_PC : std_logic_vector(31 downto 0) := (others => '0');
   
   type t_regs_slv is array(0 to 17) of std_logic_vector(31 downto 0);
   signal SAVESTATE_REGS : t_regs_slv := (others => (others => '0'));
   
   signal SAVESTATE_REGS_0_8  : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_9  : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_10 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_11 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_12 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_0_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_8  : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_9  : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_10 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_11 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_12 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_1_17 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_2_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_2_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_2_17 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_3_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_3_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_3_17 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_4_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_4_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_4_17 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_5_13 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_5_14 : std_logic_vector(31 downto 0) := (others => '0');
   signal SAVESTATE_REGS_5_17 : std_logic_vector(31 downto 0) := (others => '0');
   
   signal SAVESTATE_HALT            : std_logic;
   signal SAVESTATE_Flag_Zero       : std_logic;
   signal SAVESTATE_Flag_Carry      : std_logic;
   signal SAVESTATE_Flag_Negative   : std_logic;
   signal SAVESTATE_Flag_V_Overflow : std_logic;
   signal SAVESTATE_Flag_Q          : std_logic;
   signal SAVESTATE_thumbmode       : std_logic;
   signal SAVESTATE_cpu_mode        : std_logic_vector(3 downto 0);
   signal SAVESTATE_IRQ_disable     : std_logic;
   signal SAVESTATE_FIQ_disable     : std_logic;
   
   signal SAVESTATE_mixed_in        : std_logic_vector(12 downto 0);
   signal SAVESTATE_mixed_out       : std_logic_vector(12 downto 0);
     
begin  
   
   -- savestates
   iSAVESTATE_PC : entity work.eProcReg_ds generic map (REG_SAVESTATE_PC ) port map (clk100, savestate_bus, open, std_logic_vector(new_pc) , SAVESTATE_PC);
   gSAVESTATE_REGS : for i in 0 to 17 generate
   begin
      iSAVESTATE_REGS : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS, i) port map (clk100, savestate_bus, open, std_logic_vector(regs(i)) , SAVESTATE_REGS(i));
   end generate;
   iSAVESTATE_REGS_0_8  : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_8 ) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_8 ) , SAVESTATE_REGS_0_8 );
   iSAVESTATE_REGS_0_9  : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_9 ) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_9 ) , SAVESTATE_REGS_0_9 );
   iSAVESTATE_REGS_0_10 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_10) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_10) , SAVESTATE_REGS_0_10);
   iSAVESTATE_REGS_0_11 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_11) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_11) , SAVESTATE_REGS_0_11);
   iSAVESTATE_REGS_0_12 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_12) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_12) , SAVESTATE_REGS_0_12);
   iSAVESTATE_REGS_0_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_13) , SAVESTATE_REGS_0_13);
   iSAVESTATE_REGS_0_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_0_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_0_14) , SAVESTATE_REGS_0_14);
   iSAVESTATE_REGS_1_8  : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_8 ) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_8 ) , SAVESTATE_REGS_1_8 );
   iSAVESTATE_REGS_1_9  : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_9 ) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_9 ) , SAVESTATE_REGS_1_9 );
   iSAVESTATE_REGS_1_10 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_10) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_10) , SAVESTATE_REGS_1_10);
   iSAVESTATE_REGS_1_11 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_11) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_11) , SAVESTATE_REGS_1_11);
   iSAVESTATE_REGS_1_12 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_12) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_12) , SAVESTATE_REGS_1_12);
   iSAVESTATE_REGS_1_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_13) , SAVESTATE_REGS_1_13);
   iSAVESTATE_REGS_1_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_14) , SAVESTATE_REGS_1_14);
   iSAVESTATE_REGS_1_17 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_1_17) port map (clk100, savestate_bus, open, std_logic_vector(regs_1_17) , SAVESTATE_REGS_1_17);
   iSAVESTATE_REGS_2_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_2_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_2_13) , SAVESTATE_REGS_2_13);
   iSAVESTATE_REGS_2_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_2_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_2_14) , SAVESTATE_REGS_2_14);
   iSAVESTATE_REGS_2_17 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_2_17) port map (clk100, savestate_bus, open, std_logic_vector(regs_2_17) , SAVESTATE_REGS_2_17);
   iSAVESTATE_REGS_3_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_3_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_3_13) , SAVESTATE_REGS_3_13);
   iSAVESTATE_REGS_3_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_3_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_3_14) , SAVESTATE_REGS_3_14);
   iSAVESTATE_REGS_3_17 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_3_17) port map (clk100, savestate_bus, open, std_logic_vector(regs_3_17) , SAVESTATE_REGS_3_17);
   iSAVESTATE_REGS_4_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_4_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_4_13) , SAVESTATE_REGS_4_13);
   iSAVESTATE_REGS_4_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_4_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_4_14) , SAVESTATE_REGS_4_14);
   iSAVESTATE_REGS_4_17 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_4_17) port map (clk100, savestate_bus, open, std_logic_vector(regs_4_17) , SAVESTATE_REGS_4_17);
   iSAVESTATE_REGS_5_13 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_5_13) port map (clk100, savestate_bus, open, std_logic_vector(regs_5_13) , SAVESTATE_REGS_5_13);
   iSAVESTATE_REGS_5_14 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_5_14) port map (clk100, savestate_bus, open, std_logic_vector(regs_5_14) , SAVESTATE_REGS_5_14);
   iSAVESTATE_REGS_5_17 : entity work.eProcReg_ds generic map (REG_SAVESTATE_REGS_5_17) port map (clk100, savestate_bus, open, std_logic_vector(regs_5_17) , SAVESTATE_REGS_5_17);
   
   iSAVESTATE_CPUMIXED  : entity work.eProcReg_ds generic map (REG_SAVESTATE_CPUMIXED)  port map (clk100, savestate_bus, open, SAVESTATE_mixed_out , SAVESTATE_mixed_in);
   
   SAVESTATE_mixed_out(0) <= halt;           
   SAVESTATE_mixed_out(1) <= Flag_Zero;     
   SAVESTATE_mixed_out(2) <= Flag_Carry;     
   SAVESTATE_mixed_out(3) <= Flag_Negative;  
   SAVESTATE_mixed_out(4) <= Flag_V_Overflow;
   SAVESTATE_mixed_out(5) <= thumbmode;      
   SAVESTATE_mixed_out(9 downto 6) <= cpu_mode;       
   SAVESTATE_mixed_out(10) <= IRQ_disable;    
   SAVESTATE_mixed_out(11) <= FIQ_disable; 
   SAVESTATE_mixed_out(12) <= Flag_Q; 

   SAVESTATE_HALT            <= SAVESTATE_mixed_in(0);
   SAVESTATE_Flag_Zero       <= SAVESTATE_mixed_in(1);
   SAVESTATE_Flag_Carry      <= SAVESTATE_mixed_in(2);
   SAVESTATE_Flag_Negative   <= SAVESTATE_mixed_in(3);
   SAVESTATE_Flag_V_Overflow <= SAVESTATE_mixed_in(4);
   SAVESTATE_thumbmode       <= SAVESTATE_mixed_in(5);
   SAVESTATE_cpu_mode        <= SAVESTATE_mixed_in(9 downto 6);
   SAVESTATE_IRQ_disable     <= SAVESTATE_mixed_in(10);
   SAVESTATE_FIQ_disable     <= SAVESTATE_mixed_in(11);
   SAVESTATE_Flag_Q          <= SAVESTATE_mixed_in(12);
   -- savestates
   
   
   gbus_arm9 : if isArm9 = '1' generate
   begin
   
      OBus_1_Adr <= x"02" & "00" & datacache_mem_read_addr when datacache_mem_read_ena = '1' else bus_execute_Adr;
      OBus_1_rnw <= '1'                                    when datacache_mem_read_ena = '1' else bus_execute_rnw;
      OBus_1_ena <= '1'                                    when datacache_mem_read_ena = '1' else bus_execute_ena;
      OBus_1_acc <= ACCESS_32BIT                           when datacache_mem_read_ena = '1' else bus_execute_acc;
      
      OBus_data_din  <= OBus_1_din;
      OBus_data_done <= OBus_1_done;
   
      OBus_2_Adr <= x"02" & "00" & instr_cache_addr when instr_cache_readena = '1' else bus_fetch_Adr;
      OBus_2_ena <= instr_cache_readena or fetch_req;
      OBus_2_acc <= ACCESS_32BIT;
      
      OBus_code_din  <= OBus_2_din;
      OBus_code_done <= OBus_2_done;
      
   end generate;
   
   gbus_arm7 : if isArm9 = '0' generate
   begin
   
      OBus_1_Adr <= x"02" & "00" & instr_cache_addr when instr_cache_readena = '1' else x"02" & "00" & datacache_mem_read_addr when datacache_mem_read_ena = '1' else bus_fetch_Adr  when fetch_req = '1' else bus_execute_Adr;
      OBus_1_rnw <= '1'                             when instr_cache_readena = '1' else '1'                                    when datacache_mem_read_ena = '1' else bus_fetch_rnw  when fetch_req = '1' else bus_execute_rnw;
      OBus_1_ena <= '1'                             when instr_cache_readena = '1' else '1'                                    when datacache_mem_read_ena = '1' else '1'            when fetch_req = '1' else bus_execute_ena;
      OBus_1_acc <= ACCESS_32BIT                    when instr_cache_readena = '1' else ACCESS_32BIT                           when datacache_mem_read_ena = '1' else ACCESS_32BIT   when fetch_req = '1' else bus_execute_acc;
   
      OBus_data_din  <= OBus_1_din;
      OBus_data_done <= OBus_1_done;
      OBus_code_din  <= OBus_1_din;
      OBus_code_done <= OBus_1_done;
   
   end generate;
   
   
   PC_in_BIOS <= '1' when bus_fetch_Adr(27 downto 24) = x"0" else '0';
   jump_out   <= jump;
   
   iinstrcache : entity work.ds_cpucache
   generic map
   (
      LINES             => 64,
      CANROTATE         => '0'
   )
   port map
   (
      clk               => clk100,
      ds_on             => ds_on,
                        
      read_enable       => instr_cache_req,
      read_addr         => bus_fetch_Adr(21 downto 0),
      read_acc          => ACCESS_32BIT,
      read_data         => instr_cache_dataout,
      read_done         => instr_cache_datavalid,
      read_cached       => instr_cache_cached,
                        
      mem_read_ena      => instr_cache_readena,
      mem_read_addr     => instr_cache_addr,
      mem_read_data     => ram128code_data,
      mem_read_done     => ram128code_done,
      
      snoop_Adr         => snoop_Adr, 
      snoop_data        => snoop_data,
      snoop_we          => snoop_we,  
      snoop_be          => snoop_be  
   );
   
   halt_out <= halt;
   irq_out  <= irq_calc;
   irq_off  <= IRQ_disable;
   
   fetch_valid      <= '1' when (instr_cache_datavalid = '1' or (OBus_code_done = '1' and last_fetch_onbus = '1')) else '0';
   
   process (clk100) 
      variable execute_skip : std_logic;
   begin
      if rising_edge(clk100) then
      
         done             <= '0';
         bus_fetch_ena    <= '0';
         
         execute_start    <= '0';
         new_cycles_valid <= '0';
         
         fetch_req          <= '0';
         instr_cache_req    <= '0';
         
         if (dma_on = '1' and fetch_available = '1' and state_decode = DECODE_DONE and state_execute = FETCH_OP and jump = '0') then
            CPU_bus_idle <= '1';
         else
            CPU_bus_idle <= '0';
         end if;
            
         debug_cpu_pc <= std_logic_vector(PC);
   
         debug_cpu_mixed(0) <= halt;           
         debug_cpu_mixed(1) <= Flag_Zero;     
         debug_cpu_mixed(2) <= Flag_Carry;     
         debug_cpu_mixed(3) <= Flag_Negative;  
         debug_cpu_mixed(4) <= Flag_V_Overflow;
         debug_cpu_mixed(5) <= thumbmode;      
         debug_cpu_mixed(9 downto 6) <= cpu_mode;       
         debug_cpu_mixed(10) <= IRQ_disable;    
         debug_cpu_mixed(11) <= FIQ_disable; 
         debug_cpu_mixed(12) <= Flag_Q;
         debug_cpu_mixed(13) <= irq_triggerhold;
         debug_cpu_mixed(31 downto 24) <= std_logic_vector(PC(31 downto 24));
            
         if (reset = '1') then -- reset
            
            -- ############# arm
            
            for i in 0 to 17 loop 
               regs(i) <= unsigned(SAVESTATE_REGS(i));
            end loop;
            
            regs_0_8  <= unsigned(SAVESTATE_REGS_0_8 );
            regs_0_9  <= unsigned(SAVESTATE_REGS_0_9 );
            regs_0_10 <= unsigned(SAVESTATE_REGS_0_10);
            regs_0_11 <= unsigned(SAVESTATE_REGS_0_11);
            regs_0_12 <= unsigned(SAVESTATE_REGS_0_12);
            regs_0_13 <= unsigned(SAVESTATE_REGS_0_13);
            regs_0_14 <= unsigned(SAVESTATE_REGS_0_14);
            regs_1_8  <= unsigned(SAVESTATE_REGS_1_8 );
            regs_1_9  <= unsigned(SAVESTATE_REGS_1_9 );
            regs_1_10 <= unsigned(SAVESTATE_REGS_1_10);
            regs_1_11 <= unsigned(SAVESTATE_REGS_1_11);
            regs_1_12 <= unsigned(SAVESTATE_REGS_1_12);
            regs_1_13 <= unsigned(SAVESTATE_REGS_1_13);
            regs_1_14 <= unsigned(SAVESTATE_REGS_1_14);
            regs_1_17 <= unsigned(SAVESTATE_REGS_1_17);
            regs_2_13 <= unsigned(SAVESTATE_REGS_2_13);
            regs_2_14 <= unsigned(SAVESTATE_REGS_2_14);
            regs_2_17 <= unsigned(SAVESTATE_REGS_2_17);
            regs_3_13 <= unsigned(SAVESTATE_REGS_3_13);
            regs_3_14 <= unsigned(SAVESTATE_REGS_3_14);
            regs_3_17 <= unsigned(SAVESTATE_REGS_3_17);
            regs_4_13 <= unsigned(SAVESTATE_REGS_4_13);
            regs_4_14 <= unsigned(SAVESTATE_REGS_4_14);
            regs_4_17 <= unsigned(SAVESTATE_REGS_4_17);
            regs_5_13 <= unsigned(SAVESTATE_REGS_5_13);
            regs_5_14 <= unsigned(SAVESTATE_REGS_5_14);
            regs_5_17 <= unsigned(SAVESTATE_REGS_5_17);
            
            -- overwriting startup values - todo: fix so savestates work again
            regs(17) <= x"0000001F";
            if (isArm9 = '1') then
               regs_3_13 <= x"00803FC0";
               regs_2_13 <= x"00803FA0";
               regs_0_13 <= x"00803EC0";
               regs_4_13 <= x"00803EC0";
               regs(13)  <= x"00803EC0";
            else
               regs_3_13 <= x"0380FFDC";
               regs_2_13 <= x"0380FFB0";
               regs_0_13 <= x"0380FF00";
               regs(13)  <= x"0380FF00";
            end if;
            
            PC <= unsigned(PCEntry); -- unsigned(SAVESTATE_PC); todo: allow PC setting from savestate

            halt <= SAVESTATE_HALT;
            
            -- ################ internal
               
            fetch_req          <= '0';
            wait_fetch         <= '0';
            skip_pending_fetch <= '0';
            fetch_available    <= '0';
                
            decode_ack         <= '0';
            decode_request     <= '1';
            state_decode       <= WAITFETCH;
                
            state_execute      <= FETCH_OP;
            
            -- only required for simulation, to test if e.g. drawing works, the cpu must run without doing anything
            if (is_simu = '1') then
            
               lastread           <= x"DEADDEAD"; -- for testing purpose only
            
               if (do_step = '1') then 
                  if (halt_cnt < 5) then
                     halt_cnt <= halt_cnt + 1;
                  else
                     halt_cnt <= 0;
                     new_cycles_valid <= '1';
                     new_cycles_out   <= to_unsigned(6, 8);
                  end if;
               end if;
            end if;
            
         elsif (ds_on = '1') then
         
            -- ############################
            -- Fetch
            -- ############################
            
            if (jump = '1') then
               fetch_available    <= '0';
               skip_pending_fetch <= wait_fetch and not fetch_valid;
               wait_fetch         <= '0';
               PC                 <= new_pc;
               
               if (wait_fetch = '0' or fetch_valid = '1') then
                  bus_fetch_Adr <= std_logic_vector(new_pc);
                  bus_fetch_Adr(1 downto 0) <= "00";
                  bus_fetch_rnw <= '1';
                  bus_fetch_ena <= '1';
                  if (thumbmode = '1') then 
                     PC            <= new_pc + 2;
                  else 
                     PC            <= new_pc + 4;
                  end if;
                  if (new_pc(27 downto 24) = x"2") then
                     instr_cache_req  <= '1';
                     last_fetch_onbus <= '0';
                  else
                     fetch_req        <= '1';
                     last_fetch_onbus <= '1';
                  end if;
                  wait_fetch <= '1';
               end if;
            else
            
               if (fetch_valid = '1' and wait_fetch = '1') then
                  wait_fetch <= '0';
                  if (decode_request = '0') then
                     fetch_available <= '1';
                     if (instr_cache_datavalid = '1') then
                        fetch_data        <= instr_cache_dataout;  
                        fetch_instr_cache <= instr_cache_cached;
                     else
                        fetch_data <= OBus_code_din;
                     end if;
                  end if;
               end if;
            
               if (isArm9 = '1' or executebus = '0') then
                  if ((fetch_available = '0' or decode_request = '1') and (wait_fetch = '0' or (fetch_valid = '1' and decode_request = '1')) and (skip_pending_fetch = '0' or fetch_valid = '1')) then
                     bus_fetch_Adr <= std_logic_vector(PC);
                     bus_fetch_Adr(1 downto 0) <= "00";
                     bus_fetch_rnw <= '1';
                     bus_fetch_ena <= '1';
                     if (thumbmode = '1') then 
                        PC            <= PC + 2;
                     else 
                        PC            <= PC + 4;
                     end if;
                     if (PC(27 downto 24) = x"2") then
                        instr_cache_req  <= '1';
                        last_fetch_onbus <= '0';
                     else
                        fetch_req        <= '1';
                        last_fetch_onbus <= '1';
                     end if;
                     wait_fetch <= '1';
                  end if;
               end if;

               if (fetch_valid = '1' and skip_pending_fetch = '1') then
                  skip_pending_fetch <= '0';
               end if;  
               
               if (fetch_available = '1' and decode_request = '1') then
                  fetch_available <= '0';
               end if;
               
            end if;
            
            -- ############################
            -- Decode
            -- ############################
            
            decode_ack     <= '0';
            
            if (jump = '1') then
            
               state_decode   <= WAITFETCH;
               decode_request <= '1';
            
            else
            
               case state_decode is
               
                  when WAITFETCH =>
                     if (fetch_available = '1' or (fetch_valid = '1' and skip_pending_fetch = '0' and wait_fetch = '1')) then
                        if (fetch_available = '1') then
                           if (PC(1) = '0' and thumbmode = '1') then
                              decode_data(15 downto 0) <= fetch_data(31 downto 16);
                           else
                              decode_data              <= fetch_data;
                           end if;
                           decode_instr_cache <= fetch_instr_cache;
                           decode_PC          <= PC;
                        else
                           if (instr_cache_datavalid = '1') then
                              if (PC(1) = '0' and thumbmode = '1') then
                                 decode_data(15 downto 0) <= instr_cache_dataout(31 downto 16);
                              else
                                 decode_data              <= instr_cache_dataout;
                              end if;                              
                              decode_instr_cache <= instr_cache_cached;  
                           else
                              if (PC(1) = '0' and thumbmode = '1') then
                                 decode_data(15 downto 0) <= OBus_code_din(31 downto 16);
                              else
                                 decode_data              <= OBus_code_din;
                              end if;
                           end if;
                           decode_PC   <= PC;
                        end if;
                        
                        state_decode   <= DECODE_DETAILS;
                        decode_request <= '0';
                     end if;
                  
                  when DECODE_DETAILS =>
                     state_decode   <= DECODE_DONE;
                     
                  when DECODE_DONE =>
                     if (state_execute = FETCH_OP and do_step = '1' and dma_on = '0' and settle = '0' and halt = '0') then
                        decode_request <= '1';
                        decode_ack     <= '1';
                        state_decode   <= WAITFETCH;
                     end if;
                  
               end case;
               
            end if;
            
            -- ############################
            -- Execute
            -- ############################
            
            if (new_halt = '1' or new_halt_co15 = '1') then
               halt <= '1';
            end if;
            
            regs(16) <= Flag_Negative & Flag_Zero & Flag_Carry & Flag_V_Overflow & Flag_Q & "000" & x"0000" & IRQ_disable & FIQ_disable & thumbmode & '1' & unsigned(cpu_mode);
            
            if (execute_writeback_calc = '1') then
               if (writeback_reg /= x"F") then
                  regs(to_integer(unsigned(writeback_reg))) <= calc_result;
               end if;   
            end if;
            if (execute_writeback_r17 = '1') then
               regs(17) <= msr_writebackvalue;
            end if;
            if (execute_writeback_userreg = '1') then
               case (to_integer(unsigned(writeback_reg))) is
                  when 8  => regs_0_8  <= calc_result;
                  when 9  => regs_0_9  <= calc_result;
                  when 10 => regs_0_10 <= calc_result;
                  when 11 => regs_0_11 <= calc_result;
                  when 12 => regs_0_12 <= calc_result;
                  when 13 => regs_0_13 <= calc_result;
                  when 14 => regs_0_14 <= calc_result;
                  when others => null; -- does happen in armwrestler test
               end case;
            end if;
            
            if (execute_saveregs = '1') then
                     
               case (cpu_mode_old) is
                  when CPUMODE_USER | CPUMODE_SYSTEM =>
                     if (cpu_mode = CPUMODE_FIQ) then
                        regs_0_8  <= regs(8);
                        regs_0_9  <= regs(9);
                        regs_0_10 <= regs(10);
                        regs_0_11 <= regs(11);
                        regs_0_12 <= regs(12);
                     end if;
                     regs_0_13 <= regs(13);
                     regs_0_14 <= regs(14);
                     regs(17)  <= regs(16);
  
                  when CPUMODE_FIQ =>
                     regs_1_8  <= regs(8);
                     regs_1_9  <= regs(9);
                     regs_1_10 <= regs(10);
                     regs_1_11 <= regs(11);
                     regs_1_12 <= regs(12);
                     regs_1_13 <= regs(13);
                     regs_1_14 <= regs(14);
                     regs_1_17 <= regs(17);

                  when CPUMODE_IRQ =>
                     regs_2_13 <= regs(13);
                     regs_2_14 <= regs(14);
                     regs_2_17 <= regs(17);

                  when CPUMODE_SUPERVISOR =>
                     regs_3_13 <= regs(13);
                     regs_3_14 <= regs(14);
                     regs_3_17 <= regs(17);

                  when CPUMODE_ABORT =>
                     regs_4_13 <= regs(13);
                     regs_4_14 <= regs(14);
                     regs_4_17 <= regs(17);

                  when CPUMODE_UNDEFINED =>
                     regs_5_13 <= regs(13);
                     regs_5_14 <= regs(14);
                     regs_5_17 <= regs(17);
                     
                  when others => report "should never happen" severity failure; 
               end case;
                  
            end if;
               
            if (execute_switchregs = '1') then
            
               case (cpu_mode) is
                  when CPUMODE_USER | CPUMODE_SYSTEM =>
                     if (cpu_mode_old = CPUMODE_FIQ) then
                        regs(8)  <= regs_0_8; 
                        regs(9)  <= regs_0_9; 
                        regs(10) <= regs_0_10;
                        regs(11) <= regs_0_11;
                        regs(12) <= regs_0_12;
                     end if;
                     regs(13) <= regs_0_13;
                     regs(14) <= regs_0_14;
  
                  when CPUMODE_FIQ =>
                     regs(8)  <= regs_1_8 ;
                     regs(9)  <= regs_1_9 ;
                     regs(10) <= regs_1_10;
                     regs(11) <= regs_1_11;
                     regs(12) <= regs_1_12;
                     regs(13) <= regs_1_13;
                     regs(14) <= regs_1_14;
                     if (execute_saveState = '1') then regs(17) <= regs(16); else regs(17) <= regs_1_17; end if;

                  when CPUMODE_IRQ =>
                     regs(13) <= regs_2_13;
                     if (execute_IRP = '0') then
                        regs(14) <= regs_2_14;
                     end if;
                     if (execute_saveState = '1') then regs(17) <= regs(16); else regs(17) <= regs_2_17; end if;

                  when CPUMODE_SUPERVISOR =>
                     regs(13) <= regs_3_13;
                     if (execute_SWI = '0') then
                        regs(14) <= regs_3_14;
                     end if;
                     if (execute_saveState = '1') then regs(17) <= regs(16); else regs(17) <= regs_3_17; end if;

                  when CPUMODE_ABORT =>
                     regs(13) <= regs_4_13;
                     regs(14) <= regs_4_14;
                     if (execute_saveState = '1') then regs(17) <= regs(16); else regs(17) <= regs_4_17; end if;

                  when CPUMODE_UNDEFINED =>
                     regs(13) <= regs_5_13;
                     regs(14) <= regs_5_14;
                     if (execute_saveState = '1') then regs(17) <= regs(16); else regs(17) <= regs_5_17; end if;
                     
                  when others => report "should never happen" severity failure; 
               end case;
            
            end if;
            
            if (cpu_IRQ = '1' and IRQ_disable = '0' and irq_delay = 0 and irq_calc = '0' and irq_triggerhold = '0') then
               --irq_delay <= 4;
               irq_triggerhold <= '1';
            end if;
            
            --if (irq_delay > 0 and new_cycles_valid = '1') then
            --   if ((irq_delay - to_integer(new_cycles_out)) > 0) then
            --      irq_delay <= irq_delay - to_integer(new_cycles_out);
            --   else
            --      irq_delay       <= 0;
            --      irq_triggerhold <= '1';
            --   end if;
            --end if;
            
            irq_calc <= '0';
            
            case state_execute is
               
               when FETCH_OP =>
                  if (irq_triggerhold = '1' and IRQ_disable = '0' and dma_on = '0' and settle = '0') then

                     if (state_decode /= WAITFETCH) then -- dont do irp when decode_PC has not been updated
                        halt            <= '0';
                        irq_calc        <= '1';
                        state_execute   <= CALC;
                        execute_cycles  <= 0;
                        irq_triggerhold <= '0';
                        if (is_simu = '1') then
                           execute_data  <= (others => '0');
                        end if;
                        
                        if (thumbmode = '1') then
                           execute_PCprev <= decode_PC - 2;
                        else
                           execute_PCprev <= decode_PC - 4;
                        end if;
                        
                     end if;
                     
                  elsif (halt = '1' and dma_on = '0' and settle = '0') then
                  --   
                  --   if (do_step = '1') then 
                  --      if (halt_cnt < 5) then
                  --         halt_cnt <= halt_cnt + 1;
                  --      else
                  --         halt_cnt <= 0;
                  --         new_cycles_valid <= '1';
                  --         new_cycles_out   <= to_unsigned(6, 8); -- do 6x halt-speed for unlocked
                           done             <= '1';
                  --      end if;
                  --   end if;

                  elsif (state_decode = DECODE_DONE and do_step = '1' and dma_on = '0' and settle = '0' and jump = '0') then
                  
                     execute_cycles <= 0;
                  
                     if (thumbmode = '1') then
                        regs(15)(decode_PC'left downto 0) <= decode_PC + 2;
                     else
                        regs(15)(decode_PC'left downto 0) <= decode_PC + 4;
                     end if;
                     regs_plus_12  <= decode_PC + 8; -- only used for data operation available in arm mode
                     if (thumbmode = '1') then
                        block_pc_next <= decode_PC + 4;
                     else
                        block_pc_next <= decode_PC + 8;
                     end if;
                  
                     execute_skip := '1';
                     case (decode_condition) is
                        when x"0" => if (Flag_Zero = '1')                                        then execute_skip := '0'; end if;
                        when x"1" => if (Flag_Zero = '0')                                        then execute_skip := '0'; end if;
                        when x"2" => if (Flag_Carry = '1')                                       then execute_skip := '0'; end if;
                        when x"3" => if (Flag_Carry = '0')                                       then execute_skip := '0'; end if;
                        when x"4" => if (Flag_Negative = '1')                                    then execute_skip := '0'; end if;
                        when x"5" => if (Flag_Negative = '0')                                    then execute_skip := '0'; end if;
                        when x"6" => if (Flag_V_Overflow = '1')                                  then execute_skip := '0'; end if;
                        when x"7" => if (Flag_V_Overflow = '0')                                  then execute_skip := '0'; end if;
                        when x"8" => if (Flag_Carry = '1' and Flag_Zero = '0')                   then execute_skip := '0'; end if;
                        when x"9" => if (Flag_Carry = '0' or Flag_Zero = '1')                    then execute_skip := '0'; end if;
                        when x"A" => if (Flag_Negative = Flag_V_Overflow)                        then execute_skip := '0'; end if;
                        when x"B" => if (Flag_Negative /= Flag_V_Overflow)                       then execute_skip := '0'; end if;
                        when x"C" => if (Flag_Zero = '0' and (Flag_Negative = Flag_V_Overflow))  then execute_skip := '0'; end if;
                        when x"D" => if (Flag_Zero = '1' or (Flag_Negative /= Flag_V_Overflow))  then execute_skip := '0'; end if;
                        when x"E" => execute_skip := '0';
                        when others => null;
                     end case;
                  
                     if (execute_skip = '1') then
                        done             <= '1';
                        state_execute    <= FETCH_OP;
                        if (isArm9 = '1') then
                           new_cycles_out <= to_unsigned(decode_fetch_cycles, new_cycles_out'length);
                        else
                           new_cycles_out <= to_unsigned(decode_fetch_cycles, new_cycles_out'length - 1) & '0';
                        end if;
                        new_cycles_valid <= '1';
                     else
                        state_execute   <= CALC;
                        execute_start   <= '1';
                     end if;
                     
                     if (thumbmode = '1') then
                        execute_PCprev <= decode_PC - 2;
                     else
                        execute_PCprev <= decode_PC - 4;
                     end if;
                     
                     if (thumbmode = '1') then
                        execute_data <= x"0000" & decode_data(15 downto 0);
                     else
                        execute_data <= decode_data;
                     end if;
                     execute_fetch_cycles             <= decode_fetch_cycles;
                     execute_PC                       <= decode_PC;
                     execute_functions_detail         <= decode_functions_detail;
                     execute_datareceivetype          <= decode_datareceivetype;
                     execute_clearbit1                <= decode_clearbit1;      
                     execute_rdest                    <= decode_rdest;      
                     execute_Rn_op1                   <= decode_Rn_op1;   
                     execute_RM_op2                   <= decode_RM_op2;     
                     execute_alu_use_immi             <= decode_alu_use_immi;    
                     execute_alu_use_shift            <= decode_alu_use_shift;   
                     execute_immidiate                <= decode_immidiate;  
                     execute_shiftsettings            <= decode_shiftsettings;  
                     execute_shiftcarry               <= decode_shiftcarry; 
                     execute_useoldcarry              <= decode_useoldcarry;
                     execute_updateflags              <= decode_updateflags;
                     execute_muladd                   <= decode_muladd;
                     execute_mul_signed               <= decode_mul_signed;
                     execute_mul_useadd               <= decode_mul_useadd;
                     execute_mul_long                 <= decode_mul_long;
                     execute_mul_x_hi                 <= decode_mul_x_hi;
                     execute_mul_x_lo                 <= decode_mul_x_lo;
                     execute_mul_y_hi                 <= decode_mul_y_hi;
                     execute_mul_y_lo                 <= decode_mul_y_lo;
                     execute_mul_48                   <= decode_mul_48;
                     execute_mul_check_q              <= decode_mul_check_q;
                     execute_writeback                <= decode_writeback;  
                     execute_switch_op                <= decode_switch_op;  
                     execute_set_thumbmode            <= decode_set_thumbmode;  
                     execute_branch_usereg            <= decode_branch_usereg; 
                     execute_branch_link              <= decode_branch_link;
                     execute_branch_immi              <= decode_branch_immi;
                     execute_datatransfer_type        <= decode_datatransfer_type;   
                     execute_datatransfer_preadd      <= decode_datatransfer_preadd;   
                     execute_datatransfer_addup       <= decode_datatransfer_addup;    
                     execute_datatransfer_writeback   <= decode_datatransfer_writeback;
                     execute_datatransfer_addvalue    <= decode_datatransfer_addvalue; 
                     execute_datatransfer_shiftval    <= decode_datatransfer_shiftval; 
                     execute_datatransfer_regoffset   <= decode_datatransfer_regoffset; 
                     execute_datatransfer_swap        <= decode_datatransfer_swap; 
                     execute_datatransfer_double      <= decode_datatransfer_double; 
                     execute_block_usermoderegs       <= decode_block_usermoderegs; 
                     execute_block_switchmode         <= decode_block_switchmode; 
                     execute_block_addrmod            <= decode_block_addrmod; 
                     execute_block_endmod             <= decode_block_endmod; 
                     execute_block_addrmod_baseRlist  <= decode_block_addrmod_baseRlist; 
                     execute_block_reglist            <= decode_block_reglist; 
                     execute_block_emptylist          <= decode_block_emptylist; 
                     execute_block_wb_in_reglist      <= decode_block_wb_in_reglist; 
                     execute_psr_with_spsr            <= decode_psr_with_spsr; 
                     execute_force_armswitch          <= decode_force_armswitch; 
                     execute_leaveirp                 <= decode_leaveirp; 
                     execute_leaveirp_user            <= decode_leaveirp_user;
                     execute_co_opMode                <= decode_co_opMode;      
                     execute_co_SrcDstReg             <= decode_co_SrcDstReg;   
                     execute_co_armSrcDstReg          <= decode_co_armSrcDstReg;
                     execute_co_Number                <= decode_co_Number;      
                     execute_co_Info                  <= decode_co_Info;        
                     execute_co_opRegm                <= decode_co_opRegm;                           
                     
                  end if;
               
               when CALC =>
               
                  if (irq_calc = '1') then
                     state_execute <= FETCH_OP;
                  elsif ((execute_writeback_calc = '0' or writeback_reg /= x"F") and calc_done = '1' and branchnext = '0') then
                     state_execute <= FETCH_OP;
                     done             <= '1';
                     if (isArm9 = '1') then
                        if (execute_fetch_cycles > (execute_cycles + execute_addcycles + bus_addcycles)) then
                           new_cycles_out  <= to_unsigned(execute_fetch_cycles, new_cycles_out'length);
                        else
                           new_cycles_out  <= to_unsigned(execute_cycles + execute_addcycles + bus_addcycles, new_cycles_out'length);
                        end if;
                     else
                        if (execute_fetch_cycles > (execute_cycles + execute_addcycles + bus_addcycles)) then
                           new_cycles_out <= to_unsigned(execute_fetch_cycles, new_cycles_out'length - 1) & '0';
                        else
                           new_cycles_out <= to_unsigned(execute_cycles + execute_addcycles + bus_addcycles, new_cycles_out'length - 1) & '0';
                        end if;
                     end if;
                     new_cycles_valid <= '1';
                  end if;
                 
                  execute_cycles <= execute_cycles + execute_addcycles + bus_addcycles;
               
            end case;
         

         end if;
      end if;
   end process;
   
   -- fetch timing
   process (clk100) 
   begin
      if (rising_edge(clk100)) then
      
         if (state_decode = DECODE_DETAILS) then
         
            lastfetchAddress <= unsigned(decode_PC(31 downto 2)) & "00";
            
            if (isArm9 = '1') then
               if (unsigned(decode_PC(31 downto 24)) < 2) then
                  decode_fetch_cycles <= 1;
               elsif (decode_PC(27 downto 24) = x"2") then
                  if (decode_instr_cache = '0') then
                     decode_fetch_cycles <= 16#34#;
                  else
                     decode_fetch_cycles <= 1;
                  end if;
               else
                  decode_fetch_cycles <= codeticksAccess32;
                  if (thumbmode = '1') then
                     if ((unsigned(decode_PC(31 downto 2)) & "00") /= lastfetchAddress + 4) then
                        decode_fetch_cycles <= 6 + codeticksAccess32;
                     end if;
                  else
                     if (unsigned(decode_PC) /= lastfetchAddress + 4) then
                        decode_fetch_cycles <= 6 + codeticksAccess32;
                     end if;
                  end if;
               end if;
            else
               if (thumbmode = '1') then
                  decode_fetch_cycles <= codeticksAccess16;
               else
                  decode_fetch_cycles <= codeticksAccess32;
               end if;
            end if;
         
         end if;
      
      end if;
   end process;
   
   
   -- decoding function
   process (clk100) 
      variable opcode_high3      : std_logic_vector(2 downto 0);
      variable opcode_mid        : std_logic_vector(3 downto 0);
      variable opcode_low        : std_logic_vector(3 downto 0);
      variable bitcount8_low     : integer range 0 to 8;
      variable bitcount8_high    : integer range 0 to 8;
      
      variable decode_functions  : tFunctions;
      variable decode_datacomb   : std_logic_vector(27 downto 0) := (others => '0');
      
      -- decoding details
      variable opcode       : std_logic_vector(3 downto 0);
      variable use_imm      : std_logic;
      variable updateflags  : std_logic;
      variable Rn_op1       : std_logic_vector(3 downto 0);
      variable Rdest        : std_logic_vector(3 downto 0);
      variable RM_op2       : std_logic_vector(3 downto 0);
      variable OP2          : std_logic_vector(11 downto 0);
      
      variable rotateamount  : unsigned(4 downto 0);
      variable immidiate    : unsigned(31 downto 0);
      variable shiftcarry   : std_logic;
      variable useoldcarry  : std_logic;

   begin
   
      if (rising_edge(clk100)) then
   
         decode_datacomb  := decode_data(27 downto 0);
         
         decode_clearbit1 <= '0';
         
         bitcount8_low  := 0;
         bitcount8_high := 0;
         for i in 0 to 7 loop
            if (decode_data(i) = '1')     then bitcount8_low  := bitcount8_low + 1;  end if;
            if (decode_data(8 + i) = '1') then bitcount8_high := bitcount8_high + 1; end if;
         end loop;
         
         decode_functions := opcode_unknown;
   
         if (thumbmode = '0') then
         
            decode_condition <= decode_data(31 downto 28);

            opcode_high3  := decode_data(27 downto 25);
            opcode_mid    := decode_data(24 downto 21);
            opcode_low    := decode_data(7 downto 4);
   
            if (isArm9 = '1' and decode_data(31 downto 28) = x"F") then
            
               --if (decode_data(27 downto 26) = "01") then
               --   PLD
               --end if;
               
               if (decode_data(27 downto 25) = "101") then
                  decode_functions := blx_1;
                  decode_condition <= x"E"; -- make it execute always
               end if;
   
            elsif (isArm9 = '1' and decode_data(27 downto 26) = "00" and decode_data(24 downto 23) = "10" and decode_data(20) = '0' and not(decode_data(25) = '0' and decode_data(7) = '1' and decode_data(4) = '1')) then
               
               if (decode_data(25) = '1') then
                  decode_functions := data_processing; -- MRS/MSR
               else
               
                  case (opcode_low) is
                  
                     when x"0" =>
                        decode_functions := data_processing; -- MRS/MSR
                  
                     when x"1" =>
                        if (decode_data(22 downto 21) = "01") then
                           decode_functions := branch_and_exchange;
                           -- branch_and_exchange(RM_op2);
                        elsif (decode_data(22 downto 21) = "11") then
                           decode_functions := clz;
                           --count_leading_zeros((Byte)((asmcmd >> 12) & 0xF), (Byte)(asmcmd & 0xF));
                        end if;

                     when x"3" =>
                        decode_functions := blx_2;
                        
                     when x"5" =>
                        decode_functions := qaddsuball;

                     --when x"7" =>
                     --   BKPT
                        
                     when x"8" | x"A" | x"C" | x"E" =>
                        decode_functions := smulall;
                  
                     when others => null;
                  
                  end case;
                  
               end if;
   
            else
            
               case (to_integer(unsigned(opcode_high3))) is
               
                  when 0 => -- (27..25) = 000 => alu commands?
                     case (opcode_low) is
      
                        when x"1" =>
                           if (decode_data(24 downto 8) = '1' & x"2FFF") then
                              decode_functions := branch_and_exchange;
                              --branch_and_exchange(RM_op2);
                           else
                              decode_functions := data_processing;
                              --data_processing(use_imm, opcode_mid, updateflags, Rn_op1, Rdest, OP2, asmcmd);
                           end if;
      
                        when x"9" =>
                           if (unsigned(opcode_mid) >= 8) then
                              decode_functions := single_data_swap;
                              --single_data_swap((opcode_mid & 2) == 2, Rn_op1, Rdest, OP2);
                           elsif (unsigned(opcode_mid) >= 4) then
                              decode_functions := multiply_long;
                              --multiply_long(opcode_mid, updateflags, Rn_op1, Rdest, OP2);
                           else
                              decode_functions := multiply;
                              --multiply(opcode_mid, updateflags, Rdest, Rn_op1, (byte)((OP2 >> 8) & 0xF), (byte)(OP2 & 0xF));
                           end if;
      
                        when x"B" | x"D" | x"F" =>  -- halfword data transfer
                           if (isArm9 = '1' and (opcode_low = x"D" or opcode_low = x"F") and decode_data(20) = '0') then
                              decode_functions := ldrdstrd;
                           else
                              if (decode_data(22) = '1') then --  immidiate offset
                                 decode_functions := halfword_data_transfer_immoffset;
                                 --halfword_data_transfer(opcode_mid, opcode_low, updateflags, Rn_op1, Rdest, (UInt32)(((OP2 >> 4) & 0xF0) | RM_op2));
                              else -- register offset
                                 decode_functions := halfword_data_transfer_regoffset;
                                 --halfword_data_transfer(opcode_mid, opcode_low, updateflags, Rn_op1, Rdest, regs[RM_op2]);
                              end if;
                           end if;
      
                        when others =>
                           decode_functions := data_processing;
                           --data_processing(use_imm, opcode_mid, updateflags, Rn_op1, Rdest, OP2, asmcmd);
      
                     end case;
      
                  when 1 =>
                     decode_functions := data_processing;
                     --data_processing(use_imm, opcode_mid, updateflags, Rn_op1, Rdest, OP2, asmcmd);
      
                  when 2 | 3 =>
                     decode_functions := single_data_transfer;
                     --single_data_transfer(use_imm, opcode_mid, opcode_low, updateflags, Rn_op1, Rdest, OP2);
      
                  when 4 => 
                     decode_functions := block_data_transfer;
                     --block_data_transfer(opcode_mid, updateflags, Rn_op1, (UInt16)asmcmd);
      
                  when 5 =>
                     decode_functions := branch;
                     --branch((opcode_mid & 8) == 8, asmcmd & 0xFFFFFF);
                  
                  when 6 =>
                     if (isArm9 = '1') then
                        decode_functions := coprocessor_data_transfer;
                     end if;
      
                  when 7 =>
                     if (isArm9 = '1' and decode_data(24) = '0') then
                        if (decode_data(4) = '0') then
                           decode_functions := coprocessor_data_operation;
                        else
                           if (decode_data(20) = '1') then
                              decode_functions := coprocessor_register_transfer_read;
                           else
                              decode_functions := coprocessor_register_transfer_write;
                           end if;
                        end if;
                     else
                        decode_functions := software_interrupt;
                     end if;
               
                  when others => report "should never happen" severity failure; 
               
               end case;
               
            end if;
            
         else  -- thumb
         
            decode_condition <= x"E";
         
            case (to_integer(unsigned(decode_data(15 downto 13)))) is
         
               when 0 => 
                  if (decode_data(12 downto 11) = "11") then
                     decode_datacomb(27 downto 26)  := "00"; -- fixed
                     decode_datacomb(25)            := decode_data(10);  -- Immidiate
                     if (decode_data(9) = '1') then
                        decode_datacomb(24 downto 21)  := x"2"; -- Opcode -> sub
                     else
                        decode_datacomb(24 downto 21)  := x"4"; -- Opcode -> add
                     end if;
                     decode_datacomb(20)            := '1'; -- set condition codes
                     decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- RN -> 1st op
                     decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                     if (decode_data(10) = '1') then
                        decode_datacomb(11 downto  0)  := x"00" & '0' & decode_data(8 downto 6); -- 3 bit immidiate, no rotate
                     else
                        decode_datacomb(11 downto  4)  := x"00"; -- don't shift
                        decode_datacomb( 3 downto  0)  := '0' & decode_data(8 downto 6); -- Rm -> 2nd OP
                     end if;
                     decode_functions := data_processing;
                     --add_subtract(((asmcmd >> 10) & 1) == 1, ((asmcmd >> 9) & 1) == 1, (byte)((asmcmd >> 6) & 0x7), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                  else
                     decode_datacomb(27 downto 26)  := "00"; -- fixed
                     decode_datacomb(25)            := '0';  -- Immidiate
                     decode_datacomb(24 downto 21)  := x"D"; -- Opcode -> mov
                     decode_datacomb(20)            := '1'; -- set condition codes
                     decode_datacomb(19 downto 16)  := x"0"; -- RN -> 1st op
                     decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                     decode_datacomb(11 downto  7)  := decode_data(10 downto 6);  -- shift amount
                     decode_datacomb( 6 downto  5)  := decode_data(12 downto 11); -- shift type
                     decode_datacomb( 4)            := '0';  -- shift with immidiate
                     decode_datacomb( 3 downto  0)  := '0' & decode_data(5 downto 3); -- Rm -> 2nd OP
                     decode_functions := data_processing;
                     --move_shifted_register((byte)((asmcmd >> 11) & 3), (byte)((asmcmd >> 6) & 0x1F), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                  end if;
               
               when 1 =>
                  decode_datacomb(27 downto 26)  := "00"; -- fixed
                  decode_datacomb(25)            := '1';  -- Immidiate
                  case (decode_data(12 downto 11)) is
                     when "00" => decode_datacomb(24 downto 21)  := x"D"; -- Opcode -> mov
                     when "01" => decode_datacomb(24 downto 21)  := x"A"; -- Opcode -> cmp
                     when "10" => decode_datacomb(24 downto 21)  := x"4"; -- Opcode -> add
                     when "11" => decode_datacomb(24 downto 21)  := x"2"; -- Opcode -> sub
                     when others => report "should never happen" severity failure;
                  end case;
                  decode_datacomb(20)            := '1'; -- set condition codes
                  decode_datacomb(19 downto 16)  := '0' & decode_data(10 downto 8); -- RN -> 1st op
                  decode_datacomb(15 downto 12)  := '0' & decode_data(10 downto 8); -- Rdest
                  decode_datacomb(11 downto  0)  := x"0" & decode_data(7 downto 0); -- 8 bit immidiate, no rotate
                  decode_functions := data_processing;
                  --move_compare_add_subtract_immediate((byte)((asmcmd >> 11) & 3), (byte)((asmcmd >> 8) & 7), (byte)(asmcmd & 0xFF));
         
               when 2 =>
                  case (to_integer(unsigned(decode_data(12 downto 10)))) is
                     
                     when 0 =>
                        decode_datacomb(27 downto 26)  := "00"; -- fixed
                        decode_datacomb(25)            := '0';  -- Immidiate
                        decode_datacomb(20)            := '1'; -- set condition codes
                        decode_datacomb(19 downto 16)  := '0' & decode_data(2 downto 0); -- RN -> 1st op
                        decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                        decode_datacomb(11 downto  0)  := x"00" & '0' & decode_data(5 downto 3); -- RS -> 2nd OP -> no shift using op2 is default
                        decode_functions := data_processing;
                        case (decode_data(9 downto 6)) is
                           when x"0" => decode_datacomb(24 downto 21)  := x"0"; -- 0000 AND Rd, Rs ANDS Rd, Rd, Rs Rd:= Rd AND Rs
                           when x"1" => decode_datacomb(24 downto 21)  := x"1"; -- 0001 EOR Rd, Rs EORS Rd, Rd, Rs Rd:= Rd EOR Rs
                           
                           when x"2" =>                                         -- 0010 LSL Rd, Rs MOVS Rd, Rd, LSL Rs Rd := Rd << Rs
                              decode_datacomb(24 downto 21)  := x"D"; 
                              decode_datacomb(11 downto  0)  := '0' & decode_data(5 downto 3) & "0001" & '0' & decode_data(2 downto 0);
                           
                           when x"3" =>                                         -- 0011 LSR Rd, Rs MOVS Rd, Rd, LSR Rs Rd := Rd >> Rs
                              decode_datacomb(24 downto 21)  := x"D"; 
                              decode_datacomb(11 downto  0)  := '0' & decode_data(5 downto 3) & "0011" & '0' & decode_data(2 downto 0);
                              
                           when x"4" =>                                         -- 0100 ASR Rd, Rs MOVS Rd, Rd, ASR Rs Rd := Rd ASR Rs
                              decode_datacomb(24 downto 21)  := x"D"; 
                              decode_datacomb(11 downto  0)  := '0' & decode_data(5 downto 3) & "0101" & '0' & decode_data(2 downto 0);
                              
                           when x"5" => decode_datacomb(24 downto 21)  := x"5"; -- 0101 ADC Rd, Rs ADCS Rd, Rd, Rs Rd:= Rd + Rs + C - bit
                           when x"6" => decode_datacomb(24 downto 21)  := x"6"; -- 0110 SBC Rd, Rs SBCS Rd, Rd, Rs Rd:= Rd - Rs - NOT C - bit
                           
                           when x"7" =>                                         -- 0111 ROR Rd, Rs MOVS Rd, Rd, ROR Rs Rd := Rd ROR Rs
                              decode_datacomb(24 downto 21)  := x"D"; 
                              decode_datacomb(11 downto  0)  := '0' & decode_data(5 downto 3) & "0111" & '0' & decode_data(2 downto 0);                              
              
                           when x"8" => decode_datacomb(24 downto 21)  := x"8"; -- 1000 TST Rd, Rs TST Rd, Rs Set condition codes on Rd AND Rs
                           
                           when x"9" =>                                         -- 1001 NEG Rd, Rs RSBS Rd, Rs, #0 Rd = -Rs
                              decode_datacomb(24 downto 21)  := x"3"; 
                              decode_datacomb(25)            := '1';  -- Immidiate
                              decode_datacomb(11 downto  0)  := x"000";
                              decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- RS as 1st op
                              
                           when x"A" => decode_datacomb(24 downto 21)  := x"A"; -- 1010 CMP Rd, Rs CMP Rd, Rs Set condition codes on Rd - Rs
                           when x"B" => decode_datacomb(24 downto 21)  := x"B"; -- 1011 CMN Rd, Rs CMN Rd, Rs Set condition codes on Rd + Rs
                           when x"C" => decode_datacomb(24 downto 21)  := x"C"; -- 1100 ORR Rd, Rs ORRS Rd, Rd, Rs Rd:= Rd OR Rs
                           
                           when x"D" =>                                      -- 1101 MUL Rd, Rs MULS Rd, Rs, Rd Rd:= Rs * Rd
                              decode_datacomb(27 downto 20)  := x"01"; -- fixed 
                              decode_datacomb( 7 downto  4)  := x"9";  -- fixed 
                              decode_datacomb(11 downto  8)  := '0' & decode_data(2 downto 0); -- multiplier
                              decode_functions := multiply;
                              
                           when x"E" => decode_datacomb(24 downto 21)  := x"E"; -- 1110 BIC Rd, Rs BICS Rd, Rd, Rs Rd:= Rd AND NOT Rs
                           when x"F" => decode_datacomb(24 downto 21)  := x"F"; -- 1111 MVN Rd, Rs MVNS Rd, Rs Rd:= NOT Rs
                           when others => report "should never happen" severity failure;
                        end case;
                        
                        --alu_operations((byte)((asmcmd >> 6) & 0xF), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                      
                     when 1 =>
                        decode_datacomb(27 downto 26)  := "00"; -- fixed
                        decode_datacomb(25)            := '0';  -- Immidiate
                        decode_datacomb(20)            := '0'; -- set condition codes
                        decode_datacomb(19 downto 16)  := '0' & decode_data(2 downto 0); -- RN -> 1st op
                        decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                        decode_datacomb(11 downto  0)  := x"00" & '0' & decode_data(5 downto 3); -- RS -> 2nd OP -> no shift using op2 is default
                        decode_functions               := data_processing;
                        case (decode_data(9 downto 6)) is
                           when x"1" => decode_datacomb(24 downto 21) := x"4"; decode_datacomb( 3) := '1';                                                         -- 0001 ADD Rd, Hs ADD Rd, Rd, Hs Add a register in the range 8 - 15 to a register in the range 0 - 7.
                           when x"2" => decode_datacomb(24 downto 21) := x"4"; decode_datacomb(19) := '1'; decode_datacomb(15) := '1';                             -- 0010 ADD Hd, Rs ADD Hd, Hd, Rs Add a register in the range 0 - 7 to a register in the range 8 - 15.
                           when x"3" => decode_datacomb(24 downto 21) := x"4"; decode_datacomb( 3) := '1'; decode_datacomb(19) := '1'; decode_datacomb(15) := '1'; -- 0011 ADD Hd, Hs ADD Hd, Hd, Hs Add two registers in the range 8 - 15
                                                                                
                           when x"5" => decode_datacomb(24 downto 21) := x"A"; decode_datacomb( 3) := '1';                                                         decode_datacomb(20) := '1'; -- 0101 CMP Rd, Hs CMP Rd, Hs Compare a register in the range 0 - 7 with a register in the range 8 - 15.Set the condition code flags on the result.
                           when x"6" => decode_datacomb(24 downto 21) := x"A"; decode_datacomb(19) := '1'; decode_datacomb(15) := '1';                             decode_datacomb(20) := '1'; -- 0110 CMP Hd, Rs CMP Hd, Rs Compare a register in the range 8 - 15 with a register in the range 0 - 7.Set the condition code flags on the result.
                           when x"7" => decode_datacomb(24 downto 21) := x"A"; decode_datacomb( 3) := '1'; decode_datacomb(19) := '1'; decode_datacomb(15) := '1'; decode_datacomb(20) := '1'; -- 0111 CMP Hd, Hs CMP Hd, Hs Compare two registers in the range 8 - 15.Set the condition code flags on the result.
                                                                                                                                                                   
                           when x"8" => decode_datacomb(24 downto 21) := x"D";                                                                                     -- 1000 -> undefined but probably just using low for both  
                           when x"9" => decode_datacomb(24 downto 21) := x"D"; decode_datacomb( 3) := '1';                                                         -- 1001 MOV Rd, Hs MOV Rd, Hs Move a value from a register in the range 8 - 15 to a register in the range 0 - 7.  
                           when x"A" => decode_datacomb(24 downto 21) := x"D"; decode_datacomb(19) := '1'; decode_datacomb(15) := '1';                             -- 1010 MOV Hd, Rs MOV Hd, Rs Move a value from a register in the range 0 - 7 to a register in the range 8 - 15.
                           when x"B" => decode_datacomb(24 downto 21) := x"D"; decode_datacomb( 3) := '1'; decode_datacomb(19) := '1'; decode_datacomb(15) := '1'; -- 1011 MOV Hd, Hs MOV Hd, Hs Move a value between two registers in the range 8 - 15.
                                                                               
                           when x"C" => decode_functions := branch_and_exchange;                               -- 1100 BX Rs Perform branch(plus optional state change) to address in a register in the range 0 - 7.
                           when x"D" => decode_functions := branch_and_exchange; decode_datacomb(3) := '1';  -- 1101 BX Hs Perform branch(plus optional state change) to address in a register in the range 8 - 15.

                           when x"E" | x"F" =>
                              if (isArm9 = '1') then
                                 decode_functions            := blx_2;
                                 decode_datacomb(3 downto 0) := decode_data(6 downto 3);
                              else
                                 null;
                              end if;

                           -- can't do this check, as prefetch may fetch data that could contain this
                           --when others => report "decode_data(12 downto 10) = 1 => case should never happen" severity failure;
                           when others => null;
                        end case;
                        
                        --hi_register_operations_branch_exchange((byte)((asmcmd >> 6) & 0xF), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));   
               
                     when 2 | 3 =>
                        decode_datacomb(27 downto 26)  := "01"; -- fixed
                        decode_datacomb(25)            := '0';  -- offset is immidiate
                        decode_datacomb(24)            := '1';  -- pre add offset
                        decode_datacomb(23)            := '1';  -- add offset
                        decode_datacomb(22)            := '0';  -- word
                        decode_datacomb(21)            := '0';  -- writeback
                        decode_datacomb(20)            := decode_data(11); -- read/write
                        decode_datacomb(19 downto 16)  := x"F"; -- base register
                        decode_clearbit1               <= '1';
                        decode_datacomb(15 downto 12)  := '0' & decode_data(10 downto 8); -- Rdest
                        decode_datacomb(11 downto  0)  := "00" & decode_data(7 downto 0) & "00"; -- offset immidiate
                        decode_functions := single_data_transfer;
                        --pc_relative_load((byte)((asmcmd >> 8) & 0x7), (byte)(asmcmd & 0xFF));
                        
                     when 4 | 5 | 6 | 7 =>
                        if (decode_data(9) = '0') then
                           decode_datacomb(27 downto 26)  := "01"; -- fixed
                           decode_datacomb(25)            := '1';  -- offset is reg
                           decode_datacomb(24)            := '1';  -- pre add offset
                           decode_datacomb(23)            := '1';  -- add offset
                           decode_datacomb(22)            := decode_data(10);  -- byte/word
                           decode_datacomb(21)            := '0';  -- writeback
                           decode_datacomb(20)            := decode_data(11); -- read/write
                           decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- base register
                           decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                           decode_datacomb(11 downto  4)  := x"00"; -- don't shift
                           decode_datacomb( 3 downto  0)  := '0' & decode_data(8 downto 6); -- offset register
                           decode_functions := single_data_transfer;
                           --load_store_with_register_offset(((asmcmd >> 11) & 1) == 1, ((asmcmd >> 10) & 1) == 1, (byte)((asmcmd >> 6) & 0x7), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                        else
                           decode_datacomb(27 downto 25)  := "000"; -- fixed
                           decode_datacomb(24)            := '1';  -- pre add offset
                           decode_datacomb(23)            := '1';  -- add offset
                           decode_datacomb(22)            := '1';  -- fixed
                           decode_datacomb(21)            := '0';  -- writeback
                           decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- base register
                           decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                           decode_datacomb(11 downto  8)  := "0000"; -- fixed
                           decode_datacomb( 7)            := '1'; -- fixed
                           decode_datacomb( 4)            := '1'; -- fixed
                           decode_datacomb( 3 downto  0)  := '0' & decode_data(8 downto 6); -- offset register
                           case (decode_data(11 downto 10)) is -- read     S                             H
                              when "00" => decode_datacomb(20) := '0'; decode_datacomb(6) := '0'; decode_datacomb(5) := '1'; -- Store halfword
                              when "01" => decode_datacomb(20) := '1'; decode_datacomb(6) := '1'; decode_datacomb(5) := '0'; -- Load sign-extended byte
                              when "10" => decode_datacomb(20) := '1'; decode_datacomb(6) := '0'; decode_datacomb(5) := '1'; -- Load halfword
                              when "11" => decode_datacomb(20) := '1'; decode_datacomb(6) := '1'; decode_datacomb(5) := '1'; -- Load sign-extended halfword
                              when others => null;  
                           end case;
                           decode_functions := halfword_data_transfer_regoffset;
                           --load_store_sign_extended_byte_halfword((byte)((asmcmd >> 10) & 0x3), (byte)((asmcmd >> 6) & 0x7), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                        end if;
                        
                     when others => report "should never happen" severity failure;
               
                  end case;
               
               when 3 =>
                  decode_datacomb(27 downto 26)  := "01"; -- fixed
                  decode_datacomb(25)            := '0';  -- offset is reg
                  decode_datacomb(24)            := '1';  -- pre add offset
                  decode_datacomb(23)            := '1';  -- add offset
                  decode_datacomb(22)            := decode_data(12);  -- dword
                  decode_datacomb(21)            := '0';  -- writeback
                  decode_datacomb(20)            := decode_data(11); -- read/write
                  decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- base register
                  decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                  if (decode_data(12) = '1') then -- byte -> 5 bit address
                     decode_datacomb(11 downto  0)  := "0000000" & decode_data(10 downto 6); -- offset immidiate
                  else
                     decode_datacomb(11 downto  0)  := "00000" & decode_data(10 downto 6) & "00"; -- offset immidiate
                  end if;
                  decode_functions := single_data_transfer;
                  --load_store_with_immidiate_offset(((asmcmd >> 11) & 1) == 1, ((asmcmd >> 12) & 1) == 1, (byte)((asmcmd >> 6) & 0x1F), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
               
               when 4 =>
                  if (decode_data(12) = '0') then
                     decode_datacomb(27 downto 25)  := "000"; -- fixed
                     decode_datacomb(24)            := '1';  -- pre add offset
                     decode_datacomb(23)            := '1';  -- add offset
                     decode_datacomb(22)            := '1';  -- fixed
                     decode_datacomb(21)            := '0';  -- writeback
                     decode_datacomb(20)            := decode_data(11); -- read/write
                     decode_datacomb(19 downto 16)  := '0' & decode_data(5 downto 3); -- base register
                     decode_datacomb(15 downto 12)  := '0' & decode_data(2 downto 0); -- Rdest
                     decode_datacomb(11 downto  8)  := "00" & decode_data(10 downto 9); -- offset immidiate
                     decode_datacomb( 7)            := '1'; -- fixed
                     decode_datacomb( 6)            := '0'; -- S
                     decode_datacomb( 5)            := '1'; -- H
                     decode_datacomb( 4)            := '1'; -- fixed
                     decode_datacomb( 3 downto  0)  := decode_data(8 downto 6) & '0'; -- offset immidiate
                     decode_functions := halfword_data_transfer_immoffset;
                     --load_store_halfword(((asmcmd >> 11) & 1) == 1, (byte)((asmcmd >> 6) & 0x1F), (byte)((asmcmd >> 3) & 0x7), (byte)(asmcmd & 0x7));
                  else
                     decode_datacomb(27 downto 26)  := "01"; -- fixed
                     decode_datacomb(25)            := '0';  -- offset is reg
                     decode_datacomb(24)            := '1';  -- pre add offset
                     decode_datacomb(23)            := '1';  -- add offset
                     decode_datacomb(22)            := '0';  -- dword
                     decode_datacomb(21)            := '0';  -- writeback
                     decode_datacomb(20)            := decode_data(11); -- read/write
                     decode_datacomb(19 downto 16)  := x"D"; -- base register
                     decode_datacomb(15 downto 12)  := '0' & decode_data(10 downto 8); -- Rdest
                     decode_datacomb(11 downto  0)  := "00" & decode_data(7 downto 0) & "00"; -- offset immidiate
                     decode_functions := single_data_transfer;
                     --sp_relative_load_store(((asmcmd >> 11) & 1) == 1, (byte)((asmcmd >> 8) & 0x7), (byte)(asmcmd & 0xFF));
                  end if;
                  
               when 5 =>
                  if (decode_data(12) = '0') then
                     decode_datacomb(27 downto 26)  := "00"; -- fixed
                     decode_datacomb(25)            := '1';  -- Immidiate
                     decode_datacomb(24 downto 21)  := x"4"; -- Opcode -> add
                     decode_datacomb(20)            := '0';  -- set condition codes
                     if (decode_data(11) = '1') then -- stack pointer 13(1) or PC(15)
                        decode_datacomb(19 downto 16)  := x"D"; -- RN -> 1st op
                     else 
                        decode_datacomb(19 downto 16)  := x"F"; -- RN -> 1st op
                        decode_clearbit1               <= '1';
                     end if;
                     decode_datacomb(15 downto 12)  := '0' & decode_data(10 downto 8); -- Rdest
                     decode_datacomb(11 downto  0)  := x"F" & decode_data(7 downto 0); -- 8 bit immidiate, shift left by 2
                     decode_functions := data_processing;
                     --load_address(((asmcmd >> 11) & 1) == 1, (byte)((asmcmd >> 8) & 0x7), (byte)(asmcmd & 0xFF));
                  else
                     if (decode_data(10) = '0') then
                        decode_datacomb(27 downto 26)  := "00"; -- fixed
                        decode_datacomb(25)            := '1';  -- Immidiate
                        if (decode_data(7) = '1') then -- sign bit
                           decode_datacomb(24 downto 21)  := x"2"; -- Opcode -> sub
                        else 
                           decode_datacomb(24 downto 21)  := x"4"; -- Opcode -> add
                        end if;
                        decode_datacomb(20)            := '0'; -- set condition codes
                        decode_datacomb(19 downto 16)  := x"D"; -- RN -> 1st op
                        decode_datacomb(15 downto 12)  := x"D"; -- Rdest
                        decode_datacomb(11 downto  0)  := x"F" & '0' & decode_data(6 downto 0); -- 8 bit immidiate, shift left by 2
                        decode_functions := data_processing;
                        --add_offset_to_stack_pointer(((asmcmd >> 7) & 1) == 1, (byte)(asmcmd & 0x7F));
                     else
                        decode_datacomb(27 downto 25)  := "100"; -- fixed
                        decode_datacomb(22)            := '0'; -- PSR
                        decode_datacomb(21)            := '1'; -- Writeback
                        decode_datacomb(20)            := decode_data(11); -- Load
                        decode_datacomb(15 downto 0)   := x"00" & decode_data(7 downto 0); -- reglist
                        decode_datacomb(19 downto 16)  := x"D"; -- base register -> 13
                        bitcount8_high := 0;
                        if (decode_data(8) = '1') then -- link
                           bitcount8_high := 1;
                           if (decode_data(11) = '1') then -- load
                              decode_datacomb(15) := '1';
                           else
                              decode_datacomb(14) := '1';
                           end if;
                        end if;
                        -- LDMIA!  opcode = !pre up !csr store  <-> // STMDB !  opcode = pre !up !csr store
                        decode_datacomb(24) := not decode_data(11); -- Pre
                        decode_datacomb(23) := decode_data(11);     -- up
                        decode_functions := block_data_transfer;
                        --push_pop_register(((asmcmd >> 11) & 1) == 1, ((asmcmd >> 8) & 1) == 1, (byte)(asmcmd & 0xFF));
                     end if;
                  end if;
                  
               when 6 => 
                  if (decode_data(12) = '0') then
                     decode_datacomb(27 downto 25)  := "100"; -- fixed
                     decode_datacomb(24)            := '0'; -- Pre
                     decode_datacomb(23)            := '1'; -- up
                     decode_datacomb(22)            := '0'; -- PSR
                     decode_datacomb(21)            := '1'; -- Writeback
                     decode_datacomb(20)            := decode_data(11); -- Load
                     decode_datacomb(19 downto 16)  := '0' & decode_data(10 downto 8); -- base register
                     decode_datacomb(15 downto 0)   := x"00" & decode_data(7 downto 0); -- reglist
                     bitcount8_high                 := 0;
                     decode_functions               := block_data_transfer;
                     --multiple_load_store(((asmcmd >> 11) & 1) == 1, (byte)((asmcmd >> 8) & 0x7), (byte)(asmcmd & 0xFF));
                  else
                     if (decode_data(11 downto 8) = x"F") then
                        decode_functions := software_interrupt;
                        --software_interrupt();
                     else
                        decode_datacomb(27 downto 25) := "101"; -- fixed
                        decode_datacomb(24)           := '0';   -- without link
                        decode_datacomb(23 downto 0)  := std_logic_vector(resize(signed(decode_data(7 downto 0)), 24));
                        decode_condition              <= decode_data(11 downto 8);
                        decode_functions := branch;
                        --conditional_branch((byte)((asmcmd >> 8) & 0xF), (byte)(asmcmd & 0xFF));
                     end if;
                  end if;
                     
               when 7 =>
                  if (decode_data(12) = '0') then
                     if (isArm9 = '0' or decode_data(11) = '0') then
                        decode_datacomb(27 downto 25) := "101"; -- fixed
                        decode_datacomb(24)           := '0';   -- without link
                        decode_datacomb(23 downto 0)  := std_logic_vector(resize(signed(decode_data(10 downto 0)), 24));
                        decode_functions              := branch;
                        --unconditional_branch((UInt16)(asmcmd & 0x7FF));
                     else 
                        decode_functions              := long_branch_with_link;
                        --blx_thumb_1(asmcmd & 0x7FF);
                     end if;
                  else
                     decode_functions := long_branch_with_link;
                     --long_branch_with_link(((asmcmd >> 11) & 1) == 1, (UInt16)(asmcmd & 0x7FF));
                  end if;
               
               when others => report "should never happen" severity failure; 
         
            end case;
         
         end if;
   
      -- decoding details
   
         use_imm       := decode_datacomb(25);
         updateflags   := decode_datacomb(20);
         Rn_op1        := decode_datacomb(19 downto 16);
         Rdest         := decode_datacomb(15 downto 12);
         RM_op2        := decode_datacomb(3 downto 0);
         OP2           := decode_datacomb(11 downto 0);
         opcode        := decode_datacomb(24 downto 21);
      
         decode_updateflags            <= '1';
         decode_alu_use_immi           <= '0';
         decode_alu_use_shift          <= '0';
         decode_switch_op              <= '0';
         decode_datatransfer_shiftval  <= '0';
         decode_datatransfer_regoffset <= '0';
         decode_datatransfer_swap      <= '0';
         decode_datatransfer_double    <= '0';
         decode_datatransfer_writeback <= '0';
         decode_leaveirp               <= '0';
         decode_leaveirp_user          <= '0';
         
         decode_shiftsettings    <= decode_datacomb(11 downto 4);
         
         decode_mul_x_hi               <= '0';
         decode_mul_x_lo               <= '0';
         decode_mul_y_hi               <= '0';
         decode_mul_y_lo               <= '0';
         decode_mul_48                 <= '0';
         decode_mul_check_q            <= '0';
   
         case (decode_functions) is 
            when opcode_unknown =>
               decode_functions_detail <= decode_unknown;
         
            when data_processing =>
         
               -- imidiate calculation
               rotateamount := unsigned(Op2(11 downto 8)) & '0';
               immidiate   := x"000000" & unsigned(Op2(7 downto 0));
               
               useoldcarry := '0';
               shiftcarry  := '0';
               if (rotateamount = 0) then
                  useoldcarry := '1';
               else
                  shiftcarry  := immidiate(to_integer(rotateamount) - 1);
               end if;

               immidiate   := immidiate ror to_integer(rotateamount);
            
               decode_rdest            <= Rdest;
               decode_Rn_op1           <= Rn_op1;
               decode_RM_op2           <= RM_op2;
               decode_alu_use_immi     <= use_imm;
               decode_immidiate        <= immidiate;
               decode_shiftcarry       <= shiftcarry;
               decode_useoldcarry      <= useoldcarry;
               decode_updateflags      <= updateflags;
               decode_alu_use_shift    <= not use_imm;
            
               if (updateflags = '0' and unsigned(opcode) >= 8 and unsigned(opcode) <= 11) then -- PSR Transfer
            
                  decode_psr_with_spsr    <= decode_datacomb(22); -- spsr -> reg17
            
                  if (decode_datacomb(21 downto 16) = "001111") then 
                     decode_functions_detail <= data_processing_MRS; -- MRS (transfer PSR contents to a register)
                  else
                     decode_functions_detail <= data_processing_MSR; -- MSR (transfer register contents or immdiate value to PSR)
                  end if;
            
               else
               
                  case opcode is
                     when x"0" => decode_functions_detail <= alu_and;           decode_writeback <= '1'; decode_switch_op <= '0'; --  AND 0000 operand1 AND operand2
                     when x"1" => decode_functions_detail <= alu_xor;           decode_writeback <= '1'; decode_switch_op <= '0'; --  EOR 0001 operand1 EOR operand2
                     when x"2" => decode_functions_detail <= alu_sub;           decode_writeback <= '1'; decode_switch_op <= '0'; --  SUB 0010 operand1 - operand2
                     when x"3" => decode_functions_detail <= alu_sub;           decode_writeback <= '1'; decode_switch_op <= '1'; --  RSB 0011 operand2 - operand1
                     when x"4" => decode_functions_detail <= alu_add;           decode_writeback <= '1'; decode_switch_op <= '0'; --  ADD 0100 operand1 + operand2
                     when x"5" => decode_functions_detail <= alu_add_withcarry; decode_writeback <= '1'; decode_switch_op <= '0'; --  ADC 0101 operand1 + operand2 + carry
                     when x"6" => decode_functions_detail <= alu_sub_withcarry; decode_writeback <= '1'; decode_switch_op <= '0'; --  SBC 0110 operand1 - operand2 + carry - 1
                     when x"7" => decode_functions_detail <= alu_sub_withcarry; decode_writeback <= '1'; decode_switch_op <= '1'; --  RSC 0111 operand2 - operand1 + carry - 1
                     when x"8" => decode_functions_detail <= alu_and;           decode_writeback <= '0'; decode_switch_op <= '0'; --  TST 1000 as AND, but result is not written
                     when x"9" => decode_functions_detail <= alu_xor;           decode_writeback <= '0'; decode_switch_op <= '0'; --  TEQ 1001 as EOR, but result is not written
                     when x"A" => decode_functions_detail <= alu_sub;           decode_writeback <= '0'; decode_switch_op <= '0'; --  CMP 1010 as SUB, but result is not written
                     when x"B" => decode_functions_detail <= alu_add;           decode_writeback <= '0'; decode_switch_op <= '0'; --  CMN 1011 as ADD, but result is not written
                     when x"C" => decode_functions_detail <= alu_or;            decode_writeback <= '1'; decode_switch_op <= '0'; --  ORR 1100 operand1 OR operand2
                     when x"D" => decode_functions_detail <= alu_mov;           decode_writeback <= '1'; decode_switch_op <= '0'; --  MOV 1101 operand2(operand1 is ignored)
                     when x"E" => decode_functions_detail <= alu_and_not;       decode_writeback <= '1'; decode_switch_op <= '0'; --  BIC 1110 operand1 AND NOT operand2(Bit clear)
                     when x"F" => decode_functions_detail <= alu_mov_not;       decode_writeback <= '1'; decode_switch_op <= '0'; --  MVN 1111 NOT operand2(operand1 is ignored)
                     when others => report "should never happen" severity failure; 
                  end case;
                  
                  if ((unsigned(opcode) < 8 or unsigned(opcode) >= 12) and Rdest = x"F" and updateflags = '1') then
                     decode_leaveirp <= '1';
                     if (cpu_mode = CPUMODE_SYSTEM or cpu_mode = CPUMODE_USER) then
                        decode_leaveirp_user <= '1';
                        decode_updateflags   <= '0';
                     end if;
                  end if;
               
               end if;
               
            when multiply | multiply_long =>
               decode_functions_detail <= mulboth;
               decode_rdest            <= decode_datacomb(19 downto 16);
               decode_Rn_op1           <= decode_datacomb(3 downto 0);
               decode_RM_op2           <= decode_datacomb(11 downto 8);
               decode_updateflags      <= decode_datacomb(20);
               decode_muladd           <= decode_datacomb(15 downto 12);
               decode_mul_signed       <= decode_datacomb(22);
               decode_mul_useadd       <= decode_datacomb(21);
               decode_mul_long         <= '0';
               if (decode_functions = multiply_long) then
                  decode_mul_long <= '1';
               end if;
               
            when branch =>
               decode_functions_detail <= branch_all;
               decode_set_thumbmode    <= '0';
               decode_branch_link      <= decode_datacomb(24);
               if (thumbmode = '1') then
                  decode_branch_immi   <= resize(signed(decode_datacomb(23 downto 0)), 25) & "0";
               else
                  decode_branch_immi   <= signed(decode_datacomb(23 downto 0)) & "00";
               end if;
               decode_rdest            <= x"E"; -- 14
               decode_branch_usereg    <= '0';
            
            when branch_and_exchange =>
               decode_functions_detail <= branch_all;
               decode_set_thumbmode    <= '1';
               decode_RM_op2           <= RM_op2;
               decode_branch_usereg    <= '1';
               decode_branch_link      <= '0';
                            
            when single_data_transfer | halfword_data_transfer_regoffset | halfword_data_transfer_immoffset | single_data_swap => 
               if (decode_datacomb(20) = '1') then
                  decode_functions_detail <= data_read;
               else
                  decode_functions_detail <= data_write;
               end if;
               decode_RM_op2 <= RM_op2;
               decode_Rn_op1 <= Rn_op1;
               decode_rdest  <= Rdest;
               
               decode_datatransfer_preadd    <= opcode(3);
               decode_datatransfer_addup     <= opcode(2);
               decode_datatransfer_writeback <= (not opcode(3)) or opcode(0);
               if (Rn_op1 = Rdest and decode_datacomb(20) = '1') then --when storing, result address can be written
                  decode_datatransfer_writeback <= '0';
               end if;
               
               decode_datatransfer_shiftval  <= '0';
               decode_datatransfer_regoffset <= '0';
               decode_datatransfer_swap      <= '0';
               decode_datatransfer_addvalue  <= (others => '0');
               
               if (decode_functions = single_data_transfer) then
                  decode_datatransfer_addvalue  <= unsigned(op2);
                  decode_datatransfer_shiftval  <= use_imm;
                  decode_datatransfer_regoffset <= use_imm;
                  if (opcode(1) = '1') then
                     decode_datatransfer_type <= ACCESS_8BIT;
                     decode_datareceivetype   <= RECEIVETYPE_BYTE;
                  else
                     decode_datatransfer_type <= ACCESS_32BIT;
                     decode_datareceivetype   <= RECEIVETYPE_DWORD;
                  end if;
               elsif (decode_functions = halfword_data_transfer_regoffset or decode_functions = halfword_data_transfer_immoffset) then
                  case (decode_datacomb(6 downto 5)) is
                     when "01" => decode_datatransfer_type <= ACCESS_16BIT; decode_datareceivetype <= RECEIVETYPE_WORD;
                     when "10" => decode_datatransfer_type <= ACCESS_8BIT;  decode_datareceivetype <= RECEIVETYPE_SIGNEDBYTE;
                     when "11" => decode_datatransfer_type <= ACCESS_16BIT; decode_datareceivetype <= RECEIVETYPE_SIGNEDWORD;
                     when others => report "should never happen" severity failure;
                  end case;
                  decode_datatransfer_addvalue <= x"0" & unsigned(decode_datacomb(11 downto 8)) & unsigned(decode_datacomb(3 downto 0));
                  if (decode_functions = halfword_data_transfer_regoffset) then
                     decode_datatransfer_regoffset <= '1';
                  end if;
               elsif (decode_functions = single_data_swap) then
                  decode_datatransfer_writeback <= '0';
                  decode_functions_detail       <= data_read;
                  decode_datatransfer_swap      <= '1';
                  if (opcode(1) = '1') then
                     decode_datatransfer_type <= ACCESS_8BIT;
                     decode_datareceivetype   <= RECEIVETYPE_BYTE;
                  else
                     decode_datatransfer_type <= ACCESS_32BIT;
                     decode_datareceivetype   <= RECEIVETYPE_DWORD;
                  end if;
               end if;
            
            when block_data_transfer  => 
               if (decode_datacomb(20) = '1') then
                  decode_functions_detail <= block_read;
               else
                  decode_functions_detail <= block_write;
               end if;
               
               decode_Rn_op1                 <= Rn_op1;
               decode_block_reglist          <= decode_datacomb(15 downto 0);
               decode_datatransfer_preadd    <= opcode(3);
               decode_datatransfer_addup     <= opcode(2);
               decode_datatransfer_writeback <= opcode(0);
               decode_block_wb_in_reglist    <= '0';
               if (decode_datacomb(to_integer(unsigned(Rn_op1))) = '1' and decode_datacomb(20) = '1') then -- writeback in reglist and load
                  decode_block_wb_in_reglist <= '1';
               end if;
               if (decode_datacomb(15 downto 0) = x"0000") then -- reglist empty
                  decode_block_reglist(15) <= '1';
                  decode_block_emptylist   <= '1';
               else
                  decode_block_emptylist   <= '0';
               end if;
               
               decode_block_usermoderegs <= '0';
               decode_block_switchmode   <= '0';
               if (opcode(1) = '1') then
                  if ((decode_datacomb(15) = '1' and decode_datacomb(20) = '0') or (decode_datacomb(15) = '0')) then
                     decode_block_usermoderegs <= '1';
                  end if;
                  if (decode_datacomb(15) = '1' and decode_datacomb(20) = '1') then
                     decode_block_switchmode <= '1';
                  end if;
               end if;
               
               decode_block_addrmod <= 0;
               decode_block_endmod  <= 0;
               if (opcode(2) = '0') then -- down
                  if (decode_datacomb(15 downto 0) = x"0000") then -- reglist empty
                     decode_block_endmod  <= -64;
                     decode_block_addrmod <= -64;
                     if (opcode(3) = '0') then -- not pre
                        decode_block_addrmod <= -60;
                     end if;
                  else
                     decode_block_endmod <= (-4) * (bitcount8_low + bitcount8_high);
                     if (opcode(3) = '0') then -- not pre
                        decode_block_addrmod <= ((-4) * (bitcount8_low + bitcount8_high)) + 4;
                     else
                        decode_block_addrmod <= (-4) * (bitcount8_low + bitcount8_high);
                     end if;
                     decode_block_addrmod_baseRlist <= (-4) * (bitcount8_low + bitcount8_high);
                  end if;
               elsif (opcode(3) = '1') then -- pre
                  decode_block_addrmod <= 4;
               end if;
               if (opcode(2) = '1') then --up
                  decode_block_addrmod_baseRlist <= 4 * (bitcount8_low + bitcount8_high);
                  if (decode_datacomb(15 downto 0) = x"0000") then -- empty list
                     decode_block_endmod <= 64;
                  end if;
               end if;
               
            when software_interrupt => 
               decode_functions_detail <= software_interrupt_detail;
               decode_rdest            <= x"E"; -- 14
         
            -- thumb
            when long_branch_with_link => 
               decode_force_armswitch  <= '0';
               if (isArm9 = '1' and decode_data(12 downto 11) = "01") then
                  decode_force_armswitch  <= '1';
               end if;
               if (decode_datacomb(11) = '0') then
                  decode_functions_detail <= alu_add;
                  decode_writeback        <= '1'; 
                  decode_rdest            <= x"E";
                  decode_Rn_op1           <= x"F";
                  decode_alu_use_immi     <= '1';
                  decode_updateflags      <= '0';
                  decode_immidiate        <= unsigned(resize(signed(decode_datacomb(10 downto 0)), 20)) & x"000";
               else
                  decode_functions_detail <= long_branch_with_link_low;
                  decode_immidiate        <= x"00000" & "0" & unsigned(decode_datacomb(10 downto 0));
               end if;
               
            -- ARM9
            when blx_1 =>
               decode_functions_detail <= branch_all;
               decode_set_thumbmode    <= '1';
               decode_branch_link      <= '1';
               if (thumbmode = '1') then
                  decode_branch_immi   <= resize(signed(decode_datacomb(23 downto 1)), 24) & "00"; -- ignore bit 0 of source to force bit 1 to zero as ARMmode does not allow unalligned address, armdoc: "this restriction is obeyed"
               else
                  decode_branch_immi   <= signed(decode_datacomb(23 downto 0)) & decode_data(24) & '1'; -- lowest bit 1 -> internal handling for switch to arm/thumbmode
               end if;
               decode_rdest            <= x"E"; -- 14
               decode_branch_usereg    <= '0';
               
            when blx_2 =>
               decode_functions_detail <= branch_all;
               decode_set_thumbmode    <= '1';
               decode_branch_link      <= '1';
               decode_rdest            <= x"E"; -- 14
               decode_branch_usereg    <= '1';
               decode_RM_op2           <= RM_op2;
            
            when clz =>
               decode_functions_detail <= count_leading_zeros;
               decode_rdest            <= Rdest;
               decode_Rn_op1           <= decode_datacomb(3 downto 0);
            
            when qaddsuball =>
               decode_rdest            <= Rdest;
               decode_Rn_op1           <= Rn_op1;
               decode_RM_op2           <= RM_op2;
               decode_alu_use_immi     <= '0';
               decode_shiftcarry       <= '0';
               decode_useoldcarry      <= '0';
               decode_updateflags      <= '0';
               decode_alu_use_shift    <= '0';
               case (decode_data(22 downto 21)) is
                  when "00" => decode_functions_detail <= alu_qadd;
                  when "01" => decode_functions_detail <= alu_qsub;
                  when "10" => decode_functions_detail <= alu_qdadd;
                  when "11" => decode_functions_detail <= alu_qdsub;
                  when others => null;
               end case;
            
            when smulall =>
               decode_functions_detail <= mul_arm9;
               decode_rdest            <= decode_datacomb(19 downto 16);
               decode_Rn_op1           <= decode_datacomb(3 downto 0);
               decode_RM_op2           <= decode_datacomb(11 downto 8);
               decode_muladd           <= decode_datacomb(15 downto 12);
               decode_updateflags      <= '0';
               decode_mul_signed       <= '1';
               decode_mul_x_hi  <= decode_data(5);    -- overwritten for SMLAWy and SMULWy
               decode_mul_x_lo  <= not decode_data(5);
               decode_mul_y_hi  <= decode_data(6);
               decode_mul_y_lo  <= not decode_data(6);
               decode_mul_long  <= '0';
               case (decode_data(22 downto 21)) is
                  when "00" => -- SMLAxy
                     decode_mul_useadd  <= '1';
                     decode_mul_check_q <= '1';
                  
                  when "01" =>
                     decode_mul_x_hi <= '0';
                     decode_mul_x_lo <= '0';
                     decode_mul_48   <= '1';
                     if (decode_data(5) = '1') then -- SMULWy(1y10)
                        decode_mul_useadd <= '0';
                     else -- SMLAWy (1y00)
                        decode_mul_useadd  <= '1';
                        decode_mul_check_q <= '1';
                     end if;
                  
                  when "10" => -- SMLALxy
                     decode_mul_useadd <= '1';
                     decode_mul_long   <= '1';

                  when "11" => -- SMULxy
                     decode_mul_useadd <= '0';
                  
                  when others => null;
               end case;
               
            when ldrdstrd =>
               if (decode_data(5) = '0') then
                  decode_functions_detail <= data_read;
               else
                  decode_functions_detail <= data_write;
               end if;
               decode_RM_op2 <= RM_op2;
               decode_Rn_op1 <= Rn_op1;
               decode_rdest  <= Rdest; 
               decode_datatransfer_preadd    <= decode_data(24);
               decode_datatransfer_addup     <= decode_data(23);
               decode_datatransfer_writeback <= (not decode_data(24)) or decode_data(21);
               if (Rn_op1 = Rdest and decode_datacomb(5) = '0') then --when storing, result address can be written, unpredicatable in documentation
                  decode_datatransfer_writeback <= '0';
               end if;
               decode_datatransfer_shiftval  <= '0';
               decode_datatransfer_swap      <= '0';
               decode_datatransfer_double    <= '1';
               decode_datatransfer_type      <= ACCESS_32BIT;
               decode_datareceivetype        <= RECEIVETYPE_DWORD;
               decode_datatransfer_addvalue  <= x"0" & unsigned(decode_data(11 downto 8)) & unsigned(decode_data(3 downto 0));
               decode_datatransfer_regoffset <= not decode_data(22);
               if (Rdest(0) = '1' or Rdest(3 downto 1) = "111") then -- sanity check i is even and not 14
                  decode_functions_detail <= decode_unknown;
               end if;  
            
            when coprocessor_data_transfer =>
               decode_functions_detail <= coprocessor_data;
               
            when coprocessor_data_operation =>
               decode_functions_detail <= coprocessor_data;
            
            when coprocessor_register_transfer_read =>
               decode_functions_detail <= coprocessor_register_read;
               decode_co_opMode       <= decode_data(23 downto 21);
               decode_co_SrcDstReg    <= decode_data(19 downto 16);
               decode_co_armSrcDstReg <= decode_data(15 downto 12);
               decode_co_Number       <= decode_data(11 downto  8);
               decode_co_Info         <= decode_data( 7 downto  5);
               decode_co_opRegm       <= decode_data( 3 downto  0);

            when coprocessor_register_transfer_write =>
               decode_functions_detail <= coprocessor_register_write;
               decode_co_opMode       <= decode_data(23 downto 21);
               decode_co_SrcDstReg    <= decode_data(19 downto 16);
               decode_co_armSrcDstReg <= decode_data(15 downto 12);
               decode_co_Number       <= decode_data(11 downto  8);
               decode_co_Info         <= decode_data( 7 downto  5);
               decode_co_opRegm       <= decode_data( 3 downto  0);
            
         end case;
         
         
      end if;
   
   end process;
   
   
   memoryWait16    <= (1, 1, 2, 2, 2, 2, 2, 2, 16, 16, 16, 2, 2, 2, 2, 2) when isArm9 = '1' else (1, 1, 1, 1, 1, 1, 1, 1,  8,  8,  8, 1, 1, 1, 1, 1);
   memoryWait32    <= (1, 1, 4, 2, 2, 4, 4, 2, 32, 32, 32, 2, 2, 2, 2, 2) when isArm9 = '1' else (1, 1, 2, 1, 1, 2, 2, 1, 16, 16, 16, 1, 1, 1, 1, 1);
  
   dataticksAccess16        <=    memoryWait16(to_integer(unsigned(busaddress(27 downto 24))));
   dataticksAccess32        <=    memoryWait32(to_integer(unsigned(busaddress(27 downto 24))));
   --dataticksAccessSeq16     <= memoryWaitSeq16(to_integer(unsigned(busaddress(27 downto 24)))); -- probably not required, as dataseq32 is only for block read/write and block cmd can only do 32bit accesses 
   dataticksAccessSeq32     <= memoryWait32(to_integer(unsigned(busaddress(27 downto 24))));
                            
   codeticksAccess16        <=    memoryWait16(to_integer(unsigned(PC(27 downto 24))));
   codeticksAccess32        <=    memoryWait32(to_integer(unsigned(PC(27 downto 24))));
   codeticksAccessSeq16     <= memoryWait16(to_integer(unsigned(PC(27 downto 24))));
   codeticksAccessSeq32     <= memoryWait32(to_integer(unsigned(PC(27 downto 24))));   
   
   codeticksAccessJump16    <=    memoryWait16(to_integer(unsigned(new_pc(27 downto 24))));
   codeticksAccessJump32    <=    memoryWait32(to_integer(unsigned(new_pc(27 downto 24))));
   codeticksAccessSeqJump16 <= memoryWait16(to_integer(unsigned(new_pc(27 downto 24))));
   codeticksAccessSeqJump32 <= memoryWait32(to_integer(unsigned(new_pc(27 downto 24))));  
   
   codeticksAccess1632    <= 1 when (isArm9= '1' or thumbmode = '1') else codeticksAccess32;
   codeticksAccessSeq1632 <= 1 when (isArm9= '1' or thumbmode = '1') else codeticksAccess32;
   
   codeBaseAccess1632    <= codeticksAccess16    when (thumbmode = '1') else codeticksAccess32;
   codeBaseAccessSeq1632 <= codeticksAccessSeq16 when (thumbmode = '1') else codeticksAccessSeq32;
   

   process (clk100) 
      variable ticks : integer range 0 to 127;
   begin
      if (rising_edge(clk100)) then
   
         bus_addcycles <= 0;
      
         if (dataaccess_cyclecheck = '1' or datacache_read_checked = '1' or datacache_write_checked = '1') then
         
            if (bus_execute_acc = ACCESS_8BIT or bus_execute_acc = ACCESS_16BIT) then -- dataTicksAccess816
         
               lastAddress   <= unsigned(busaddress);
               
               ticks := 0;
               if (isArm9 = '1') then
                  if ((busaddress(31 downto 14)) = Co15_DTCMRegion(31 downto 14)) then
                     ticks := 1;
                  elsif (to_integer(unsigned(busaddress(27 downto 24))) = 2) then
                     if (datacache_read_cached = '1' or datacache_write_cached = '1') then
                        ticks := 1;
                     else
                        if ((bus_execute_acc = ACCESS_16BIT and unsigned(busaddress) = lastAddress + 2) or (bus_execute_acc = ACCESS_8BIT and unsigned(busaddress) = lastAddress + 1)) then
                           ticks := 2;
                        elsif (bus_execute_rnw = '1') then
                           ticks := 10;
                        else
                           ticks := 4;
                        end if;
            
                        if (bus_execute_rnw = '1') then
                           ticks := ticks + 32;
                        end if;
                     end if;
                  else
                     ticks := dataticksAccess16;
            
                     if ((bus_execute_acc = ACCESS_16BIT and unsigned(busaddress) /= lastAddress + 2) or (bus_execute_acc = ACCESS_8BIT and unsigned(busaddress) /= lastAddress + 1)) then
                        ticks := ticks + 6;
                     end if;
                  end if; 
               else
                  ticks := dataticksAccess16;
            
                  if ((bus_execute_acc = ACCESS_16BIT and unsigned(busaddress) /= lastAddress + 2) or (bus_execute_acc = ACCESS_8BIT and unsigned(busaddress) /= lastAddress + 1)) then
                     ticks := ticks + 1;
                  end if;
                  
               end if;
               
               bus_addcycles <= ticks;
   
            elsif (bus_execute_acc = ACCESS_32BIT) then -- dataTicksAccess32
         
               lastAddress   <= unsigned(busaddress);
               
               ticks := 0;
               if (isArm9 = '1') then
                  if ((busaddress(31 downto 14)) = Co15_DTCMRegion(31 downto 14)) then
                     ticks := 1;
                  elsif (to_integer(unsigned(busaddress(27 downto 24))) = 2) then
                     if (datacache_read_cached = '1' or datacache_write_cached = '1') then
                        ticks := 1;
                     else
                        if (unsigned(busaddress) = lastAddress + 4) then
                           ticks := 4;
                        elsif (bus_execute_rnw = '1') then
                           ticks := 20;
                        else
                           ticks := 8;
                        end if;
            
                        if (bus_execute_rnw = '1') then
                           ticks := ticks + 32;
                        end if;
                     end if;
                  else
                     ticks := dataticksAccess32;
            
                     if (unsigned(busaddress) /= lastAddress + 4) then
                        ticks := ticks + 6;
                     end if;
                  end if; 
               else
                  ticks := dataticksAccess32;
            
                  if (unsigned(busaddress) /= lastAddress + 4) then
                     ticks := ticks + 1;
                  end if;
                  
               end if;
               
               bus_addcycles <= ticks;
               
            end if;
            
         end if;
         
      end if;
   end process;
   
   gdatacache: if isArm9 = '1' generate
   begin
      idatacache : entity work.ds_cpucache
      generic map
      (
         LINES             => 32,
         CANROTATE         => '1'
      )
      port map
      (
         clk               => clk100,
         ds_on             => ds_on,
                           
         read_enable       => datacache_read_enable,
         read_addr         => datacache_read_addr,  
         read_acc          => bus_execute_acc,
         read_data         => datacache_read_data,  
         read_done         => datacache_read_done,  
         read_checked      => datacache_read_checked,
         read_cached       => datacache_read_cached,
                           
         write_enable      => datacache_write_enable,
         write_addr        => datacache_write_addr,  
         write_checked     => datacache_write_checked,
         write_cached      => datacache_write_cached,
                           
         mem_read_ena      => datacache_mem_read_ena, 
         mem_read_addr     => datacache_mem_read_addr,
         mem_read_data     => ram128data_data,
         mem_read_done     => ram128data_done,
         
         snoop_Adr         => snoop_Adr, 
         snoop_data        => snoop_data,
         snoop_we          => snoop_we,  
         snoop_be          => snoop_be  
      );
   end generate;
   
   
   -- calc
   process (clk100) 
      variable new_pc_var  : unsigned(31 downto 0);
      variable new_value   : unsigned(31 downto 0);
      variable firstbitpos : integer range 0 to 15;
      variable readdata    : std_logic_vector(31 downto 0);
      variable readaddr    : unsigned(31 downto 0);
      variable qmul2       : signed(32 downto 0);
      variable mul_resfull : unsigned(63 downto 0);
   begin
   
      if (rising_edge(clk100)) then
   
         execute_addcycles  <= 0;
         
         calc_done     <= '0';
         jump          <= '0';
         branchnext    <= '0';
         blockr15jump  <= '0';
         
         bus_execute_ena <= '0';
         
         bus_lowbits     <= "00";
         
         execute_writeback_calc     <= '0';
         execute_writeback_r17      <= '0';
         execute_writeback_userreg  <= '0';
         execute_switchregs         <= '0';
         execute_saveregs           <= '0';
         execute_saveState          <= '0';
         execute_SWI                <= '0';
         execute_IRP                <= '0';
         
         shifter_start              <= '0';
         
         datacache_read_enable      <= '0';
         datacache_write_enable     <= '0';
         dataaccess_cyclecheck      <= '0';
         
         new_halt_co15              <= '0';
         
   
         if (reset = '1') then -- reset
            Flag_Zero       <= SAVESTATE_Flag_Zero;      
            Flag_Carry      <= SAVESTATE_Flag_Carry;     
            Flag_Negative   <= SAVESTATE_Flag_Negative;  
            Flag_V_Overflow <= SAVESTATE_Flag_V_Overflow;
            if (isArm9 = '1') then
               Flag_Q       <= SAVESTATE_Flag_Q;
            else
               Flag_Q       <= '0';
            end if;
            thumbmode       <= SAVESTATE_thumbmode;      
            cpu_mode        <= SAVESTATE_cpu_mode;       
            IRQ_disable     <= SAVESTATE_IRQ_disable;    
            FIQ_disable     <= SAVESTATE_FIQ_disable;    
            
            executebus      <= '0';
            
            alu_stage       <= ALUSTART;
            mul_stage       <= MULSTART;
            data_rw_stage   <= FETCHADDR;
            block_rw_stage  <= BLOCKFETCHADDR;
            MSR_Stage       <= MSR_START;
            clz_stage       <= CLZSTART;
            
            if (isArm9 = '1') then
               Co15_ctrl            <= x"00012078";
               Co15_DaccessPerm     <= x"22222222";
               Co15_IaccessPerm     <= x"22222222";
                       
               Co15_ICConfig        <= (others => '0');
               Co15_DCConfig        <= (others => '0');
               Co15_writeBuffCtrl   <= (others => '0');
               Co15_DTCMRegion      <= (others => '0');
               
               Co15_protectBaseSize <= (others => (others => '0'));
            end if;
            
         elsif (ds_on = '1') then
            
            if ((execute_writeback_calc = '1' and writeback_reg = x"F" and blockr15jump = '0')) then
               branchnext       <= '1';
               if (thumbmode = '1') then
                  new_pc     <= calc_result(new_pc'left downto 1) & '0';
               else
                  new_pc     <= calc_result(new_pc'left downto 2) & "00";
               end if;
            end if;
            
            if (branchnext = '1') then
               jump             <= '1';
               calc_done        <= '1';
            end if;
            
            if (irq_calc = '1') then
               calc_result            <= execute_PCprev + 4; -- working code suggests always +4 even for thumbmode? seems to be correct!
               execute_writeback_calc <= '1';
               writeback_reg          <= x"E";
               
               execute_saveState  <= '1';
               execute_switchregs <= '1';
               execute_saveregs   <= '1';
               execute_IRP        <= '1';
               cpu_mode_old       <= cpu_mode;
               cpu_mode           <= CPUMODE_IRQ;
               thumbmode          <= '0';
               IRQ_disable        <= '1';
               new_pc             <= irpTarget + to_unsigned(16#18#, new_pc'length);
               jump               <= '1';
               calc_done          <= '1';
            end if;
         
            case execute_functions_detail is
            
               when decode_unknown =>
                  if (execute_start = '1') then
                     calc_done <= '1';
                  end if;
            
               when alu_and | alu_xor | alu_add | alu_sub | alu_add_withcarry | alu_sub_withcarry | alu_or | alu_mov | alu_and_not | alu_mov_not | alu_qadd | alu_qsub | alu_qdadd | alu_qdsub =>
                  case (alu_stage) is                                                                                                         
                     when ALUSTART =>                                                                                                              
                        if (execute_start = '1') then  
                           if (execute_functions_detail = alu_qdadd or execute_functions_detail = alu_qdsub) then
                              alu_stage <= ALUQMUL2;
                           elsif (execute_alu_use_shift = '1') then
                              alu_stage     <= ALUSHIFT;
                              shifter_start <= '1';
                           else
                              if (execute_switch_op = '1') then
                                 alu_stage <= ALUSWITCHOP;
                              else
                                 alu_stage <= ALUCALC;
                              end if;
                           end if;
                           
                           -- timing
                           if (execute_rdest = x"F") then
                              execute_addcycles  <= 3;
                           elsif (execute_functions_detail = alu_qadd or execute_functions_detail = alu_qsub or execute_functions_detail = alu_qdadd or execute_functions_detail = alu_qdsub) then
                              execute_addcycles  <= 2;
                           elsif (execute_alu_use_shift = '1' and execute_shiftsettings(0) = '1') then
                              execute_addcycles  <= 2;
                           end if;
                           
                        end if;
                        alu_op1 <= regs(to_integer(unsigned(execute_Rn_op1)));
                        if (execute_clearbit1 = '1') then
                           alu_op1(1) <= '0';
                        end if;
                        if (execute_alu_use_immi = '1') then
                           alu_op2 <= execute_immidiate;
                        else
                           alu_op2  <= regs(to_integer(unsigned(execute_Rm_op2)));
                           shiftreg <= regs(to_integer(unsigned(execute_Rm_op2)));
                        end if;
                        shiftbyreg       <= regs(to_integer(unsigned(execute_shiftsettings(7 downto 4))))(7 downto 0);
                        alu_shiftercarry <= execute_shiftcarry;
                        if (execute_useoldcarry = '1') then
                           alu_shiftercarry <= Flag_Carry;
                        end if;
                        
                     when ALUSHIFT =>
                        if (execute_shiftsettings = x"00") then
                           if (execute_switch_op = '1') then
                              alu_stage <= ALUSWITCHOP;
                           else
                              alu_stage <= ALUCALC;
                           end if;
                        else
                           alu_stage    <= ALUSHIFTWAIT;
                           shiftwait    <= 2;
                        end if;
                        if (execute_shiftsettings(0) = '1') then
                           if (execute_Rn_op1 = x"F") then
                              alu_op1 <= regs_plus_12;
                           end if;
                        end if;
                        
                     when ALUSHIFTWAIT =>
                        if (shiftwait > 0) then
                           shiftwait <= shiftwait - 1;
                        else
                           alu_op2          <= shiftresult;
                           alu_shiftercarry <= shiftercarry;
                           if (execute_switch_op = '1') then
                              alu_stage <= ALUSWITCHOP;
                           else
                              alu_stage <= ALUCALC;
                           end if;
                        end if;
                        
                     when ALUSWITCHOP =>
                        alu_op1 <= alu_op2;
                        alu_op2 <= alu_op1;
                        alu_stage <= ALUCALC;
                        
                     when ALUQMUL2 =>
                        alu_stage <= ALUCALC;
                        qmul2 := signed(alu_op2) & '0';
                        if (signed(qmul2) < -2147483648) then
                           alu_op2     <= x"80000000";
                           Flag_Q      <= '1';
                        elsif (signed(qmul2) > 2147483647) then
                           alu_op2     <= x"7FFFFFFF";
                           Flag_Q      <= '1';
                        else
                           alu_op2     <= unsigned(qmul2(31 downto 0));
                        end if;
                        
                     when ALUCALC  => 
                        alu_saturate_max <= '0';
                        alu_saturate_min <= '0';
                        case (execute_functions_detail) is
                           when alu_and =>     alu_result <= alu_op1 and alu_op2;          
                           when alu_xor =>     alu_result <= alu_op1 xor alu_op2;       
                           when alu_or  =>     alu_result <= alu_op1  or alu_op2;         
                           when alu_and_not => alu_result <= alu_op1 and (not alu_op2);                                     
                           when alu_mov =>     alu_result <= alu_op2;                      
                           when alu_mov_not => alu_result <= not alu_op2;                  
                              
                           when alu_add => 
                              alu_result_add <= ('0' & alu_op1) + ('0' & alu_op2);
                              
                           when alu_qadd | alu_qdadd => 
                              alu_result_add <= ('0' & alu_op1) + ('0' & alu_op2);
                              if ((resize(signed(alu_op1), 33) + resize(signed(alu_op2), 33)) < -2147483648) then
                                 alu_saturate_min <= '1';
                              end if;
                              if ((resize(signed(alu_op1), 33) + resize(signed(alu_op2), 33)) > 2147483647) then
                                 alu_saturate_max <= '1';
                              end if;
                           
                           when alu_sub => 
                              alu_result <= alu_op1 - alu_op2;
                              
                           when alu_qsub | alu_qdsub => 
                              alu_result <= alu_op1 - alu_op2;
                              if ((resize(signed(alu_op1), 33) - resize(signed(alu_op2), 33)) < -2147483648) then
                                 alu_saturate_min <= '1';
                              end if;
                              if ((resize(signed(alu_op1), 33) - resize(signed(alu_op2), 33)) > 2147483647) then
                                 alu_saturate_max <= '1';
                              end if;
                              
                           when alu_add_withcarry =>
                              if (Flag_Carry = '1') then
                                 alu_result_add <= ('0' & alu_op1) + ('0' & alu_op2) + to_unsigned(1, 33);
                              else
                                 alu_result_add <= ('0' & alu_op1) + ('0' & alu_op2);
                              end if;
                           
                           when alu_sub_withcarry =>
                              if (Flag_Carry = '1') then
                                 alu_result <= alu_op1 - alu_op2;
                              else
                                 alu_result <= alu_op1 - alu_op2 - 1;
                              end if;
 
                           when others => report "should never happen" severity failure;
                        end case;
                        alu_stage <= ALUSETFLAGS;
                        
                     when ALUSETFLAGS =>
                        if (execute_leaveirp = '1') then
                           alu_stage              <= ALULEAVEIRP;
                        else
                           alu_stage              <= ALUSTART;
                           calc_done              <= '1';
                           execute_writeback_calc <= execute_writeback;
                           writeback_reg          <= execute_rdest;
                        end if;
                        
                        if (execute_updateflags = '1') then
                        
                           if (alu_result = 0) then Flag_Zero <= '1'; else Flag_Zero <= '0'; end if;
                           Flag_Negative <= alu_result(31);
                        
                           case (execute_functions_detail) is
                              when alu_and =>     Flag_Carry <= alu_shiftercarry; 
                              when alu_xor =>     Flag_Carry <= alu_shiftercarry; 
                              when alu_or  =>     Flag_Carry <= alu_shiftercarry; 
                              when alu_and_not => Flag_Carry <= alu_shiftercarry;                                  
                              when alu_mov =>     Flag_Carry <= alu_shiftercarry; 
                              when alu_mov_not => Flag_Carry <= alu_shiftercarry; 
                              
                              when alu_add | alu_add_withcarry =>  
                                 if (alu_result_add(31 downto 0) = 0) then Flag_Zero <= '1'; else Flag_Zero <= '0'; end if;
                                 Flag_Negative <= alu_result_add(31);
                                 Flag_Carry <= alu_result_add(32);
                                 if ((alu_op1(31) xor alu_result_add(31)) = '1' and (alu_op2(31) xor alu_result_add(31)) = '1') then
                                    Flag_V_Overflow <= '1';
                                 else
                                    Flag_V_Overflow <= '0';
                                 end if;
                              
                              when alu_sub => 
                                 if (alu_op1(31) /= alu_op2(31) and alu_op1(31) /= alu_result(31)) then
                                    Flag_V_Overflow <= '1';
                                 else
                                    Flag_V_Overflow <= '0';
                                 end if;
                                 if (alu_op1 >= alu_op2) then -- subs -> carry is 0 if borror, 1 otherwise
                                    Flag_Carry <= '1'; 
                                 else
                                    Flag_Carry <= '0'; 
                                 end if;
                              
                              when alu_sub_withcarry =>
                                 if (alu_op1(31) /= alu_op2(31) and alu_op1(31) /= alu_result(31)) then
                                    Flag_V_Overflow <= '1';
                                 else
                                    Flag_V_Overflow <= '0';
                                 end if;
                                 if (Flag_Carry = '1') then
                                    if (alu_op1 >= alu_op2) then
                                       Flag_Carry <= '1'; 
                                    else
                                       Flag_Carry <= '0'; 
                                    end if;
                                 else
                                    if (alu_op1 = 0) then
                                       Flag_Carry <= '0'; 
                                    elsif ((alu_op1 - 1) >= alu_op2) then
                                       Flag_Carry <= '1'; 
                                    else
                                       Flag_Carry <= '0'; 
                                    end if;
                                 end if;
                           
                              when others => report "should never happen" severity failure;
                           end case;
                        end if;
                        
                        if (alu_saturate_max = '1') then
                           calc_result <= x"7FFFFFFF";
                           Flag_Q      <= '1';
                        elsif (alu_saturate_min = '1') then
                           calc_result <= x"80000000";
                           Flag_Q      <= '1';
                        elsif (execute_functions_detail = alu_add or execute_functions_detail = alu_add_withcarry or execute_functions_detail = alu_qadd or execute_functions_detail = alu_qdadd) then
                           calc_result <= alu_result_add(31 downto 0);
                        else
                           calc_result <= alu_result;
                        end if;
                        
                     when ALULEAVEIRP =>
                        alu_stage              <= ALUSTART;
                        calc_done              <= '1';
                        execute_writeback_calc <= execute_writeback;
                        writeback_reg          <= execute_rdest;
                        execute_saveregs       <= '1';
                        execute_saveState      <= '0';
                        execute_switchregs     <= '1';
                        if (
                              (cpu_mode = CPUMODE_USER   and (std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_USER or std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_SYSTEM)) or
                              (cpu_mode = CPUMODE_SYSTEM and (std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_USER or std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_SYSTEM))
                          ) then
                           execute_switchregs  <= '0';
                        end if;
                        cpu_mode_old           <= cpu_mode;
                        if (execute_leaveirp_user = '0') then
                           cpu_mode               <= std_logic_vector(regs(17)(3 downto 0));
                           thumbmode              <= regs(17)(5);
                           FIQ_disable            <= regs(17)(6);
                           IRQ_disable            <= regs(17)(7);
                           Flag_Negative          <= regs(17)(31);
                           Flag_Zero              <= regs(17)(30);
                           Flag_Carry             <= regs(17)(29);
                           Flag_V_Overflow        <= regs(17)(28);
                           if (isArm9 = '1') then
                              Flag_Q              <= regs(17)(27);
                           end if;
                        end if;
               
                  end case;
                  
               when mulboth | mul_arm9 =>
                  case (mul_stage) is
                     when MULSTART =>
                        if (execute_start = '1') then
                           if (execute_mul_x_lo = '1') then
                              mul_op1 <= unsigned(resize(signed(regs(to_integer(unsigned(execute_Rn_op1)))(15 downto 0)), 32)); 
                           elsif (execute_mul_x_hi = '1') then
                              mul_op1 <= unsigned(resize(signed(regs(to_integer(unsigned(execute_Rn_op1)))(31 downto 16)), 32)); 
                           else
                              mul_op1 <= regs(to_integer(unsigned(execute_Rn_op1))); 
                           end if;
                           if (execute_mul_y_lo = '1') then
                              mul_op2 <= unsigned(resize(signed(regs(to_integer(unsigned(execute_RM_op2)))(15 downto 0)), 32)); 
                           elsif (execute_mul_y_hi = '1') then
                              mul_op2 <= unsigned(resize(signed(regs(to_integer(unsigned(execute_RM_op2)))(31 downto 16)), 32)); 
                           else
                              mul_op2 <= regs(to_integer(unsigned(execute_RM_op2))); -- to be used for timing
                           end if;
                           
                           mul_opaddlow  <= regs(to_integer(unsigned(execute_muladd)));
                           mul_opaddhigh <= regs(to_integer(unsigned(execute_rdest)));
                           mul_stage <= MULCALCMUL;
                           mul_wait  <= 3;
                           if (execute_mul_long = '1') then
                              execute_addcycles  <= 1;
                           end if;
                        end if;
                     
                     when MULCALCMUL =>
                        if (execute_mul_48 = '1') then
                           mul_resfull := unsigned(signed(mul_op1) * signed(mul_op2));
                           mul_result <= x"00000000" & mul_resfull(47 downto 16);
                        elsif (execute_mul_long = '0' or execute_mul_signed = '0') then
                           mul_result <= mul_op1 * mul_op2;
                        else
                          mul_result <= unsigned(signed(mul_op1) * signed(mul_op2));
                        end if;
                        if (mul_wait > 0) then
                           mul_wait <= mul_wait - 1;
                        else
                           if (execute_mul_useadd = '1') then
                              mul_stage <= MULADDLOW;
                           elsif (execute_updateflags = '1') then
                              mul_stage <= MULSETFLAGS;
                           else
                              mul_stage <= MULWRITEBACK_LOW;
                           end if;
                           
                        end if;
                        -- timing
                        if (mul_wait = 3 and execute_functions_detail = mulboth) then
                           execute_addcycles <= 4; 
                              if (mul_op2(31 downto 8)  = x"000000" or mul_op2(31 downto 8)  = x"FFFFFF") then execute_addcycles <= 1;
                           elsif (mul_op2(31 downto 16) = x"0000"   or mul_op2(31 downto 16) = x"FFFF")   then execute_addcycles <= 2;
                           elsif (mul_op2(31 downto 24) = x"00"     or mul_op2(31 downto 24) = x"FF")     then execute_addcycles <= 3; end if;  
                        end if;
                        if (mul_wait = 2 and execute_mul_useadd = '1') then
                           execute_addcycles  <= 1;
                        end if;
                     
                     when MULADDLOW =>
                        if (execute_mul_useadd = '1') then
                           mul_result         <= mul_result + mul_opaddlow;
                           if (execute_mul_check_q = '1') then
                              if ((resize(signed(mul_result(31 downto 0)), 33) + resize(signed(mul_opaddlow), 33)) < -2147483648) then
                                 Flag_Q <= '1';
                              end if;
                              if ((resize(signed(mul_result(31 downto 0)), 33) + resize(signed(mul_opaddlow), 33)) > 2147483647) then
                                 Flag_Q <= '1';
                              end if;
                           end if;
                        end if;
                        if (execute_mul_long = '1') then
                           mul_stage <= MULADDHIGH;
                        elsif (execute_updateflags = '1') then
                           mul_stage <= MULSETFLAGS;
                        else
                           mul_stage <= MULWRITEBACK_LOW;
                        end if;
                     
                     when MULADDHIGH =>
                        mul_result <= mul_result + (mul_opaddhigh & x"00000000");
                        if (execute_updateflags = '1') then
                           mul_stage <= MULSETFLAGS;
                        else
                           mul_stage <= MULWRITEBACK_LOW;
                        end if;
                     
                     when MULSETFLAGS =>
                        mul_stage <= MULWRITEBACK_LOW;
                        if (execute_mul_long = '1') then
                           if (mul_result = 0) then Flag_Zero <= '1'; else Flag_Zero <= '0'; end if;
                           Flag_Negative <= mul_result(63);
                        else
                           if (mul_result(31 downto 0) = 0) then Flag_Zero <= '1'; else Flag_Zero <= '0'; end if;
                           Flag_Negative <= mul_result(31);
                        end if;
                     
                     when MULWRITEBACK_LOW =>
                        execute_writeback_calc <= '1';
                        calc_result            <= mul_result(31 downto 0);
                        if (execute_mul_long = '1') then
                           mul_stage     <= MULWRITEBACK_HIGH;
                           writeback_reg <= execute_muladd;
                        else
                           writeback_reg <= execute_rdest;
                           mul_stage <= MULSTART;
                           calc_done <= '1';
                           -- timing
                           execute_addcycles  <= 1;
                        end if;
                     
                     when MULWRITEBACK_HIGH =>
                        mul_stage <= MULSTART;
                        calc_done <= '1';
                        writeback_reg          <= execute_rdest;
                        execute_writeback_calc <= '1';
                        calc_result            <= mul_result(63 downto 32);
                        -- timing
                        execute_addcycles  <= 1;
                              
                  end case;
                  
               when data_processing_MRS =>
                  if (execute_start = '1') then
                     calc_done <= '1';
                     writeback_reg          <= execute_rdest;
                     execute_writeback_calc <= '1';
                     if (execute_psr_with_spsr = '1') then
                        calc_result <= regs(17);
                     else
                        calc_result <= regs(16);
                     end if;
                     execute_addcycles      <= 1;
                  end if;               
                  
               when data_processing_MSR =>
                  case (MSR_Stage) is
                     when MSR_START =>
                        if (execute_start = '1') then
                           if (execute_alu_use_immi = '1') then
                              msr_value <= execute_immidiate(31 downto 24) & x"00000" & execute_immidiate(3 downto 0); -- immidiate is for flags only
                           else
                              msr_value <= regs(to_integer(unsigned(execute_Rm_op2)));
                           end if;
                           msr_writebackvalue <= regs(17);
                           if (execute_psr_with_spsr = '1') then
                              MSR_Stage <= MSR_SPSR;
                           else
                              MSR_Stage <= MSR_CPSR;
                           end if;
                        end if;
                        
                     when MSR_SPSR =>
                        MSR_Stage <= MSR_START;
                        calc_done <= '1';
                        execute_writeback_r17 <= '1';
                        if (cpu_mode /= CPUMODE_USER) then
                           if (execute_Rn_op1(0) = '1') then msr_writebackvalue( 7 downto  0) <= msr_value( 7 downto  0); end if;
                           if (execute_Rn_op1(1) = '1') then msr_writebackvalue(15 downto  8) <= msr_value(15 downto  8); end if;
                           if (execute_Rn_op1(2) = '1') then msr_writebackvalue(23 downto 16) <= msr_value(23 downto 16); end if;
                           if (execute_Rn_op1(3) = '1') then msr_writebackvalue(31 downto 24) <= msr_value(31 downto 24); end if;
                        end if;
                        execute_addcycles      <= 1;
                        
                     when MSR_CPSR =>
                        calc_done      <= '1';
                        MSR_Stage      <= MSR_START;
                        new_value := regs(16);
                        if (execute_alu_use_immi = '1') then
                           new_value(31 downto 24) := msr_value(31 downto 24);
                        end if;
                        if (cpu_mode /= CPUMODE_USER) then
                           if (execute_Rn_op1(0) = '1') then new_value( 7 downto  0) := msr_value( 7 downto  0); end if;
                           if (execute_Rn_op1(1) = '1') then new_value(15 downto  8) := msr_value(15 downto  8); end if;
                           if (execute_Rn_op1(2) = '1') then new_value(23 downto 16) := msr_value(23 downto 16); end if;
                        end if;
                        if (execute_Rn_op1(3) = '1') then new_value(31 downto 24) := msr_value(31 downto 24); end if;
                        if (cpu_mode /= std_logic_vector(new_value(3 downto 0))) then
                           execute_switchregs <= '1';
                        end if;
                        if (
                              (cpu_mode = CPUMODE_USER   and (std_logic_vector(new_value(3 downto 0)) = CPUMODE_USER or std_logic_vector(new_value(3 downto 0)) = CPUMODE_SYSTEM)) or
                              (cpu_mode = CPUMODE_SYSTEM and (std_logic_vector(new_value(3 downto 0)) = CPUMODE_USER or std_logic_vector(new_value(3 downto 0)) = CPUMODE_SYSTEM))
                          ) then
                           execute_switchregs  <= '0';
                        end if;
                        execute_saveregs   <= '1';
                        cpu_mode_old       <= cpu_mode;
                        cpu_mode           <= std_logic_vector(new_value(3 downto 0));
                        thumbmode          <= new_value(5);
                        FIQ_disable        <= new_value(6);
                        IRQ_disable        <= new_value(7);
                        Flag_Negative      <= new_value(31);
                        Flag_Zero          <= new_value(30);
                        Flag_Carry         <= new_value(29);
                        Flag_V_Overflow    <= new_value(28);
                        if (isArm9 = '1') then
                           Flag_Q             <= new_value(27);
                        end if;
                        if (thumbmode /= new_value(5)) then
                           new_pc             <= execute_PC;
                           jump               <= '1';
                           execute_addcycles  <= 3;
                        else
                           execute_addcycles  <= 1;
                        end if;
                        
                        
                  end case;
                  
               when branch_all =>
                  if (execute_start = '1') then
                     if (execute_branch_link = '1') then
                        calc_result            <= execute_PC;
                        if (isArm9 = '1' and thumbmode = '1') then
                           calc_result(0) <= '1';
                        end if;
                        execute_writeback_calc <= '1';
                        writeback_reg          <= execute_rdest;
                     end if;
                     branchnext   <= '1';
                     if (execute_branch_usereg = '1') then
                        new_pc_var := regs(to_integer(unsigned(execute_Rm_op2)));
                     else
                        new_pc_var := regs(15) + unsigned(resize(execute_branch_immi, 32)); 
                     end if;
                     if (execute_set_thumbmode = '1') then
                        thumbmode <= new_pc_var(0);
                        if (new_pc_var(0) = '1') then
                           new_pc <= new_pc_var(31 downto 1) & '0';
                        else
                           new_pc <= new_pc_var(31 downto 2) & "00";
                        end if;
                     else
                        if (thumbmode = '1') then
                           new_pc <= new_pc_var(31 downto 1) & '0';
                        else
                           new_pc <= new_pc_var(31 downto 2) & "00";
                        end if;
                     end if;
                     execute_addcycles  <= 3;
                  end if;
                  
               when data_read | data_write =>
                  case (data_rw_stage) is
                     when FETCHADDR =>
                        if (execute_start = '1') then
                           swap_write       <= '0';
                           datadouble_first <= '1';
                           if (execute_datatransfer_swap = '1') then
                              OBus_1_dout          <= std_logic_vector(regs(to_integer(unsigned(execute_RM_op2))));
                           elsif (execute_rdest = x"F") then  -- pc is + 12 for data writes
                              OBus_1_dout          <= std_logic_vector(regs_plus_12);  
                           else
                              OBus_1_dout          <= std_logic_vector(regs(to_integer(unsigned(execute_rdest))));
                           end if;
                           busaddress <= regs(to_integer(unsigned(execute_Rn_op1)))(busaddress'left downto 0);
                           if (execute_Rn_op1 = x"F") then -- for pc relative load -> word aligned
                              busaddress(1) <= '0';
                           end if;
                           if (execute_datatransfer_regoffset = '1') then
                              busaddmod  <= regs(to_integer(unsigned(execute_Rm_op2)))(busaddress'left downto 0);
                              shiftreg   <= regs(to_integer(unsigned(execute_Rm_op2)));
                           else
                              busaddmod  <= x"00000" & execute_datatransfer_addvalue;
                           end if;
                           shiftbyreg <= regs(to_integer(unsigned(execute_shiftsettings(7 downto 4))))(7 downto 0);
                           if (execute_datatransfer_shiftval = '1') then
                              data_rw_stage <= BUSSHIFT;
                              shifter_start <= '1';
                           else
                              data_rw_stage <= CALCADDR;
                           end if;
                        end if;
                        
                     when BUSSHIFT =>  
                        if (execute_shiftsettings = x"00") then
                           data_rw_stage <= CALCADDR;
                        else
                           data_rw_stage <= BUSSHIFTWAIT;
                           shiftwait     <= 2;
                        end if;
                        if (execute_shiftsettings(0) = '1') then
                           execute_addcycles  <= 1;
                        end if;
                        
                     when BUSSHIFTWAIT =>
                        if (shiftwait > 0) then
                           shiftwait <= shiftwait - 1;
                        else
                           busaddmod     <= shiftresult(busaddmod'left downto 0);
                           data_rw_stage <= CALCADDR;
                        end if;
                        
                     when CALCADDR =>
                        data_rw_stage <= BUSREQUEST;
                        readaddr := busaddress;
                        if (execute_datatransfer_preadd = '1') then
                           if (execute_datatransfer_addup = '1') then
                              readaddr := busaddress + busaddmod;
                           else
                              readaddr := busaddress - busaddmod;
                           end if;
                           busaddress <= readaddr;
                        end if;
                        bus_execute_acc <= execute_datatransfer_type;
                        -- timing
                        if (isArm9 = '0' or readaddr(27 downto 24) /= x"2" or readaddr(31 downto 14) = Co15_DTCMRegion(31 downto 14)) then
                           dataaccess_cyclecheck <= '1';
                        end if;
                        
                     when BUSREQUEST =>
                        if (isArm9 = '1' or (fetch_available = '1' and decode_request = '0')) then
                           executebus      <= '1'; 
                           data_rw_stage   <= WAITBUS;
                           bus_execute_Adr <= std_logic_vector(busaddress);
                           if (execute_clearbit1 = '1') then
                              bus_execute_Adr(1) <= '0';
                           end if;
                           if (execute_functions_detail = data_read and swap_write = '0') then
                              bus_execute_rnw <= '1';
                           else
                              bus_execute_rnw <= '0';
                           end if;
                           if (execute_datatransfer_double = '1') then
                              if (datadouble_first = '1') then
                                 busaddress <= busaddress + 4;
                              else
                                 busaddress <= busaddress - 4;
                              end if;
                           end if;
                           -- cache
                           datacache_read_addr  <= std_logic_vector(busaddress(21 downto 0));
                           datacache_write_addr <= std_logic_vector(busaddress(21 downto 0));
                           datacache_readwait   <= '0';
                           if (isArm9 = '1' and busaddress(27 downto 24) = x"2" and execute_functions_detail = data_read and swap_write = '0' and busaddress(31 downto 14) /= Co15_DTCMRegion(31 downto 14)) then
                              datacache_read_enable <= '1';
                              datacache_readwait    <= '1';
                           else
                              bus_execute_ena <= '1';
                           end if;
                           if (busaddress(27 downto 24) = x"2" and execute_functions_detail = data_write and busaddress(31 downto 14) /= Co15_DTCMRegion(31 downto 14)) then
                              datacache_write_enable <= '1';
                           end if;
                        end if;
                        
                     when WAITBUS =>
                        if ((OBus_data_done = '1' and datacache_readwait = '0') or datacache_read_done = '1') then
                           if (datacache_read_done = '1') then
                              readdata := datacache_read_data;
                           else
                              readdata := OBus_data_din;
                           end if;
                           executebus  <= '0';
                           if (execute_functions_detail = data_read and swap_write = '0') then
                              case (execute_datareceivetype) is
                                 when RECEIVETYPE_BYTE       => calc_result <= x"000000" & unsigned(readdata(7 downto 0));
                                 when RECEIVETYPE_WORD       => calc_result <= unsigned(readdata); -- !!!
                                 when RECEIVETYPE_DWORD      => calc_result <= unsigned(readdata);
                                 when RECEIVETYPE_SIGNEDBYTE => calc_result <= unsigned(resize(signed(readdata(7 downto 0)), 32));
                                 when RECEIVETYPE_SIGNEDWORD => 
                                    if (busaddress(0) = '0') then
                                       calc_result <= unsigned(resize(signed(readdata(15 downto 0)), 32));
                                    else
                                       calc_result <= unsigned(resize(signed(readdata(7 downto 0)), 32));
                                    end if;                                    
                                      
                              end case;
                              execute_writeback_calc <= '1';
                              if (datadouble_first = '0') then
                                 writeback_reg      <= std_logic_vector(unsigned(execute_rdest) + 1);
                              else
                                 writeback_reg          <= execute_rdest;
                              end if;
                              if (isArm9 = '1' and execute_rdest = x"F") then
                                 thumbmode <= readdata(0);
                              end if;
                           end if;
                           
                           if (execute_datatransfer_preadd = '0') then
                              if (execute_datatransfer_addup = '1') then
                                 busaddress <= busaddress + busaddmod;
                              else
                                 busaddress <= busaddress - busaddmod;
                              end if;
                           end if;
                           
                           if (execute_datatransfer_double = '1' and datadouble_first = '1') then
                              data_rw_stage      <= BUSREQUEST;
                              datadouble_first   <= '0';
                              busaddress         <= busaddress;
                              if (isArm9 = '0' or readaddr(27 downto 24) /= x"2" or readaddr(31 downto 14) = Co15_DTCMRegion(31 downto 14)) then
                                 dataaccess_cyclecheck <= '1';
                              else
                                 execute_addcycles <= 1;
                              end if;
                           elsif (execute_datatransfer_swap = '1' and swap_write = '0') then
                              data_rw_stage      <= BUSREQUEST;
                              swap_write         <= '1';
                           else
                              if (execute_datatransfer_writeback = '1') then
                                 data_rw_stage <= WRITEBACKADDR;
                              else
                                 data_rw_stage <= FETCHADDR;
                                 calc_done  <= '1';
                              end if;
                           end if;
                           
                           --timing
                           if (execute_datatransfer_swap = '1') then
                              if (swap_write = '1') then
                                 if (datacache_read_done = '1' and datacache_read_cached = '1') then
                                    if (isArm9 = '0') then execute_addcycles <= 3; elsif (execute_cycles < 3) then execute_addcycles <= 3 - execute_cycles; end if;
                                 else
                                    if (isArm9 = '0') then execute_addcycles <= 4; elsif (execute_cycles < 4) then execute_addcycles <= 4 - execute_cycles; end if;
                                 end if;
                              else
                                 if (isArm9 = '0' or readaddr(27 downto 24) /= x"2" or readaddr(31 downto 14) = Co15_DTCMRegion(31 downto 14)) then
                                    dataaccess_cyclecheck <= '1';
                                 else
                                    execute_addcycles <= 1;
                                 end if;
                              end if;
                           elsif (execute_datatransfer_swap = '0') then
                              if (execute_functions_detail = data_read or execute_datatransfer_double = '1') then
                                 if (execute_rdest = x"F") then
                                    if (datacache_read_done = '1' and datacache_read_cached = '1') then
                                       if (isArm9 = '0') then execute_addcycles <= 4; elsif (execute_cycles < 4) then execute_addcycles <= 4 - execute_cycles; end if;
                                    else
                                       if (isArm9 = '0') then execute_addcycles <= 5; elsif (execute_cycles < 5) then execute_addcycles <= 5 - execute_cycles; end if;
                                    end if;
                                 else
                                    if (datacache_read_done = '1' and datacache_read_cached = '1') then
                                       if (isArm9 = '0') then execute_addcycles <= 2; elsif (execute_cycles < 2) then execute_addcycles <= 2 - execute_cycles; end if;
                                    else
                                       if (isArm9 = '0') then execute_addcycles <= 3; elsif (execute_cycles < 3) then execute_addcycles <= 3 - execute_cycles; end if;
                                    end if;
                                 end if;
                              else
                                 if (isArm9 = '0') then execute_addcycles <= 2; elsif (execute_cycles < 2) then execute_addcycles <= 2 - execute_cycles; end if;
                              end if;
                           end if;

                        end if;
                        
                     when WRITEBACKADDR =>
                        writeback_reg          <= execute_Rn_op1;
                        calc_result            <= busaddress;
                        execute_writeback_calc <= '1';
                        data_rw_stage          <= FETCHADDR;
                        calc_done              <= '1';

                  end case; 
                  
               when block_read | block_write =>
                  case (block_rw_stage) is
                     when BLOCKFETCHADDR =>
                        if (execute_start = '1') then
                           first_mem_access     <= '1';
                           block_regindex       <= 0;
                           busaddress           <= regs(to_integer(unsigned(execute_Rn_op1))) + unsigned(to_signed(execute_block_addrmod, 32));
                           endaddress           <= regs(to_integer(unsigned(execute_Rn_op1))) + unsigned(to_signed(execute_block_endmod, 32));
                           endaddressRlist      <= regs(to_integer(unsigned(execute_Rn_op1))) + unsigned(to_signed(execute_block_addrmod_baseRlist, 32));                       
                           block_reglist        <= execute_block_reglist;
                           block_rw_stage       <= BLOCKCHECKNEXT;
                           block_switch_pc      <= execute_PC;
                           block_hasPC          <= execute_block_reglist(15);
                           block_arm9_writeback <= '0';
                        end if;
                        
                     when BLOCKCHECKNEXT => 
                        firstbitpos := 0;
                        for i in 15 downto 1 loop
                           if (block_reglist(i) = '1') then
                              firstbitpos := i;
                           end if;
                        end loop;

                        if (block_reglist(0) = '1') then
                           block_reglist  <= '0' & block_reglist(15 downto 1);
                           if (execute_functions_detail = block_read) then
                              block_rw_stage  <= BLOCKREAD;
                           else
                              block_rw_stage  <= BLOCKWRITE;
                           end if;
                        else
                           block_reglist  <= std_logic_vector(unsigned(block_reglist) srl firstbitpos);
                           block_regindex <= block_regindex + firstbitpos;
                        end if;
                        
                        if (isArm9 = '1' and execute_functions_detail = block_read and to_integer(unsigned(execute_Rn_op1)) = block_regindex and block_reglist(0) = '1') then
                           if (unsigned(block_reglist) > 1 or (first_mem_access = '1' and unsigned(block_reglist) = 1)) then -- writeback if Rb is "the ONLY register, or NOT the LAST register" in Rlist
                              block_arm9_writeback <= '1';
                           end if;
                        end if;
                        
                        if (block_reglist = x"0000") then
                           if (execute_datatransfer_writeback = '1' and (execute_block_wb_in_reglist = '0' or block_arm9_writeback = '1')) then
                              block_rw_stage  <= BLOCKWRITEBACKADDR;
                              if (execute_datatransfer_addup = '1') then
                                 if (execute_datatransfer_preadd = '1') then
                                    busaddress <= busaddress - 4;
                                 end if;
                              else
                                 busaddress <= endaddress;
                              end if;
                              if (execute_block_emptylist = '1') then
                                 busaddress <= endaddress;
                              end if;
                           elsif (execute_block_switchmode = '1') then
                              block_rw_stage         <= BLOCKSWITCHMODE;
                           else
                              block_rw_stage         <= BLOCKFETCHADDR;
                              calc_done              <= '1';
                              
                              -- timing
                              if (execute_functions_detail = block_read) then
                                 if (block_hasPC = '1') then
                                    if (isArm9 = '0') then execute_addcycles <= 4; elsif (execute_cycles < 4) then execute_addcycles <= 4 - execute_cycles; end if;
                                 else
                                    if (isArm9 = '0') then execute_addcycles <= 2; elsif (execute_cycles < 2) then execute_addcycles <= 2 - execute_cycles; end if;
                                 end if;
                              end if;
                              
                           end if;
                           
                        end if;
                        
                        if (execute_block_usermoderegs = '1' and cpu_mode /= CPUMODE_USER and cpu_mode /= CPUMODE_SYSTEM) then
                           case (block_regindex) is
                              when 13 => block_writevalue <= regs_0_13;
                              when 14 => block_writevalue <= regs_0_14;
                              when others => block_writevalue <= regs(block_regindex);
                           end case;
                        elsif (block_regindex = 15) then  -- pc is +6/12 for block writes
                           block_writevalue     <= block_pc_next;  
                        elsif (isArm9 = '0' and first_mem_access = '0' and to_integer(unsigned(execute_Rn_op1)) = block_regindex) then
                           block_writevalue     <= endaddressRlist;
                        else
                           block_writevalue     <= regs(block_regindex);
                        end if;
                        
                     when BLOCKWRITE =>
                        if (isArm9 = '1' or (fetch_available = '1' and decode_request = '0')) then
                           executebus           <= '1';
                           OBus_1_dout          <= std_logic_vector(block_writevalue);
                           bus_execute_Adr      <= std_logic_vector(busaddress(busaddress'left downto 2)) & "00";
                           bus_lowbits          <= std_logic_vector(busaddress(1 downto 0));
                           bus_execute_rnw      <= '0';
                           bus_execute_ena      <= '1';
                           bus_execute_acc      <= ACCESS_32BIT;
                           block_rw_stage       <= BLOCKWAITWRITE;
                           -- timing
                           if (isArm9 = '0' or busaddress(27 downto 24) /= x"2" or busaddress(31 downto 14) = Co15_DTCMRegion(31 downto 14)) then
                              dataaccess_cyclecheck <= '1';
                           end if;
                           first_mem_access      <= '0';
                           if (first_mem_access = '1' and isArm9 = '0') then
                              execute_addcycles  <= 1;
                           end if;
                           -- cache
                           datacache_write_addr <= std_logic_vector(busaddress(21 downto 2)) & "00";
                           if (busaddress(27 downto 24) = x"2" and busaddress(31 downto 14) /= Co15_DTCMRegion(31 downto 14)) then
                              datacache_write_enable <= '1';
                           end if;
                        end if;
                        
                     when BLOCKWAITWRITE =>
                        if (OBus_data_done = '1') then
                           executebus      <= '0';
                           block_rw_stage  <= BLOCKCHECKNEXT;
                           busaddress      <= busaddress + 4;
                           if (block_regindex < 15) then
                              block_regindex <= block_regindex + 1;
                           end if;
                        end if;
                        
                     when BLOCKREAD =>
                        if (isArm9 = '1' or (fetch_available = '1' and decode_request = '0')) then
                           executebus      <= '1';
                           bus_execute_Adr <= std_logic_vector(busaddress(busaddress'left downto 2)) & "00";
                           bus_lowbits     <= std_logic_vector(busaddress(1 downto 0));
                           bus_execute_rnw <= '1';
                           bus_execute_acc <= ACCESS_32BIT;
                           block_rw_stage  <= BLOCKWAITREAD;
                           -- timing
                           first_mem_access <= '0';
                           -- cache
                           datacache_read_addr <= std_logic_vector(busaddress(21 downto 0));
                           datacache_readwait  <= '0';
                           if (isArm9 = '1' and busaddress(27 downto 24) = x"2" and busaddress(31 downto 14) /= Co15_DTCMRegion(31 downto 14)) then
                              datacache_read_enable <= '1';
                              datacache_readwait    <= '1';
                           else
                              bus_execute_ena       <= '1';
                              dataaccess_cyclecheck <= '1';
                           end if;
                        end if;
                      
                     when BLOCKWAITREAD =>
                        if ((OBus_data_done = '1' and datacache_readwait = '0') or datacache_read_done = '1') then
                           if (datacache_read_done = '1') then
                              readdata := datacache_read_data;
                           else
                              readdata := OBus_data_din;
                           end if;
                           block_rw_stage  <= BLOCKCHECKNEXT;
                           busaddress      <= busaddress + 4;
                           if (block_regindex < 15) then
                              block_regindex <= block_regindex + 1;
                           end if;
                           calc_result <= unsigned(readdata);
                           executebus  <= '0';
                           if (execute_block_usermoderegs = '1' and cpu_mode /= CPUMODE_USER and cpu_mode /= CPUMODE_SYSTEM) then
                              execute_writeback_userreg <= '1';
                              if (block_regindex < 13) then
                                 execute_writeback_calc <= '1';
                              end if;
                           else
                              execute_writeback_calc    <= '1';
                           end if;
                           writeback_reg             <= std_logic_vector(to_unsigned(block_regindex, 4));
                           if (block_regindex = 15) then
                              block_switch_pc <= unsigned(readdata);
                              blockr15jump    <= execute_block_switchmode;
                              if (isArm9 = '1') then
                                 thumbmode <= readdata(0);
                              end if;
                           end if;
                        end if;

                     when BLOCKWRITEBACKADDR =>
                        writeback_reg          <= execute_Rn_op1;
                        calc_result            <= busaddress;
                        execute_writeback_calc <= '1';
                        if (execute_block_switchmode = '1') then
                           block_rw_stage         <= BLOCKSWITCHMODE;
                        else
                           block_rw_stage         <= BLOCKFETCHADDR;
                           calc_done              <= '1';
                        end if;
                        -- timing
                        if (execute_functions_detail = block_read) then
                           if (block_hasPC = '1') then
                              if (isArm9 = '0') then execute_addcycles <= 4; elsif (execute_cycles < 4) then execute_addcycles <= 4 - execute_cycles; end if;
                           else
                              if (isArm9 = '0') then execute_addcycles <= 2; elsif (execute_cycles < 2) then execute_addcycles <= 2 - execute_cycles; end if;
                           end if;
                        end if;
                        
                     when BLOCKSWITCHMODE =>
                        block_rw_stage     <= BLOCKFETCHADDR;
                        calc_done          <= '1';
                        execute_saveState  <= '1';
                        execute_switchregs <= '1';
                        if (
                              (cpu_mode = CPUMODE_USER   and (std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_USER or std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_SYSTEM)) or
                              (cpu_mode = CPUMODE_SYSTEM and (std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_USER or std_logic_vector(regs(17)(3 downto 0)) = CPUMODE_SYSTEM))
                          ) then
                           execute_switchregs  <= '0';
                        end if;
                        execute_saveregs   <= '1';
                        cpu_mode_old       <= cpu_mode;
                        cpu_mode           <= std_logic_vector(regs(17)(3 downto 0));
                        thumbmode          <= regs(17)(5);
                        FIQ_disable        <= regs(17)(6);
                        IRQ_disable        <= regs(17)(7);
                        Flag_Negative      <= regs(17)(31);
                        Flag_Zero          <= regs(17)(30);
                        Flag_Carry         <= regs(17)(29);
                        Flag_V_Overflow    <= regs(17)(28);
                        if (isArm9 = '1') then
                           Flag_Q          <= regs(17)(27);
                        end if;
                        
                        if (regs(17)(5) = '1') then
                           new_pc     <= block_switch_pc(new_pc'left downto 1) & '0';
                        else
                           new_pc     <= block_switch_pc(new_pc'left downto 2) & "00";
                        end if;
                        
                        if (thumbmode = regs(17)(5)) then
                           jump               <= '1';
                        else
                           branchnext         <= '1';
                        end if;

                  end case;
                  
               when software_interrupt_detail =>
                  if (execute_start = '1') then
                     if (thumbmode = '1') then
                        calc_result  <= execute_PCprev + 2;
                     else
                        calc_result  <= execute_PCprev + 4;
                     end if;
                     execute_writeback_calc <= '1';
                     writeback_reg          <= x"E";
                     
                     --if (old_IRQ_disable)  really required?
                     --{
                     --   regs[17] |= 0x80;
                     --}
                     
                     execute_addcycles  <= 3;
                     
                     execute_saveState  <= '1';
                     execute_switchregs <= '1';
                     execute_saveregs   <= '1';
                     execute_SWI        <= '1';
                     cpu_mode_old       <= cpu_mode;
                     cpu_mode           <= CPUMODE_SUPERVISOR;
                     thumbmode          <= '0';
                     IRQ_disable        <= '1';
                     -- only switch for when not in system/usermode?
                     --FIQ_disable        <= regs(17)(6);
                     --Flag_Negative      <= regs(17)(31);
                     --Flag_Zero          <= regs(17)(30);
                     --Flag_Carry         <= regs(17)(29);
                     --Flag_V_Overflow    <= regs(17)(28);
                     --Flag_Q             <= regs(17)(27);
                     new_pc             <= irpTarget + to_unsigned(8, new_pc'length);
                     branchnext         <= '1';
                  end if;
               
               when long_branch_with_link_low =>
                  if (execute_start = '1') then
                     new_pc                 <= (regs(14)(31 downto 1) & '0') + (execute_immidiate(10 downto 0) & '0');
                     branchnext             <= '1';
                     writeback_reg          <= x"E";
                     calc_result            <= execute_PC;
                     calc_result(0)         <= '1';
                     execute_writeback_calc <= '1';
                     if (execute_force_armswitch = '1') then
                        new_pc(1) <= '0';
                        thumbmode <= '0';
                     end if;
                     execute_addcycles  <= 3;
                  end if;
                 
               -- ARM9
               when count_leading_zeros =>
                  case (clz_stage) is
                     when CLZSTART =>
                        if (execute_start = '1') then
                           clz_stage   <= CLZCALC;
                           clz_workreg <= regs(to_integer(unsigned(execute_Rn_op1)));
                        end if;
                     
                     when CLZCALC =>
                        execute_addcycles  <= 2;
                        clz_stage <= CLZWRITEBACK;
                        clz_count <= 32;
                        for i in 0 to 31 loop
                           if (clz_workreg(i) = '1') then
                              clz_count <= 31 - i;
                           end if;
                        end loop;
                     
                     when CLZWRITEBACK =>
                        clz_stage              <= CLZSTART;
                        calc_done              <= '1';
                        writeback_reg          <= execute_rdest;
                        calc_result            <= to_unsigned(clz_count, 32);
                        execute_writeback_calc <= '1';
                     
                  end case;
               
               when coprocessor_data =>
                  if (execute_start = '1') then
                     calc_done <= '1';
                  end if;
               
               when coprocessor_register_read =>
                  if (execute_start = '1') then
                     calc_done         <= '1';
                     execute_addcycles <= 4;
                     if (cpu_mode /= CPUMODE_USER) then
                        case (execute_co_SrcDstReg) is
                           when x"0" =>
                              if (execute_co_opMode = "000" and execute_co_opRegm = "0000") then
                                 case (execute_co_Info) is
                                    when "001" =>
                                       calc_result            <= x"0F0D2112"; --cacheType;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;
                                    when "010" =>
                                       calc_result            <= x"00140180"; --TCMSize;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;
                                    when others =>
                                       calc_result            <= x"41059461"; --IDCode;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;                                                 
                                 end case;
                              end if;
                              
                           when x"1" => 
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm = "0000") then
                                 calc_result            <= Co15_ctrl;
                                 execute_writeback_calc <= '1';
                                 writeback_reg          <= execute_co_armSrcDstReg;
                              end if;
                              
                           when x"2" =>
                              if (execute_co_opMode = "000" and execute_co_opRegm = "0000") then
                                 case (execute_co_Info) is
                                    when "000" =>
                                       calc_result            <= Co15_DCConfig;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;
                                    when "001" =>
                                       calc_result            <= Co15_ICConfig;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;                                    
                                    when others => null;
                                 end case;
                              end if;
                           
                           when x"3" =>
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm = "0000") then
                                 calc_result            <= Co15_writeBuffCtrl;
                                 execute_writeback_calc <= '1';
                                 writeback_reg          <= execute_co_armSrcDstReg;
                              end if;
                              
                           when x"5" =>
                              if (execute_co_opMode = "000" and execute_co_opRegm = "0000") then
                                 case (execute_co_Info) is
                                    when "010" =>
                                       calc_result            <= Co15_DaccessPerm;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;
                                    when "011" =>
                                       calc_result            <= Co15_IaccessPerm;
                                       execute_writeback_calc <= '1';
                                       writeback_reg          <= execute_co_armSrcDstReg;                                    
                                    when others => null;
                                 end case;
                              end if;
                           
                           when x"6" =>
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm(3) = '0') then
                                 calc_result            <= Co15_protectBaseSize(to_integer(unsigned(execute_co_opRegm(2 downto 0))));
                                 execute_writeback_calc <= '1';
                                 writeback_reg          <= execute_co_armSrcDstReg;
                              end if;
                           
                           when x"9" =>
                              if (execute_co_opMode = "000") then
                                 case (execute_co_opRegm) is
                                    when "0000" => null; -- todo
                                    when "0001" =>
                                       case (execute_co_Info) is
                                          when "000" =>
                                             calc_result            <= Co15_DTCMRegion;
                                             execute_writeback_calc <= '1';
                                             writeback_reg          <= execute_co_armSrcDstReg;
                                          when "001" => null; -- todo                               
                                          when others => null;
                                       end case;
                                    when others => null;
                                 end case;                                 
                              end if;
                              
                           when others => null;
                        end case;
                     end if;
                  end if;
      
               when coprocessor_register_write =>
                  if (execute_start = '1') then
                     calc_done         <= '1';
                     execute_addcycles <= 2;
                     if (cpu_mode /= CPUMODE_USER) then
                        case (execute_co_SrcDstReg) is
                           when x"1" => 
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm = "0000") then
                                 Co15_ctrl <= x"00000078"; --On the NDS bit0,2,7,12..19 are R/W, Bit3..6 are always set, all other bits are always zero.
                                 Co15_ctrl(19 downto 12)  <= regs(to_integer(unsigned(execute_co_armSrcDstReg)))(19 downto 12);
                                 Co15_ctrl(7)             <= regs(to_integer(unsigned(execute_co_armSrcDstReg)))(7);
                                 Co15_ctrl(2)             <= regs(to_integer(unsigned(execute_co_armSrcDstReg)))(2);
                                 Co15_ctrl(0)             <= regs(to_integer(unsigned(execute_co_armSrcDstReg)))(0);
                                 if (regs(to_integer(unsigned(execute_co_armSrcDstReg)))(13) = '1') then
                                    irpTarget <= x"FFFF0000";
                                 else
                                    irpTarget <= (others => '0');
                                 end if;
                              end if;
                              
                           when x"2" =>
                              if (execute_co_opMode = "000" and execute_co_opRegm = "0000") then
                                 case (execute_co_Info) is
                                    when "000" =>
                                       Co15_DCConfig <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                                    when "001" =>
                                       Co15_ICConfig <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                                    when others => null;
                                 end case;
                              end if;
                           
                           when x"3" =>
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm = "0000") then
                                 Co15_writeBuffCtrl <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                              end if;
                              
                           when x"5" =>
                              if (execute_co_opMode = "000" and execute_co_opRegm = "0000") then
                                 case (execute_co_Info) is
                                    when "010" =>
                                       Co15_DaccessPerm <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                                    when "011" =>
                                       Co15_IaccessPerm <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                                    when others => null;
                                 end case;
                              end if;
                           
                           when x"6" =>
                              if (execute_co_opMode = "000" and execute_co_Info = "000" and execute_co_opRegm(3) = '0') then
                                 Co15_protectBaseSize(to_integer(unsigned(execute_co_opRegm(2 downto 0)))) <= regs(to_integer(unsigned(execute_co_armSrcDstReg)));
                              end if;
                              
                           when x"7" =>
                              if (execute_co_opMode = "000" and execute_co_Info = "100" and execute_co_opRegm = "0000") then
                                 new_halt_co15 <= '1';
                              end if;
                           
                           when x"9" =>
                              if (execute_co_opMode = "000") then
                                 case (execute_co_opRegm) is
                                    when "0000" => null; -- todo
                                    when "0001" =>
                                       case (execute_co_Info) is
                                          when "000" =>
                                             Co15_DTCMRegion               <= (others => '0');
                                             Co15_DTCMRegion(27 downto 12) <= regs(to_integer(unsigned(execute_co_armSrcDstReg)))(27 downto 12);
                                          when "001" => null; -- todo                               
                                          when others => null;
                                       end case;
                                    when others => null;
                                 end case;                                 
                              end if;
                              
                           when others => null;
                        end case;
                     end if;
                  end if;
               
               
            end case;
            
         end if;
         
      end if;
   
   end process;
   
   DTCMRegion <= std_logic_vector(Co15_DTCMRegion);
   
   
   -- shifter
   process (clk100) 
   begin
      if (rising_edge(clk100)) then
   
         if (shifter_start = '1') then
            shiftervalue <= shiftreg;
      
            shift_rrx <= '0';
      
            if (execute_shiftsettings(0) = '0') then --shift by immidiate 
      
               shiftamount <= to_integer(unsigned(execute_shiftsettings(7 downto 3)));
               if ((execute_shiftsettings(2 downto 1) = "01" or execute_shiftsettings(2 downto 1) = "10") and execute_shiftsettings(7 downto 3) = "00000") then
                  shiftamount <= 32;
               end if;
               
               if (execute_shiftsettings(2 downto 1) = "11" and execute_shiftsettings(7 downto 3) = "00000") then
                  shift_rrx <= '1';
               end if;
      
            else --shift by register
               
               if (execute_Rm_op2 = x"F") then
                  shiftervalue <= shiftreg + 4; -- really always 4? not 2 for thumbmode?
               end if;
               
               if (execute_shiftsettings(2 downto 1) = "11" and unsigned(shiftbyreg) > 32) then
                  shiftamount <= to_integer(unsigned(shiftbyreg(4 downto 0)));
               else
                  shiftamount <= to_integer(unsigned(shiftbyreg));
               end if;
            
            end if;
         end if;
         
         -- ARM DOC: For all these instructions except ROR:
         -- if the shift is 32, Rd is cleared, and the last bit shifted out remains in the C flag
         -- if the shift is greater than 32, Rd and the C flag are cleared.
         --
         -- however this seems to be wrong. For asr setting rd to zero when shifting by 32 does not pass armwrestler tests
         
         -- LSL
         shiftresult_LSL <= shiftervalue;
         if (shiftamount >= 32) then
            if (shiftamount = 32) then
               shiftercarry_LSL <= shiftervalue(0);
            else
               shiftercarry_LSL <= '0';
            end if;
            shiftresult_LSL <= (others => '0');
         elsif (shiftamount > 0) then
            shiftercarry_LSL <= shiftervalue(32 - shiftamount);
            shiftresult_LSL <= shiftervalue sll shiftamount;
         else
            shiftercarry_LSL <= Flag_Carry;
         end if;
         
         -- RSL
         shiftresult_RSL <= shiftervalue;
         if (shiftamount >= 32) then
            if (shiftamount = 32) then
               shiftercarry_RSL <= shiftervalue(31);
            else
               shiftercarry_RSL <= '0';
            end if;
            shiftresult_RSL <= (others => '0');
         elsif (shiftamount > 0) then
            shiftercarry_RSL <= shiftervalue(shiftamount - 1);
            shiftresult_RSL <= shiftervalue srl shiftamount;
         else
            shiftercarry_RSL <= Flag_Carry;
         end if;
         
         -- ARS
         shiftresult_ARS <= shiftervalue;
         if (shiftamount >= 32) then
            shiftercarry_ARS <= shiftervalue(31);
            shiftresult_ARS <= unsigned(shift_right(signed(shiftervalue),31));
         elsif (shiftamount > 0)  then
            shiftercarry_ARS <= shiftervalue(shiftamount - 1);
            shiftresult_ARS <= unsigned(shift_right(signed(shiftervalue),shiftamount));
         else
            shiftercarry_ARS <= Flag_Carry;
         end if;
         
         -- ROR
         shiftresult_ROR <= shiftervalue;
         if (shiftamount >= 32) then -- >32 can never happen, as checked above, but this fixes simulation problems with carry index and other shifters
            shiftercarry_ROR <= shiftervalue(31);
         elsif (shiftamount > 0) then
            shiftercarry_ROR <= shiftervalue(shiftamount - 1); -- this is the critical line that should not be called if another shifter uses >32
            shiftresult_ROR  <= shiftervalue ror shiftamount;
         else
            shiftercarry_ROR <= Flag_Carry;
         end if;
         
         -- RRX
         shiftercarry_RRX <= shiftervalue(0);
         shiftresult_RRX  <= Flag_Carry & shiftervalue(31 downto 1);

         -- combine
         if (shift_rrx = '1') then
            shiftercarry <= shiftercarry_RRX;
            shiftresult  <= shiftresult_RRX;
         else
            case (execute_shiftsettings(2 downto 1)) is
               when "00" => shiftercarry <= shiftercarry_LSL; shiftresult <= shiftresult_LSL;
               when "01" => shiftercarry <= shiftercarry_RSL; shiftresult <= shiftresult_RSL;
               when "10" => shiftercarry <= shiftercarry_ARS; shiftresult <= shiftresult_ARS;
               when "11" => shiftercarry <= shiftercarry_ROR; shiftresult <= shiftresult_ROR;
               when others => null;
            end case;
         end if;
   
      end if;
   end process;
   
   
   
   goutput : if is_simu = '1' generate
   begin
   
      gregexport: for i in 0 to 14 generate
         exportdata.regs(i) <= std_logic_vector(regs(i));
      end generate;

      exportdata.regs(15) <= std_logic_vector(execute_PC);
      exportdata.regs(16) <= std_logic_vector(regs(16));
      exportdata.regs(17) <= std_logic_vector(regs(17));
      
      exportdata.opcode          <= execute_data;
      exportdata.thumbmode       <= thumbmode;      
      exportdata.flag_Negative   <= Flag_Negative;
      exportdata.flag_Carry      <= Flag_Carry;      
      exportdata.flag_Zero       <= Flag_Zero;   
      exportdata.flag_V_Overflow <= Flag_V_Overflow;
      exportdata.flag_Q          <= Flag_Q;
      exportdata.newticks        <= x"00" & std_logic_vector(new_cycles_out);
      exportdata.armmode         <= "0001" & cpu_mode;
      exportdata.irpdisable      <= IRQ_disable;
      exportdata.R13_USR         <= x"00000000"; -- regs_0_13
      exportdata.R14_USR         <= x"00000000"; -- regs_0_14
      exportdata.R13_IRQ         <= x"00000000"; -- regs_2_13
      exportdata.R14_IRQ         <= x"00000000"; -- regs_2_14
      exportdata.R13_SVC         <= x"00000000"; -- regs_3_13
      exportdata.R14_SVC         <= x"00000000"; -- regs_3_14
      exportdata.SPSR_IRQ        <= x"00000000"; -- regs_2_17
      exportdata.SPSR_SVC        <= x"00000000"; -- regs_3_17
      
   end generate goutput;

end architecture;



