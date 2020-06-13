library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;
use work.pReg_ds_system_7.all;

entity ds_SPI_intern is
   generic
   (
      Softmap_DS_FIRMWARE_ADDR : integer
   );
   port 
   (
      clk100        : in     std_logic;  
      ds_on         : in     std_logic;
      reset         : in     std_logic;
                             
      ds_bus        : in     proc_bus_ds_type; 
      ds_bus_data   : out    std_logic_vector(31 downto 0);       
      
      Touch         : in     std_logic;
      TouchX        : in     std_logic_vector(7 downto 0);
      TouchY        : in     std_logic_vector(7 downto 0);

      spi_done      : out    std_logic := '0';
      spi_active    : buffer std_logic := '0';
      firmware_read : out    std_logic := '0';
      firmware_addr : out    std_logic_vector(28 downto 0);
      firmware_data : in     std_logic_vector(31 downto 0);
      firmware_done : in     std_logic
      
   );
end entity;

architecture arch of ds_SPI_intern is
  
   signal REG_SPICNT_Baudrate          : std_logic_vector(SPICNT_Baudrate         .upper downto SPICNT_Baudrate         .lower) := (others => '0');
   signal REG_SPICNT_Busy_Flag         : std_logic_vector(SPICNT_Busy_Flag        .upper downto SPICNT_Busy_Flag        .lower) := (others => '0');
   signal REG_SPICNT_Device_Select     : std_logic_vector(SPICNT_Device_Select    .upper downto SPICNT_Device_Select    .lower) := (others => '0');
   signal REG_SPICNT_Transfer_Size     : std_logic_vector(SPICNT_Transfer_Size    .upper downto SPICNT_Transfer_Size    .lower) := (others => '0');
   signal REG_SPICNT_Chipselect_Hold   : std_logic_vector(SPICNT_Chipselect_Hold  .upper downto SPICNT_Chipselect_Hold  .lower) := (others => '0');
   signal REG_SPICNT_Interrupt_Request : std_logic_vector(SPICNT_Interrupt_Request.upper downto SPICNT_Interrupt_Request.lower) := (others => '0');
   signal REG_SPICNT_SPI_Bus_Enable    : std_logic_vector(SPICNT_SPI_Bus_Enable   .upper downto SPICNT_SPI_Bus_Enable   .lower) := (others => '0');
   signal REG_SPIDATA_IN               : std_logic_vector(SPIDATA                 .upper downto SPIDATA                 .lower) := (others => '0');
   signal REG_SPIDATA_OUT              : std_logic_vector(SPIDATA                 .upper downto SPIDATA                 .lower) := (others => '0');
             
   type t_reg_wired_or is array(0 to 7) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;

   signal REG_SPICNT_Baudrate_written      : std_logic;
   signal REG_SPICNT_Device_Select_written : std_logic;
   signal REG_SPIDATA_written              : std_logic;
   
   signal REG_SPICNT_Device_Select_1   : std_logic_vector(SPICNT_Device_Select    .upper downto SPICNT_Device_Select    .lower) := (others => '0');
   signal REG_SPICNT_Chipselect_Hold_1 : std_logic_vector(SPICNT_Chipselect_Hold  .upper downto SPICNT_Chipselect_Hold  .lower) := (others => '0');

   -- common
   signal register_access : std_logic := '0';
   signal last_command    : std_logic_vector(7 downto 0);

   -- powerman
   signal powerman_control_written : std_logic := '0';
   signal powerman_control         : std_logic_vector(7 downto 0);
   type t_powerman_regs is array(0 to 4) of std_logic_vector(7 downto 0);
   signal powerman_regs : t_powerman_regs;

   -- firmware
   type tfirmwarestate is
   (
      IDLE,
      CMDREAD
   );
   signal firmwarestate : tfirmwarestate := IDLE;
   
   signal firmware_wordcnt : integer range 0 to 3;
   signal firmware_address : std_logic_vector(23 downto 0);
   signal fireware_lowmux  : std_logic_vector(1 downto 0);
   
   -- touch screen
   signal firstbyte : std_logic := '1';
   signal z1u : std_logic_vector(15 downto 0);
   signal z2u : std_logic_vector(15 downto 0);
   

