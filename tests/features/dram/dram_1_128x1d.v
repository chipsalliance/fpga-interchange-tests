// Copyright (C) 2021  The Symbiflow Authors.
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
    RAM128X1D #(
        .INIT(128'b10)
    ) ram0 (
        .WCLK   (clk),
        .A      (sw[6:0]),
        .DPRA   (sw[13:7]),
        .SPO    (led[0]),
        .DPO    (led[1]),
        .D      (sw[14]),
        .WE     (sw[15])
    );

    assign led[15:2] = sw[15:2];
    assign tx = rx;

endmodule
