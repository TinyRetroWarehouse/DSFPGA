library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

use work.pProc_bus_ds.all;

entity ds_gpu_timing is
   generic
   (
      is_simu : std_logic
   );
   port 
   (
      clk100               : in  std_logic;  
      ds_on                : in  std_logic;
      reset                : in  std_logic;
      lockspeed            : in  std_logic;
      
      ds_bus9              : in  proc_bus_ds_type;
      ds_bus9_data         : out std_logic_vector(31 downto 0); 
      ds_bus7              : in  proc_bus_ds_type;
      ds_bus7_data         : out std_logic_vector(31 downto 0); 
                           
      new_cycles           : in  unsigned(7 downto 0);
      new_cycles_valid     : in  std_logic;
                           
      IRP_HBlank9          : out std_logic := '0';
      IRP_HBlank7          : out std_logic := '0';
      IRP_VBlank9          : out std_logic := '0';
      IRP_VBlank7          : out std_logic := '0';
      IRP_LCDStat9         : out std_logic := '0';
      IRP_LCDStat7         : out std_logic := '0';
      
      line_trigger         : out std_logic := '0';                              
      hblank_trigger       : out std_logic := '0';                              
      vblank_trigger       : out std_logic := '0';                              
      MemDisplay_trigger   : out std_logic := '0';                              
      drawline             : out std_logic := '0';                       
      refpoint_update      : out std_logic := '0';                       
      newline_invsync      : out std_logic := '0';                       
      linecounter_drawer   : out unsigned(8 downto 0);
      pixelpos             : out integer range 0 to 511; 
      vsync_end            : out std_logic := '0'; 
      
      DISPSTAT_debug       : out std_logic_vector(31 downto 0)
   );
end entity;

architecture arch of ds_gpu_timing is
   
   signal REG9_DISPSTAT_V_Blank_flag         : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Blank_flag        .upper downto work.pReg_ds_display_9.DISPSTAT_V_Blank_flag        .lower) := (others => '0');
   signal REG9_DISPSTAT_H_Blank_flag         : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_H_Blank_flag        .upper downto work.pReg_ds_display_9.DISPSTAT_H_Blank_flag        .lower) := (others => '0');
   signal REG9_DISPSTAT_V_Counter_flag       : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Counter_flag      .upper downto work.pReg_ds_display_9.DISPSTAT_V_Counter_flag      .lower) := (others => '0');
   signal REG9_DISPSTAT_V_Blank_IRQ_Enable   : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Blank_IRQ_Enable  .upper downto work.pReg_ds_display_9.DISPSTAT_V_Blank_IRQ_Enable  .lower) := (others => '0');
   signal REG9_DISPSTAT_H_Blank_IRQ_Enable   : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_H_Blank_IRQ_Enable  .upper downto work.pReg_ds_display_9.DISPSTAT_H_Blank_IRQ_Enable  .lower) := (others => '0');
   signal REG9_DISPSTAT_V_Counter_IRQ_Enable : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Counter_IRQ_Enable.upper downto work.pReg_ds_display_9.DISPSTAT_V_Counter_IRQ_Enable.lower) := (others => '0');
   signal REG9_DISPSTAT_V_Count_Setting      : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Count_Setting     .upper downto work.pReg_ds_display_9.DISPSTAT_V_Count_Setting     .lower) := (others => '0');
   signal REG9_DISPSTAT_V_Count_Setting8     : std_logic_vector(work.pReg_ds_display_9.DISPSTAT_V_Count_Setting8    .upper downto work.pReg_ds_display_9.DISPSTAT_V_Count_Setting8    .lower) := (others => '0');
   signal REG9_VCOUNT                        : std_logic_vector(work.pReg_ds_display_9.VCOUNT                       .upper downto work.pReg_ds_display_9.VCOUNT                       .lower) := (others => '0');
   
   signal REG7_DISPSTAT_V_Blank_flag         : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Blank_flag        .upper downto work.pReg_ds_display_7.DISPSTAT_V_Blank_flag        .lower) := (others => '0');
   signal REG7_DISPSTAT_H_Blank_flag         : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_H_Blank_flag        .upper downto work.pReg_ds_display_7.DISPSTAT_H_Blank_flag        .lower) := (others => '0');
   signal REG7_DISPSTAT_V_Counter_flag       : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Counter_flag      .upper downto work.pReg_ds_display_7.DISPSTAT_V_Counter_flag      .lower) := (others => '0');
   signal REG7_DISPSTAT_V_Blank_IRQ_Enable   : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Blank_IRQ_Enable  .upper downto work.pReg_ds_display_7.DISPSTAT_V_Blank_IRQ_Enable  .lower) := (others => '0');
   signal REG7_DISPSTAT_H_Blank_IRQ_Enable   : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_H_Blank_IRQ_Enable  .upper downto work.pReg_ds_display_7.DISPSTAT_H_Blank_IRQ_Enable  .lower) := (others => '0');
   signal REG7_DISPSTAT_V_Counter_IRQ_Enable : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Counter_IRQ_Enable.upper downto work.pReg_ds_display_7.DISPSTAT_V_Counter_IRQ_Enable.lower) := (others => '0');
   signal REG7_DISPSTAT_V_Count_Setting      : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Count_Setting     .upper downto work.pReg_ds_display_7.DISPSTAT_V_Count_Setting     .lower) := (others => '0');
   signal REG7_DISPSTAT_V_Count_Setting8     : std_logic_vector(work.pReg_ds_display_7.DISPSTAT_V_Count_Setting8    .upper downto work.pReg_ds_display_7.DISPSTAT_V_Count_Setting8    .lower) := (others => '0');
   signal REG7_VCOUNT                        : std_logic_vector(work.pReg_ds_display_7.VCOUNT                       .upper downto work.pReg_ds_display_7.VCOUNT                       .lower) := (others => '0');
   
   type t_reg_wired_or is array(0 to 8) of std_logic_vector(31 downto 0);
   signal reg_wired_or9 : t_reg_wired_or;
   signal reg_wired_or7 : t_reg_wired_or;
   
   type tGPUState is
   (
      HSTART,
      HIRQ,
      VISIBLE,
      HBLANK,
      VBLANK_START,
      VBLANK_HIRQ,
      VBLANK_DRAWIDLE,
      VBLANKHBLANK
   );
   signal gpustate : tGPUState;
   
   signal linecounter : unsigned(8 downto 0)  := (others => '0');
   signal cycles      : unsigned(11 downto 0) := (others => '0');
   signal drawsoon    : std_logic := '0';
   
   signal vcount_irp_next9 : std_logic := '0';
   signal vcount_irp_next7 : std_logic := '0';
   
   signal V_Count_Setting9 : unsigned(8 downto 0);
   signal V_Count_Setting7 : unsigned(8 downto 0);
   
