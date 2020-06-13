library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;
use work.pRegmap_ds.all;

entity ds_dma is
   generic
   (
      isArm9                       : std_logic;
      DMA0SAD                      : regmap_type;
      DMA0DAD                      : regmap_type;
      DMA0CNT_L                    : regmap_type;
      DMA0CNT_H                    : regmap_type;
      DMA0CNT_H_Dest_Addr_Control  : regmap_type;
      DMA0CNT_H_Source_Adr_Control : regmap_type;
      DMA0CNT_H_DMA_Repeat         : regmap_type;
      DMA0CNT_H_DMA_Transfer_Type  : regmap_type;
      DMA0CNT_H_DMA_Start_Timing   : regmap_type;
      DMA0CNT_H_IRQ_on             : regmap_type;
      DMA0CNT_H_DMA_Enable         : regmap_type;
      DMA1SAD                      : regmap_type;
      DMA1DAD                      : regmap_type;
      DMA1CNT_L                    : regmap_type;
      DMA1CNT_H                    : regmap_type;
      DMA1CNT_H_Dest_Addr_Control  : regmap_type;
      DMA1CNT_H_Source_Adr_Control : regmap_type;
      DMA1CNT_H_DMA_Repeat         : regmap_type;
      DMA1CNT_H_DMA_Transfer_Type  : regmap_type;
      DMA1CNT_H_DMA_Start_Timing   : regmap_type;
      DMA1CNT_H_IRQ_on             : regmap_type;
      DMA1CNT_H_DMA_Enable         : regmap_type;
      DMA2SAD                      : regmap_type;
      DMA2DAD                      : regmap_type;
      DMA2CNT_L                    : regmap_type;
      DMA2CNT_H                    : regmap_type;
      DMA2CNT_H_Dest_Addr_Control  : regmap_type;
      DMA2CNT_H_Source_Adr_Control : regmap_type;
      DMA2CNT_H_DMA_Repeat         : regmap_type;
      DMA2CNT_H_DMA_Transfer_Type  : regmap_type;
      DMA2CNT_H_DMA_Start_Timing   : regmap_type;
      DMA2CNT_H_IRQ_on             : regmap_type;
      DMA2CNT_H_DMA_Enable         : regmap_type;
      DMA3SAD                      : regmap_type;
      DMA3DAD                      : regmap_type;
      DMA3CNT_L                    : regmap_type;
      DMA3CNT_H                    : regmap_type;
      DMA3CNT_H_Dest_Addr_Control  : regmap_type;
      DMA3CNT_H_Source_Adr_Control : regmap_type;
      DMA3CNT_H_DMA_Repeat         : regmap_type;
      DMA3CNT_H_DMA_Transfer_Type  : regmap_type;
      DMA3CNT_H_DMA_Start_Timing   : regmap_type;
      DMA3CNT_H_IRQ_on             : regmap_type;
      DMA3CNT_H_DMA_Enable         : regmap_type              
   );
   port 
   (
      clk100              : in     std_logic;  
      reset               : in     std_logic;
                                   
      savestate_bus       : in     proc_bus_ds_type;
      loading_savestate   : in     std_logic;
                                   
      ds_bus              : in     proc_bus_ds_type;
      ds_bus_data         : out    std_logic_vector(31 downto 0); 
      
      new_cycles          : in     unsigned(7 downto 0);
      new_cycles_valid    : in     std_logic;
                                   
      IRP_DMA0            : out    std_logic;
      IRP_DMA1            : out    std_logic;
      IRP_DMA2            : out    std_logic;
      IRP_DMA3            : out    std_logic;
      lastread_dma        : out    std_logic_vector(31 downto 0);
                                   
      dma_on              : out    std_logic;
      CPU_bus_idle        : in     std_logic;
      do_step             : in     std_logic;
      dma_soon            : out    std_logic;
                                   
      hblank_trigger      : in     std_logic;
      vblank_trigger      : in     std_logic;
      MemDisplay_trigger  : in     std_logic;
      cardtrans_trigger   : in     std_logic;
      cardtrans_size      : in     integer range 0 to 128;
      
      sounddata_req_ena   : in     std_logic;
      sounddata_req_addr  : in     std_logic_vector(31 downto 0);
      sounddata_req_done  : out    std_logic := '0';
      sounddata_req_data  : out    std_logic_vector(31 downto 0);
                            
      dma_cycles_out      : out    unsigned(7 downto 0) := (others => '0');
      dma_cycles_valid    : out    std_logic := '0';
      
      dma_bus_Adr         : out    std_logic_vector(31 downto 0);
      dma_bus_rnw         : buffer std_logic;
      dma_bus_ena         : out    std_logic;
      dma_bus_acc         : out    std_logic_vector(1 downto 0);
      dma_bus_dout        : out    std_logic_vector(31 downto 0);
      dma_bus_din         : in     std_logic_vector(31 downto 0);
      dma_bus_done        : in     std_logic;
      dma_bus_unread      : in     std_logic;
      
      debug_dma           : out    std_logic_vector(31 downto 0);
      debug_dma_count     : buffer std_logic_vector(31 downto 0) := (others => '0')
   );
