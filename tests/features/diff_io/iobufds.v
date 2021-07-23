// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

// Truth tables (SW and LED corresponding to the basys3 board):
//
// | SW0 | SW1 | diff_p | diff_n | LED               |
// |  0  |  0  |   0    |   1    |  0                |
// |  1  |  0  |   1    |   0    |  1                |
// |  x  |  1  |   z    |   z    |  diff_p & !diff_n |

`default_nettype none

module top (
    input  wire [1:0] sw,
    output wire       led,

    inout  wire       diff_p,
    inout  wire       diff_n
);

IOBUFDS # (
    .IOSTANDARD("DIFF_SSTL135"),
    .SLEW("FAST")
) obuftds_0 (
    .I(sw[0]),    // SW0
    .O(led),      // LED0
    .IO(diff_p),  // XA1_P
    .IOB(diff_n), // XA1_N
    .T(sw[1])     // SW1
);

endmodule

