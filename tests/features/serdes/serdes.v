// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`default_nettype none

module top (
    input  wire clk,

    input  wire rst,

    input  wire [11:0] sw,
    output wire [12:0] led,

    inout wire [5:0] io
);

localparam CLKFBOUT_MULT = 8;
localparam DATA_WIDTH = 2;
localparam DATA_RATE = "SDR";
localparam NUM_SERDES = 6;

wire SYSCLK;
wire CLKDIV;
wire REFCLK;

wire O_LOCKED;

wire clk_fb_i;
wire clk_fb_o;

assign clk_fb_i = clk_fb_o;

reg [3:0] rst_sr;

initial rst_sr = 4'hF;

always @(posedge clk)
    if (rst)
        rst_sr <= 4'hF;
    else
        rst_sr <= rst_sr >> 1;

wire RST = rst_sr[0];

localparam DIVIDE_RATE = DATA_RATE == "SDR" ? DATA_WIDTH : DATA_WIDTH / 2;

PLLE2_ADV #(
    .BANDWIDTH          ("HIGH"),
    .COMPENSATION       ("ZHOLD"),

    .CLKIN1_PERIOD      (10.0),
    .CLKIN2_PERIOD      (10.0),

    .CLKFBOUT_MULT      (CLKFBOUT_MULT),
    .CLKOUT0_DIVIDE     (CLKFBOUT_MULT),
    .CLKOUT1_DIVIDE     (CLKFBOUT_MULT * DIVIDE_RATE),
    .CLKOUT2_DIVIDE     (CLKFBOUT_MULT / 2), // 200 MHz

    .STARTUP_WAIT       ("FALSE"),

    .DIVCLK_DIVIDE      (1'd1)
) pll (
    .CLKIN1     (clk),
    .CLKIN2     (clk),
    .CLKINSEL   (1'b1),

    .RST        (RST),
    .PWRDWN     (0),
    .LOCKED     (O_LOCKED),

    .CLKFBIN    (clk_fb_i),
    .CLKFBOUT   (clk_fb_o),

    .CLKOUT0    (SYSCLK),
    .CLKOUT1    (CLKDIV),
    .CLKOUT2    (REFCLK)
);

wire REFCLK_BUFG, SYSCLK_BUFG, CLKDIV_BUFG;

BUFG ref_bufg (.I(REFCLK), .O(REFCLK_BUFG));
BUFG sys_bufg (.I(SYSCLK), .O(SYSCLK_BUFG));
BUFG div_bufg (.I(CLKDIV), .O(CLKDIV_BUFG));

(* BEL="IDELAYCTRL" *)
IDELAYCTRL idelayctrl (
    .REFCLK (REFCLK_BUFG)
);

// Test uints
wire [11:0] OUTPUTS;

wire [NUM_SERDES-1:0] I_DAT;
wire [NUM_SERDES-1:0] O_DAT;
wire [NUM_SERDES-1:0] T_DAT;

genvar i;
generate
    for(i = 0; i < NUM_SERDES; i = i + 1) begin
        IOBUF iobuf(.I(O_DAT[i]), .O(I_DAT[i]), .T(T_DAT[i]), .IO(io[i]));

        serdes_test #(
            .DATA_WIDTH   (DATA_WIDTH),
            .DATA_RATE    (DATA_RATE)
        ) serdes_test (
            .SYSCLK     (SYSCLK_BUFG),
            .CLKDIV     (CLKDIV_BUFG),
            .RST        (RST),

            .OUTPUTS    (OUTPUTS[i*2 + 1: i*2]),
            .INPUTS     (sw[i*2 + 1: i*2]),

            .I_DAT      (I_DAT[i]),
            .O_DAT      (O_DAT[i]),
            .T_DAT      (T_DAT[i])
        );
    end
endgenerate

// I/O connections
reg [23:0] heartbeat_cnt;

always @(posedge SYSCLK)
    heartbeat_cnt <= heartbeat_cnt + 1;

assign led[0] = heartbeat_cnt[22];
assign led[12:1] = OUTPUTS;

endmodule
