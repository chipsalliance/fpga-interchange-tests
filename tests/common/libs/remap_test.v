// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module $_OR_(input A, input B, output Y);

    LUT2 #(.INIT("4'hE")) _TECHMAP_REPLACE_ (.I0(A), .I1(B), .O(Y));

endmodule

module FF(input D, input C, input R, output Q);

    DFF _TECHMAP_REPLACE_ (.D(D), .R(R), .C(C), .Q(Q));

endmodule

module \$lut (A, Y);
  parameter WIDTH = 0;
  parameter LUT = 16'h0000;

  (* force_downto *)
  input [WIDTH-1:0] A;
  output Y;
  generate
    if (WIDTH == 1) begin
      LUT1 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.I0(A[0]), .O(Y));
    end else
    if (WIDTH == 2) begin
      LUT2 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.I0(A[0]), .I1(A[1]), .O(Y));
    end else
    if (WIDTH == 3) begin
      LUT3 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.I0(A[0]), .I1(A[1]), .I2(A[2]), .O(Y));
    end else
    if (WIDTH == 4) begin
      LUT4 #(.INIT(LUT)) _TECHMAP_REPLACE_ (.I0(A[0]), .I1(A[1]), .I2(A[2]), .I3(A[3]), .O(Y));
    end else begin
      wire _TECHMAP_FAIL_ = 1;
    end
  endgenerate
endmodule

