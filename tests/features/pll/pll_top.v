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

    input  wire [1:0] sw,
    output wire [6:0] led
);

plle2_test pll_test (
    .CLK        (clk),
    .RST        (sw[0]),

    .I_PWRDWN   (sw[1]),

    .O_LOCKED   (led[6]),
    .O_CNT      (led[5:0])
);

endmodule

