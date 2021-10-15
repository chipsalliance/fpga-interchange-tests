// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module $_OR_(input A, input B, output Y);

    LUT #(.INIT("16'h000E")) _TECHMAP_REPLACE_ (.A0(A), .A1(B), .A2(1'b0), .A3(1'b0), .O(Y));

endmodule
