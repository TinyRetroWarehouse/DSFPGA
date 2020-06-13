library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library tb;
use tb.globals.all;

entity mig_7series_0 is
   port 
   (
      sys_clk_i            : in    std_logic;
      clk_ref_i            : in    std_logic; 
      sys_rst              : in    std_logic;
      ui_clk               : out   std_logic;
      ui_clk_sync_rst      : out   std_logic;
      init_calib_complete  : out   std_logic;
                           
      ddr3_dq              : inout std_logic_vector(15 downto 0);
      ddr3_dqs_p           : inout std_logic_vector(1 downto 0);
      ddr3_dqs_n           : inout std_logic_vector(1 downto 0);
      ddr3_addr            : out   std_logic_vector(14 downto 0);
      ddr3_ba              : out   std_logic_vector(2 downto 0);
      ddr3_ras_n           : out   std_logic;
      ddr3_cas_n           : out   std_logic;
      ddr3_we_n            : out   std_logic;
      ddr3_reset_n         : out   std_logic;
      ddr3_ck_p            : out   std_logic_vector(0 downto 0);
      ddr3_ck_n            : out   std_logic_vector(0 downto 0);
      ddr3_cke             : out   std_logic_vector(0 downto 0);
      ddr3_dm              : out   std_logic_vector(1 downto 0);
      ddr3_odt             : out   std_logic_vector(0 downto 0);
                           
      app_addr             : in    std_logic_vector(28 downto 0);
      app_cmd              : in    std_logic_vector(2 downto 0);
      app_en               : in    std_logic;
      app_wdf_data         : in    std_logic_vector(127 downto 0);
      app_wdf_end          : in    std_logic;
      app_wdf_mask         : in    std_logic_vector(15 downto 0);
      app_wdf_wren         : in    std_logic;
      app_rd_data          : out   std_logic_vector(127 downto 0);
      app_rd_data_end      : out   std_logic := '0';
      app_rd_data_valid    : out   std_logic := '0';
      app_rdy              : out   std_logic := '1';
      app_wdf_rdy          : out   std_logic := '1';
      app_sr_req           : in    std_logic;
      app_ref_req          : in    std_logic;
      app_zq_req           : in    std_logic;
      app_sr_active        : out   std_logic;
      app_ref_ack          : out   std_logic;
      app_zq_ack           : out   std_logic
   );
end entity;

architecture arch of mig_7series_0 is

   constant readlatency_on : std_logic := '0';
   constant readlatency    : integer := 22;

   -- not full size, because of memory required
   type t_data is array(0 to (2**27)-1) of integer;
   type bit_vector_file is file of bit_vector;
   
   signal clk_buf      : STD_LOGIC := '1';
   
