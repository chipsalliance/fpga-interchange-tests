// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module $_OR_(input A, input B, output Y);

    LUT #(.INIT("16'h000E")) _TECHMAP_REPLACE_ (.A0(A), .A1(B), .A2(1'b0), .A3(1'b0), .O(Y));

/*  wire [1:0] in;
  assign in = {B, A};
  \$lut #(.WIDTH(2), .LUT(4'b1110)) lut (.A(in), .Y(Y));
*/
endmodule

module FF(input D, input C, input R, output Q);

    DFF _TECHMAP_REPLACE_ (.D(D), .R(R), .C(C), .Q(Q));

/*  wire [1:0] in;
  assign in = {B, A};
  \$lut #(.WIDTH(2), .LUT(4'b1110)) lut (.A(in), .Y(Y));
*/
endmodule

module \$lut (A, Y);
  parameter WIDTH = 0;
  parameter LUT = 0;

  (* force_downto *)
  input [WIDTH-1:0] A;
  output Y;
  generate
    if (WIDTH == 1) begin
      LUT #(.INIT(LUT)) _TECHMAP_REPLACE_ (.A0(A[0]), .O(Y));
    end else
    if (WIDTH == 2) begin
      LUT #(.INIT(LUT)) _TECHMAP_REPLACE_ (.A0(A[0]), .A1(A[1]), .O(Y));
    end else
    if (WIDTH == 3) begin
      LUT #(.INIT(LUT)) _TECHMAP_REPLACE_ (.A0(A[0]), .A1(A[1]), .A2(A[2]), .O(Y));
    end else
    if (WIDTH == 4) begin
      LUT #(.INIT(LUT)) _TECHMAP_REPLACE_ (.A0(A[0]), .A1(A[1]), .A2(A[2]), .A3(A[3]), .O(Y));
    end else begin
      wire _TECHMAP_FAIL_ = 1;
    end
  endgenerate
endmodule

