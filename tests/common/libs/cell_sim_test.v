// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC


module LUT1(input I0, output O);
  parameter [1:0] INIT = 2'h0;
endmodule
module LUT2(input I0, I1, output O);
  parameter [3:0] INIT = 4'h0;
endmodule
module LUT3(input I0, I1, I2, output O);
  parameter [7:0] INIT = 8'h00;
endmodule
module LUT4(input I0, I1, I2, I3, output O);
  parameter [15:0] INIT = 16'h0000;
endmodule
module IB(input P, output I); endmodule
module OB(input O, output P); endmodule
module DFFR(input D, C, R, output Q); endmodule
module DFFS(input D, C, S, output Q); endmodule
module VCC(output V); endmodule
module GND(output G); endmodule