end entity;

architecture arch of ds_dma is

   type tArray_Dout is array(0 to 3) of std_logic_vector(31 downto 0);
   type tArray_Adr  is array(0 to 3) of std_logic_vector(31 downto 0);
   type tArray_acc  is array(0 to 3) of std_logic_vector(1 downto 0);
   type tArray_rnw  is array(0 to 3) of std_logic;
   type tArray_ena  is array(0 to 3) of std_logic;
   type tArray_done is array(0 to 3) of std_logic;
   
   signal Array_Dout : tArray_Dout;
   signal Array_Adr  : tArray_Adr;
   signal Array_acc  : tArray_acc;
   signal Array_rnw  : tArray_rnw;
   signal Array_ena  : tArray_ena;
   signal Array_done : tArray_done;
             
   signal single_dma_on   : std_logic_vector(3 downto 0);
   signal single_allow_on : std_logic_vector(3 downto 0);
   signal single_soon     : std_logic_vector(3 downto 0);
   
   signal dma_switch : integer range 0 to 4 := 0; 
   
   signal dma_idle   : std_logic := '1';
           
   signal last_dma_value   : std_logic_vector(31 downto 0) := (others => '0');
   
   signal last_dma0        : std_logic_vector(31 downto 0);
   signal last_dma1        : std_logic_vector(31 downto 0);
   signal last_dma2        : std_logic_vector(31 downto 0);
   signal last_dma3        : std_logic_vector(31 downto 0);
   signal last_dma_valid0  : std_logic;
   signal last_dma_valid1  : std_logic;
   signal last_dma_valid2  : std_logic;
   signal last_dma_valid3  : std_logic;
   
   signal single_is_idle   : std_logic_vector(3 downto 0);
   
   type t_timingarray is array(0 to 15) of integer range 0 to 32;
   signal memoryWait16    : t_timingarray;
   signal memoryWait32    : t_timingarray;
           
   type t_reg_wired_or is array(0 to 3) of std_logic_vector(31 downto 0);
   signal reg_wired_or : t_reg_wired_or;
   
   -- sound dma
   type tsoundstate is
   (
      IDLE,
      WAITSOON,
      WAITREQUEST,
      WAITDONE
   );
   signal soundstate : tsoundstate := IDLE;
   signal sounddata_req_soon : std_logic := '0';
   signal sounddata_req_on   : std_logic := '0';
   signal sounddata_req_dma  : std_logic := '0';
 
