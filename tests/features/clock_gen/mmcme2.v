// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module mmcme2 (
    input  wire         CLK,
    input  wire         RST,

    input  wire         I_PWRDWN,
    output wire         O_LOCKED,

    output wire [3:0]   O_CNT
);

wire clk_fb_o;
wire clk_fb_ob;
wire clk_fb_i;

wire [6:0] clk;

wire clkb_out[3:0];

wire [15:0] do;
wire drdy;
wire clkfbstopped;
wire clkinstopped;
wire psdone;

MMCME2_ADV #(
    .BANDWIDTH          ("HIGH"),

    .CLKIN1_PERIOD      (10.0),  // 100MHz
    .DIVCLK_DIVIDE      (1),

    .CLKFBOUT_MULT_F    (8.0),

    .CLKOUT0_DIVIDE_F   (8.0),
    .CLKOUT0_DUTY_CYCLE (0.5),

    .CLKOUT1_DIVIDE     (16),
    .CLKOUT1_DUTY_CYCLE (0.25),

    .CLKOUT2_DIVIDE     (32),
    .CLKOUT2_DUTY_CYCLE (0.75),

    .CLKOUT3_DIVIDE     (64),
    .CLKOUT3_DUTY_CYCLE (0.5)
) mmcm (
    .CLKIN1     (CLK),

    .RST        (RST),
    .PWRDWN     (I_PWRDWN),
    .LOCKED     (O_LOCKED),

    .CLKFBIN    (clk_fb_i),
    .CLKFBOUT   (clk_fb_o),
    .CLKFBOUTB  (clk_fb_ob),

    .CLKOUT0    (clk[0]),
    .CLKOUT0B   (clkb_out[0]),
    .CLKOUT1    (clk[1]),
    .CLKOUT1B   (clkb_out[1]),
    .CLKOUT2    (clk[2]),
    .CLKOUT2B   (clkb_out[2]),
    .CLKOUT3    (clk[3]),
    .CLKOUT3B   (clkb_out[3]),

    // Stub outputs
    .CLKOUT4    (clk[4]),
    .CLKOUT5    (clk[5]),
    .CLKOUT6    (clk[6]),

    .PSDONE         (psdone),
    .DRDY           (drdy),
    .DO             (do),
    .CLKINSTOPPED   (clkinstopped),
    .CLKFBSTOPPED   (clkfbstopped),

    // Stub inputs
    .DADDR      (7'b0),
    .DCLK       (1'b0),
    .DEN        (1'b0),
    .DWE        (1'b0),
    .DI         (16'b0),
    .CLKIN2     (1'b0),
    .CLKINSEL   (1'b1),
    .PSCLK      (1'b0),
    .PSEN       (1'b0),
    .PSINCDEC   (1'b0)
);

assign clk_fb_i = clk_fb_o;

// Counters
wire rst = RST || !O_LOCKED;

genvar i;
generate for (i=0; i<4; i=i+1) begin
  reg [3:0] counter;

  always @(posedge clk[i] or posedge rst)
      if (rst) counter <= 0;
      else     counter <= counter + 1;

  assign O_CNT[i] = counter[3];

end endgenerate

endmodule
