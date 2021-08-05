// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`timescale 1 ns / 1 ps
`default_nettype none

module tb;

`include "utils.v"

reg clk;
reg rst;

reg [1:0] sw;

always #5 clk <= !clk;

initial begin
    clk = 1'b0;
    rst = 1'b1;
    sw  = 2'b0;

    #10 rst = 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 $finish();
end

wire jc1;

top dut(
    .sw(sw),
    .jc1(jc1)
);

always @(posedge clk) begin
    if (rst)
        sw <= 0;
    else
        sw <= sw + 1;

    assert(sw[1] != 1  || jc1 === 1'bz, sw);
    assert(sw != 2'b00 || jc1 === 1'b0, sw);
    assert(sw != 2'b01 || jc1 === 1'b1, sw);
end

endmodule
