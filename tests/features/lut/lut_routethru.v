// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top(input [3:0] i, output [3:0] o);

wire i0_wire, i1_wire, i2_wire, i3_wire;
wire o0_wire, o1_wire, o2_wire, o3_wire;

IB ib_0(.I(i0_wire), .P(i[0]));
IB ib_1(.I(i1_wire), .P(i[1]));
IB ib_2(.I(i2_wire), .P(i[2]));
IB ib_3(.I(i3_wire), .P(i[3]));

OB ob_0(.O(o0_wire), .P(o[0]));
OB ob_1(.O(o1_wire), .P(o[1]));
OB ob_2(.O(o2_wire), .P(o[2]));
OB ob_3(.O(o3_wire), .P(o[3]));

// "Free" flip-flops. In the testarch with no FFMUX they require LUT-thrus
DFFR ff_0(.D(i0_wire), .C(1'b1), .R(1'b0), .Q(o0_wire));
DFFR ff_1(.D(i1_wire), .C(1'b1), .R(1'b0), .Q(o1_wire));
DFFR ff_2(.D(i2_wire), .C(1'b1), .R(1'b0), .Q(o2_wire));
DFFR ff_3(.D(i3_wire), .C(1'b1), .R(1'b0), .Q(o3_wire));

endmodule
