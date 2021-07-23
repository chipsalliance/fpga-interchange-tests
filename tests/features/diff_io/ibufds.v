// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`default_nettype none

module top (
    output wire       led,

    input  wire       diff_i_p,
    input  wire       diff_i_n
);

IBUFDS # (
    .IOSTANDARD("DIFF_SSTL135")
) ibufds_0 (
    .I(diff_i_p),     // SW1
    .IB(diff_i_n),    // SW0
    .O(led)
);

endmodule

