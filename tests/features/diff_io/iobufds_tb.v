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
wire      led;

always #5 clk <= !clk;

initial begin
    clk = 1'b0;
    rst = 1'b1;
    sw  = 2'd0;

    #10 rst = 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 $finish();
end

wire diff_p, diff_n;

top dut(
    .sw(sw),
    .led(led),

    .diff_p(diff_p),
    .diff_n(diff_n)
);

assign diff_p = (sw[1]) ?  sw[0] : 1'bz;
assign diff_n = (sw[1]) ? !sw[0] : 1'bz;

always @(posedge clk) begin
    if (rst)
        sw <= 0;
    else
        sw <= sw + 1;

    assert(sw != 2'b00   || diff_n === 1 && diff_p == 0, sw);
    assert(sw != 2'b01   || diff_n === 0 && diff_p == 1, sw);
    assert(sw[1] != 1'b1 || led === sw[0], sw);
end

endmodule
