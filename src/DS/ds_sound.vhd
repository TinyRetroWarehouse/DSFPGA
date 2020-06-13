library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;
use work.pReg_ds_sound_7.all;

entity ds_sound is
   port 
   (
      clk100              : in  std_logic;  
      reset               : in  std_logic;
                                
      ds_bus              : in  proc_bus_ds_type;
      ds_bus_data         : out std_logic_vector(31 downto 0); 
      
      new_cycles          : in  unsigned(7 downto 0);
      new_cycles_valid    : in  std_logic;
      
      sound_out_L         : out std_logic_vector(15 downto 0) := (others => '0');
      sound_out_R         : out std_logic_vector(15 downto 0) := (others => '0');
                                   
      req_ena             : out std_logic := '0';
      req_addr            : out std_logic_vector(31 downto 0);
      req_done            : in  std_logic;
      req_data            : in  std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_sound is

   -- single regs
   type t16_27 is array(0 to 15) of std_logic_vector(26 downto 0);
   type t16_22 is array(0 to 15) of std_logic_vector(21 downto 0);
   type t16_16 is array(0 to 15) of std_logic_vector(15 downto 0);
   type t16_7  is array(0 to 15) of std_logic_vector(6 downto 0);
   type t16_3  is array(0 to 15) of std_logic_vector(2 downto 0);
   type t16_2  is array(0 to 15) of std_logic_vector(1 downto 0);
   type t16_1  is array(0 to 15) of std_logic_vector(0 downto 0);
   
   signal SOUNDCNT_Volume_Mul  : t16_7;
   signal SOUNDCNT_Volume_Div  : t16_2;
   signal SOUNDCNT_Hold        : t16_1;
   signal SOUNDCNT_Panning     : t16_7;
   signal SOUNDCNT_Wave_Duty   : t16_3;
   signal SOUNDCNT_Repeat_Mode : t16_2;
   signal SOUNDCNT_Format      : t16_2;
   signal SOUNDCNT_Start       : t16_1;
   signal SOUNDCNT_Status      : std_logic_vector(0 to 15);
   signal SOUNDSAD             : t16_27;
   signal SOUNDTMR             : t16_16;
   signal SOUNDPNT             : t16_16;
   signal SOUNDLEN             : t16_22;
   signal Start_written        : std_logic_vector(0 to 15);
   
   -- common regs
   signal REG_SOUNDCNT_Master_Volume         : std_logic_vector(SOUNDCNT_Master_Volume        .upper downto SOUNDCNT_Master_Volume        .lower) := (others => '0');
   signal REG_SOUNDCNT_Left_Output_from      : std_logic_vector(SOUNDCNT_Left_Output_from     .upper downto SOUNDCNT_Left_Output_from     .lower) := (others => '0');
   signal REG_SOUNDCNT_Right_Output_from     : std_logic_vector(SOUNDCNT_Right_Output_from    .upper downto SOUNDCNT_Right_Output_from    .lower) := (others => '0');
   signal REG_SOUNDCNT_Output_Ch1_to_Mixer   : std_logic_vector(SOUNDCNT_Output_Ch1_to_Mixer  .upper downto SOUNDCNT_Output_Ch1_to_Mixer  .lower) := (others => '0');
   signal REG_SOUNDCNT_Output_Ch3_to_Mixer   : std_logic_vector(SOUNDCNT_Output_Ch3_to_Mixer  .upper downto SOUNDCNT_Output_Ch3_to_Mixer  .lower) := (others => '0');
   signal REG_SOUNDCNT_Master_Enable         : std_logic_vector(SOUNDCNT_Master_Enable        .upper downto SOUNDCNT_Master_Enable        .lower) := (others => '0');
                                                                              
   signal REG_SOUNDBIAS                      : std_logic_vector(SOUNDBIAS                     .upper downto SOUNDBIAS                     .lower) := (others => '0');
                                                                              
   signal REG_SOUNDCAP0_Control              : std_logic_vector(SOUNDCAP0_Control             .upper downto SOUNDCAP0_Control             .lower) := (others => '0');
   signal REG_SOUNDCAP0_Capture_Source       : std_logic_vector(SOUNDCAP0_Capture_Source      .upper downto SOUNDCAP0_Capture_Source      .lower) := (others => '0');
   signal REG_SOUNDCAP0_Capture_Repeat       : std_logic_vector(SOUNDCAP0_Capture_Repeat      .upper downto SOUNDCAP0_Capture_Repeat      .lower) := (others => '0');
   signal REG_SOUNDCAP0_Capture_Format       : std_logic_vector(SOUNDCAP0_Capture_Format      .upper downto SOUNDCAP0_Capture_Format      .lower) := (others => '0');
   signal REG_SOUNDCAP0_Capture_Start_Status : std_logic_vector(SOUNDCAP0_Capture_Start_Status.upper downto SOUNDCAP0_Capture_Start_Status.lower) := (others => '0');
   signal REG_SOUNDCAP1_Control              : std_logic_vector(SOUNDCAP1_Control             .upper downto SOUNDCAP1_Control             .lower) := (others => '0');
   signal REG_SOUNDCAP1_Capture_Source       : std_logic_vector(SOUNDCAP1_Capture_Source      .upper downto SOUNDCAP1_Capture_Source      .lower) := (others => '0');
   signal REG_SOUNDCAP1_Capture_Repeat       : std_logic_vector(SOUNDCAP1_Capture_Repeat      .upper downto SOUNDCAP1_Capture_Repeat      .lower) := (others => '0');
   signal REG_SOUNDCAP1_Capture_Format       : std_logic_vector(SOUNDCAP1_Capture_Format      .upper downto SOUNDCAP1_Capture_Format      .lower) := (others => '0');
   signal REG_SOUNDCAP1_Capture_Start_Status : std_logic_vector(SOUNDCAP1_Capture_Start_Status.upper downto SOUNDCAP1_Capture_Start_Status.lower) := (others => '0');
                                                                              
   signal REG_SNDCAP0DAD                     : std_logic_vector(SNDCAP0DAD                    .upper downto SNDCAP0DAD                    .lower) := (others => '0');
   signal REG_SNDCAP0LEN                     : std_logic_vector(SNDCAP0LEN                    .upper downto SNDCAP0LEN                    .lower) := (others => '0');
   signal REG_SNDCAP1DAD                     : std_logic_vector(SNDCAP1DAD                    .upper downto SNDCAP1DAD                    .lower) := (others => '0');
   signal REG_SNDCAP1LEN                     : std_logic_vector(SNDCAP1LEN                    .upper downto SNDCAP1LEN                    .lower) := (others => '0');

   type t_reg_wired_or is array(0 to 36) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   -- adpcm read
   signal adpcm_data       : std_logic_vector(15 downto 0);
   signal adpcm_data_1     : std_logic_vector(15 downto 0);
   signal adpcm_data_2     : std_logic_vector(15 downto 0);
   
   type tadpcm_rom is array(0 to 88) of std_logic_vector(15 downto 0);
   signal adpcm_rom : tadpcm_rom := 
   (
      x"0007", x"0008", x"0009", x"000A", x"000B", x"000C", x"000D", x"000E", x"0010",
      x"0011", x"0013", x"0015", x"0017", x"0019", x"001C", x"001F", x"0022", x"0025",
      x"0029", x"002D", x"0032", x"0037", x"003C", x"0042", x"0049", x"0050", x"0058",
      x"0061", x"006B", x"0076", x"0082", x"008F", x"009D", x"00AD", x"00BE", x"00D1",
      x"00E6", x"00FD", x"0117", x"0133", x"0151", x"0173", x"0198", x"01C1", x"01EE",
      x"0220", x"0256", x"0292", x"02D4", x"031C", x"036C", x"03C3", x"0424", x"048E",
      x"0502", x"0583", x"0610", x"06AB", x"0756", x"0812", x"08E0", x"09C3", x"0ABD",
      x"0BD0", x"0CFF", x"0E4C", x"0FBA", x"114C", x"1307", x"14EE", x"1706", x"1954",
      x"1BDC", x"1EA5", x"21B6", x"2515", x"28CA", x"2CDF", x"315B", x"364B", x"3BB9",
      x"41B2", x"4844", x"4F7E", x"5771", x"602F", x"69CE", x"7462", x"7FFF"
   );
          
   -- channel processing
   type tchannel_internals is array(0 to 127) of std_logic_vector(31 downto 0);
   signal channel_internals : tchannel_internals;
   
   signal channelindex     : integer range 0 to 15;
   signal wordindex        : integer range 0 to 7;
   signal wordindex_next   : integer range 0 to 7;
   
   signal paramdata        : std_logic_vector(31 downto 0);
   signal paramwrite       : std_logic := '0';
   signal paramwritedata   : std_logic_vector(31 downto 0);
   signal paramaddr        : integer range 0 to 127;
   
   type t_freqCounter is array(0 to 15) of unsigned(19 downto 0);
   signal freqCounter : t_freqCounter;
   signal Start_written_buffer : std_logic_vector(0 to 15);
   
   signal totallength       : integer range 0 to 268435455;
   signal samplepos         : integer range -3 to 268435455;
   signal timer             : integer range 0 to 262143;
   signal format            : integer range 0 to 3;
           
   signal lfsr              : std_logic_vector(14 downto 0);
   signal psgcnt            : unsigned(2 downto 0);
   
   signal databuffer        : std_logic_vector(31 downto 0);
   signal data_ptr          : integer range -1 to 7;  
      
   signal tableindex        : integer range 0 to 88 := 0;
   signal tableindex_1      : integer range 0 to 88 := 0;
   signal adpcm_databuffer  : std_logic_vector(15 downto 0);
   signal adpcm_4bit        : std_logic_vector(3 downto 0);
   signal adpcm_diff        : signed(15 downto 0);
   
   signal loopindex_reached : std_logic;
   signal loopsample        : signed(15 downto 0);
   signal loopindex         : integer range 0 to 88;
   
   signal sample            : signed(15 downto 0) := (others => '0');
   signal sample_div        : signed(19 downto 0) := (others => '0');
   signal sample_mul        : signed(26 downto 0) := (others => '0');
   signal sample_mul_1      : signed(26 downto 0) := (others => '0');
   signal sound_out_pan_L   : signed(33 downto 0) := (others => '0');
   signal sound_out_pan_R   : signed(33 downto 0) := (others => '0');
   
   signal sound_result_24_L : signed(23 downto 0) := (others => '0');
   signal sound_result_24_R : signed(23 downto 0) := (others => '0');
   signal sound_result_16   : signed(15 downto 0) := (others => '0');
     
   type tstate is
   (
      IDLE,
      READREGS,
      CHECK_START,
      LOADPARAMS,
      CHECK_TICK,
      NEWTICK,
      FETCHDATA,
      DMASOUNDTICK,
      CHECKLOOPEND,
      ADPCM_FIRST,
      ADPCM_NEXT_DIFF,
      ADPCM_NEXT_SAMPLE,
      CALC_SAMPLE1,
      CALC_SAMPLE2,
      CALC_SAMPLE3,
      CALC_SAMPLE4,
      CALC_SAMPLE5,
      CALC_SAMPLE6,
      SAVEPARAMS
   );
   signal state : tstate := IDLE;
   
   signal REG_SOUNDCNT_Volume_Mul  : std_logic_vector( 6 downto 0);
   signal REG_SOUNDCNT_Volume_Div  : std_logic_vector( 1 downto 0);
   signal REG_SOUNDCNT_Hold        : std_logic_vector( 0 downto 0);
   signal REG_SOUNDCNT_Panning     : std_logic_vector( 6 downto 0);
   signal REG_SOUNDCNT_Wave_Duty   : std_logic_vector( 2 downto 0);
   signal REG_SOUNDCNT_Repeat_Mode : std_logic_vector( 1 downto 0);
   signal REG_SOUNDCNT_Format      : std_logic_vector( 1 downto 0);
   signal REG_SOUNDCNT_Start       : std_logic_vector( 0 downto 0);
   signal REG_SOUNDSAD             : std_logic_vector(26 downto 0);
   signal REG_SOUNDTMR             : std_logic_vector(15 downto 0);
   signal REG_SOUNDPNT             : std_logic_vector(15 downto 0);
   signal REG_SOUNDLEN             : std_logic_vector(21 downto 0);
          
   -- signal path
   type tsound_16 is array(0 to 15) of signed(15 downto 0);
   signal sound_16 : tsound_16 := (others => (others => '0'));
   type tsound_24 is array(0 to 15) of signed(23 downto 0);
   signal sound_24_L : tsound_24 := (others => (others => '0'));
   signal sound_24_R : tsound_24 := (others => (others => '0'));
   
   signal sum_left_0_3       : signed(25 downto 0);
   signal sum_left_4_7       : signed(25 downto 0);
   signal sum_left_8_11      : signed(25 downto 0);
   signal sum_left_12_15     : signed(25 downto 0);
   signal sum_left_all       : signed(27 downto 0);
                             
   signal sum_right_0_3      : signed(25 downto 0);
   signal sum_right_4_7      : signed(25 downto 0);
   signal sum_right_8_11     : signed(25 downto 0);
   signal sum_right_12_15    : signed(25 downto 0);
   signal sum_right_all      : signed(27 downto 0);
   
   signal sound_select_left  : signed(19 downto 0);
   signal sound_select_right : signed(19 downto 0);   
   
   signal sound_master_left  : signed(26 downto 0);
   signal sound_master_right : signed(26 downto 0);
 
begin 

   -- single channels
   iSOUND0CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND0CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (0) );  
   iSOUND0CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND0CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (0) );  
   iSOUND0CNT_Hold         : entity work.eProcReg_ds generic map (SOUND0CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (0) );   
   iSOUND0CNT_Panning      : entity work.eProcReg_ds generic map (SOUND0CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (0) );  
   iSOUND0CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND0CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (0) );  
   iSOUND0CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND0CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(0) );  
   iSOUND0CNT_Format       : entity work.eProcReg_ds generic map (SOUND0CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (0) );  
   iSOUND0CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND0CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (0) , Start_written(0));  
   iSOUND0SAD              : entity work.eProcReg_ds generic map (SOUND0SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (0) );  
   iSOUND0TMR              : entity work.eProcReg_ds generic map (SOUND0TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (0) );  
   iSOUND0PNT              : entity work.eProcReg_ds generic map (SOUND0PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (0) );  
   iSOUND0LEN              : entity work.eProcReg_ds generic map (SOUND0LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (0) ); 
   
   iSOUND1CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND1CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (1) );  
   iSOUND1CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND1CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (1) );  
   iSOUND1CNT_Hold         : entity work.eProcReg_ds generic map (SOUND1CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (1) );   
   iSOUND1CNT_Panning      : entity work.eProcReg_ds generic map (SOUND1CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (1) );  
   iSOUND1CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND1CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (1) );  
   iSOUND1CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND1CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(1) );  
   iSOUND1CNT_Format       : entity work.eProcReg_ds generic map (SOUND1CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (1) );  
   iSOUND1CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND1CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (1) , Start_written(1));  
   iSOUND1SAD              : entity work.eProcReg_ds generic map (SOUND1SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (1) );  
   iSOUND1TMR              : entity work.eProcReg_ds generic map (SOUND1TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (1) );  
   iSOUND1PNT              : entity work.eProcReg_ds generic map (SOUND1PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (1) );  
   iSOUND1LEN              : entity work.eProcReg_ds generic map (SOUND1LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (1) ); 
   
   iSOUND2CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND2CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (2) );  
   iSOUND2CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND2CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (2) );  
   iSOUND2CNT_Hold         : entity work.eProcReg_ds generic map (SOUND2CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (2) );   
   iSOUND2CNT_Panning      : entity work.eProcReg_ds generic map (SOUND2CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (2) );  
   iSOUND2CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND2CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (2) );  
   iSOUND2CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND2CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(2) );  
   iSOUND2CNT_Format       : entity work.eProcReg_ds generic map (SOUND2CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (2) );  
   iSOUND2CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND2CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (2) , Start_written(2));  
   iSOUND2SAD              : entity work.eProcReg_ds generic map (SOUND2SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (2) );  
   iSOUND2TMR              : entity work.eProcReg_ds generic map (SOUND2TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (2) );  
   iSOUND2PNT              : entity work.eProcReg_ds generic map (SOUND2PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (2) );  
   iSOUND2LEN              : entity work.eProcReg_ds generic map (SOUND2LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (2) ); 
   
   iSOUND3CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND3CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (3) );  
   iSOUND3CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND3CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (3) );  
   iSOUND3CNT_Hold         : entity work.eProcReg_ds generic map (SOUND3CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (3) );   
   iSOUND3CNT_Panning      : entity work.eProcReg_ds generic map (SOUND3CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (3) );  
   iSOUND3CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND3CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (3) );  
   iSOUND3CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND3CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(3) );  
   iSOUND3CNT_Format       : entity work.eProcReg_ds generic map (SOUND3CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (3) );  
   iSOUND3CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND3CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (3) , Start_written(3));  
   iSOUND3SAD              : entity work.eProcReg_ds generic map (SOUND3SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (3) );  
   iSOUND3TMR              : entity work.eProcReg_ds generic map (SOUND3TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (3) );  
   iSOUND3PNT              : entity work.eProcReg_ds generic map (SOUND3PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (3) );  
   iSOUND3LEN              : entity work.eProcReg_ds generic map (SOUND3LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (3) ); 
   
   iSOUND4CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND4CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (4) );  
   iSOUND4CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND4CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (4) );  
   iSOUND4CNT_Hold         : entity work.eProcReg_ds generic map (SOUND4CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (4) );   
   iSOUND4CNT_Panning      : entity work.eProcReg_ds generic map (SOUND4CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (4) );  
   iSOUND4CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND4CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (4) );  
   iSOUND4CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND4CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(4) );  
   iSOUND4CNT_Format       : entity work.eProcReg_ds generic map (SOUND4CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (4) );  
   iSOUND4CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND4CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (4) , Start_written(4));  
   iSOUND4SAD              : entity work.eProcReg_ds generic map (SOUND4SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (4) );  
   iSOUND4TMR              : entity work.eProcReg_ds generic map (SOUND4TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (4) );  
   iSOUND4PNT              : entity work.eProcReg_ds generic map (SOUND4PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (4) );  
   iSOUND4LEN              : entity work.eProcReg_ds generic map (SOUND4LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (4) ); 
   
   iSOUND5CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND5CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (5) );  
   iSOUND5CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND5CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (5) );  
   iSOUND5CNT_Hold         : entity work.eProcReg_ds generic map (SOUND5CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (5) );   
   iSOUND5CNT_Panning      : entity work.eProcReg_ds generic map (SOUND5CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (5) );  
   iSOUND5CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND5CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (5) );  
   iSOUND5CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND5CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(5) );  
   iSOUND5CNT_Format       : entity work.eProcReg_ds generic map (SOUND5CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (5) );  
   iSOUND5CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND5CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (5) , Start_written(5));  
   iSOUND5SAD              : entity work.eProcReg_ds generic map (SOUND5SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (5) );  
   iSOUND5TMR              : entity work.eProcReg_ds generic map (SOUND5TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (5) );  
   iSOUND5PNT              : entity work.eProcReg_ds generic map (SOUND5PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (5) );  
   iSOUND5LEN              : entity work.eProcReg_ds generic map (SOUND5LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (5) ); 
   
   iSOUND6CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND6CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (6) );  
   iSOUND6CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND6CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (6) );  
   iSOUND6CNT_Hold         : entity work.eProcReg_ds generic map (SOUND6CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (6) );   
   iSOUND6CNT_Panning      : entity work.eProcReg_ds generic map (SOUND6CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (6) );  
   iSOUND6CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND6CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (6) );  
   iSOUND6CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND6CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(6) );  
   iSOUND6CNT_Format       : entity work.eProcReg_ds generic map (SOUND6CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (6) );  
   iSOUND6CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND6CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (6) , Start_written(6));  
   iSOUND6SAD              : entity work.eProcReg_ds generic map (SOUND6SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (6) );  
   iSOUND6TMR              : entity work.eProcReg_ds generic map (SOUND6TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (6) );  
   iSOUND6PNT              : entity work.eProcReg_ds generic map (SOUND6PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (6) );  
   iSOUND6LEN              : entity work.eProcReg_ds generic map (SOUND6LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (6) ); 
   
   iSOUND7CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND7CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (7) );  
   iSOUND7CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND7CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (7) );  
   iSOUND7CNT_Hold         : entity work.eProcReg_ds generic map (SOUND7CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (7) );   
   iSOUND7CNT_Panning      : entity work.eProcReg_ds generic map (SOUND7CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (7) );  
   iSOUND7CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND7CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (7) );  
   iSOUND7CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND7CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(7) );  
   iSOUND7CNT_Format       : entity work.eProcReg_ds generic map (SOUND7CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (7) );  
   iSOUND7CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND7CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (7) , Start_written(7));  
   iSOUND7SAD              : entity work.eProcReg_ds generic map (SOUND7SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (7) );  
   iSOUND7TMR              : entity work.eProcReg_ds generic map (SOUND7TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (7) );  
   iSOUND7PNT              : entity work.eProcReg_ds generic map (SOUND7PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (7) );  
   iSOUND7LEN              : entity work.eProcReg_ds generic map (SOUND7LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (7) ); 
   
   iSOUND8CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND8CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (8) );  
   iSOUND8CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND8CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (8) );  
   iSOUND8CNT_Hold         : entity work.eProcReg_ds generic map (SOUND8CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (8) );   
   iSOUND8CNT_Panning      : entity work.eProcReg_ds generic map (SOUND8CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (8) );  
   iSOUND8CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND8CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (8) );  
   iSOUND8CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND8CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(8) );  
   iSOUND8CNT_Format       : entity work.eProcReg_ds generic map (SOUND8CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (8) );  
   iSOUND8CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND8CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (8) , Start_written(8));  
   iSOUND8SAD              : entity work.eProcReg_ds generic map (SOUND8SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (8) );  
   iSOUND8TMR              : entity work.eProcReg_ds generic map (SOUND8TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (8) );  
   iSOUND8PNT              : entity work.eProcReg_ds generic map (SOUND8PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (8) );  
   iSOUND8LEN              : entity work.eProcReg_ds generic map (SOUND8LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (8) ); 
   
   iSOUND9CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND9CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (9) );  
   iSOUND9CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND9CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (9) );  
   iSOUND9CNT_Hold         : entity work.eProcReg_ds generic map (SOUND9CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (9) );   
   iSOUND9CNT_Panning      : entity work.eProcReg_ds generic map (SOUND9CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (9) );  
   iSOUND9CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND9CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (9) );  
   iSOUND9CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND9CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(9) );  
   iSOUND9CNT_Format       : entity work.eProcReg_ds generic map (SOUND9CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (9) );  
   iSOUND9CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND9CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (9) , Start_written(9));  
   iSOUND9SAD              : entity work.eProcReg_ds generic map (SOUND9SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (9) );  
   iSOUND9TMR              : entity work.eProcReg_ds generic map (SOUND9TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (9) );  
   iSOUND9PNT              : entity work.eProcReg_ds generic map (SOUND9PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (9) );  
   iSOUND9LEN              : entity work.eProcReg_ds generic map (SOUND9LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (9) ); 
   
   iSOUND10CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND10CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (10) );  
   iSOUND10CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND10CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (10) );  
   iSOUND10CNT_Hold         : entity work.eProcReg_ds generic map (SOUND10CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (10) );   
   iSOUND10CNT_Panning      : entity work.eProcReg_ds generic map (SOUND10CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (10) );  
   iSOUND10CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND10CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (10) );  
   iSOUND10CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND10CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(10) );  
   iSOUND10CNT_Format       : entity work.eProcReg_ds generic map (SOUND10CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (10) );  
   iSOUND10CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND10CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (10) , Start_written(10));  
   iSOUND10SAD              : entity work.eProcReg_ds generic map (SOUND10SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (10) );  
   iSOUND10TMR              : entity work.eProcReg_ds generic map (SOUND10TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (10) );  
   iSOUND10PNT              : entity work.eProcReg_ds generic map (SOUND10PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (10) );  
   iSOUND10LEN              : entity work.eProcReg_ds generic map (SOUND10LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (10) ); 
   
   iSOUND11CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND11CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (11) );  
   iSOUND11CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND11CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (11) );  
   iSOUND11CNT_Hold         : entity work.eProcReg_ds generic map (SOUND11CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (11) );   
   iSOUND11CNT_Panning      : entity work.eProcReg_ds generic map (SOUND11CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (11) );  
   iSOUND11CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND11CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (11) );  
   iSOUND11CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND11CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(11) );  
   iSOUND11CNT_Format       : entity work.eProcReg_ds generic map (SOUND11CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (11) );  
   iSOUND11CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND11CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (11) , Start_written(11));  
   iSOUND11SAD              : entity work.eProcReg_ds generic map (SOUND11SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (11) );  
   iSOUND11TMR              : entity work.eProcReg_ds generic map (SOUND11TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (11) );  
   iSOUND11PNT              : entity work.eProcReg_ds generic map (SOUND11PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (11) );  
   iSOUND11LEN              : entity work.eProcReg_ds generic map (SOUND11LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (11) ); 
   
   iSOUND12CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND12CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (12) );  
   iSOUND12CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND12CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (12) );  
   iSOUND12CNT_Hold         : entity work.eProcReg_ds generic map (SOUND12CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (12) );   
   iSOUND12CNT_Panning      : entity work.eProcReg_ds generic map (SOUND12CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (12) );  
   iSOUND12CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND12CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (12) );  
   iSOUND12CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND12CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(12) );  
   iSOUND12CNT_Format       : entity work.eProcReg_ds generic map (SOUND12CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (12) );  
   iSOUND12CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND12CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (12) , Start_written(12));  
   iSOUND12SAD              : entity work.eProcReg_ds generic map (SOUND12SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (12) );  
   iSOUND12TMR              : entity work.eProcReg_ds generic map (SOUND12TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (12) );  
   iSOUND12PNT              : entity work.eProcReg_ds generic map (SOUND12PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (12) );  
   iSOUND12LEN              : entity work.eProcReg_ds generic map (SOUND12LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (12) ); 
   
   iSOUND13CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND13CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (13) );  
   iSOUND13CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND13CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (13) );  
   iSOUND13CNT_Hold         : entity work.eProcReg_ds generic map (SOUND13CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (13) );   
   iSOUND13CNT_Panning      : entity work.eProcReg_ds generic map (SOUND13CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (13) );  
   iSOUND13CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND13CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (13) );  
   iSOUND13CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND13CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(13) );  
   iSOUND13CNT_Format       : entity work.eProcReg_ds generic map (SOUND13CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (13) );  
   iSOUND13CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND13CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (13) , Start_written(13));  
   iSOUND13SAD              : entity work.eProcReg_ds generic map (SOUND13SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (13) );  
   iSOUND13TMR              : entity work.eProcReg_ds generic map (SOUND13TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (13) );  
   iSOUND13PNT              : entity work.eProcReg_ds generic map (SOUND13PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (13) );  
   iSOUND13LEN              : entity work.eProcReg_ds generic map (SOUND13LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (13) ); 
   
   iSOUND14CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND14CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (14) );  
   iSOUND14CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND14CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (14) );  
   iSOUND14CNT_Hold         : entity work.eProcReg_ds generic map (SOUND14CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (14) );   
   iSOUND14CNT_Panning      : entity work.eProcReg_ds generic map (SOUND14CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (14) );  
   iSOUND14CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND14CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (14) );  
   iSOUND14CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND14CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(14) );  
   iSOUND14CNT_Format       : entity work.eProcReg_ds generic map (SOUND14CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (14) );  
   iSOUND14CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND14CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (14) , Start_written(14));  
   iSOUND14SAD              : entity work.eProcReg_ds generic map (SOUND14SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (14) );  
   iSOUND14TMR              : entity work.eProcReg_ds generic map (SOUND14TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (14) );  
   iSOUND14PNT              : entity work.eProcReg_ds generic map (SOUND14PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (14) );  
   iSOUND14LEN              : entity work.eProcReg_ds generic map (SOUND14LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (14) ); 
   
   iSOUND15CNT_Volume_Mul   : entity work.eProcReg_ds generic map (SOUND15CNT_Volume_Mul  ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Volume_Mul (15) );  
   iSOUND15CNT_Volume_Div   : entity work.eProcReg_ds generic map (SOUND15CNT_Volume_Div  ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Volume_Div (15) );  
   iSOUND15CNT_Hold         : entity work.eProcReg_ds generic map (SOUND15CNT_Hold        ) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Hold       (15) );   
   iSOUND15CNT_Panning      : entity work.eProcReg_ds generic map (SOUND15CNT_Panning     ) port map  (clk100, ds_bus, open , ( 6 downto 0 => '0'), SOUNDCNT_Panning    (15) );  
   iSOUND15CNT_Wave_Duty    : entity work.eProcReg_ds generic map (SOUND15CNT_Wave_Duty   ) port map  (clk100, ds_bus, open , ( 2 downto 0 => '0'), SOUNDCNT_Wave_Duty  (15) );  
   iSOUND15CNT_Repeat_Mode  : entity work.eProcReg_ds generic map (SOUND15CNT_Repeat_Mode ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Repeat_Mode(15) );  
   iSOUND15CNT_Format       : entity work.eProcReg_ds generic map (SOUND15CNT_Format      ) port map  (clk100, ds_bus, open , ( 1 downto 0 => '0'), SOUNDCNT_Format     (15) );  
   iSOUND15CNT_Start_Status : entity work.eProcReg_ds generic map (SOUND15CNT_Start_Status) port map  (clk100, ds_bus, open , ( 0 downto 0 => '0'), SOUNDCNT_Start      (15) , Start_written(15));  
   iSOUND15SAD              : entity work.eProcReg_ds generic map (SOUND15SAD             ) port map  (clk100, ds_bus, open , (26 downto 0 => '0'), SOUNDSAD            (15) );  
   iSOUND15TMR              : entity work.eProcReg_ds generic map (SOUND15TMR             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDTMR            (15) );  
   iSOUND15PNT              : entity work.eProcReg_ds generic map (SOUND15PNT             ) port map  (clk100, ds_bus, open , (15 downto 0 => '0'), SOUNDPNT            (15) );  
   iSOUND15LEN              : entity work.eProcReg_ds generic map (SOUND15LEN             ) port map  (clk100, ds_bus, open , (21 downto 0 => '0'), SOUNDLEN            (15) ); 
   
   reg_wired_or(0 ) <= SOUNDCNT_Status(0 ) & SOUNDCNT_Format(0 ) & SOUNDCNT_Repeat_Mode(0 ) & SOUNDCNT_Wave_Duty(0 ) & "0" & SOUNDCNT_Panning(0 ) & SOUNDCNT_Hold(0 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(0 ) & "0" & SOUNDCNT_Volume_Mul(0 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND0CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(1 ) <= SOUNDCNT_Status(1 ) & SOUNDCNT_Format(1 ) & SOUNDCNT_Repeat_Mode(1 ) & SOUNDCNT_Wave_Duty(1 ) & "0" & SOUNDCNT_Panning(1 ) & SOUNDCNT_Hold(1 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(1 ) & "0" & SOUNDCNT_Volume_Mul(1 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND1CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(2 ) <= SOUNDCNT_Status(2 ) & SOUNDCNT_Format(2 ) & SOUNDCNT_Repeat_Mode(2 ) & SOUNDCNT_Wave_Duty(2 ) & "0" & SOUNDCNT_Panning(2 ) & SOUNDCNT_Hold(2 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(2 ) & "0" & SOUNDCNT_Volume_Mul(2 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND2CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(3 ) <= SOUNDCNT_Status(3 ) & SOUNDCNT_Format(3 ) & SOUNDCNT_Repeat_Mode(3 ) & SOUNDCNT_Wave_Duty(3 ) & "0" & SOUNDCNT_Panning(3 ) & SOUNDCNT_Hold(3 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(3 ) & "0" & SOUNDCNT_Volume_Mul(3 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND3CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(4 ) <= SOUNDCNT_Status(4 ) & SOUNDCNT_Format(4 ) & SOUNDCNT_Repeat_Mode(4 ) & SOUNDCNT_Wave_Duty(4 ) & "0" & SOUNDCNT_Panning(4 ) & SOUNDCNT_Hold(4 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(4 ) & "0" & SOUNDCNT_Volume_Mul(4 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND4CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(5 ) <= SOUNDCNT_Status(5 ) & SOUNDCNT_Format(5 ) & SOUNDCNT_Repeat_Mode(5 ) & SOUNDCNT_Wave_Duty(5 ) & "0" & SOUNDCNT_Panning(5 ) & SOUNDCNT_Hold(5 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(5 ) & "0" & SOUNDCNT_Volume_Mul(5 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND5CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(6 ) <= SOUNDCNT_Status(6 ) & SOUNDCNT_Format(6 ) & SOUNDCNT_Repeat_Mode(6 ) & SOUNDCNT_Wave_Duty(6 ) & "0" & SOUNDCNT_Panning(6 ) & SOUNDCNT_Hold(6 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(6 ) & "0" & SOUNDCNT_Volume_Mul(6 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND6CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(7 ) <= SOUNDCNT_Status(7 ) & SOUNDCNT_Format(7 ) & SOUNDCNT_Repeat_Mode(7 ) & SOUNDCNT_Wave_Duty(7 ) & "0" & SOUNDCNT_Panning(7 ) & SOUNDCNT_Hold(7 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(7 ) & "0" & SOUNDCNT_Volume_Mul(7 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND7CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(8 ) <= SOUNDCNT_Status(8 ) & SOUNDCNT_Format(8 ) & SOUNDCNT_Repeat_Mode(8 ) & SOUNDCNT_Wave_Duty(8 ) & "0" & SOUNDCNT_Panning(8 ) & SOUNDCNT_Hold(8 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(8 ) & "0" & SOUNDCNT_Volume_Mul(8 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND8CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(9 ) <= SOUNDCNT_Status(9 ) & SOUNDCNT_Format(9 ) & SOUNDCNT_Repeat_Mode(9 ) & SOUNDCNT_Wave_Duty(9 ) & "0" & SOUNDCNT_Panning(9 ) & SOUNDCNT_Hold(9 ) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(9 ) & "0" & SOUNDCNT_Volume_Mul(9 ) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND9CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(10) <= SOUNDCNT_Status(10) & SOUNDCNT_Format(10) & SOUNDCNT_Repeat_Mode(10) & SOUNDCNT_Wave_Duty(10) & "0" & SOUNDCNT_Panning(10) & SOUNDCNT_Hold(10) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(10) & "0" & SOUNDCNT_Volume_Mul(10) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND10CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(11) <= SOUNDCNT_Status(11) & SOUNDCNT_Format(11) & SOUNDCNT_Repeat_Mode(11) & SOUNDCNT_Wave_Duty(11) & "0" & SOUNDCNT_Panning(11) & SOUNDCNT_Hold(11) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(11) & "0" & SOUNDCNT_Volume_Mul(11) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND11CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(12) <= SOUNDCNT_Status(12) & SOUNDCNT_Format(12) & SOUNDCNT_Repeat_Mode(12) & SOUNDCNT_Wave_Duty(12) & "0" & SOUNDCNT_Panning(12) & SOUNDCNT_Hold(12) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(12) & "0" & SOUNDCNT_Volume_Mul(12) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND12CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(13) <= SOUNDCNT_Status(13) & SOUNDCNT_Format(13) & SOUNDCNT_Repeat_Mode(13) & SOUNDCNT_Wave_Duty(13) & "0" & SOUNDCNT_Panning(13) & SOUNDCNT_Hold(13) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(13) & "0" & SOUNDCNT_Volume_Mul(13) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND13CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(14) <= SOUNDCNT_Status(14) & SOUNDCNT_Format(14) & SOUNDCNT_Repeat_Mode(14) & SOUNDCNT_Wave_Duty(14) & "0" & SOUNDCNT_Panning(14) & SOUNDCNT_Hold(14) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(14) & "0" & SOUNDCNT_Volume_Mul(14) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND14CNT.Adr, ds_bus.adr'length))) else (others => '0');
   reg_wired_or(15) <= SOUNDCNT_Status(15) & SOUNDCNT_Format(15) & SOUNDCNT_Repeat_Mode(15) & SOUNDCNT_Wave_Duty(15) & "0" & SOUNDCNT_Panning(15) & SOUNDCNT_Hold(15) & (14 downto 10 => '0') & SOUNDCNT_Volume_Div(15) & "0" & SOUNDCNT_Volume_Mul(15) when (ds_bus.Adr = std_logic_vector(to_unsigned(SOUND15CNT.Adr, ds_bus.adr'length))) else (others => '0');

   -- common regs
   iREG_SOUNDCNT_Master_Volume         : entity work.eProcReg_ds generic map (SOUNDCNT_Master_Volume        ) port map  (clk100, ds_bus, reg_wired_or(16), REG_SOUNDCNT_Master_Volume         , REG_SOUNDCNT_Master_Volume        );
   iREG_SOUNDCNT_Left_Output_from      : entity work.eProcReg_ds generic map (SOUNDCNT_Left_Output_from     ) port map  (clk100, ds_bus, reg_wired_or(17), REG_SOUNDCNT_Left_Output_from      , REG_SOUNDCNT_Left_Output_from     );
   iREG_SOUNDCNT_Right_Output_from     : entity work.eProcReg_ds generic map (SOUNDCNT_Right_Output_from    ) port map  (clk100, ds_bus, reg_wired_or(18), REG_SOUNDCNT_Right_Output_from     , REG_SOUNDCNT_Right_Output_from    );
   iREG_SOUNDCNT_Output_Ch1_to_Mixer   : entity work.eProcReg_ds generic map (SOUNDCNT_Output_Ch1_to_Mixer  ) port map  (clk100, ds_bus, reg_wired_or(19), REG_SOUNDCNT_Output_Ch1_to_Mixer   , REG_SOUNDCNT_Output_Ch1_to_Mixer  );
   iREG_SOUNDCNT_Output_Ch3_to_Mixer   : entity work.eProcReg_ds generic map (SOUNDCNT_Output_Ch3_to_Mixer  ) port map  (clk100, ds_bus, reg_wired_or(20), REG_SOUNDCNT_Output_Ch3_to_Mixer   , REG_SOUNDCNT_Output_Ch3_to_Mixer  );
   iREG_SOUNDCNT_Master_Enable         : entity work.eProcReg_ds generic map (SOUNDCNT_Master_Enable        ) port map  (clk100, ds_bus, reg_wired_or(21), REG_SOUNDCNT_Master_Enable         , REG_SOUNDCNT_Master_Enable        );
                                                                                                                                                                                                                                 
   iREG_SOUNDBIAS                      : entity work.eProcReg_ds generic map (SOUNDBIAS                     ) port map  (clk100, ds_bus, reg_wired_or(22), REG_SOUNDBIAS                      , REG_SOUNDBIAS                     );
                                                                                                                                                                                                                                 
   iREG_SOUNDCAP0_Control              : entity work.eProcReg_ds generic map (SOUNDCAP0_Control             ) port map  (clk100, ds_bus, reg_wired_or(23), REG_SOUNDCAP0_Control              , REG_SOUNDCAP0_Control             );
   iREG_SOUNDCAP0_Capture_Source       : entity work.eProcReg_ds generic map (SOUNDCAP0_Capture_Source      ) port map  (clk100, ds_bus, reg_wired_or(24), REG_SOUNDCAP0_Capture_Source       , REG_SOUNDCAP0_Capture_Source      );
   iREG_SOUNDCAP0_Capture_Repeat       : entity work.eProcReg_ds generic map (SOUNDCAP0_Capture_Repeat      ) port map  (clk100, ds_bus, reg_wired_or(25), REG_SOUNDCAP0_Capture_Repeat       , REG_SOUNDCAP0_Capture_Repeat      );
   iREG_SOUNDCAP0_Capture_Format       : entity work.eProcReg_ds generic map (SOUNDCAP0_Capture_Format      ) port map  (clk100, ds_bus, reg_wired_or(26), REG_SOUNDCAP0_Capture_Format       , REG_SOUNDCAP0_Capture_Format      );
   iREG_SOUNDCAP0_Capture_Start_Status : entity work.eProcReg_ds generic map (SOUNDCAP0_Capture_Start_Status) port map  (clk100, ds_bus, reg_wired_or(27), REG_SOUNDCAP0_Capture_Start_Status , REG_SOUNDCAP0_Capture_Start_Status);
   iREG_SOUNDCAP1_Control              : entity work.eProcReg_ds generic map (SOUNDCAP1_Control             ) port map  (clk100, ds_bus, reg_wired_or(28), REG_SOUNDCAP1_Control              , REG_SOUNDCAP1_Control             );
   iREG_SOUNDCAP1_Capture_Source       : entity work.eProcReg_ds generic map (SOUNDCAP1_Capture_Source      ) port map  (clk100, ds_bus, reg_wired_or(29), REG_SOUNDCAP1_Capture_Source       , REG_SOUNDCAP1_Capture_Source      );
   iREG_SOUNDCAP1_Capture_Repeat       : entity work.eProcReg_ds generic map (SOUNDCAP1_Capture_Repeat      ) port map  (clk100, ds_bus, reg_wired_or(30), REG_SOUNDCAP1_Capture_Repeat       , REG_SOUNDCAP1_Capture_Repeat      );
   iREG_SOUNDCAP1_Capture_Format       : entity work.eProcReg_ds generic map (SOUNDCAP1_Capture_Format      ) port map  (clk100, ds_bus, reg_wired_or(31), REG_SOUNDCAP1_Capture_Format       , REG_SOUNDCAP1_Capture_Format      );
   iREG_SOUNDCAP1_Capture_Start_Status : entity work.eProcReg_ds generic map (SOUNDCAP1_Capture_Start_Status) port map  (clk100, ds_bus, reg_wired_or(32), REG_SOUNDCAP1_Capture_Start_Status , REG_SOUNDCAP1_Capture_Start_Status);
                                                                                                                                                                                                                                 
   iREG_SNDCAP0DAD                     : entity work.eProcReg_ds generic map (SNDCAP0DAD                    ) port map  (clk100, ds_bus, reg_wired_or(33), REG_SNDCAP0DAD                     , REG_SNDCAP0DAD                    );
   iREG_SNDCAP0LEN                     : entity work.eProcReg_ds generic map (SNDCAP0LEN                    ) port map  (clk100, ds_bus, reg_wired_or(34), REG_SNDCAP0LEN                     , REG_SNDCAP0LEN                    );
   iREG_SNDCAP1DAD                     : entity work.eProcReg_ds generic map (SNDCAP1DAD                    ) port map  (clk100, ds_bus, reg_wired_or(35), REG_SNDCAP1DAD                     , REG_SNDCAP1DAD                    );
   iREG_SNDCAP1LEN                     : entity work.eProcReg_ds generic map (SNDCAP1LEN                    ) port map  (clk100, ds_bus, reg_wired_or(36), REG_SNDCAP1LEN                     , REG_SNDCAP1LEN                    );

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   -- channel processing
   process (clk100)
      variable new_tableindex : integer range -1 to 96;
   begin
      if rising_edge(clk100) then
   
         req_ena   <= '0';
         
         tableindex_1 <= tableindex;
         adpcm_data   <= adpcm_rom(tableindex_1);
         adpcm_data_1 <= adpcm_data;
         adpcm_data_2 <= adpcm_data_1;
         
         paramwrite <= '0';
         
         if (paramwrite = '1') then
            channel_internals(paramaddr) <= paramwritedata;
         end if;
         paramdata <= channel_internals(channelindex * 8 + wordindex);
         
         if (reset = '1') then
         
            state                <= IDLE;
            freqCounter          <= (others => (others => '0'));
            sound_16             <= (others => (others => '0'));
            sound_24_L           <= (others => (others => '0'));
            sound_24_R           <= (others => (others => '0'));
            SOUNDCNT_Status      <= (others => '0');
            Start_written_buffer <= (others => '0');
         
         else
         
            for i in 0 to 15 loop
               if (new_cycles_valid = '1') then
                  freqCounter(i) <= freqCounter(i) + new_cycles;
               end if;
            end loop;
         
            Start_written_buffer <= Start_written_buffer or Start_written;
            
            REG_SOUNDCNT_Volume_Mul  <= SOUNDCNT_Volume_Mul(channelindex);
            REG_SOUNDCNT_Volume_Div  <= SOUNDCNT_Volume_Div(channelindex); 
            REG_SOUNDCNT_Hold        <= SOUNDCNT_Hold(channelindex);       
            REG_SOUNDCNT_Panning     <= SOUNDCNT_Panning(channelindex);   
            REG_SOUNDCNT_Wave_Duty   <= SOUNDCNT_Wave_Duty(channelindex);  
            REG_SOUNDCNT_Repeat_Mode <= SOUNDCNT_Repeat_Mode(channelindex);
            REG_SOUNDCNT_Format      <= SOUNDCNT_Format(channelindex);     
            REG_SOUNDCNT_Start       <= SOUNDCNT_Start(channelindex);      
            REG_SOUNDSAD             <= SOUNDSAD(channelindex);            
            REG_SOUNDTMR             <= SOUNDTMR(channelindex);            
            REG_SOUNDPNT             <= SOUNDPNT(channelindex);            
            REG_SOUNDLEN             <= SOUNDLEN(channelindex);    

            timer <= to_integer(unsigned(REG_SOUNDTMR)) * 4;            
            
            case (state) is
               when IDLE =>
                  if (channelindex < 15) then
                     channelindex <= channelindex + 1;
                  else
                     channelindex <= 0;
                  end if;
                  wordindex      <= 0;
                  wordindex_next <= 0;
                  state <= READREGS;
                  
               when READREGS =>
                  state <= CHECK_START;
                  
               when CHECK_START =>  
                  if (SOUNDCNT_Status(channelindex) = '1') then
                     state <= LOADPARAMS;
                  else
                     state <= IDLE;
                  end if;
                  
                  if (Start_written_buffer(channelindex) = '1') then
                     Start_written_buffer(channelindex) <= '0';
                     if (SOUNDCNT_Status(channelindex) = '0' and REG_SOUNDCNT_Start = "1") then
                     
                        SOUNDCNT_Status(channelindex) <= '1';
                        freqCounter(channelindex)     <= (others => '0');
                        samplepos           <= -3;
                        state               <= IDLE;
                        format              <= to_integer(unsigned(REG_SOUNDCNT_Format));
                        data_ptr            <= -1;
                        sample              <= (others => '0'); 
                        tableindex          <= 0;
      
                        case (to_integer(unsigned(REG_SOUNDCNT_Format))) is
                           when 0 => totallength <= (to_integer(unsigned(REG_SOUNDLEN)) + to_integer(unsigned(REG_SOUNDPNT))) * 4;
                           when 1 => totallength <= (to_integer(unsigned(REG_SOUNDLEN)) + to_integer(unsigned(REG_SOUNDPNT))) * 2;
                           when 2 => totallength <= (to_integer(unsigned(REG_SOUNDLEN)) + to_integer(unsigned(REG_SOUNDPNT))) * 8;
                           when others => null;
                        end case;   
                        
                        psgcnt <= (others => '0');
                        lfsr   <= (others => '1');
                        
                        state     <= SAVEPARAMS;
                        wordindex <= 0;
                        
                     elsif (SOUNDCNT_Status(channelindex) = '1' and REG_SOUNDCNT_Start = "0") then
                        SOUNDCNT_Status(channelindex) <= '0';
                        sample <= (others => '0');
                        state  <= CALC_SAMPLE1;
                     end if;
                  end if;
                  
               when LOADPARAMS =>
                  wordindex_next <= wordindex;
                  if (wordindex < 7) then
                     wordindex <= wordindex + 1;
                  end if;
                  if (wordindex_next = 7) then
                     state <= CHECK_TICK;
                  end if;
                  if (wordindex > 0) then
                     case (wordindex_next) is
                        when 0 => 
                           sample      <= signed(paramdata(15 downto 0));
                           format      <= to_integer(unsigned(paramdata(17 downto 16)));
                           psgcnt      <= unsigned(paramdata(20 downto 18));
                           data_ptr    <= to_integer(signed(paramdata(24 downto 21)));
                           tableindex  <= to_integer(unsigned(paramdata(31 downto 25)));
                        when 1 =>
                           totallength <= to_integer(unsigned(paramdata(27 downto 0)));
                        when 2 =>
                           samplepos   <= to_integer(signed(paramdata(28 downto 0)));
                        when 3 =>
                           lfsr        <= paramdata(14 downto 0);
                           loopindex_reached <= paramdata(15);
                        when 4 =>
                           databuffer  <= paramdata;
                        when 5 =>
                           loopsample  <= signed(paramdata(15 downto 0));
                        when 6 =>
                           loopindex   <= to_integer(unsigned(paramdata(6 downto 0)));
                        when 7 => null;
                        when others => null;
                     end case;
                  end if;    
                  
               when CHECK_TICK =>
                  if (new_cycles_valid = '0') then
                     if (freqCounter(channelindex) >= (16#40000# - timer)) then
                        freqCounter(channelindex) <= freqCounter(channelindex) - (16#40000# - timer);
                        state       <= NEWTICK;
                     else
                        state <= IDLE;
                     end if;
                  end if;
                  
               when NEWTICK =>
                  if (format < 2) then
                     samplepos <= samplepos + 1;
                  end if;
                  if (format < 3) then
                     if (data_ptr = -1) then
                        if (samplepos >= 0) then
                           state <= FETCHDATA;
                           req_ena <= '1';
                           case (format) is
                              when 0 => req_addr <= std_logic_vector(to_unsigned(to_integer(unsigned(REG_SOUNDSAD)) + samplepos,     32));
                              when 1 => req_addr <= std_logic_vector(to_unsigned(to_integer(unsigned(REG_SOUNDSAD)) + samplepos * 2, 32));
                              when 2 => req_addr <= std_logic_vector(to_unsigned(to_integer(unsigned(REG_SOUNDSAD)) + samplepos / 2, 32));
                              when others => null;
                           end case;
                        else
                           if (format = 2) then
                              state     <= ADPCM_FIRST;
                              req_ena   <= '1';
                              req_addr  <= "00000" & REG_SOUNDSAD;
                           else
                              state     <= SAVEPARAMS;
                              wordindex <= 0;
                           end if;
                        end if;
                     else
                        state <= DMASOUNDTICK;
                     end if;
                  
                  else
                     
                     state <= CALC_SAMPLE1;
                     if (channelindex >= 14) then -- noise
                        --lfsr <= (lfsr(1) xor lfsr(0)) & lfsr(14 downto 1); ??
                        if (lfsr(0) = '1') then
                           lfsr <= lfsr(0) & (not lfsr(14)) & lfsr(13 downto 1);
                           sample <= x"8000";
                        else
                           lfsr <= '0' & lfsr(14 downto 1);
                           sample <= x"7FFF";
                        end if;
                     elsif (channelindex >= 8 and channelindex <= 13) then -- psg
                        if (psgcnt > unsigned(REG_SOUNDCNT_Wave_Duty)) then
                           sample <= x"8000";
                        else
                           sample <= x"7FFF";
                        end if;
                        psgcnt <= psgcnt + 1;
                     end if;
                  
                  end if;
                  
               when FETCHDATA =>
                  if (req_done = '1') then
                     databuffer <= req_data;
                     state      <= DMASOUNDTICK;
                     case (format) is
                        when 0 => data_ptr <= 3;
                        when 1 => data_ptr <= 1;
                        when 2 => data_ptr <= 7;
                        when others => null;
                     end case;
                  end if;
                  
               when DMASOUNDTICK =>
                  state <= CHECKLOOPEND;
                  data_ptr <= data_ptr - 1;
                  case (format) is
                     when 0 => 
                        case (data_ptr) is
                           when 3 => sample <= signed(databuffer( 7 downto  0)) & x"00";
                           when 2 => sample <= signed(databuffer(15 downto  8)) & x"00";
                           when 1 => sample <= signed(databuffer(23 downto 16)) & x"00";
                           when 0 => sample <= signed(databuffer(31 downto 24)) & x"00";
                           when others => null;
                        end case;
                     when 1 => 
                        if (data_ptr = 1) then 
                           sample <= signed(databuffer(15 downto 0));
                        else
                           sample <= signed(databuffer(31 downto 16));
                        end if;
                        
                     when 2 => 
                        case (data_ptr) is
                           when 7 => adpcm_4bit <= databuffer( 3 downto  0);
                           when 6 => adpcm_4bit <= databuffer( 7 downto  4);
                           when 5 => adpcm_4bit <= databuffer(11 downto  8);
                           when 4 => adpcm_4bit <= databuffer(15 downto 12);
                           when 3 => adpcm_4bit <= databuffer(19 downto 16);
                           when 2 => adpcm_4bit <= databuffer(23 downto 20);
                           when 1 => adpcm_4bit <= databuffer(27 downto 24);
                           when 0 => adpcm_4bit <= databuffer(31 downto 28);
                           when others => null;
                        end case;
                        state     <= ADPCM_NEXT_DIFF;
                        
                     when others => null;
                  end case;
                  
               when CHECKLOOPEND => 
                  state <= CALC_SAMPLE1;
                  if (samplepos >= totallength) then
                     data_ptr <= -1;
                     if (REG_SOUNDCNT_Repeat_Mode = "01") then
                        case (format) is
                           when 0 => samplepos <= samplepos - (totallength - (to_integer(unsigned(REG_SOUNDPNT)) * 4));
                           when 1 => samplepos <= samplepos - (totallength - (to_integer(unsigned(REG_SOUNDPNT)) * 2));
                           when 2 => 
                              if (loopindex_reached = '0') then
                                 samplepos <= -3;
                              else
                                 samplepos  <= samplepos - (totallength - (to_integer(unsigned(REG_SOUNDPNT)) * 8));
                                 sample     <= loopsample;
                                 tableindex <= loopindex;
                              end if;

                           when others => null;
                        end case;
                     else
                        SOUNDCNT_Status(channelindex) <= '0';
                     end if;
                  end if;
                  
               when ADPCM_FIRST => 
                  if (req_done = '1') then
                     state <= CALC_SAMPLE1;
                     samplepos <= 8;
                     loopindex_reached <= '0';
                     sample <= signed(req_data(15 downto 0));
                     if (unsigned(req_data(22 downto 16)) < 88) then
                        tableindex <= to_integer(unsigned(req_data(22 downto 16)));
                     else
                        tableindex <= 88;
                     end if;
                  end if;
           
               when ADPCM_NEXT_DIFF =>
                  state <= ADPCM_NEXT_SAMPLE;
                  adpcm_diff <= resize((((to_integer(unsigned(adpcm_4bit(2 downto 0))) * 2) + 1) * signed(adpcm_data_2)) / 8, 16);
                  if (samplepos = (to_integer(unsigned(REG_SOUNDPNT)) * 8)) then
                     loopsample        <= sample;
                     loopindex         <= tableindex;
                     loopindex_reached <= '1';
                  end if;
           
               when ADPCM_NEXT_SAMPLE =>
                  state     <= CHECKLOOPEND;
                  samplepos <= samplepos + 1; 
                  if (adpcm_4bit(3) = '1') then
                     if (to_integer(sample) - to_integer(adpcm_diff) < -32767) then
                        sample <= to_signed(-32767, 16);
                     else
                        sample <= sample - adpcm_diff;
                     end if;
                  else
                     if (to_integer(sample) + to_integer(adpcm_diff) > 32767) then
                        sample <= to_signed(32767, 16);
                     else
                        sample <= sample + adpcm_diff;
                     end if;
                  end if;
                  new_tableindex := tableindex;
                  case (to_integer(unsigned(adpcm_4bit(2 downto 0)))) is
                     when 0 | 1 | 2 | 3 => new_tableindex := new_tableindex - 1;
                     when 4             => new_tableindex := new_tableindex + 2;
                     when 5             => new_tableindex := new_tableindex + 4;
                     when 6             => new_tableindex := new_tableindex + 6; 
                     when 7             => new_tableindex := new_tableindex + 8; 
                     when others => null;
                  end case;
                  if (new_tableindex < 0) then
                     tableindex <= 0;
                  elsif (new_tableindex > 88) then
                     tableindex <= 88;
                  else
                     tableindex <= new_tableindex;
                  end if;
                  
               when CALC_SAMPLE1 =>
                  state <= CALC_SAMPLE2;
                  
               when CALC_SAMPLE2 =>
                  state <= CALC_SAMPLE3;
               
               when CALC_SAMPLE3 =>
                  state <= CALC_SAMPLE4;
               
               when CALC_SAMPLE4 =>
                  state <= CALC_SAMPLE5;
               
               when CALC_SAMPLE5 =>
                  state <= CALC_SAMPLE6;
           
               when CALC_SAMPLE6 =>
                  state <= SAVEPARAMS;
                  wordindex <= 0;
                  sound_24_L(channelindex) <= sound_result_24_L;
                  sound_24_R(channelindex) <= sound_result_24_R;
                  sound_16(channelindex)   <= sound_result_16;
           
               when SAVEPARAMS =>
                  if (wordindex < 7) then
                     wordindex <= wordindex + 1;
                  else
                     state <= IDLE;
                  end if;
                  paramaddr      <= channelindex * 8 + wordindex;
                  paramwrite     <= '1';
                  paramwritedata <= (others => '0');
                  case (wordindex) is
                     when 0 => 
                        paramwritedata(15 downto  0) <= std_logic_vector(sample);
                        paramwritedata(17 downto 16) <= std_logic_vector(to_unsigned(format, 2));
                        paramwritedata(20 downto 18) <= std_logic_vector(psgcnt);
                        paramwritedata(24 downto 21) <= std_logic_vector(to_signed(data_ptr, 4));
                        paramwritedata(31 downto 25) <= std_logic_vector(to_unsigned(tableindex, 7));
                     when 1 => 
                        paramwritedata(27 downto 0)  <= std_logic_vector(to_unsigned(totallength, 28));
                     when 2 => 
                        paramwritedata(28 downto 0) <= std_logic_vector(to_signed(samplepos, 29));
                     when 3 => 
                        paramwritedata(14 downto 0) <= lfsr;
                        paramwritedata(15) <= loopindex_reached;
                     when 4 => 
                        paramwritedata <= databuffer;
                     when 5 => 
                        paramwritedata(15 downto 0) <= std_logic_vector(loopsample);
                     when 6 => 
                        paramwritedata(6 downto 0) <= std_logic_vector(to_unsigned(loopindex, 7));
                     when 7 => null;
                     when others => null;
                  end case;
           
            end case;
            
         end if;
         
         -- CALC_SAMPLE1
         case (to_integer(unsigned(REG_SOUNDCNT_Volume_Div))) is
            when 0 => sample_div <= resize(sample * 16, 20);
            when 1 => sample_div <= resize(sample *  8, 20);
            when 2 => sample_div <= resize(sample *  4, 20);
            when 3 => sample_div <= resize(sample *  1, 20);
            when others => null;
         end case;
         
         -- CALC_SAMPLE2
         sample_mul <= resize(sample_div * to_integer(unsigned(REG_SOUNDCNT_Volume_Mul)), 27);
         
         -- CALC_SAMPLE3
         sample_mul_1 <= sample_mul;
         
         -- CALC_SAMPLE4             
         sound_out_pan_L <= resize(sample_mul_1 * (127 - to_integer(unsigned(REG_SOUNDCNT_Panning))), 34);
         sound_out_pan_R <= resize(sample_mul_1 * (      to_integer(unsigned(REG_SOUNDCNT_Panning))), 34);
      
         -- CALC_SAMPLE5
         sound_result_24_L <= sound_out_pan_L(sound_out_pan_L'left downto 10);
         sound_result_24_R <= sound_out_pan_R(sound_out_pan_R'left downto 10);
         sound_result_16   <= sample_div(19 downto 4);
      
      end if;
   end process;
   
   
   -- mixing
   process (clk100)
   begin
      if rising_edge(clk100) then
         
         sum_left_0_3    <= resize(sound_24_L( 0), 26) + resize(sound_24_L( 1), 26) + resize(sound_24_L( 2), 26) + resize(sound_24_L( 3), 26);
         sum_left_4_7    <= resize(sound_24_L( 4), 26) + resize(sound_24_L( 5), 26) + resize(sound_24_L( 6), 26) + resize(sound_24_L( 7), 26);
         sum_left_8_11   <= resize(sound_24_L( 8), 26) + resize(sound_24_L( 9), 26) + resize(sound_24_L(10), 26) + resize(sound_24_L(11), 26);
         sum_left_12_15  <= resize(sound_24_L(12), 26) + resize(sound_24_L(13), 26) + resize(sound_24_L(14), 26) + resize(sound_24_L(15), 26);
         sum_left_all    <= resize(sum_left_0_3, 28) + resize(sum_left_4_7, 28) + resize(sum_left_8_11, 28) + resize(sum_left_12_15, 28);
         
         sum_right_0_3   <= resize(sound_24_R( 0), 26) + resize(sound_24_R( 1), 26) + resize(sound_24_R( 2), 26) + resize(sound_24_R( 3), 26);
         sum_right_4_7   <= resize(sound_24_R( 4), 26) + resize(sound_24_R( 5), 26) + resize(sound_24_R( 6), 26) + resize(sound_24_R( 7), 26);
         sum_right_8_11  <= resize(sound_24_R( 8), 26) + resize(sound_24_R( 9), 26) + resize(sound_24_R(10), 26) + resize(sound_24_R(11), 26);
         sum_right_12_15 <= resize(sound_24_R(12), 26) + resize(sound_24_R(13), 26) + resize(sound_24_R(14), 26) + resize(sound_24_R(15), 26);
         sum_right_all   <= resize(sum_right_0_3, 28) + resize(sum_right_4_7, 28) + resize(sum_right_8_11, 28) + resize(sum_right_12_15, 28);
         
         case (to_integer(unsigned(REG_SOUNDCNT_Left_Output_from))) is
            when 0 => sound_select_left <= sum_left_all(27 downto 8);
            when 1 => sound_select_left <= sound_24_L(1)(23 downto 4);
            when 2 => sound_select_left <= sound_24_L(3)(23 downto 4);
            when 3 => sound_select_left <= sound_24_L(1)(23 downto 4) + sound_24_L(3)(23 downto 4);
            when others => null;
         end case;
         
         case (to_integer(unsigned(REG_SOUNDCNT_Right_Output_from))) is
            when 0 => sound_select_right <= sum_right_all(27 downto 8);
            when 1 => sound_select_right <= sound_24_R(1)(23 downto 4);
            when 2 => sound_select_right <= sound_24_R(3)(23 downto 4);
            when 3 => sound_select_right <= sound_24_R(1)(23 downto 4) + sound_24_R(3)(23 downto 4);
            when others => null;
         end case;
         
         if (REG_SOUNDCAP0_Capture_Start_Status = "1" and REG_SOUNDCAP1_Capture_Start_Status = "1") then -- todo: remove capture hack
            sound_select_left  <= sum_left_all(27 downto 8);
            sound_select_right <= sum_right_all(27 downto 8);
         end if;
         
         sound_master_left  <= resize(sound_select_left  * to_integer(unsigned(REG_SOUNDCNT_Master_Volume)), 27);
         sound_master_right <= resize(sound_select_right * to_integer(unsigned(REG_SOUNDCNT_Master_Volume)), 27);
         
         sound_out_L <= std_logic_vector(sound_master_left (26 downto 11));
         sound_out_R <= std_logic_vector(sound_master_right(26 downto 11));
         
         
      end if;
   end process;

end architecture;


 
 