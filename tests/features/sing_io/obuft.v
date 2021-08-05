// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

// Truth table:
//
// SW1 SW0 | jc1
//  0   0  |  0
//  0   1  |  1
//  1   0  |  z
//  1   1  |  z

module top (
    input   wire [1:0] sw,
    inout   wire jc1
);

wire io_i;
wire io_t;

OBUFT obuft
(
    .I  (io_i),
    .T  (io_t),
    .O  (jc1)
);

// SW0 controls OBUFT.I
assign io_i = sw[0];
// SW1 controls OBUFT.T
assign io_t = sw[1];

endmodule