begin

   clk_buf <= not clk_buf after  5 ns;
   ui_clk <= clk_buf;


   process
   
      variable data : t_data := (others => 0);
      variable cmd_address_save : STD_LOGIC_VECTOR(app_addr'left downto 0);
      variable cmd_din_save     : STD_LOGIC_VECTOR(app_wdf_data'left downto 0);
      variable cmd_be_save      : STD_LOGIC_VECTOR(app_wdf_mask'left downto 0);
      
      variable readmodifywrite : std_logic_vector(31 downto 0);
      
      file infile             : bit_vector_file;
      variable f_status       : FILE_OPEN_STATUS;
      variable read_byte0     : std_logic_vector(7 downto 0);
      variable read_byte1     : std_logic_vector(7 downto 0);
      variable read_byte2     : std_logic_vector(7 downto 0);
      variable read_byte3     : std_logic_vector(7 downto 0);
      variable next_vector    : bit_vector (3 downto 0);
      variable actual_len     : natural;
      variable targetpos      : integer;
      
      -- copy from std_logic_arith, not used here because numeric std is also included
      function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
        variable result: STD_LOGIC_VECTOR (SIZE-1 downto 0);
        variable temp: integer;
      begin
 
         temp := ARG;
         for i in 0 to SIZE-1 loop
 
         if (temp mod 2) = 1 then
            result(i) := '1';
         else 
            result(i) := '0';
         end if;
 
         if temp > 0 then
            temp := temp / 2;
         elsif (temp > integer'low) then
            temp := (temp - 1) / 2; -- simulate ASR
         else
            temp := temp / 2; -- simulate ASR
         end if;
        end loop;
 
        return result;  
      end;
   
   begin
      wait until rising_edge(sys_clk_i);
      
      if (app_en = '1') then
         if (app_cmd = "001") then 
            if (readlatency_on = '1') then
               for i in 1 to readlatency loop
                  wait until rising_edge(sys_clk_i);
               end loop; 
            end if;
            cmd_address_save := app_addr;
            app_rd_data_valid <= '1';
            app_rd_data       <= std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 3), 32)) & 
                                 std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 2), 32)) &
                                 std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 1), 32)) &
                                 std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 0), 32));
            wait until rising_edge(sys_clk_i);
            app_rd_data_valid <= '0';
            app_rd_data       <= (others => 'X');
         end if;  
         
         if (app_cmd = "000" and app_wdf_wren = '1') then 
            cmd_address_save := app_addr;
            cmd_din_save     := app_wdf_data;
            cmd_be_save      := app_wdf_mask;
            wait until rising_edge(sys_clk_i);                                                                                                     
            if (cmd_be_save(15 downto 12) /= x"F") then 
               readmodifywrite := std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 3), 32));
               if (cmd_be_save(15) = '0') then readmodifywrite(31 downto 24) := cmd_din_save(127 downto 120); end if;
               if (cmd_be_save(14) = '0') then readmodifywrite(23 downto 16) := cmd_din_save(119 downto 112); end if;
               if (cmd_be_save(13) = '0') then readmodifywrite(15 downto  8) := cmd_din_save(111 downto 104); end if;
               if (cmd_be_save(12) = '0') then readmodifywrite( 7 downto  0) := cmd_din_save(103 downto  96); end if;
               data(to_integer(unsigned(cmd_address_save)) / 2 + 3) := to_integer(signed(readmodifywrite));
            end if;
            
            if (cmd_be_save(11 downto 8) /= x"F") then 
               readmodifywrite := std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 2), 32));
               if (cmd_be_save(11) = '0') then readmodifywrite(31 downto 24) := cmd_din_save(95 downto 88); end if;
               if (cmd_be_save(10) = '0') then readmodifywrite(23 downto 16) := cmd_din_save(87 downto 80); end if;
               if (cmd_be_save( 9) = '0') then readmodifywrite(15 downto  8) := cmd_din_save(79 downto 72); end if;
               if (cmd_be_save( 8) = '0') then readmodifywrite( 7 downto  0) := cmd_din_save(71 downto 64); end if;
               data(to_integer(unsigned(cmd_address_save)) / 2 + 2) := to_integer(signed(readmodifywrite)); 
            end if;
            
            if (cmd_be_save(7 downto 4) /= x"F") then 
               readmodifywrite := std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 1), 32));
               if (cmd_be_save(7) = '0') then readmodifywrite(31 downto 24) := cmd_din_save(63 downto 56); end if;
               if (cmd_be_save(6) = '0') then readmodifywrite(23 downto 16) := cmd_din_save(55 downto 48); end if;
               if (cmd_be_save(5) = '0') then readmodifywrite(15 downto  8) := cmd_din_save(47 downto 40); end if;
               if (cmd_be_save(4) = '0') then readmodifywrite( 7 downto  0) := cmd_din_save(39 downto 32); end if;
               data(to_integer(unsigned(cmd_address_save)) / 2 + 1) := to_integer(signed(readmodifywrite)); 
            end if;
            
            if (cmd_be_save(3 downto 0) /= x"F") then 
               readmodifywrite := std_logic_vector(to_signed(data(to_integer(unsigned(cmd_address_save)) / 2 + 0), 32));
               if (cmd_be_save(3) = '0') then readmodifywrite(31 downto 24) := cmd_din_save(31 downto 24); end if;
               if (cmd_be_save(2) = '0') then readmodifywrite(23 downto 16) := cmd_din_save(23 downto 16); end if;
               if (cmd_be_save(1) = '0') then readmodifywrite(15 downto  8) := cmd_din_save(15 downto  8); end if;
               if (cmd_be_save(0) = '0') then readmodifywrite( 7 downto  0) := cmd_din_save( 7 downto  0); end if;
               data(to_integer(unsigned(cmd_address_save)) / 2 + 0) := to_integer(signed(readmodifywrite)); 
            end if;

         end if;  
      end if;  
       
       
      -- data from file
      COMMAND_FILE_ACK <= '0';
      if COMMAND_FILE_START = '1' then
         
         assert false report "received" severity note;
         assert false report COMMAND_FILE_NAME(1 to COMMAND_FILE_NAMELEN) severity note;
      
         file_open(f_status, infile, COMMAND_FILE_NAME(1 to COMMAND_FILE_NAMELEN), read_mode);
      
         targetpos := COMMAND_FILE_TARGET - 134217728;
      
         while (not endfile(infile)) loop
            
            read(infile, next_vector, actual_len);  
             
            read_byte0 := CONV_STD_LOGIC_VECTOR(bit'pos(next_vector(0)), 8);
            read_byte1 := CONV_STD_LOGIC_VECTOR(bit'pos(next_vector(1)), 8);
            read_byte2 := CONV_STD_LOGIC_VECTOR(bit'pos(next_vector(2)), 8);
            read_byte3 := CONV_STD_LOGIC_VECTOR(bit'pos(next_vector(3)), 8);
         
            if (COMMAND_FILE_ENDIAN = '1') then
               data(targetpos) := to_integer(signed(read_byte3 & read_byte2 & read_byte1 & read_byte0));
            else
               data(targetpos) := to_integer(signed(read_byte0 & read_byte1 & read_byte2 & read_byte3));
            end if;
            targetpos       := targetpos + 1;
            
         end loop;
      
         file_close(infile);
      
         COMMAND_FILE_ACK <= '1';
      
      end if;
      
   
   
   end process;
   
end architecture;


