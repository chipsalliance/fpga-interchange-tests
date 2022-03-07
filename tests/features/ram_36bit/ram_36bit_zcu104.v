// Copyright (C) 2022  The F4PGA Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top_zcu104 (
    input wire clk_p,
    input wire clk_n,
    output wire [15:0] led,
    input wire [15:0] sw,
    output wire tx,
    input wire rx,
    input wire butu,
    input wire butd,
    input wire butl,
    input wire butr,
    input wire butc
);

    // The ZCU104 CLK comes from a differential pair
    wire clk;
    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));

    top top_ (
        .led(led),
        .sw(sw),
        .tx(tx),
        .rx(rx),
        .butu(butu),
        .butd(butd),
        .butl(butl),
        .butr(butr),
        .butc(butc),
        .clk(clk)
    );
endmodule