begin 
   
   iREG9_DISPSTAT_V_Blank_flag         : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Blank_flag        ) port map  (clk100, ds_bus9, reg_wired_or9(0), REG9_DISPSTAT_V_Blank_flag  ); 
   iREG9_DISPSTAT_H_Blank_flag         : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_H_Blank_flag        ) port map  (clk100, ds_bus9, reg_wired_or9(1), REG9_DISPSTAT_H_Blank_flag  ); 
   iREG9_DISPSTAT_V_Counter_flag       : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Counter_flag      ) port map  (clk100, ds_bus9, reg_wired_or9(2), REG9_DISPSTAT_V_Counter_flag); 
   iREG9_DISPSTAT_V_Blank_IRQ_Enable   : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Blank_IRQ_Enable  ) port map  (clk100, ds_bus9, reg_wired_or9(3), REG9_DISPSTAT_V_Blank_IRQ_Enable   , REG9_DISPSTAT_V_Blank_IRQ_Enable   ); 
   iREG9_DISPSTAT_H_Blank_IRQ_Enable   : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_H_Blank_IRQ_Enable  ) port map  (clk100, ds_bus9, reg_wired_or9(4), REG9_DISPSTAT_H_Blank_IRQ_Enable   , REG9_DISPSTAT_H_Blank_IRQ_Enable   ); 
   iREG9_DISPSTAT_V_Counter_IRQ_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Counter_IRQ_Enable) port map  (clk100, ds_bus9, reg_wired_or9(5), REG9_DISPSTAT_V_Counter_IRQ_Enable , REG9_DISPSTAT_V_Counter_IRQ_Enable ); 
   iREG9_DISPSTAT_V_Count_Setting      : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Count_Setting     ) port map  (clk100, ds_bus9, reg_wired_or9(6), REG9_DISPSTAT_V_Count_Setting      , REG9_DISPSTAT_V_Count_Setting      ); 
   iREG9_DISPSTAT_V_Count_Setting8     : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.DISPSTAT_V_Count_Setting8    ) port map  (clk100, ds_bus9, reg_wired_or9(7), REG9_DISPSTAT_V_Count_Setting8     , REG9_DISPSTAT_V_Count_Setting8     ); 
   iREG9_VCOUNT                        : entity work.eProcReg_ds generic map (work.pReg_ds_display_9.VCOUNT                       ) port map  (clk100, ds_bus9, reg_wired_or9(8), REG9_VCOUNT); 
                                                                                                                                                                              
   iREG7_DISPSTAT_V_Blank_flag         : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Blank_flag        ) port map  (clk100, ds_bus7, reg_wired_or7(0), REG7_DISPSTAT_V_Blank_flag  ); 
   iREG7_DISPSTAT_H_Blank_flag         : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_H_Blank_flag        ) port map  (clk100, ds_bus7, reg_wired_or7(1), REG7_DISPSTAT_H_Blank_flag  ); 
   iREG7_DISPSTAT_V_Counter_flag       : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Counter_flag      ) port map  (clk100, ds_bus7, reg_wired_or7(2), REG7_DISPSTAT_V_Counter_flag); 
   iREG7_DISPSTAT_V_Blank_IRQ_Enable   : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Blank_IRQ_Enable  ) port map  (clk100, ds_bus7, reg_wired_or7(3), REG7_DISPSTAT_V_Blank_IRQ_Enable   , REG7_DISPSTAT_V_Blank_IRQ_Enable   ); 
   iREG7_DISPSTAT_H_Blank_IRQ_Enable   : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_H_Blank_IRQ_Enable  ) port map  (clk100, ds_bus7, reg_wired_or7(4), REG7_DISPSTAT_H_Blank_IRQ_Enable   , REG7_DISPSTAT_H_Blank_IRQ_Enable   ); 
   iREG7_DISPSTAT_V_Counter_IRQ_Enable : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Counter_IRQ_Enable) port map  (clk100, ds_bus7, reg_wired_or7(5), REG7_DISPSTAT_V_Counter_IRQ_Enable , REG7_DISPSTAT_V_Counter_IRQ_Enable ); 
   iREG7_DISPSTAT_V_Count_Setting      : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Count_Setting     ) port map  (clk100, ds_bus7, reg_wired_or7(6), REG7_DISPSTAT_V_Count_Setting      , REG7_DISPSTAT_V_Count_Setting      ); 
   iREG7_DISPSTAT_V_Count_Setting8     : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.DISPSTAT_V_Count_Setting8    ) port map  (clk100, ds_bus7, reg_wired_or7(7), REG7_DISPSTAT_V_Count_Setting8     , REG7_DISPSTAT_V_Count_Setting8     ); 
   iREG7_VCOUNT                        : entity work.eProcReg_ds generic map (work.pReg_ds_display_7.VCOUNT                       ) port map  (clk100, ds_bus7, reg_wired_or7(8), REG7_VCOUNT); 
   
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
   
   V_Count_Setting9(8)          <= REG9_DISPSTAT_V_Count_Setting8(REG9_DISPSTAT_V_Count_Setting8'left);
   V_Count_Setting9(7 downto 0) <= unsigned(REG9_DISPSTAT_V_Count_Setting);
   V_Count_Setting7(8)          <= REG9_DISPSTAT_V_Count_Setting8(REG7_DISPSTAT_V_Count_Setting8'left);
   V_Count_Setting7(7 downto 0) <= unsigned(REG7_DISPSTAT_V_Count_Setting);
   
   linecounter_drawer <= linecounter;
   
   REG9_VCOUNT(24 downto 16) <= std_logic_vector(linecounter);
   REG7_VCOUNT(24 downto 16) <= std_logic_vector(linecounter);

   DISPSTAT_debug <= REG9_VCOUNT &
                     REG9_DISPSTAT_V_Count_Setting &
                     REG9_DISPSTAT_V_Count_Setting8 &
                     '0' &
                     REG9_DISPSTAT_V_Counter_IRQ_Enable &
                     REG9_DISPSTAT_H_Blank_IRQ_Enable &
                     REG9_DISPSTAT_V_Blank_IRQ_Enable &
                     REG9_DISPSTAT_V_Counter_flag &
                     REG9_DISPSTAT_H_Blank_flag &
                     REG9_DISPSTAT_V_Blank_flag;
   
   process (clk100)
   begin
      if rising_edge(clk100) then
      
         IRP_HBlank9        <= '0';
         IRP_HBlank7        <= '0';
         IRP_VBlank9        <= '0';
         IRP_VBlank7        <= '0';
         IRP_LCDStat9       <= '0';
         IRP_LCDStat7       <= '0';
                            
         drawline           <= '0';
         refpoint_update    <= '0';
         line_trigger       <= '0';
         hblank_trigger     <= '0';
         vblank_trigger     <= '0';
         MemDisplay_trigger <= '0';
         newline_invsync    <= '0';
         vsync_end          <= '0';
         
         if (reset = '1') then
         
            gpustate    <= HSTART;
            cycles      <= (others => '0');
            linecounter <= (others => '0');
            
            REG9_DISPSTAT_V_Counter_flag <= "1";
            REG9_DISPSTAT_H_Blank_flag   <= "0";
            REG9_DISPSTAT_V_Blank_flag   <= "0";
            
            REG7_DISPSTAT_V_Counter_flag <= "0";
            REG7_DISPSTAT_H_Blank_flag   <= "0";
            REG7_DISPSTAT_V_Blank_flag   <= "0";
            
            if (is_simu = '1') then
               drawsoon <= '1';
            end if;
            
         elsif (ds_on = '1') then
         
            if (new_cycles_valid = '1') then
               cycles <= cycles + new_cycles;
            else
            
               case (gpustate) is
                  when HSTART =>
                     if (cycles >= 12) then
                        gpustate <= HIRQ;
                        cycles   <= cycles - 12;
                        if (vcount_irp_next9 = '1') then IRP_LCDStat9 <= '1'; vcount_irp_next9 <= '0'; end if;
                        if (vcount_irp_next7 = '1') then IRP_LCDStat7 <= '1'; vcount_irp_next7 <= '0'; end if;
                     end if;
                  
                  when HIRQ =>
                     if (cycles >= 84) then
                        gpustate           <= VISIBLE;
                        cycles             <= cycles - 84;
                        MemDisplay_trigger <= '1';
                     end if;
               
                  when VISIBLE =>
                     --if ((lockspeed = '0' or cycles >= 160)) then
                        --if (lockspeed = '1') then
                        --   pixelpos  <= (to_integer(cycles) / 2) - 80;
                        --end if;
                        if (drawsoon = '1') then
                           drawline  <= '1';
                           drawsoon  <= '0';
                        end if;
                     --end if;
                     if (cycles >= 3108) then
                        pixelpos                   <= 256;
                        cycles                     <= cycles - 3108;
                        gpustate                   <= HBLANK;
                        REG9_DISPSTAT_H_Blank_flag <= "1";
                        REG7_DISPSTAT_H_Blank_flag <= "1";
                        hblank_trigger             <= '1';
                        if (REG9_DISPSTAT_H_Blank_IRQ_Enable = "1") then IRP_HBlank9 <= '1'; end if;
                        if (REG7_DISPSTAT_H_Blank_IRQ_Enable = "1") then IRP_HBlank7 <= '1'; end if;
                     end if;
                  
                  when HBLANK =>
                     if (cycles >= 1056) then -- 272
                        cycles      <= cycles - 1056;
                        linecounter <= linecounter + 1;
                        
                        if ((linecounter + 1) = unsigned(V_Count_Setting9)) then
                           if (REG9_DISPSTAT_V_Counter_IRQ_Enable = "1") then
                              vcount_irp_next9 <= '1';
                           end if;
                           REG9_DISPSTAT_V_Counter_flag <= "1";
                        else
                           REG9_DISPSTAT_V_Counter_flag <= "0";
                        end if;
                                             
                        if ((linecounter + 1) = unsigned(V_Count_Setting7)) then
                           if (REG7_DISPSTAT_V_Counter_IRQ_Enable = "1") then
                              vcount_irp_next7 <= '1';
                           end if;
                           REG7_DISPSTAT_V_Counter_flag <= "1";
                        else
                           REG7_DISPSTAT_V_Counter_flag <= "0";
                        end if;
   
                        REG9_DISPSTAT_H_Blank_flag <= "0";
                        REG7_DISPSTAT_H_Blank_flag <= "0";
                        
                        if ((linecounter + 1) < 192) then
                           gpustate           <= HSTART;
                           drawsoon           <= '1';
                           pixelpos           <= 0;
                           line_trigger       <= '1';
                        else
                           gpustate                   <= VBLANK_START;
                           refpoint_update            <= '1';
                           REG9_DISPSTAT_V_Blank_flag <= "1";
                           REG7_DISPSTAT_V_Blank_flag <= "1";
                           vblank_trigger             <= '1';
                        end if;
                     end if;
                  
                  when VBLANK_START =>
                     if (cycles >= 12) then
                        gpustate    <= VBLANK_HIRQ;
                        cycles      <= cycles - 12;
                        
                        if (vcount_irp_next9 = '1') then IRP_LCDStat9 <= '1'; vcount_irp_next9 <= '0'; end if;
                        if (vcount_irp_next7 = '1') then IRP_LCDStat7 <= '1'; vcount_irp_next7 <= '0'; end if;
                        
                        if (linecounter = 192) then
                           if (REG9_DISPSTAT_V_Blank_IRQ_Enable = "1") then IRP_VBlank9 <= '1'; end if;
                           if (REG7_DISPSTAT_V_Blank_IRQ_Enable = "1") then IRP_VBlank7 <= '1'; end if;
                        end if;
                        
                     end if;
                  
                  when VBLANK_HIRQ =>
                     if (cycles >= 84) then
                        gpustate    <= VBLANK_DRAWIDLE;
                        cycles      <= cycles - 84;
                     end if;
                  
                  
                  when VBLANK_DRAWIDLE =>
                     if (cycles >= 3108) then
                        cycles                     <= cycles - 3108;
                        gpustate                   <= VBLANKHBLANK;
                        REG9_DISPSTAT_H_Blank_flag <= "1";
                        REG7_DISPSTAT_H_Blank_flag <= "1";
                        newline_invsync            <= '1';
                        -- don't do hblank for dma here!
                        if (REG9_DISPSTAT_H_Blank_IRQ_Enable = "1") then IRP_HBlank9 <= '1'; end if;
                        if (REG7_DISPSTAT_H_Blank_IRQ_Enable = "1") then IRP_HBlank7 <= '1'; end if;
                     end if;
                  
                  when VBLANKHBLANK =>
                     if (cycles >= 1056) then
                        cycles      <= cycles - 1056;
                        linecounter <= linecounter + 1;
                        
                        if ((linecounter + 1) = unsigned(V_Count_Setting9) or ((linecounter + 1) = 263 and to_integer(unsigned(V_Count_Setting9)) = 0)) then
                           if (REG9_DISPSTAT_V_Counter_IRQ_Enable = "1") then
                              vcount_irp_next9 <= '1';
                           end if;
                           REG9_DISPSTAT_V_Counter_flag <= "1";
                        else
                           REG9_DISPSTAT_V_Counter_flag <= "0";
                        end if;
                                             
                        if ((linecounter + 1) = unsigned(V_Count_Setting7) or ((linecounter + 1) = 263 and to_integer(unsigned(V_Count_Setting7)) = 0)) then
                           if (REG7_DISPSTAT_V_Counter_IRQ_Enable = "1") then
                              vcount_irp_next7 <= '1';
                           end if;
                           REG7_DISPSTAT_V_Counter_flag <= "1";
                        else
                           REG7_DISPSTAT_V_Counter_flag <= "0";
                        end if;
                        
                        REG9_DISPSTAT_H_Blank_flag <= "0";
                        REG7_DISPSTAT_H_Blank_flag <= "0";
                        
                        line_trigger <= '1';
                        if ((linecounter + 1) = 262) then
                           REG9_DISPSTAT_V_Blank_flag <= "0";
                           REG7_DISPSTAT_V_Blank_flag <= "0";
                        end if;
                        
                        if ((linecounter + 1) = 263) then
                           linecounter         <= (others => '0');
                           gpustate            <= HSTART;
                           drawsoon            <= '1';
                           pixelpos            <= 0;
                           vsync_end           <= '1';
                        else
                           gpustate <= VBLANK_START;
                        end if;
                     end if;
               
               end case;
         
            end if;
         
         end if;
      
      end if;
   end process;

end architecture;





