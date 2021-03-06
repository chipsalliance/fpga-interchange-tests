// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`default_nettype none

// ============================================================================

module top
(
input  wire clk,

input  wire [15:0] sw,
output wire [15:0] led,

input  wire jc1, // unused
output wire jc2,
input  wire jc3, // unused
input  wire jc4
);

// ============================================================================
// Clock & reset
wire CLK;
BUFG bufgctrl(.I(clk), .O(CLK));

reg [3:0] rst_sr;
initial rst_sr <= 4'hF;

always @(posedge CLK)
    if (sw[0])
        rst_sr <= 4'hF;
    else
        rst_sr <= rst_sr >> 1;

wire RST = rst_sr[0];

// ============================================================================
// The tester

plle2_test #
(
.FEEDBACK   ("BUFG")
)
plle2_test
(
.CLK        (CLK),
.RST        (RST),

.CLKFBOUT   (),
.CLKFBIN    (),

.I_PWRDWN   (sw[1]),
.I_CLKINSEL (sw[2]),

.O_LOCKED   (led[6]),
.O_CNT      (led[5:0])
);

assign led[15:7] = sw[15:7];
assign jc2 = jc4;

endmodule

