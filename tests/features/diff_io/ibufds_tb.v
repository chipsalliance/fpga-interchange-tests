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

reg  sig;
wire led;

always #5 clk <= !clk;

initial begin
    clk = 1'b0;
    rst = 1'b1;
    sig = 1'b0;

    #10 rst = 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 $finish();
end

wire diff_p, diff_n;

top dut(
    .led(led),

    .diff_i_p(diff_p),
    .diff_i_n(diff_n)
);

assign diff_p =  sig;
assign diff_n = !sig;

always @(posedge clk) begin
    if (rst)
        sig <= 0;
    else
        sig <= ~sig;

    assert(sig == led, sig);
end

endmodule