begin 

   process (reg_wired_or)
      variable wired_or : std_logic_vector(31 downto 0);
   begin
      wired_or := reg_wired_or(0);
      for i in 1 to (reg_wired_or'length - 1) loop
         wired_or := wired_or or reg_wired_or(i);
      end loop;
      ds_bus_data <= wired_or;
   end process;
   
   ids_dma_module0 : entity work.ds_dma_module
   generic map
   (
      isArm9                       => isArm9,
      index                        => 0,
      Reg_SAD                      => DMA0SAD                     ,
      Reg_DAD                      => DMA0DAD                     ,
      Reg_CNT_L                    => DMA0CNT_L                   ,
      Reg_CNT_H_Dest_Addr_Control  => DMA0CNT_H_Dest_Addr_Control ,
      Reg_CNT_H_Source_Adr_Control => DMA0CNT_H_Source_Adr_Control,
      Reg_CNT_H_DMA_Repeat         => DMA0CNT_H_DMA_Repeat        ,
      Reg_CNT_H_DMA_Transfer_Type  => DMA0CNT_H_DMA_Transfer_Type ,
      Reg_CNT_H_DMA_Start_Timing   => DMA0CNT_H_DMA_Start_Timing  ,
      Reg_CNT_H_IRQ_on             => DMA0CNT_H_IRQ_on            ,
      Reg_CNT_H_DMA_Enable         => DMA0CNT_H_DMA_Enable       
   )                                  
   port map
   (
      clk100             => clk100,     
      reset              => reset,
                         
      savestate_bus      => savestate_bus,
      loading_savestate  => loading_savestate,
                         
      ds_bus             => ds_bus,
      ds_bus_data        => reg_wired_or(0),
                         
      new_cycles         => new_cycles,      
      new_cycles_valid   => new_cycles_valid,
      do_step            => do_step,
                         
      IRP_DMA            => IRP_DMA0,
                         
      dma_on             => single_dma_on(0),
      allow_on           => single_allow_on(0),
      dma_soon           => single_soon(0),
                         
      hblank_trigger     => hblank_trigger,
      vblank_trigger     => vblank_trigger,
      MemDisplay_trigger => MemDisplay_trigger,
      cardtrans_trigger  => cardtrans_trigger,
      cardtrans_size     => cardtrans_size,
                        
      last_dma_out       => last_dma0,
      last_dma_valid     => last_dma_valid0,
      last_dma_in        => last_dma_value,
                         
      dma_bus_Adr        => Array_Adr(0),
      dma_bus_rnw        => Array_rnw(0), 
      dma_bus_ena        => Array_ena(0), 
      dma_bus_acc        => Array_acc(0), 
      dma_bus_dout       => Array_Dout(0), 
      dma_bus_din        => dma_bus_din,
      dma_bus_done       => Array_done(0),
      dma_bus_unread     => dma_bus_unread,
                         
      is_idle            => single_is_idle(0)
   );
   
   ids_dma_module1 : entity work.ds_dma_module
   generic map
   (
      isArm9                       => isArm9,
      index                        => 1,
      Reg_SAD                      => DMA1SAD                     ,
      Reg_DAD                      => DMA1DAD                     ,
      Reg_CNT_L                    => DMA1CNT_L                   ,
      Reg_CNT_H_Dest_Addr_Control  => DMA1CNT_H_Dest_Addr_Control ,
      Reg_CNT_H_Source_Adr_Control => DMA1CNT_H_Source_Adr_Control,
      Reg_CNT_H_DMA_Repeat         => DMA1CNT_H_DMA_Repeat        ,
      Reg_CNT_H_DMA_Transfer_Type  => DMA1CNT_H_DMA_Transfer_Type ,
      Reg_CNT_H_DMA_Start_Timing   => DMA1CNT_H_DMA_Start_Timing  ,
      Reg_CNT_H_IRQ_on             => DMA1CNT_H_IRQ_on            ,
      Reg_CNT_H_DMA_Enable         => DMA1CNT_H_DMA_Enable        
   )                                 
   port map
   (
      clk100             => clk100,
      reset              => reset,
                          
      savestate_bus      => savestate_bus,
      loading_savestate  => loading_savestate,
                         
      ds_bus             => ds_bus,
      ds_bus_data        => reg_wired_or(1),
                         
      new_cycles         => new_cycles,      
      new_cycles_valid   => new_cycles_valid,
      do_step            => do_step,
                         
      IRP_DMA            => IRP_DMA1,
                         
      dma_on             => single_dma_on(1),
      allow_on           => single_allow_on(1),
      dma_soon           => single_soon(1),
                         
      hblank_trigger     => hblank_trigger,
      vblank_trigger     => vblank_trigger,
      MemDisplay_trigger => MemDisplay_trigger,
      cardtrans_trigger  => cardtrans_trigger,
      cardtrans_size     => cardtrans_size,
                          
      last_dma_out       => last_dma1,
      last_dma_valid     => last_dma_valid1,
      last_dma_in        => last_dma_value,
                         
      dma_bus_Adr        => Array_Adr(1),
      dma_bus_rnw        => Array_rnw(1), 
      dma_bus_ena        => Array_ena(1), 
      dma_bus_acc        => Array_acc(1), 
      dma_bus_dout       => Array_Dout(1), 
      dma_bus_din        => dma_bus_din,
      dma_bus_done       => Array_done(1),
      dma_bus_unread     => dma_bus_unread,
                         
      is_idle            => single_is_idle(1)
   );
   
   ids_dma_module2 : entity work.ds_dma_module
   generic map
   (
      isArm9                       => isArm9,
      index                        => 2,
      Reg_SAD                      => DMA2SAD                     ,
      Reg_DAD                      => DMA2DAD                     ,
      Reg_CNT_L                    => DMA2CNT_L                   ,
      Reg_CNT_H_Dest_Addr_Control  => DMA2CNT_H_Dest_Addr_Control ,
      Reg_CNT_H_Source_Adr_Control => DMA2CNT_H_Source_Adr_Control,
      Reg_CNT_H_DMA_Repeat         => DMA2CNT_H_DMA_Repeat        ,
      Reg_CNT_H_DMA_Transfer_Type  => DMA2CNT_H_DMA_Transfer_Type ,
      Reg_CNT_H_DMA_Start_Timing   => DMA2CNT_H_DMA_Start_Timing  ,
      Reg_CNT_H_IRQ_on             => DMA2CNT_H_IRQ_on            ,
      Reg_CNT_H_DMA_Enable         => DMA2CNT_H_DMA_Enable        
   )                                  
   port map
   (
      clk100             => clk100, 
      reset              => reset,
                         
      savestate_bus      => savestate_bus,
      loading_savestate  => loading_savestate,
                         
      ds_bus             => ds_bus,
      ds_bus_data        => reg_wired_or(2),
                         
      new_cycles         => new_cycles,      
      new_cycles_valid   => new_cycles_valid,
      do_step            => do_step,
                         
      IRP_DMA            => IRP_DMA2,
                         
      dma_on             => single_dma_on(2),
      allow_on           => single_allow_on(2),
      dma_soon           => single_soon(2),
                         
      hblank_trigger     => hblank_trigger,
      vblank_trigger     => vblank_trigger,
      MemDisplay_trigger => MemDisplay_trigger,
      cardtrans_trigger  => cardtrans_trigger,
      cardtrans_size     => cardtrans_size,
         
      last_dma_out       => last_dma2,
      last_dma_valid     => last_dma_valid2,
      last_dma_in        => last_dma_value,
                         
      dma_bus_Adr        => Array_Adr(2),
      dma_bus_rnw        => Array_rnw(2), 
      dma_bus_ena        => Array_ena(2), 
      dma_bus_acc        => Array_acc(2), 
      dma_bus_dout       => Array_Dout(2), 
      dma_bus_din        => dma_bus_din,
      dma_bus_done       => Array_done(2),
      dma_bus_unread     => dma_bus_unread,
                         
      is_idle            => single_is_idle(2)
   );
   
   ids_dma_module3 : entity work.ds_dma_module
   generic map
   (
      isArm9                       => isArm9,
      index                        => 3,
      Reg_SAD                      => DMA3SAD                     ,
      Reg_DAD                      => DMA3DAD                     ,
      Reg_CNT_L                    => DMA3CNT_L                   ,
      Reg_CNT_H_Dest_Addr_Control  => DMA3CNT_H_Dest_Addr_Control ,
      Reg_CNT_H_Source_Adr_Control => DMA3CNT_H_Source_Adr_Control,
      Reg_CNT_H_DMA_Repeat         => DMA3CNT_H_DMA_Repeat        ,
      Reg_CNT_H_DMA_Transfer_Type  => DMA3CNT_H_DMA_Transfer_Type ,
      Reg_CNT_H_DMA_Start_Timing   => DMA3CNT_H_DMA_Start_Timing  ,
      Reg_CNT_H_IRQ_on             => DMA3CNT_H_IRQ_on            ,
      Reg_CNT_H_DMA_Enable         => DMA3CNT_H_DMA_Enable        
   )                                  
   port map
   (
      clk100             => clk100,   
      reset              => reset,
                         
      savestate_bus      => savestate_bus, 
      loading_savestate  => loading_savestate,      
                         
      ds_bus             => ds_bus,
      ds_bus_data        => reg_wired_or(3),
                         
      new_cycles         => new_cycles,      
      new_cycles_valid   => new_cycles_valid,
      do_step            => do_step,
                         
      IRP_DMA            => IRP_DMA3,
                         
      dma_on             => single_dma_on(3),
      allow_on           => single_allow_on(3),
      dma_soon           => single_soon(3),
                         
      hblank_trigger     => hblank_trigger,
      vblank_trigger     => vblank_trigger,
      MemDisplay_trigger => MemDisplay_trigger,
      cardtrans_trigger  => cardtrans_trigger,
      cardtrans_size     => cardtrans_size,
         
      last_dma_out       => last_dma3,
      last_dma_valid     => last_dma_valid3,
      last_dma_in        => last_dma_value,
                         
      dma_bus_Adr        => Array_Adr(3),
      dma_bus_rnw        => Array_rnw(3), 
      dma_bus_ena        => Array_ena(3), 
      dma_bus_acc        => Array_acc(3), 
      dma_bus_dout       => Array_Dout(3), 
      dma_bus_din        => dma_bus_din,
      dma_bus_done       => Array_done(3),
      dma_bus_unread     => dma_bus_unread,
                         
      is_idle            => single_is_idle(3)
   );
   
   lastread_dma <= last_dma_value;
   
   dma_bus_dout <= Array_Dout(0) when dma_switch = 0 else Array_Dout(1) when dma_switch = 1 else Array_Dout(2) when dma_switch = 2 else Array_Dout(3);
   dma_bus_Adr  <= Array_Adr(0)  when dma_switch = 0 else Array_Adr(1)  when dma_switch = 1 else Array_Adr(2)  when dma_switch = 2 else Array_Adr(3)  when (dma_switch = 3 or isArm9 = '1') else sounddata_req_addr;
   dma_bus_acc  <= Array_acc(0)  when dma_switch = 0 else Array_acc(1)  when dma_switch = 1 else Array_acc(2)  when dma_switch = 2 else Array_acc(3)  when (dma_switch = 3 or isArm9 = '1') else ACCESS_32BIT;
   dma_bus_rnw  <= Array_rnw(0)  when dma_switch = 0 else Array_rnw(1)  when dma_switch = 1 else Array_rnw(2)  when dma_switch = 2 else Array_rnw(3)  when (dma_switch = 3 or isArm9 = '1') else '1';
   dma_bus_ena  <= Array_ena(0)  when dma_switch = 0 else Array_ena(1)  when dma_switch = 1 else Array_ena(2)  when dma_switch = 2 else Array_ena(3)  when (dma_switch = 3 or isArm9 = '1') else sounddata_req_dma;
   
   Array_done(0) <= dma_bus_done when dma_switch = 0 else '0';
   Array_done(1) <= dma_bus_done when dma_switch = 1 else '0';
   Array_done(2) <= dma_bus_done when dma_switch = 2 else '0';
   Array_done(3) <= dma_bus_done when dma_switch = 3 else '0';
   
   single_allow_on(0) <= '1' when (do_step = '1' and dma_idle = '0' and CPU_bus_idle = '1' and dma_switch = 0) else '0';
   single_allow_on(1) <= '1' when (do_step = '1' and dma_idle = '0' and CPU_bus_idle = '1' and dma_switch = 1) else '0';
   single_allow_on(2) <= '1' when (do_step = '1' and dma_idle = '0' and CPU_bus_idle = '1' and dma_switch = 2) else '0';
   single_allow_on(3) <= '1' when (do_step = '1' and dma_idle = '0' and CPU_bus_idle = '1' and dma_switch = 3) else '0';
   
   dma_on   <= single_dma_on(0) or single_dma_on(1) or  single_dma_on(2) or single_dma_on(3) or sounddata_req_on;
   dma_soon <= single_soon(0)   or single_soon(1)   or  single_soon(2)   or single_soon(3) or sounddata_req_soon;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         if (last_dma_valid0 = '1') then
            last_dma_value <= last_dma0;
         elsif (last_dma_valid1 = '1') then
            last_dma_value <= last_dma1;
         elsif (last_dma_valid2 = '1') then
            last_dma_value <= last_dma2;
         elsif (last_dma_valid3 = '1') then
            last_dma_value <= last_dma3;
         end if;
         
         -- possible speedup here, as if only 1 dma is requesting, it must wait 1 cycle after each r+w transfer
         -- currently implementing this speedup cannot work, as the dma module is turned off the cycle after dma_bus_done
         -- so we don't know here if it will require more
         
         if (reset = '1') then
         
            dma_idle           <= '1';
            dma_switch         <= 0;
            soundstate         <= IDLE;
            sounddata_req_soon <= '0';
            sounddata_req_on   <= '0';
            sounddata_req_dma  <= '0';
            
         else
         
            if (dma_idle = '1') then
                  if (sounddata_req_on   = '1') then dma_switch <= 4; dma_idle <= '0';
               elsif (single_dma_on(0)   = '1') then dma_switch <= 0; dma_idle <= '0';
               elsif (single_dma_on(1)   = '1') then dma_switch <= 1; dma_idle <= '0';
               elsif (single_dma_on(2)   = '1') then dma_switch <= 2; dma_idle <= '0';
               elsif (single_dma_on(3)   = '1') then dma_switch <= 3; dma_idle <= '0'; end if;
            elsif (dma_bus_done = '1' and (dma_bus_rnw = '0' or dma_switch = 4)) then 
               dma_idle <= '1';
               debug_dma_count <= std_logic_vector(unsigned(debug_dma_count) + 1);
            end if;
            
            -- sound dma
            sounddata_req_done <= '0';
            sounddata_req_dma  <= '0';
            if (isArm9 = '0') then
               case (soundstate) is
                  when IDLE =>
                     if (sounddata_req_ena = '1') then
                        soundstate         <= WAITSOON;
                        sounddata_req_soon <= '1';
                     end if;
                     
                  when WAITSOON =>
                     if (do_step = '1') then
                        sounddata_req_on   <= '1';
                        sounddata_req_soon <= '0';
                        soundstate         <= WAITREQUEST;
                     end if;
                     
                  when WAITREQUEST =>
                     if (do_step = '1' and dma_idle = '0' and CPU_bus_idle = '1' and dma_switch = 4) then
                        soundstate        <=  WAITDONE;
                        sounddata_req_dma <= '1';
                     end if;
                     
                  when WAITDONE =>
                     if (dma_bus_done = '1' and dma_switch = 4) then
                        soundstate         <=  IDLE;
                        sounddata_req_on   <= '0';
                        sounddata_req_done <= '1';
                        sounddata_req_data <= dma_bus_din;
                     end if;
               end case;
            end if;
            
         end if;
         
         -- timing  
         dma_cycles_valid <= '0';
         for i in 0 to 3 loop
            if (Array_ena(i) = '1') then
               dma_cycles_valid <= '1';
               if (Array_acc(i) = ACCESS_16BIT) then
                  dma_cycles_out <= to_unsigned(memoryWait16(to_integer(unsigned(Array_Adr(i)(27 downto 24)))), 8); -- todo: timing is completly wrong this way...
               else
                  dma_cycles_out <= to_unsigned(memoryWait32(to_integer(unsigned(Array_Adr(i)(27 downto 24)))), 8);
               end if;
               if (dma_switch = 4) then -- todo: sound dma currently free of charge...
                  dma_cycles_valid <= '0';
               end if;
            end if;
         end loop;
         
         debug_dma(0) <= dma_idle;
         debug_dma(1) <= '0';
         debug_dma(2) <= '0';
         debug_dma(3) <= single_dma_on(0);
         debug_dma(4) <= single_dma_on(1);
         debug_dma(5) <= single_dma_on(2);
         debug_dma(6) <= single_dma_on(3);
         debug_dma(7) <= '0';
         debug_dma(8) <= single_allow_on(0);
         debug_dma(9) <= single_allow_on(1);
         debug_dma(10) <= single_allow_on(2);
         debug_dma(11) <= single_allow_on(3);
         debug_dma(12) <= single_is_idle(0);
         debug_dma(13) <= single_is_idle(1);
         debug_dma(14) <= single_is_idle(2);
         debug_dma(15) <= single_is_idle(3);
      
         if (soundstate = IDLE       ) then debug_dma(16) <= '1'; else debug_dma(16) <= '0'; end if;
         if (soundstate = WAITSOON   ) then debug_dma(17) <= '1'; else debug_dma(17) <= '0'; end if;
         if (soundstate = WAITREQUEST) then debug_dma(18) <= '1'; else debug_dma(18) <= '0'; end if;
         if (soundstate = WAITDONE   ) then debug_dma(19) <= '1'; else debug_dma(19) <= '0'; end if;
         debug_dma(22 downto 20) <= std_logic_vector(to_unsigned(dma_switch, 3));
         debug_dma(23) <= '0';
         debug_dma(24) <= sounddata_req_on;
         debug_dma(25) <= sounddata_req_soon;
         debug_dma(26) <= sounddata_req_dma;
         debug_dma(31 downto 27) <= (others => '0');

      end if;
   end process;
   
   memoryWait16    <= (1, 1, 2, 2, 2, 2, 2, 2, 16, 16, 16, 2, 2, 2, 2, 2) when isArm9 = '1' else (1, 1, 1, 1, 1, 1, 1, 1,  8,  8,  8, 1, 1, 1, 1, 1);
   memoryWait32    <= (1, 1, 4, 2, 2, 4, 4, 2, 32, 32, 32, 2, 2, 2, 2, 2) when isArm9 = '1' else (1, 1, 2, 1, 1, 2, 2, 1, 16, 16, 16, 1, 1, 1, 1, 1);
   

    
end architecture;


 
 