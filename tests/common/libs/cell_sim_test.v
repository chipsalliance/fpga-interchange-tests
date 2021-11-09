// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC


module LUT(input A0, A1, A2, A3, output O);
  parameter [3:0] INIT = 0;
endmodule
module IB(input P, output I); endmodule
module OB(input O, output P); endmodule
module DFF(input D, C, R, output Q); endmodule
module VCC(output V); endmodule
module GND(output G); endmodule
