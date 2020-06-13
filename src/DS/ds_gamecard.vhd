library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

entity ds_gamecard is
   generic
   (
      AUXSPICNT_SPI_Baudrate        : regmap_type; 
      AUXSPICNT_SPI_Hold_Chipselect : regmap_type; 
      AUXSPICNT_SPI_Busy            : regmap_type; 
      AUXSPICNT_NDS_Slot_Mode       : regmap_type; 
      AUXSPICNT_Transfer_Ready_IRQ  : regmap_type; 
      AUXSPICNT_NDS_Slot_Enable     : regmap_type; 
      AUXSPIDATA                    : regmap_type; 
      ROMCTRL_KEY1_gap1_length      : regmap_type; 
      ROMCTRL_KEY2_encrypt_data     : regmap_type; 
      ROMCTRL_SE                    : regmap_type; 
      ROMCTRL_KEY2_Apply_Seed       : regmap_type; 
      ROMCTRL_KEY1_gap2_length      : regmap_type; 
      ROMCTRL_KEY2_encrypt_cmd      : regmap_type; 
      ROMCTRL_Data_Word_Status      : regmap_type; 
      ROMCTRL_Data_Block_size       : regmap_type; 
      ROMCTRL_Transfer_CLK_rate     : regmap_type; 
      ROMCTRL_KEY1_Gap_CLKs         : regmap_type; 
      ROMCTRL_RESB_Release_Reset    : regmap_type; 
      ROMCTRL_WR                    : regmap_type; 
      ROMCTRL_Block_Start_Status    : regmap_type; 
      Gamecard_bus_Command_1        : regmap_type; 
      Gamecard_bus_Command_2        : regmap_type
   );
   port 
   (
      clk100            : in  std_logic;  
      reset             : in  std_logic;
                              
      ds_bus            : in  proc_bus_ds_type; 
      ds_bus_data       : out std_logic_vector(31 downto 0);
      
      new_cycles        : in  unsigned(7 downto 0);
      new_cycles_valid  : in  std_logic;
      
      IRQ_Slot          : out std_logic := '0';
      
      dma_request       : out std_logic := '0';
      dma_size          : out integer range 0 to 128;
      
      gamecard_read     : in  std_logic;
      romaddress        : out std_logic_vector(31 downto 0);
      readtype          : out integer range 0 to 2;
      
      auxspi_addr       : out std_logic_vector(31 downto 0);
      auxspi_dataout    : out std_logic_vector( 7 downto 0);
      auxspi_request    : out std_logic := '0';
      auxspi_rnw        : out std_logic;
      auxspi_datain     : in  std_logic_vector( 7 downto 0);
      auxspi_done       : in  std_logic
   );
end entity;

