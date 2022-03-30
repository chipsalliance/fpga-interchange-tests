// Copyright (C) 2022  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top_diff (
    input wire clk_p,
    input wire clk_n,
    input wire rx,
    output wire tx,
    input wire [15:0] sw,
    output wire [15:0] led
);
    wire clk;
    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));
    top top_ (
        .rx(rx),
        .tx(tx),
        .sw(sw),
        .led(led),
        .clk(clk)
    );
endmodule
