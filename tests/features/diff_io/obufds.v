// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

// Truth tables (SW and LED corresponding to the basys3 board):
//
// SW8  | LED3 LED2
//  0   |  1    0
//  1   |  0    1

`default_nettype none

module top (
    input wire   sw,

    output wire  diff_p,
    output wire  diff_n
);

OBUFDS # (
    .IOSTANDARD("DIFF_SSTL135"),
    .SLEW("FAST")
) obuftds_0 (
    .I(sw),
    .O(diff_p),  // LED2
    .OB(diff_n)  // LED3
);

endmodule

