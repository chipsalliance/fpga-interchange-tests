// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`default_nettype none

module mmcme2_test
(
input  wire         CLK,
input  wire         RST,

output wire         CLKFBOUT,
input  wire         CLKFBIN,

input  wire         I_PWRDWN,
input  wire         I_CLKINSEL,
output wire         O_LOCKED,

output wire [5:0]   O_CNT
);

// "INTERNAL" - MMCM's internal feedback
// "BUF"      - Feedback through a BUFG
// "EXTERNAL" - Feedback external to the FPGA chip (use CLKFB* ports)
parameter FEEDBACK = "INTERNAL";

// CLKFBOUT multiplier and CLKOUT0 divider (can be fractional)
parameter CLKFBOUT_MULT_F  = 12.000;
parameter CLKOUT0_DIVIDE_F = 12.000;

parameter CLKFBOUT_PHASE   = 0.0;
parameter CLKOUT0_PHASE    = 45.0;

// ============================================================================
// Input clock divider (to get different clkins)
wire clk100;
reg  clk50;

assign clk100 = CLK;

always @(posedge clk100)
    clk50 <= !clk50;

wire clk50_bufg;
BUFG bufgctrl (.I(clk50), .O(clk50_bufg));

// ============================================================================
// The MMCM
wire clk_fb_o;
wire clk_fb_i;

wire [5:0] clk;
wire [5:0] gclk;

MMCME2_ADV #
(
.BANDWIDTH          ("HIGH"),
.COMPENSATION       (FEEDBACK == "EXTERNAL" ? "EXTERNAL" : 
                     FEEDBACK == "BUFG"     ? "BUF_IN"   :
                                              "INTERNAL"),

.CLKIN1_PERIOD      (10.0),  // Its actually 50MHz but we provide 100 to make Vivado not complain
.CLKIN2_PERIOD      (10.0),  // 100MHz

.CLKFBOUT_MULT_F    (CLKFBOUT_MULT_F),
.CLKFBOUT_PHASE     (CLKFBOUT_PHASE),

.CLKOUT0_DIVIDE_F   (CLKOUT0_DIVIDE_F),
.CLKOUT0_DUTY_CYCLE (0.50),
.CLKOUT0_PHASE      (CLKOUT0_PHASE),

.CLKOUT1_DIVIDE     (32),
.CLKOUT1_DUTY_CYCLE (0.53125),
.CLKOUT1_PHASE      (90.0),

.CLKOUT2_DIVIDE     (48),
.CLKOUT2_DUTY_CYCLE (0.50),
.CLKOUT2_PHASE      (135.0),

.CLKOUT3_DIVIDE     (64),
.CLKOUT3_DUTY_CYCLE (0.50),
.CLKOUT3_PHASE      (45.0),

.CLKOUT4_DIVIDE     (80),
.CLKOUT4_DUTY_CYCLE (0.50),
.CLKOUT4_PHASE      (90.0),

.CLKOUT5_DIVIDE     (96),
.CLKOUT5_DUTY_CYCLE (0.50),
.CLKOUT5_PHASE      (135.0),

.CLKOUT6_DIVIDE     (1),
.CLKOUT6_DUTY_CYCLE (0.50),
.CLKOUT6_PHASE      (0.0),

// FIXME: RapidWright reports STARTUP_WAIT for PLL as "string" while for MMCM
// as "boolean". Hence here the value has to be provided as boolean, otherwise
// JSON to LogicalNetlist conversion fails.
.STARTUP_WAIT       (0/*"FALSE"*/)
)
mmcm
(
.CLKIN1     (clk50_bufg),
.CLKIN2     (clk100),
.CLKINSEL   (I_CLKINSEL),

.RST        (RST),
.PWRDWN     (I_PWRDWN),
.LOCKED     (O_LOCKED),

.CLKFBIN    (clk_fb_i),
.CLKFBOUT   (clk_fb_o),

.CLKOUT0    (clk[0]),
.CLKOUT1    (clk[1]),
.CLKOUT2    (clk[2]),
.CLKOUT3    (clk[3]),
.CLKOUT4    (clk[4]),
.CLKOUT5    (clk[5])
);

generate if (FEEDBACK == "INTERNAL") begin
    assign clk_fb_i = clk_fb_o;

end else if (FEEDBACK == "BUFG") begin
    BUFG clk_fb_buf (.I(clk_fb_o), .O(clk_fb_i));

end else if (FEEDBACK == "EXTERNAL") begin
    assign CLKFBOUT = clk_fb_o;
    assign clk_fb_i = CLKFBIN;

end endgenerate

// ============================================================================
// Counters

wire rst = RST || !O_LOCKED;

genvar i;
generate for (i=0; i<6; i=i+1) begin
  BUFG bufg(.I(clk[i]), .O(gclk[i]));

  reg [23:0] counter;

  always @(posedge gclk[i] or posedge rst)
      if (rst) counter <= 0;
      else     counter <= counter + 1;

  assign O_CNT[i] = counter[21];

end endgenerate

endmodule
