// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

// Truth table:
//
// SW1 SW0 | LED0
//  0   0  |  0
//  0   1  |  1
//  1   0  |  x
//  1   1  |  x

module top (
    output wire led,

    input   wire [1:0] sw,
    inout   wire jc1
);

wire io_i;
wire io_o;
wire io_t;

IOBUF iobuf
(
    .I  (io_i),
    .T  (io_t),
    .O  (io_o),
    .IO (jc1)
);

// SW0 controls IOBUF.I
assign io_i = sw[0];
// SW1 controls IOBUF.T
assign io_t = sw[1];

// LED0 is connected IOBUF.O
assign led = io_o;

endmodule
