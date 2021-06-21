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

reg [2:0] sw;

reg [0:7] check;

always #5 clk <= !clk;

initial begin
    clk = 1'b0;
    rst = 1'b1;
    sw  = 3'b0;

    check = 8'b01000111;

    #10 rst = 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 $finish();
end

wire led;
wire jc1;

assign jc1 = sw[1] ? sw[2] : 1'bz;

top dut(
    .sw(sw[1:0]),

    .led(led),
    .jc1(jc1)
);

always @(posedge clk) begin
    if (rst)
        sw <= 0;
    else
        sw <= sw + 1;

    assert(sw != 3'd0 || led === check[0], led);
    assert(sw != 3'd1 || led === check[1], led);
    assert(sw != 3'd2 || led === check[2], led);
    assert(sw != 3'd3 || led === check[3], led);
    assert(sw != 3'd4 || led === check[4], led);
    assert(sw != 3'd5 || led === check[5], led);
    assert(sw != 3'd6 || led === check[6], led);
    assert(sw != 3'd7 || led === check[7], led);
end

endmodule
