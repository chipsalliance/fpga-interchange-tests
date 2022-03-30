// Copyright (C) 2022  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`default_nettype none

module blinker (
    input wire clk,
    output reg [1:0] led
);
    initial led = 2'b00;

    always @(posedge clk) begin
        led[0] <= ~led[0];
        if (led[0])
            led[1] <= ~led[1];
    end
endmodule

module top (
    input wire clk_n, clk_p,
    input wire rst,
    output wire [15:0] led
);
    wire clk;
    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));

    wire clkfb_in, clkfb_out;
    wire [6:0] mclk;
    MMCME4_ADV #(
        .BANDWIDTH          ("HIGH"),
        .CLKFBOUT_MULT_F    (8.000),
        .CLKIN1_PERIOD      (8.000),
        .CLKIN2_PERIOD      (8.000),
        .CLKOUT0_DIVIDE_F   (1.500),
        .CLKOUT1_DIVIDE     (12),
        .CLKOUT2_DIVIDE     (40),
        .CLKOUT3_DIVIDE     (69),
        .CLKOUT4_DIVIDE     (96),
        .CLKOUT5_DIVIDE     (111),
        .CLKOUT6_DIVIDE     (77)
    ) mmcm (
        .CLKIN1     (clk),
        .CLKIN2     (clk),
        .CLKFBIN    (clkfb_in),
        .CLKFBOUT   (clkfb_out),
        .CLKOUT0    (mclk[0]),
        .CLKOUT1    (mclk[1]),
        .CLKOUT2    (mclk[2]),
        .CLKOUT3    (mclk[3]),
        .CLKOUT4    (mclk[4]),
        .CLKOUT5    (mclk[5]),
        .CLKOUT6    (mclk[6]),
        .DADDR      (7'h0),
        .DEN        (1'b0),
        .DI         (16'h0),
        .DWE        (1'b0),
        .RST        (rst)
    );

    assign clkfb_in = clkfb_out;
    
    wire [6:0] bclk;
    genvar i;
    for (i = 0; i < 6; i = i + 1) begin
        BUFGCTRL #(
            .PRESELECT_I0   (1)
        ) clkbuf (
            .CE0       (1'b1),
            .CE1       (1'b0),
            .IGNORE0   (1'b0),
            .IGNORE1   (1'b1),
            .I0        (mclk[i]),
            .O         (bclk[i]),
            .S0        (1'b1),
            .S1        (1'b0)
        );
        blinker blnk (bclk[i], led[(i*2+1):(i*2)]);
    end

endmodule
