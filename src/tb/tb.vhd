library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.numeric_std.all;     

library tb;
library top;

entity etb  is
end entity;

architecture arch of etb is

   constant vgattxoff : std_logic := '1';
   constant FB1ttxon  : std_logic := '1';
   constant FB2ttxon  : std_logic := '1';
   constant ds_nogpu  : std_logic := '0';
 
   constant clk_speed    : integer := 100000000;
                         
   signal CLOCK_100      : std_logic := '1';
                         
   signal ftdi_d         : std_logic_vector(7 downto 0);
   signal ftdi_rdn       : std_logic;
   signal ftdi_rxen      : std_logic;
   signal ftdi_siwun     : std_logic;
   signal ftdi_txen      : std_logic;
   signal ftdi_wrn       : std_logic;
   
   signal ac_adc_sdata   : std_logic;
   signal ac_bclk        : std_logic;
   signal ac_dac_sdata   : std_logic;
   signal ac_lrclk       : std_logic;
   signal ac_mclk        : std_logic;
                     
   signal I2C_SCLK       : std_logic;
   signal I2C_SDAT       : std_logic;
   
   signal i2c_address    : std_logic_vector(7 downto 0) := (others => '0');
   signal i2c_reg        : std_logic_vector(6 downto 0) := (others => '0');
   signal i2c_data       : std_logic_vector(8 downto 0) := (others => '0');
   
begin

   CLOCK_100 <= not CLOCK_100 after 5 ns;
   
   itop : entity top.eTop
   generic map
   (
      is_simu      => '1',
      vgattxoff    => vgattxoff,
      FB1ttxon     => FB1ttxon,      
      FB2ttxon     => FB2ttxon,
      ds_nogpu     => ds_nogpu      
   )
   port map
   (
      clk          => CLOCK_100,
                   
      sw           => x"00",
                   
      led          => open,
                   
      ftdi_d       => ftdi_d,    
      ftdi_rdn     => ftdi_rdn,  
      ftdi_rxen    => ftdi_rxen, 
      ftdi_siwun   => ftdi_siwun,
      ftdi_txen    => ftdi_txen, 
      ftdi_wrn     => ftdi_wrn,

      ac_adc_sdata => ac_adc_sdata,
      ac_bclk      => ac_bclk,     
      ac_dac_sdata => ac_dac_sdata,
      ac_lrclk     => ac_lrclk,    
      ac_mclk      => ac_mclk,    
          
      scl          => I2C_SCLK,         
      sda          => I2C_SDAT        
      
   );
   
   itb_interpreter : entity tb.etb_interpreter
   port map
   (
      clk        => CLOCK_100,
      ftdi_d     => ftdi_d,    
      ftdi_rdn   => ftdi_rdn,  
      ftdi_rxen  => ftdi_rxen, 
      ftdi_siwun => ftdi_siwun,
      ftdi_txen  => ftdi_txen, 
      ftdi_wrn   => ftdi_wrn  
   );
     
     
   -- audio
   process
   begin
      I2C_SDAT <= 'Z';
      
      -- wait for address
      wait until (falling_edge(I2C_SCLK));
      for i in 7 downto 0 loop
         wait until (rising_edge(I2C_SCLK));
         i2c_address(i) <= I2C_SDAT;
      end loop;
      
      if (i2c_address = x"73") then
         I2C_SDAT <= '0';
      end if;
      wait for 10 us;
      I2C_SDAT <= 'Z';  
      i2c_address <= (others => '0');
      
      -- wait for 2x data
      for word in 1 downto 0 loop
      
         for i in 7 downto 0 loop
            wait until (rising_edge(I2C_SCLK));
            if (i + word * 8 > 8) then
               i2c_reg(i - 1) <= I2C_SDAT;
            else
               i2c_data(i + word * 8) <= I2C_SDAT;
            end if;
         end loop;
         
         I2C_SDAT <= '0';
         wait for 10 us;
         I2C_SDAT <= 'Z'; 
         
      end loop;
         
   
   end process;

end architecture;


