// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module plle2 (
    input  wire         CLK,
    input  wire         RST,

    input  wire         I_PWRDWN,
    output wire         O_LOCKED,

    output wire [3:0]   O_CNT
);

wire clk_fb_o;
wire clk_fb_i;

wire [5:0] clk;

wire [15:0] do;
wire drdy;

PLLE2_ADV #(
    .BANDWIDTH          ("HIGH"),

    .CLKIN1_PERIOD      (10.0),  // 100MHz

    .CLKFBOUT_MULT      (16),

    .CLKOUT0_DIVIDE     (16),
    .CLKOUT0_DUTY_CYCLE (0.531250),

    .CLKOUT1_DIVIDE     (32),
    .CLKOUT1_DUTY_CYCLE (0.25),

    .CLKOUT2_DIVIDE     (64),
    .CLKOUT2_DUTY_CYCLE (0.75),

    .CLKOUT3_DIVIDE     (128),
    .CLKOUT3_DUTY_CYCLE (0.5),

    .STARTUP_WAIT       ("FALSE")
) pll (
    .CLKIN1     (CLK),
    .CLKINSEL   (1'b1),

    .RST        (RST),
    .PWRDWN     (I_PWRDWN),
    .LOCKED     (O_LOCKED),

    .CLKFBIN    (clk_fb_i),
    .CLKFBOUT   (clk_fb_o),

    .CLKOUT0    (clk[0]),
    .CLKOUT1    (clk[1]),
    .CLKOUT2    (clk[2]),
    .CLKOUT3    (clk[3])
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
