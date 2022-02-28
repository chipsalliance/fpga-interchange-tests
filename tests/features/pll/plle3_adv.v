// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top (
    input wire clk_p, clk_n,
    input wire rst,
    output wire [7:0] leds
);
    wire clk;
    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));

    wire locked;
    wire clk0, clk1;
    wire clkfb;

    PLLE3_ADV #(
        .CLKFBOUT_MULT        (8),    // 1GHz
        .CLKFBOUT_PHASE       (0.000),
        .CLKIN_PERIOD         (8.0),  // 125MHz

        /* CLK0 */
        .CLKOUT0_DIVIDE       (20),  // 50MHz
        .CLKOUT0_DUTY_CYCLE   (0.500),
        .CLKOUT0_PHASE        (0.000),
        /* CLK1 */
        .CLKOUT1_DIVIDE       (5),  // 200MHz
        .CLKOUT1_DUTY_CYCLE   (0.500),
        .CLKOUT1_PHASE        (0.000)
    ) pll (
        .CLKIN         (clk),
        .RST           (rst),
        .LOCKED        (locked),
        .CLKOUT0       (clk0),
        .CLKOUT1       (clk1),
        .CLKOUTPHYEN   (1'b0),
        .PWRDWN        (1'b0),
        .DADDR         (7'b0),
        .DEN           (1'b0),
        .CLKFBIN       (clkfb),
        .CLKFBOUT      (clkfb)
    );

    wire rst0, rst1;
    sig_fifo1 fifo_rst0(clk, clk0, rst, rst0);
    sig_fifo1 fifo_rst1(clk, clk1, rst, rst1);

    wire slow_cnt0, slow_cnt1;
    counter #(.WIDTH(24)) slow0 (clk0, rst0, slow_cnt0);
    counter #(.WIDTH(24)) slow1 (clk1, rst1, slow_cnt1);

    wire sclk0, sclk1;
    assign sclk0 = (slow_cnt0 == 0) | rst0;
    assign sclk1 = (slow_cnt1 == 0) | rst1;

    counter #(.WIDTH(4)) out0 (sclk0, rst0, leds[3:0]);
    counter #(.WIDTH(4)) out1 (sclk1, rst1, leds[7:4]);
endmodule
