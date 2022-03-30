// Copyright (C) 2022  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top (
    input  wire clk,

    input  wire rx,
    output wire tx,

    input  wire [15:0] sw,
    output wire [15:0] led
);
    RAM64X8SW #(
        .INIT_A(64'b0000000111111111111111011111100111110001111000011100000110000001),
        .INIT_B(64'b0000001111111111111110111111001111100011110000111000001100000010),
        .INIT_C(64'b0000011111111111111101111110011111000111100001110000011000000100),
        .INIT_D(64'b0000111111111111111011111100111110001111000011100000110000001000),
        .INIT_E(64'b0001111111111111110111111001111100011110000111000001100000010000),
        .INIT_F(64'b0011111111111111101111110011111000111100001110000011000000100000),
        .INIT_G(64'b0111111111111111011111100111110001111000011100000110000001000000),
        .INIT_H(64'b1111111111111110111111001111100011110000111000001100000010000000)
    ) ram0 (
        .WCLK   (clk),
        .A      (sw[5:0]),
        .D      (sw[12]),
        .O      (led[7:0]),
        .WE     (sw[15]),
        .WSEL   (sw[12:10])
    );

    assign led[15:10] = sw[5:0];
    assign tx = rx;

endmodule