architecture arch of ds_gamecard is
  
   signal REG_AUXSPICNT_SPI_Baudrate          : std_logic_vector(AUXSPICNT_SPI_Baudrate       .upper downto AUXSPICNT_SPI_Baudrate       .lower) := (others => '0');
   signal REG_AUXSPICNT_SPI_Hold_Chipselect   : std_logic_vector(AUXSPICNT_SPI_Hold_Chipselect.upper downto AUXSPICNT_SPI_Hold_Chipselect.lower) := (others => '0');
   signal REG_AUXSPICNT_SPI_Busy              : std_logic_vector(AUXSPICNT_SPI_Busy           .upper downto AUXSPICNT_SPI_Busy           .lower) := (others => '0');
   signal REG_AUXSPICNT_NDS_Slot_Mode         : std_logic_vector(AUXSPICNT_NDS_Slot_Mode      .upper downto AUXSPICNT_NDS_Slot_Mode      .lower) := (others => '0');
   signal REG_AUXSPICNT_Transfer_Ready_IRQ    : std_logic_vector(AUXSPICNT_Transfer_Ready_IRQ .upper downto AUXSPICNT_Transfer_Ready_IRQ .lower) := (others => '0');
   signal REG_AUXSPICNT_NDS_Slot_Enable       : std_logic_vector(AUXSPICNT_NDS_Slot_Enable    .upper downto AUXSPICNT_NDS_Slot_Enable    .lower) := (others => '0');
   signal REG_AUXSPIDATA                      : std_logic_vector(AUXSPIDATA                   .upper downto AUXSPIDATA                   .lower) := (others => '0');
   signal REG_AUXSPIDATA_readback             : std_logic_vector(AUXSPIDATA                   .upper downto AUXSPIDATA                   .lower) := (others => '0');
   
   signal REG_ROMCTRL_KEY1_gap1_length        : std_logic_vector(ROMCTRL_KEY1_gap1_length     .upper downto ROMCTRL_KEY1_gap1_length     .lower) := (others => '0');
   signal REG_ROMCTRL_KEY2_encrypt_data       : std_logic_vector(ROMCTRL_KEY2_encrypt_data    .upper downto ROMCTRL_KEY2_encrypt_data    .lower) := (others => '0');
   signal REG_ROMCTRL_SE                      : std_logic_vector(ROMCTRL_SE                   .upper downto ROMCTRL_SE                   .lower) := (others => '0');
   signal REG_ROMCTRL_KEY2_Apply_Seed         : std_logic_vector(ROMCTRL_KEY2_Apply_Seed      .upper downto ROMCTRL_KEY2_Apply_Seed      .lower) := (others => '0');
   signal REG_ROMCTRL_KEY1_gap2_length        : std_logic_vector(ROMCTRL_KEY1_gap2_length     .upper downto ROMCTRL_KEY1_gap2_length     .lower) := (others => '0');
   signal REG_ROMCTRL_KEY2_encrypt_cmd        : std_logic_vector(ROMCTRL_KEY2_encrypt_cmd     .upper downto ROMCTRL_KEY2_encrypt_cmd     .lower) := (others => '0');
   signal REG_ROMCTRL_Data_Word_Status        : std_logic_vector(ROMCTRL_Data_Word_Status     .upper downto ROMCTRL_Data_Word_Status     .lower) := (others => '0');
   signal REG_ROMCTRL_Data_Block_size         : std_logic_vector(ROMCTRL_Data_Block_size      .upper downto ROMCTRL_Data_Block_size      .lower) := (others => '0');
   signal REG_ROMCTRL_Transfer_CLK_rate       : std_logic_vector(ROMCTRL_Transfer_CLK_rate    .upper downto ROMCTRL_Transfer_CLK_rate    .lower) := (others => '0');
   signal REG_ROMCTRL_KEY1_Gap_CLKs           : std_logic_vector(ROMCTRL_KEY1_Gap_CLKs        .upper downto ROMCTRL_KEY1_Gap_CLKs        .lower) := (others => '0');
   signal REG_ROMCTRL_RESB_Release_Reset      : std_logic_vector(ROMCTRL_RESB_Release_Reset   .upper downto ROMCTRL_RESB_Release_Reset   .lower) := (others => '0');
   signal REG_ROMCTRL_WR                      : std_logic_vector(ROMCTRL_WR                   .upper downto ROMCTRL_WR                   .lower) := (others => '0');
   signal REG_ROMCTRL_Block_Start_Status      : std_logic_vector(ROMCTRL_Block_Start_Status   .upper downto ROMCTRL_Block_Start_Status   .lower) := (others => '0');
   signal REG_ROMCTRL_Block_Start_Status_back : std_logic_vector(ROMCTRL_Block_Start_Status   .upper downto ROMCTRL_Block_Start_Status   .lower) := (others => '0');
                                                                                                                                         
   signal REG_Gamecard_bus_Command_1          : std_logic_vector(Gamecard_bus_Command_1       .upper downto Gamecard_bus_Command_1       .lower) := (others => '0');
   signal REG_Gamecard_bus_Command_2          : std_logic_vector(Gamecard_bus_Command_2       .upper downto Gamecard_bus_Command_2       .lower) := (others => '0');
             
   type t_reg_wired_or is array(0 to 19) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   signal hold_written   : std_logic;
   signal enable_written : std_logic;
   signal data_written   : std_logic;
   signal Start_written  : std_logic;
   
   -- internals gamerom
   signal address       : std_logic_vector(31 downto 0) := (others => '0');
   signal transfercount : integer range 0 to 512;
   type toperationtype is
   (
      NONE,
      ROM,
      CHIPID
   );
   signal operationtype : toperationtype;
   signal workcnt       : integer range 0 to 4194303 := 0;

   -- save
   constant CMD_IDLE         : std_logic_vector(7 downto 0) := x"00";
   constant CMD_AUTODETECT   : std_logic_vector(7 downto 0) := x"FF";
   constant CMD_WRITESTATUS  : std_logic_vector(7 downto 0) := x"01";
   constant CMD_WRITELOW     : std_logic_vector(7 downto 0) := x"02";
   constant CMD_READLOW      : std_logic_vector(7 downto 0) := x"03";
   constant CMD_WRITEDISABLE : std_logic_vector(7 downto 0) := x"04";
   constant CMD_READSTATUS   : std_logic_vector(7 downto 0) := x"05";
   constant CMD_WRITEENABLE  : std_logic_vector(7 downto 0) := x"06";
   constant CMD_WRITEHIGH    : std_logic_vector(7 downto 0) := x"0A";
   constant CMD_READHIGH     : std_logic_vector(7 downto 0) := x"0B";
   constant CMD_IRDA         : std_logic_vector(7 downto 0) := x"08";
   constant CMD_PAGE_WRITE   : std_logic_vector(7 downto 0) := x"0A";
   constant CMD_PAGE_ERASE   : std_logic_vector(7 downto 0) := x"DB";
   constant CMD_SECTOR_ERASE : std_logic_vector(7 downto 0) := x"D8";
   constant CMD_CHIP_ERASE   : std_logic_vector(7 downto 0) := x"C7";

   signal spi_oldcnt       : std_logic_vector(15 downto 0);
	signal csOld            : std_logic;

	signal auxspi_reset     : std_logic;
	signal cmd              : std_logic_vector(7 downto 0);
	signal write_enable     : std_logic;
	signal write_protect    : std_logic_vector(7 downto 0);
   signal addr_size        : integer range 0 to 3;
	signal addr_counter     : unsigned(31 downto 0);
	signal addr             : unsigned(31 downto 0);
	signal autodetect       : std_logic;
	signal autodetectsize   : unsigned(7 downto 0);

