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

always #5 clk <= !clk;

initial begin
    clk = 1'd0;
    counter = 1'b0;
    rst = 1'd1;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 rst = 1'b0;
    #500 $finish();
end

wire [3:0] out;
top dut (
    .clk(clk),
    .rst(rst),
    .io_led(out)
);

reg [31:0] counter;
always @(posedge clk) begin
    if (rst)
        counter <= 32'b0;
    else
        counter <= counter + 1;

    assert(out == counter[5:2], out);
end

endmodule