begin 
   
   iREG_SPICNT_Baudrate          : entity work.eProcReg_ds generic map (SPICNT_Baudrate         ) port map  (clk100, ds_bus, reg_wired_or(0), REG_SPICNT_Baudrate          , REG_SPICNT_Baudrate          , REG_SPICNT_Baudrate_written); 
   iREG_SPICNT_Busy_Flag         : entity work.eProcReg_ds generic map (SPICNT_Busy_Flag        ) port map  (clk100, ds_bus, reg_wired_or(1), REG_SPICNT_Busy_Flag         ); 
   iREG_SPICNT_Device_Select     : entity work.eProcReg_ds generic map (SPICNT_Device_Select    ) port map  (clk100, ds_bus, reg_wired_or(2), REG_SPICNT_Device_Select     , REG_SPICNT_Device_Select     , REG_SPICNT_Device_Select_written); 
   iREG_SPICNT_Transfer_Size     : entity work.eProcReg_ds generic map (SPICNT_Transfer_Size    ) port map  (clk100, ds_bus, reg_wired_or(3), REG_SPICNT_Transfer_Size     , REG_SPICNT_Transfer_Size     ); 
   iREG_SPICNT_Chipselect_Hold   : entity work.eProcReg_ds generic map (SPICNT_Chipselect_Hold  ) port map  (clk100, ds_bus, reg_wired_or(4), REG_SPICNT_Chipselect_Hold   , REG_SPICNT_Chipselect_Hold   ); 
   iREG_SPICNT_Interrupt_Request : entity work.eProcReg_ds generic map (SPICNT_Interrupt_Request) port map  (clk100, ds_bus, reg_wired_or(5), REG_SPICNT_Interrupt_Request , REG_SPICNT_Interrupt_Request ); 
   iREG_SPICNT_SPI_Bus_Enable    : entity work.eProcReg_ds generic map (SPICNT_SPI_Bus_Enable   ) port map  (clk100, ds_bus, reg_wired_or(6), REG_SPICNT_SPI_Bus_Enable    , REG_SPICNT_SPI_Bus_Enable    ); 
   iREG_SPIDATA                  : entity work.eProcReg_ds generic map (SPIDATA                 ) port map  (clk100, ds_bus, reg_wired_or(7), REG_SPIDATA_OUT              , REG_SPIDATA_IN               , REG_SPIDATA_written); 

  
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;

   process (clk100)
      variable command : std_logic_vector(7 downto 0);
      variable retval  : std_logic_vector(7 downto 0);
      variable powerman_regindex : integer range 0 to 4;
   begin
      if rising_edge(clk100) then
      
         spi_done      <= '0';
         firmware_read <= '0';
   
         if (reset = '1') then -- reset
         
            spi_active               <= '0';
   
            last_command             <= (others => '0');
            REG_SPIDATA_OUT          <= (others => '0');
            
            powerman_control_written <= '0';
            powerman_control         <= (others => '0'); 
            powerman_regs(0)         <= x"0D";
            powerman_regs(1)         <= x"00";
            powerman_regs(2)         <= x"01";
            powerman_regs(3)         <= x"00";
            powerman_regs(4)         <= x"03";
            
            firmwarestate            <= IDLE;
            
            firstbyte                <= '1';
   
         else
         
            -- touchscreen z1/z2 calculation - todo
            if (Touch = '1') then
               z1u <= x"4567";
               z2u <= x"4567";
            else
               z1u <= (others => '0');
               z2u <= (others => '0');
            end if;
            
            -- check reset
            REG_SPICNT_Device_Select_1   <= REG_SPICNT_Device_Select;
            REG_SPICNT_Chipselect_Hold_1 <= REG_SPICNT_Chipselect_Hold;
            if (REG_SPICNT_Baudrate_written = '1' or REG_SPICNT_Device_Select_written = '1') then
               
               if (unsigned(REG_SPICNT_Device_Select) /= 1 or unsigned(REG_SPICNT_Device_Select_1) /= 1 or REG_SPICNT_Chipselect_Hold_1 = "0") then
                  firmwarestate <= IDLE;
               end if;
               
            end if;
            
            register_access <= '0';
            if (ds_bus.adr(12 downto 0) = '0' & x"1C0" and ds_bus.ena = '1') then
               register_access <= '1';
            end if;
            if (register_access = '1') then
               spi_done <= '1'; -- default, overwritten only for firmware access
            end if;
            
            if (firmware_done = '1' and spi_active = '1') then
               spi_done   <= '1';
               spi_active <= '0';
               case (fireware_lowmux(1 downto 0)) is
                  when "00" => REG_SPIDATA_OUT <= firmware_data( 7 downto  0);
                  when "01" => REG_SPIDATA_OUT <= firmware_data(15 downto  8);
                  when "10" => REG_SPIDATA_OUT <= firmware_data(23 downto 16);
                  when "11" => REG_SPIDATA_OUT <= firmware_data(31 downto 24);
                  when others => null;
               end case;
            end if;
            
            -- write data
            if (REG_SPIDATA_written = '1') then
            
               command := REG_SPIDATA_IN;
            
               if (REG_SPIDATA_IN = x"00") then -- save last command, only used for touchscreen device select!
                  command := last_command;
               else
                  last_command <= REG_SPIDATA_IN;
               end if;

               retval := REG_SPIDATA_IN;
               
               case (to_integer(unsigned(REG_SPICNT_Device_Select))) is
               
                  when 0 => -- powerman
                     if (powerman_control_written = '0') then
                        powerman_control_written <= '1';
                        powerman_control         <= REG_SPIDATA_IN;
                     else
                        powerman_control_written <= '0';
                        if (to_integer(unsigned(powerman_control(2 downto 0))) > 4) then
                           powerman_regindex := 4;
                        else
                           powerman_regindex := to_integer(unsigned(powerman_control(2 downto 0)));
                        end if;
                        if (powerman_control(7) = '1') then -- read
                           retval := powerman_regs(powerman_regindex);
                        else
                           powerman_regs(powerman_regindex) <= REG_SPIDATA_IN;
                        end if;
                        
                     end if;
                     
                  when 1 => -- firmware
                     if (to_integer(unsigned(REG_SPICNT_Baudrate)) /= 0) then
                        retval := x"00";
                     else
                        case (firmwarestate) is
                           when IDLE =>
                              if (REG_SPIDATA_IN = x"03") then
                                 firmwarestate    <= CMDREAD;
                                 firmware_wordcnt <= 3;
                              end if;
                              
                           when CMDREAD =>
                              if (firmware_wordcnt > 0) then
                                 firmware_wordcnt <= firmware_wordcnt - 1;
                                 firmware_address(((firmware_wordcnt - 1) * 8) + 7 downto (firmware_wordcnt - 1) * 8) <= REG_SPIDATA_IN;
                              else
                                 if (unsigned(firmware_address) < 262144) then
                                    firmware_read    <= '1';
                                    firmware_addr    <= ("00000" & firmware_address) or std_logic_vector(to_unsigned(Softmap_DS_FIRMWARE_ADDR, 29));
                                    spi_done         <= '0';
                                    spi_active       <= '1';
                                    fireware_lowmux  <= firmware_address(1 downto 0);
                                    firmware_address <= std_logic_vector(unsigned(firmware_address) + 1);
                                 end if;
                              end if;
                        end case;
                     end if;
                  
                  when 2 => -- touchscreen
                     case (to_integer(unsigned(command(6 downto 4)))) is
                     
                        when 0 =>  -- Temperature 0 (requires calibration, step 2.1mV per 1'C accuracy)
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := x"60"; -- ((716 << 3) & 0x7FF)
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := x"16"; -- (716 >> 5)
                           end if;
                        
                        when 1 =>  -- Touchscreen Y - Position(somewhat 0B0h..F20h, or FFFh = released) - todo: may add some jitter here
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := TouchY(0) & (6 downto 0 => '0');
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := '0' & TouchY(7 downto 1);
                           end if;
                        
                        when 2 =>  -- Battery Voltage(not used, connected to GND in NDS, always 000h)
                           retval := x"00";
                        
                        when 3 =>  -- Touchscreen Z1 - Position(diagonal position for pressure measurement)
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := z1u(4 downto 0) & "000";
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := z1u(12 downto 5);
                           end if;
                        
                        when 4 =>  -- Touchscreen Z2 - Position(diagonal position for pressure measurement)
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := z2u(4 downto 0) & "000";
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := z2u(12 downto 5);
                           end if;
                        
                        when 5 =>  -- Touchscreen X - Position(somewhat 100h..ED0h, or 000h = released)
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := TouchX(0) & (6 downto 0 => '0');
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := '0' & TouchX(7 downto 1);
                           end if;
                        
                        when 6 =>  -- AUX Input(connected to Microphone in the NDS)
                           retval := x"00";
                        
                        when 7 =>  -- Temperature 1 (difference to Temp 0, without calibration, 2'C accuracy)
                           firstbyte <= '1';
                           if (firstbyte = '1' or REG_SPICNT_Chipselect_Hold = "0") then
                              retval := x"08"; -- ((865 << 3) & 0x7FF)
                              if (REG_SPICNT_Chipselect_Hold = "1") then
                                 firstbyte <= '0';
                              end if;
                           else
                              retval := x"1B"; -- (865 >> 5)
                           end if;
                     
                        when others => null;
                     end case;

                  when others => null;
               end case;
               
               REG_SPIDATA_OUT <= retval;
            
            end if;
            
            
         end if;

      end if;
   end process;

end architecture;





