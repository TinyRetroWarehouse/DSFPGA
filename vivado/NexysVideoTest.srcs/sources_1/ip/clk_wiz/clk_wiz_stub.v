// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2.1 (win64) Build 2729669 Thu Dec  5 04:49:17 MST 2019
// Date        : Fri May  1 15:39:22 2020
// Host        : DESKTOP-B3CJGD5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Projekte/Xilinx/nexysvideo/vivado/NexysVideoTest.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.v
// Design      : clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tsbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz(clk100, clk200, clk12, clk50, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk100,clk200,clk12,clk50,clk_in1" */;
  output clk100;
  output clk200;
  output clk12;
  output clk50;
  input clk_in1;
endmodule
