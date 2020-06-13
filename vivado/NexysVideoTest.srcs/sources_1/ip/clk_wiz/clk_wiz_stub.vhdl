-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2.1 (win64) Build 2729669 Thu Dec  5 04:49:17 MST 2019
-- Date        : Fri May  1 15:39:22 2020
-- Host        : DESKTOP-B3CJGD5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Projekte/Xilinx/nexysvideo/vivado/NexysVideoTest.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.vhdl
-- Design      : clk_wiz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz is
  Port ( 
    clk100 : out STD_LOGIC;
    clk200 : out STD_LOGIC;
    clk12 : out STD_LOGIC;
    clk50 : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz;

architecture stub of clk_wiz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk100,clk200,clk12,clk50,clk_in1";
begin
end;
