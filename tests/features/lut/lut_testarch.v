// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top(input i0, input i1, output o);

wire i0_wire, i1_wire;
wire o_wire;

IB ib_0(.I(i0_wire), .P(i0));
IB ib_1(.I(i1_wire), .P(i1));

OB ob_1(.O(o_wire), .P(o));

assign o_wire = i0_wire | i1_wire;

endmodule
