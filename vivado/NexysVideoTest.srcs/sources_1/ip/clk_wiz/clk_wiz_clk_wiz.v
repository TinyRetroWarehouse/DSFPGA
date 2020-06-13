
// file: clk_wiz.v
// 
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// None
//
//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// __clk100__100.00000______0.000______50.0______151.366____132.063
// __clk200__200.00000______0.000______50.0______132.221____132.063
// ___clk12__12.00000______0.000______50.0______231.952____132.063
// ___clk50__50.00000______0.000______50.0______174.353____132.063
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary_________100.000____________0.010

`timescale 1ps/1ps

module clk_wiz_clk_wiz 

 (// Clock in ports
  // Clock out ports
  output        clk100,
  output        clk200,
  output        clk12,
  output        clk50,
  input         clk_in1
 );
  // Input buffering
  //------------------------------------
wire clk_in1_clk_wiz;
wire clk_in2_clk_wiz;
  IBUF clkin1_ibufg
   (.O (clk_in1_clk_wiz),
    .I (clk_in1));




  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        clk100_clk_wiz;
  wire        clk200_clk_wiz;
  wire        clk12_clk_wiz;
  wire        clk50_clk_wiz;
  wire        clk_out5_clk_wiz;
  wire        clk_out6_clk_wiz;
  wire        clk_out7_clk_wiz;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_clk_wiz;
  wire        clkfbout_buf_clk_wiz;
  wire        clkfboutb_unused;
    wire clkout0b_unused;
   wire clkout1b_unused;
   wire clkout2b_unused;
   wire clkout3b_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg1 = 0;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg2 = 0;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg3 = 0;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg4 = 0;

  MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (6.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (6.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (3),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (50),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKOUT3_DIVIDE       (12),
    .CLKOUT3_PHASE        (0.000),
    .CLKOUT3_DUTY_CYCLE   (0.500),
    .CLKOUT3_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (10.0))
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_clk_wiz),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (clk100_clk_wiz),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (clk200_clk_wiz),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (clk12_clk_wiz),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clk50_clk_wiz),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_clk_wiz),
    .CLKIN1              (clk_in1_clk_wiz),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0));

// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf
   (.O (clkfbout_buf_clk_wiz),
    .I (clkfbout_clk_wiz));







  BUFGCE clkout1_buf
   (.O   (clk100),
    .CE  (seq_reg1[7]),
    .I   (clk100_clk_wiz));

  BUFH clkout1_buf_en
   (.O   (clk100_clk_wiz_en_clk),
    .I   (clk100_clk_wiz));
  always @(posedge clk100_clk_wiz_en_clk)
        seq_reg1 <= {seq_reg1[6:0],locked_int};


  BUFGCE clkout2_buf
   (.O   (clk200),
    .CE  (seq_reg2[7]),
    .I   (clk200_clk_wiz));
 
  BUFH clkout2_buf_en
   (.O   (clk200_clk_wiz_en_clk),
    .I   (clk200_clk_wiz));
 
  always @(posedge clk200_clk_wiz_en_clk)
        seq_reg2 <= {seq_reg2[6:0],locked_int};


  BUFGCE clkout3_buf
   (.O   (clk12),
    .CE  (seq_reg3[7]),
    .I   (clk12_clk_wiz));
 
  BUFH clkout3_buf_en
   (.O   (clk12_clk_wiz_en_clk),
    .I   (clk12_clk_wiz));
 
  always @(posedge clk12_clk_wiz_en_clk)
        seq_reg3 <= {seq_reg3[6:0],locked_int};


  BUFGCE clkout4_buf
   (.O   (clk50),
    .CE  (seq_reg4[7]),
    .I   (clk50_clk_wiz));

  BUFH clkout4_buf_en
   (.O   (clk50_clk_wiz_en_clk),
    .I   (clk50_clk_wiz));
	
  always @(posedge clk50_clk_wiz_en_clk)
        seq_reg4 <= {seq_reg4[6:0],locked_int};





endmodule