begin 
   
   
   iREG_AUXSPICNT_SPI_Baudrate        : entity work.eProcReg_ds generic map (AUXSPICNT_SPI_Baudrate       ) port map  (clk100, ds_bus, reg_wired_or( 0), REG_AUXSPICNT_SPI_Baudrate          , REG_AUXSPICNT_SPI_Baudrate        );
   iREG_AUXSPICNT_SPI_Hold_Chipselect : entity work.eProcReg_ds generic map (AUXSPICNT_SPI_Hold_Chipselect) port map  (clk100, ds_bus, reg_wired_or( 1), REG_AUXSPICNT_SPI_Hold_Chipselect   , REG_AUXSPICNT_SPI_Hold_Chipselect , hold_written);
   iREG_AUXSPICNT_SPI_Busy            : entity work.eProcReg_ds generic map (AUXSPICNT_SPI_Busy           ) port map  (clk100, ds_bus, reg_wired_or( 2), REG_AUXSPICNT_SPI_Busy              );
   iREG_AUXSPICNT_NDS_Slot_Mode       : entity work.eProcReg_ds generic map (AUXSPICNT_NDS_Slot_Mode      ) port map  (clk100, ds_bus, reg_wired_or( 3), REG_AUXSPICNT_NDS_Slot_Mode         , REG_AUXSPICNT_NDS_Slot_Mode       );
   iREG_AUXSPICNT_Transfer_Ready_IRQ  : entity work.eProcReg_ds generic map (AUXSPICNT_Transfer_Ready_IRQ ) port map  (clk100, ds_bus, reg_wired_or( 4), REG_AUXSPICNT_Transfer_Ready_IRQ    , REG_AUXSPICNT_Transfer_Ready_IRQ  );
   iREG_AUXSPICNT_NDS_Slot_Enable     : entity work.eProcReg_ds generic map (AUXSPICNT_NDS_Slot_Enable    ) port map  (clk100, ds_bus, reg_wired_or( 5), REG_AUXSPICNT_NDS_Slot_Enable       , REG_AUXSPICNT_NDS_Slot_Enable     , enable_written);
   iREG_AUXSPIDATA                    : entity work.eProcReg_ds generic map (AUXSPIDATA                   ) port map  (clk100, ds_bus, reg_wired_or( 6), REG_AUXSPIDATA_readback             , REG_AUXSPIDATA                    , data_written);
   
   iREG_ROMCTRL_KEY1_gap1_length      : entity work.eProcReg_ds generic map (ROMCTRL_KEY1_gap1_length     ) port map  (clk100, ds_bus, reg_wired_or( 7), REG_ROMCTRL_KEY1_gap1_length        , REG_ROMCTRL_KEY1_gap1_length      ); 
   iREG_ROMCTRL_KEY2_encrypt_data     : entity work.eProcReg_ds generic map (ROMCTRL_KEY2_encrypt_data    ) port map  (clk100, ds_bus, reg_wired_or( 8), REG_ROMCTRL_KEY2_encrypt_data       , REG_ROMCTRL_KEY2_encrypt_data     ); 
   iREG_ROMCTRL_SE                    : entity work.eProcReg_ds generic map (ROMCTRL_SE                   ) port map  (clk100, ds_bus, reg_wired_or( 9), REG_ROMCTRL_SE                      , REG_ROMCTRL_SE                    ); 
   iREG_ROMCTRL_KEY2_Apply_Seed       : entity work.eProcReg_ds generic map (ROMCTRL_KEY2_Apply_Seed      ) port map  (clk100, ds_bus, reg_wired_or(10), REG_ROMCTRL_KEY2_Apply_Seed         , REG_ROMCTRL_KEY2_Apply_Seed       ); 
   iREG_ROMCTRL_KEY1_gap2_length      : entity work.eProcReg_ds generic map (ROMCTRL_KEY1_gap2_length     ) port map  (clk100, ds_bus, reg_wired_or(11), REG_ROMCTRL_KEY1_gap2_length        , REG_ROMCTRL_KEY1_gap2_length      ); 
   iREG_ROMCTRL_KEY2_encrypt_cmd      : entity work.eProcReg_ds generic map (ROMCTRL_KEY2_encrypt_cmd     ) port map  (clk100, ds_bus, reg_wired_or(12), REG_ROMCTRL_KEY2_encrypt_cmd        , REG_ROMCTRL_KEY2_encrypt_cmd      ); 
   iREG_ROMCTRL_Data_Word_Status      : entity work.eProcReg_ds generic map (ROMCTRL_Data_Word_Status     ) port map  (clk100, ds_bus, reg_wired_or(13), REG_ROMCTRL_Data_Word_Status        );                                  
   iREG_ROMCTRL_Data_Block_size       : entity work.eProcReg_ds generic map (ROMCTRL_Data_Block_size      ) port map  (clk100, ds_bus, reg_wired_or(14), REG_ROMCTRL_Data_Block_size         , REG_ROMCTRL_Data_Block_size       ); 
   iREG_ROMCTRL_Transfer_CLK_rate     : entity work.eProcReg_ds generic map (ROMCTRL_Transfer_CLK_rate    ) port map  (clk100, ds_bus, reg_wired_or(15), REG_ROMCTRL_Transfer_CLK_rate       , REG_ROMCTRL_Transfer_CLK_rate     ); 
   iREG_ROMCTRL_KEY1_Gap_CLKs         : entity work.eProcReg_ds generic map (ROMCTRL_KEY1_Gap_CLKs        ) port map  (clk100, ds_bus, reg_wired_or(16), REG_ROMCTRL_KEY1_Gap_CLKs           , REG_ROMCTRL_KEY1_Gap_CLKs         ); 
   iREG_ROMCTRL_RESB_Release_Reset    : entity work.eProcReg_ds generic map (ROMCTRL_RESB_Release_Reset   ) port map  (clk100, ds_bus, reg_wired_or(17), REG_ROMCTRL_RESB_Release_Reset      , REG_ROMCTRL_RESB_Release_Reset    ); 
   iREG_ROMCTRL_WR                    : entity work.eProcReg_ds generic map (ROMCTRL_WR                   ) port map  (clk100, ds_bus, reg_wired_or(18), REG_ROMCTRL_WR                      , REG_ROMCTRL_WR                    ); 
   iREG_ROMCTRL_Block_Start_Status    : entity work.eProcReg_ds generic map (ROMCTRL_Block_Start_Status   ) port map  (clk100, ds_bus, reg_wired_or(19), REG_ROMCTRL_Block_Start_Status_back , REG_ROMCTRL_Block_Start_Status    , Start_written); 
                                                                                                                                                                                                                                 
   iREG_Gamecard_bus_Command_1        : entity work.eProcReg_ds generic map (Gamecard_bus_Command_1       ) port map  (clk100, ds_bus, open            , (31 downto 0 => '0')                , REG_Gamecard_bus_Command_1        ); 
   iREG_Gamecard_bus_Command_2        : entity work.eProcReg_ds generic map (Gamecard_bus_Command_2       ) port map  (clk100, ds_bus, open            , (31 downto 0 => '0')                , REG_Gamecard_bus_Command_2        ); 

  
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   readtype   <= toperationtype'POS(operationtype);
   romaddress <= address;

   -- rom
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         dma_request <= '0';
         IRQ_Slot    <= '0';
      
         if (reset = '1') then
            REG_ROMCTRL_Block_Start_Status_back <= "0";
         else  
            
            if (Start_written = '1') then
               if (REG_ROMCTRL_Block_Start_Status = "1") then
                  REG_ROMCTRL_Block_Start_Status_back <= "1";
                  operationtype <= NONE;
                  
                  if (REG_Gamecard_bus_Command_1(7 downto 0) = x"B7") then
                     transfercount <= 16#200#;
                     operationtype <= ROM;
                     address       <= REG_Gamecard_bus_Command_1(15 downto 8) & REG_Gamecard_bus_Command_1(23 downto 16) & REG_Gamecard_bus_Command_1(31 downto 24) & REG_Gamecard_bus_Command_2(7 downto 0);
                  elsif (REG_Gamecard_bus_Command_1(7 downto 0) = x"B8") then
                     transfercount <= 4;
                     operationtype <= CHIPID;
                  end if;
                  
                  if (REG_Gamecard_bus_Command_1(7 downto 0) = x"B7" or REG_Gamecard_bus_Command_1(7 downto 0) = x"B8") then
                     if (REG_ROMCTRL_Transfer_CLK_rate = "1") then
                        workcnt <= (2 * 8 * (8 + to_integer(unsigned(REG_ROMCTRL_KEY1_gap1_length)))) + 4;
                     else
                        workcnt <= (2 * 5 * (8 + to_integer(unsigned(REG_ROMCTRL_KEY1_gap1_length)))) + 4;
                     end if;
                  end if;
                  
               else
                  REG_ROMCTRL_Block_Start_Status_back <= "0";
                  REG_ROMCTRL_Data_Word_Status        <= "0";
               end if;
            end if;
         
            if (new_cycles_valid = '1' and workcnt > 0) then
               if (new_cycles < workcnt) then
                  workcnt <= workcnt - to_integer(new_cycles);
               else
                  workcnt <= 0;
                  REG_ROMCTRL_Data_Word_Status <= "1";
                  dma_request                  <= '1';
                  dma_size                     <= transfercount / 4;
               end if;
            end if;
            
            if (unsigned(address) < 16#8000#) then  --feature of retail carts : B7 "Can be used only for addresses 8000h and up, smaller addresses will be silently redirected to address `8000h+(addr AND 1FFh)`"
               address <= std_logic_vector(to_unsigned(to_integer(unsigned(address(8 downto 0))) + 16#8000#, 32));
            end if;
            
            if (gamecard_read = '1') then -- todo: protect read after rom
               if (operationtype = ROM) then
                  address(11 downto 0) <= std_logic_vector(unsigned(address(11 downto 0)) + 4); -- However, the datastream wraps to the begin of the current 4K block when address+length crosses a 4K boundary (1000h bytes)
               end if;
               
               if (transfercount > 4) then
                  transfercount <= transfercount - 4;
               else
                  REG_ROMCTRL_Block_Start_Status_back <= "0";
                  REG_ROMCTRL_Data_Word_Status        <= "0";
                  if (REG_AUXSPICNT_Transfer_Ready_IRQ = "1") then
                     IRQ_Slot <= '1';
                  end if;
               end if;
            
            end if;
         
         end if;

      end if;
   end process;
   
   --save
   process (clk100)
      variable newvalue          : std_logic_vector(7 downto 0);
      variable newcmd            : std_logic_vector(7 downto 0);
      variable new_autodetecsize : unsigned(7 downto 0);
   begin
      if rising_edge(clk100) then
      
         auxspi_request <= '0';
      
         if (reset = '1') then
            
            spi_oldcnt     <= (others => '0');
            csOld          <= '0';
                            
            auxspi_reset   <= '0';
            cmd            <= CMD_IDLE;
            write_enable   <= '0';
            write_protect  <= (others => '0');
            addr_size      <= 0;
            addr_counter   <= (others => '0');
            addr           <= (others => '0');
            autodetect     <= '1';
            autodetectsize <= (others => '0');
            
            REG_AUXSPICNT_SPI_Busy  <= "0";
            REG_AUXSPIDATA_readback <= (others => '0');
         
         else
         
            if (hold_written = '1' or enable_written = '1') then
               if ((REG_AUXSPICNT_SPI_Hold_Chipselect = "0" and csOld = '1') or (REG_AUXSPICNT_NDS_Slot_Mode = "1" and (spi_oldcnt = x"0000") and REG_AUXSPICNT_SPI_Hold_Chipselect = "0")) then
                  auxspi_reset <= '1';
               end if;
            
               csOld <= REG_AUXSPICNT_SPI_Hold_Chipselect(REG_AUXSPICNT_SPI_Hold_Chipselect'left);
               spi_oldcnt <= REG_AUXSPICNT_NDS_Slot_Enable & REG_AUXSPICNT_Transfer_Ready_IRQ & REG_AUXSPICNT_NDS_Slot_Mode & (12 downto 8 => '0') & "0" & REG_AUXSPICNT_SPI_Hold_Chipselect & (5 downto 2 => '0') & REG_AUXSPICNT_SPI_Baudrate;
            end if;
         
            if (data_written = '1') then
               newvalue := REG_AUXSPIDATA;
               
               case (cmd) is
                  when CMD_WRITESTATUS => 
                     write_protect             <= REG_AUXSPIDATA;
                     write_protect(1 downto 0) <= "00";
               
                  when CMD_WRITELOW | CMD_READLOW =>
                     if (autodetect = '1') then
                        new_autodetecsize := autodetectsize + 1;
                        autodetectsize <= new_autodetecsize;
                        newvalue := x"FF";
                        if (auxspi_reset = '1') then
                           case (new_autodetecsize) is
                              when x"00" | x"01" => addr_size <= 1;
                              when x"02"  => addr_size <= 1;
                              when x"03"  => addr_size <= 2;
                              when x"04"  => addr_size <= 3;
                              when others => addr_size <= to_integer(new_autodetecsize(1 downto 0));
                           end case;
                           autodetect <= '0';
                           autodetectsize <= (others => '0');
                        end if;
                     else
                        if (addr_counter < addr_size) then
                           addr <= addr(23 downto 0) & unsigned(REG_AUXSPIDATA);
                           addr_counter <= addr_counter + 1;
                           newvalue := x"FF";
                        else
                           --why does tomb raider underworld access 0x180 and go clear through to 0x280?
                           --should this wrap around at 0 or at 0x100?
                           --TODO - dont other backup memory types have similar wraparound issues?
                           auxspi_addr <= std_logic_vector(addr);
                           if (addr_size = 1) then
                              auxspi_addr(31 downto 9) <= (31 downto 9 => '0');
                           end if;
               
                           if (cmd = CMD_READLOW) then
                              auxspi_request <= '1';
                              auxspi_rnw     <= '1';
                           else
                              if (write_enable = '1') then
                                 auxspi_request <= '1';
                                 auxspi_rnw     <= '0';
                                 auxspi_dataout <= REG_AUXSPIDATA;
                              end if;
                           end if;
                           addr <= addr + 1;
                        end if;
                     end if;

                  when CMD_READSTATUS =>
                     newvalue := write_protect;
                     if (write_enable = '1') then 
                        newvalue(1) := '1';
                     end if;
               
                  when CMD_IRDA =>
                     newvalue := x"AA";
               
                  when others =>
                     if (cmd = CMD_IDLE) then
                        cmd <= REG_AUXSPIDATA;
                        newvalue := x"FF";
                        newcmd := REG_AUXSPIDATA;
                        case (newcmd) is
                           when CMD_IRDA =>
                              newvalue := x"AA";
                              
                           when CMD_WRITEDISABLE => write_enable <= '0';
                           when CMD_WRITEENABLE  => write_enable <= '1';
                     
                           when CMD_WRITELOW | CMD_READLOW =>
                              addr_counter <= (others => '0');
                              addr         <= (others => '0');
                     
                           when CMD_WRITEHIGH | CMD_READHIGH =>
                              if (REG_AUXSPIDATA = CMD_WRITEHIGH) then cmd <= CMD_WRITELOW; end if;
                              if (REG_AUXSPIDATA = CMD_READHIGH)  then cmd <= CMD_READLOW;  end if;
                              addr_counter <= (others => '0');
                              addr         <= (others => '0');
                              if (addr_size = 1) then 
                                 addr <= to_unsigned(1, 32); -- due to 256byte space or bugs in games (e.g. pokemon diamond?)
                              end if;
                              
                           when others => null;
                        end case;
                     end if;
                     
               end case;
               
               if (auxspi_reset = '1') then
                  --if (cmd == AUXSPICMD::WRITELOW || cmd == AUXSPICMD::WRITEHIGH)
                  --{
                  --   //flush? -> probably close file -> write ended?
                  --}
                  cmd          <= CMD_IDLE;
                  auxspi_reset <= '0';
               end if;
               
               REG_AUXSPIDATA_readback <= newvalue; 
            
            end if;
            
            if (auxspi_done = '1') then
               REG_AUXSPIDATA_readback <= auxspi_datain;
            end if;
            
         end if;

      end if;
   end process;

end architecture;





