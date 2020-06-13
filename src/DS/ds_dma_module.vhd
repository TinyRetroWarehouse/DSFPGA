library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

use work.pReg_savestates.all;

entity ds_dma_module is
   generic
   (
      isArm9                       : std_logic;
      index                        : integer range 0 to 3;
      Reg_SAD                      : regmap_type;
      Reg_DAD                      : regmap_type;
      Reg_CNT_L                    : regmap_type;
      Reg_CNT_H_Dest_Addr_Control  : regmap_type;
      Reg_CNT_H_Source_Adr_Control : regmap_type;
      Reg_CNT_H_DMA_Repeat         : regmap_type;
      Reg_CNT_H_DMA_Transfer_Type  : regmap_type;
      Reg_CNT_H_DMA_Start_Timing   : regmap_type;
      Reg_CNT_H_IRQ_on             : regmap_type;
      Reg_CNT_H_DMA_Enable         : regmap_type
   );
   port 
   (
      clk100              : in  std_logic;  
      reset               : in  std_logic;
      
      savestate_bus       : in  proc_bus_ds_type;
      loading_savestate   : in  std_logic;
      
      ds_bus              : in  proc_bus_ds_type;
      ds_bus_data         : out std_logic_vector(31 downto 0); 
      
      new_cycles          : in  unsigned(7 downto 0);
      new_cycles_valid    : in  std_logic;
      do_step             : in  std_logic;
      
      IRP_DMA             : out std_logic := '0';
      
      dma_on              : out std_logic := '0';
      allow_on            : in  std_logic;
      dma_soon            : out std_logic := '0';
      
      hblank_trigger      : in  std_logic;
      vblank_trigger      : in  std_logic;
      MemDisplay_trigger  : in  std_logic;
      cardtrans_trigger   : in  std_logic;
      cardtrans_size      : in  integer range 0 to 128;
      
      last_dma_out        : out std_logic_vector(31 downto 0) := (others => '0');
      last_dma_valid      : out std_logic := '0';
      last_dma_in         : in  std_logic_vector(31 downto 0);
      
      dma_bus_Adr         : out std_logic_vector(31 downto 0) := (others => '0'); 
      dma_bus_rnw         : out std_logic := '0';
      dma_bus_ena         : out std_logic := '0';
      dma_bus_acc         : out std_logic_vector(1 downto 0) := (others => '0'); 
      dma_bus_dout        : out std_logic_vector(31 downto 0) := (others => '0'); 
      dma_bus_din         : in  std_logic_vector(31 downto 0);
      dma_bus_done        : in  std_logic;
      dma_bus_unread      : in  std_logic;
      
      is_idle             : out std_logic
   );
end entity;

