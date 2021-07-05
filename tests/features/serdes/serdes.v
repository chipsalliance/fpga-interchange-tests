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

    input  wire [7:0] sw,
    output wire [9:0] led,

    inout wire io
);

localparam CLKFBOUT_MULT = 8;
localparam DATA_WIDTH = 8;
localparam DATA_RATE = "SDR";

wire SYSCLK;
wire CLKDIV;

wire O_LOCKED;

wire clk_fb_i;
wire clk_fb_o;

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

    .CLKFBOUT_MULT      (CLKFBOUT_MULT),
    .CLKOUT0_DIVIDE     (CLKFBOUT_MULT),
    .CLKOUT1_DIVIDE     (CLKFBOUT_MULT * DIVIDE_RATE),

    .STARTUP_WAIT       ("FALSE"),

    .DIVCLK_DIVIDE      (1'd1)
) pll (
    .CLKIN1     (clk),

    .RST        (RST),
    .PWRDWN     (0),
    .LOCKED     (O_LOCKED),

    .CLKFBIN    (clk_fb_i),
    .CLKFBOUT   (clk_fb_o),

    .CLKOUT0    (SYSCLK),
    .CLKOUT1    (CLKDIV),

    // Stub inputs
    .CLKIN2     (1'b0),
    .CLKINSEL   (1'b1),
    .DADDR      (7'b0),
    .DCLK       (1'b0),
    .DEN        (1'b0),
    .DWE        (1'b0),
    .DI         (16'b0)
);

// Test uints
wire [7:0] OUTPUTS;

wire [7:0] INPUTS = sw[7:0];

localparam MASK = DATA_WIDTH == 2 ? 8'b00000011 :
                  DATA_WIDTH == 3 ? 8'b00000111 :
                  DATA_WIDTH == 4 ? 8'b00001111 :
                  DATA_WIDTH == 5 ? 8'b00011111 :
                  DATA_WIDTH == 6 ? 8'b00111111 :
                  DATA_WIDTH == 7 ? 8'b01111111 :
                /*DATA_WIDTH == 8*/ 8'b11111111;

wire [7:0] MASKED_INPUTS = INPUTS & MASK;

wire I_DAT;
wire O_DAT;
wire T_DAT;


IOBUF iobuf(.I(O_DAT), .O(I_DAT), .T(T_DAT), .IO(io));

serdes_test #(
    .DATA_WIDTH   (DATA_WIDTH),
    .DATA_RATE    (DATA_RATE)
) serdes_test (
    .SYSCLK     (SYSCLK),
    .CLKDIV     (CLKDIV),
    .RST        (RST),

    .OUTPUTS    (OUTPUTS),
    .INPUTS     (MASKED_INPUTS),

    .I_DAT      (I_DAT),
    .O_DAT      (O_DAT),
    .T_DAT      (T_DAT)
);

wire [7:0] MASKED_OUTPUTS = OUTPUTS & MASK;

// I/O connections
reg [23:0] heartbeat_cnt;

always @(posedge SYSCLK)
    heartbeat_cnt <= heartbeat_cnt + 1;

assign led[0] = heartbeat_cnt[22];
assign led[8:1] = MASKED_OUTPUTS;

endmodule