architecture arch of ds_dma_module is

   signal SAD                      : std_logic_vector(Reg_SAD                     .upper downto Reg_SAD                     .lower) := (others => '0');
   signal DAD                      : std_logic_vector(Reg_DAD                     .upper downto Reg_DAD                     .lower) := (others => '0');
   signal CNT_L                    : std_logic_vector(Reg_CNT_L                   .upper downto Reg_CNT_L                   .lower) := (others => '0');
   signal CNT_H_Dest_Addr_Control  : std_logic_vector(Reg_CNT_H_Dest_Addr_Control .upper downto Reg_CNT_H_Dest_Addr_Control .lower) := (others => '0');
   signal CNT_H_Source_Adr_Control : std_logic_vector(Reg_CNT_H_Source_Adr_Control.upper downto Reg_CNT_H_Source_Adr_Control.lower) := (others => '0');
   signal CNT_H_DMA_Repeat         : std_logic_vector(Reg_CNT_H_DMA_Repeat        .upper downto Reg_CNT_H_DMA_Repeat        .lower) := (others => '0');
   signal CNT_H_DMA_Transfer_Type  : std_logic_vector(Reg_CNT_H_DMA_Transfer_Type .upper downto Reg_CNT_H_DMA_Transfer_Type .lower) := (others => '0');
   signal CNT_H_DMA_Start_Timing   : std_logic_vector(Reg_CNT_H_DMA_Start_Timing  .upper downto Reg_CNT_H_DMA_Start_Timing  .lower) := (others => '0');
   signal CNT_H_IRQ_on             : std_logic_vector(Reg_CNT_H_IRQ_on            .upper downto Reg_CNT_H_IRQ_on            .lower) := (others => '0');
   signal CNT_H_DMA_Enable         : std_logic_vector(Reg_CNT_H_DMA_Enable        .upper downto Reg_CNT_H_DMA_Enable        .lower) := (others => '0');
               
   type t_reg_wired_or is array(0 to 7) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
               
   signal CNT_H_DMA_Enable_written           : std_logic;   

   signal Enable    : std_logic_vector(0 downto 0) := "0";
   signal running   : std_logic := '0';
   signal waiting   : std_logic := '0';
   signal first     : std_logic := '0';
   signal dmaon     : std_logic := '0';
   signal waitTicks : integer range 0 to 3 := 0;
   
   signal dest_Addr_Control  : integer range 0 to 3;
   signal source_Adr_Control : integer range 0 to 3;
   signal Start_Timing       : integer range 0 to 7;
   signal Repeat             : std_logic;
   signal Transfer_Type_DW   : std_logic;
   signal iRQ_on             : std_logic;

   signal addr_source        : unsigned(31 downto 0);
   signal addr_target        : unsigned(31 downto 0);
   signal count              : unsigned(CNT_L'left + 1 downto 0);

   type tstate is
   (
      IDLE,
      READING,
      WRITING
   );
   signal state : tstate := IDLE;

   -- savestate
   signal SAVESTATE_DMASOURCE     : std_logic_vector(31 downto 0);
   signal SAVESTATE_DMATARGET     : std_logic_vector(31 downto 0);
   signal SAVESTATE_DMAMIXED      : std_logic_vector(30 downto 0);
   signal SAVESTATE_DMAMIXED_BACK : std_logic_vector(30 downto 0); 
   
   
begin 

   iSAD                      : entity work.eProcReg_ds generic map ( Reg_SAD                      ) port map  (clk100, ds_bus, open           , x"00000000"                  , SAD                     );  
   iDAD                      : entity work.eProcReg_ds generic map ( Reg_DAD                      ) port map  (clk100, ds_bus, open           , x"00000000"                  , DAD                     );  
   iCNT_L                    : entity work.eProcReg_ds generic map ( Reg_CNT_L                    ) port map  (clk100, ds_bus, reg_wired_or(0), (CNT_L'left downto 0 => '0') , CNT_L                   );   
   iCNT_H_Dest_Addr_Control  : entity work.eProcReg_ds generic map ( Reg_CNT_H_Dest_Addr_Control  ) port map  (clk100, ds_bus, reg_wired_or(1), CNT_H_Dest_Addr_Control      , CNT_H_Dest_Addr_Control );  
   iCNT_H_Source_Adr_Control : entity work.eProcReg_ds generic map ( Reg_CNT_H_Source_Adr_Control ) port map  (clk100, ds_bus, reg_wired_or(2), CNT_H_Source_Adr_Control     , CNT_H_Source_Adr_Control);  
   iCNT_H_DMA_Repeat         : entity work.eProcReg_ds generic map ( Reg_CNT_H_DMA_Repeat         ) port map  (clk100, ds_bus, reg_wired_or(3), CNT_H_DMA_Repeat             , CNT_H_DMA_Repeat        );  
   iCNT_H_DMA_Transfer_Type  : entity work.eProcReg_ds generic map ( Reg_CNT_H_DMA_Transfer_Type  ) port map  (clk100, ds_bus, reg_wired_or(4), CNT_H_DMA_Transfer_Type      , CNT_H_DMA_Transfer_Type );  
   iCNT_H_DMA_Start_Timing   : entity work.eProcReg_ds generic map ( Reg_CNT_H_DMA_Start_Timing   ) port map  (clk100, ds_bus, reg_wired_or(5), CNT_H_DMA_Start_Timing       , CNT_H_DMA_Start_Timing  );  
   iCNT_H_IRQ_on             : entity work.eProcReg_ds generic map ( Reg_CNT_H_IRQ_on             ) port map  (clk100, ds_bus, reg_wired_or(6), CNT_H_IRQ_on                 , CNT_H_IRQ_on            );  
   iCNT_H_DMA_Enable         : entity work.eProcReg_ds generic map ( Reg_CNT_H_DMA_Enable         ) port map  (clk100, ds_bus, reg_wired_or(7), Enable                       , CNT_H_DMA_Enable         , CNT_H_DMA_Enable_written);  
   
   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   -- save state
   iSAVESTATE_DMASOURCE : entity work.eProcReg_ds generic map (REG_SAVESTATE_DMASOURCE, index) port map (clk100, savestate_bus, open, std_logic_vector(addr_source) , SAVESTATE_DMASOURCE);
   iSAVESTATE_DMATARGET : entity work.eProcReg_ds generic map (REG_SAVESTATE_DMATARGET, index) port map (clk100, savestate_bus, open, std_logic_vector(addr_target) , SAVESTATE_DMATARGET);
   iSAVESTATE_DMAMIXED  : entity work.eProcReg_ds generic map (REG_SAVESTATE_DMAMIXED , index) port map (clk100, savestate_bus, open,       SAVESTATE_DMAMIXED_BACK , SAVESTATE_DMAMIXED );
   
   SAVESTATE_DMAMIXED_BACK(16 downto 0)  <= (others => '0'); --std_logic_vector(count(16 downto 0)); -- todo: wrong bits for arm9 DMAs
   SAVESTATE_DMAMIXED_BACK(17 downto 17) <= Enable;            
   SAVESTATE_DMAMIXED_BACK(18)           <= '1' when running = '1' or waitTicks > 0 else '0';           
   SAVESTATE_DMAMIXED_BACK(19)           <= waiting;           
   SAVESTATE_DMAMIXED_BACK(20)           <= first;             
   SAVESTATE_DMAMIXED_BACK(22 downto 21) <= std_logic_vector(to_unsigned(dest_Addr_Control, 2)); 
   SAVESTATE_DMAMIXED_BACK(24 downto 23) <= std_logic_vector(to_unsigned(source_Adr_Control, 2));
   SAVESTATE_DMAMIXED_BACK(26 downto 25) <= std_logic_vector(to_unsigned(Start_Timing, 2));     -- todo: wrong bits for arm9 DMAs  
   SAVESTATE_DMAMIXED_BACK(27)           <= Repeat;           
   SAVESTATE_DMAMIXED_BACK(28)           <= Transfer_Type_DW; 
   SAVESTATE_DMAMIXED_BACK(29)           <= iRQ_on;            
   SAVESTATE_DMAMIXED_BACK(30)           <= dmaon;            
   
   is_idle <= '1' when state = IDLE else '0';
   
   dma_on <= dmaon;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         IRP_DMA       <= '0';
         
         dma_bus_ena   <= '0';
         
         last_dma_valid   <= '0';
         
         if (reset = '1') then
            addr_source        <= unsigned(SAVESTATE_DMASOURCE);
            addr_target        <= unsigned(SAVESTATE_DMATARGET);
            count              <= (others => '0'); -- unsigned(SAVESTATE_DMAMIXED(16 downto 0));   todo: wrong bits for arm9 DMAs
            
            Enable             <= SAVESTATE_DMAMIXED(17 downto 17);
            running            <= SAVESTATE_DMAMIXED(18);
            waiting            <= SAVESTATE_DMAMIXED(19);
            first              <= SAVESTATE_DMAMIXED(20);
            dest_Addr_Control  <= to_integer(unsigned(SAVESTATE_DMAMIXED(22 downto 21)));
            source_Adr_Control <= to_integer(unsigned(SAVESTATE_DMAMIXED(24 downto 23)));
            Start_Timing       <= to_integer(unsigned(SAVESTATE_DMAMIXED(26 downto 25)));
            Repeat             <= SAVESTATE_DMAMIXED(27);
            Transfer_Type_DW   <= SAVESTATE_DMAMIXED(28);
            iRQ_on             <= SAVESTATE_DMAMIXED(29);
            dmaon              <= SAVESTATE_DMAMIXED(30);
         
            waitTicks          <= 0;
            state              <= IDLE;
         else
      
            -- dma init
            if (CNT_H_DMA_Enable_written= '1' and loading_savestate = '0') then
            
               Enable <= CNT_H_DMA_Enable;
               
               if (CNT_H_DMA_Enable = "0") then
                  running <= '0';
                  waiting <= '0';
                  dmaon   <= '0';
               end if;
            
               if (Enable = "0" and CNT_H_DMA_Enable = "1") then
                  
                  dest_Addr_Control  <= to_integer(unsigned(CNT_H_Dest_Addr_Control));
                  source_Adr_Control <= to_integer(unsigned(CNT_H_Source_Adr_Control));
                  Start_Timing       <= to_integer(unsigned(CNT_H_DMA_Start_Timing));
                  Repeat             <= CNT_H_DMA_Repeat(CNT_H_DMA_Repeat'left);
                  Transfer_Type_DW   <= CNT_H_DMA_Transfer_Type(CNT_H_DMA_Transfer_Type'left);
                  iRQ_on             <= CNT_H_IRQ_on(CNT_H_IRQ_on'left);
   
                  addr_source <= unsigned(SAD(31 downto 0));
                  addr_target <= unsigned(DAD(31 downto 0));
   
                  waiting <= '1';
   
                  if (isArm9 = '1') then
   
                     if (unsigned(CNT_L) = 0) then  
                        count <= to_unsigned(16#200000#, count'length);
                     else
                        count <= '0' & unsigned(CNT_L);
                     end if;
   
                  else
                     addr_source(31 downto 28) <= x"0";
                     addr_target(31 downto 28) <= x"0";
                     case (index) is
                        when 0 => addr_source(27) <= '0'; addr_target(27) <= '0';
                        when 1 =>                         addr_target(27) <= '0';
                        when 2 =>                         addr_target(27) <= '0';
                        when 3 => null;
                     end case;
                     
                     if (index = 3) then
                        if (unsigned(CNT_L) = 0) then   
                           count <= to_unsigned(16#10000#, count'length);
                        else
                           count <= '0' & unsigned(CNT_L);
                        end if;  
                     else
                        if (unsigned(CNT_L) = 0) then
                           count <= to_unsigned(16#4000#, count'length);
                        else
                           count <= '0' & unsigned(CNT_L);
                        end if;  
                     end if;
                     
                  end if;
                     
               end if;
            
            end if;
         
            -- dma checkrun
            if (Enable = "1") then 
               if (waiting = '1') then
                  if (Start_Timing = 0 or 
                  (Start_Timing = 1 and vblank_trigger = '1') or 
                  (Start_Timing = 2 and hblank_trigger = '1') or
                  (isArm9 = '1' and Start_Timing = 4 and MemDisplay_trigger = '1') or
                  (isArm9 = '1' and Start_Timing = 5 and cardtrans_trigger = '1') or
                  (isArm9 = '0' and Start_Timing = 2 and cardtrans_trigger = '1')) then
                     dma_soon   <= '1';
                     waitTicks  <= 1;
                     waiting    <= '0';
                     first      <= '1';
                  end if ;

                  if (Start_Timing = 4) then
                     count <= to_unsigned(128, count'length);
                  end if;
                  
                  if ((isArm9 = '1' and Start_Timing = 5 and cardtrans_trigger = '1') or (isArm9 = '0' and Start_Timing = 2 and cardtrans_trigger = '1')) then
                     count <= to_unsigned(cardtrans_size, count'length);
                  end if;

                  if (isArm9 = '1' and Start_Timing = 4 and vblank_trigger = '1') then
                     waiting <= '0';
                     dmaon   <= '0';
                     Enable  <= "0";
                  end if;
               end if;
      
               if (waitTicks > 0) then
                  if (do_step = '1') then
                     --if (new_cycles >= waitTicks) then
                        running   <= '1';
                        dmaon     <= '1';
                        waitTicks <= 0;
                        dma_soon  <= '0';
                     --else
                     --   waitTicks <= waitTicks - to_integer(new_cycles);
                     --end if;
                  end if;
               end if;
                  
      
               -- dma work
               if (running = '1') then
                  
                  case state is
                  
                     when IDLE =>
                        if (allow_on = '1') then
                           state <= READING;
                           dma_bus_rnw <= '1';
                           dma_bus_ena <= '1';
                           if (Transfer_Type_DW = '1') then
                              dma_bus_Adr <= std_logic_vector(addr_source(31 downto 2)) & "00";
                              dma_bus_acc <= ACCESS_32BIT;
                           else
                              dma_bus_Adr <= std_logic_vector(addr_source(31 downto 1)) & "0";
                              dma_bus_acc <= ACCESS_16BIT;
                           end if;  
                           -- timing
                           count <= count - 1;
                           first <= '0'; 
                        end if;
                     
                     when READING =>
                        if (dma_bus_done = '1') then
                           state <= WRITING;
                           dma_bus_rnw  <= '0';
                           dma_bus_ena  <= '1';
                           if (Transfer_Type_DW = '1') then
                              dma_bus_Adr <= std_logic_vector(addr_target(31 downto 2)) & "00";
                           else
                              dma_bus_Adr <= std_logic_vector(addr_target(31 downto 1)) & "0";
                           end if;
                           
                           if (addr_source >= 16#2000000# and dma_bus_unread = '0') then
                              dma_bus_dout   <= dma_bus_din;
                              last_dma_valid <= '1';
                              if (Transfer_Type_DW = '1') then                           
                                 last_dma_out   <= dma_bus_din;
                              else
                                 last_dma_out   <= dma_bus_din(15 downto 0) & dma_bus_din(15 downto 0);
                              end if;
                           else
                              dma_bus_dout <= last_dma_in;
                           end if;
                           
                           -- next settings
                           if (Transfer_Type_DW = '1') then
                              if (source_Adr_Control = 0 or source_Adr_Control = 3 or (addr_source >= 16#8000000# and addr_source < 16#E000000#)) then 
                                 addr_source <= addr_source + 4; 
                              elsif (source_Adr_Control = 1) then
                                 addr_source <= addr_source - 4;
                              end if;
   
                              if (dest_Addr_Control = 0 or (dest_Addr_Control = 3 and Start_Timing /= 3)) then
                                 addr_target <= addr_target + 4;
                              elsif (dest_Addr_Control = 1) then
                                 addr_target <= addr_target - 4;
                              end if;
                           else
                              if (source_Adr_Control = 0 or source_Adr_Control = 3 or (addr_source >= 16#8000000# and addr_source < 16#E000000#)) then 
                                 addr_source <= addr_source + 2; 
                              elsif (source_Adr_Control = 1) then
                                 addr_source <= addr_source - 2;
                              end if;
   
                              if (dest_Addr_Control = 0 or (dest_Addr_Control = 3 and Start_Timing /= 3)) then
                                 addr_target <= addr_target + 2;
                              elsif (dest_Addr_Control = 1) then
                                 addr_target <= addr_target - 2;
                              end if;
                           end if;
                        end if;
                        
                     
                     when WRITING =>
                        if (dma_bus_done = '1') then
                           state <= IDLE;
                           if (count = 0) then
                              running <= '0';
                              dmaon   <= '0';
   
                              IRP_DMA <= iRQ_on;
   
                              if (Repeat = '1' and Start_Timing /= 0) then
                                 waiting <= '1';
                                    
                                 if (isArm9 = '1') then
                  
                                    if (unsigned(CNT_L) = 0) then  
                                       count <= to_unsigned(16#200000#, count'length);
                                    end if;
                                    
                                    if (dest_Addr_Control = 3) then
                                       addr_target <= unsigned(DAD(31 downto 0));
                                    end if;
                  
                                 else
                                 
                                    if (dest_Addr_Control = 3) then
                                       addr_target <= unsigned(DAD(31 downto 0));
                                       addr_target(31 downto 28) <= x"0";
                                       if (index < 3) then
                                          addr_target(27) <= '0';
                                       end if;
                                    end if;
                                    
                                    if (index = 3) then
                                       if (unsigned(CNT_L) = 0) then   
                                          count <= to_unsigned(16#10000#, count'length);
                                       else
                                          count <= '0' & unsigned(CNT_L);
                                       end if;  
                                    else
                                       if (unsigned(CNT_L) = 0) then
                                          count <= to_unsigned(16#4000#, count'length);
                                       else
                                          count <= '0' & unsigned(CNT_L);
                                       end if;  
                                    end if;
                                 end if;

                              else
                                 Enable <= "0";
                              end if;
                           end if;
                        end if;
                     
                  end case;
                  
               
               end if;
            end if;
            
         end if;
      
      end if;
   end process;
  

end architecture;


