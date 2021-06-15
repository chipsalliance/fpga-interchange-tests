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

reg rx;
reg [15:0] sw;

reg [3:0] check_counter;

reg rst;

reg [15:0] ram[0:1023];

always #5 clk <= !clk;

initial begin
    clk = 1'b0;
    rx  = 1'b0;
    sw  = 16'b0;

    rst = 1'b1;

    // The RAM content is present on the output
    // after two clock cycles
    check_counter = 4'd13;

    ram[0] = 16'b00000000_00000001;
    ram[1] = 16'b10101010_10101010;
    ram[2] = 16'b01010101_01010101;
    ram[3] = 16'b11111111_11111111;
    ram[4] = 16'b11110000_11110000;
    ram[5] = 16'b00001111_00001111;
    ram[6] = 16'b11001100_11001100;
    ram[7] = 16'b00110011_00110011;
    ram[8] = 16'b00000000_00000010;
    ram[9] = 16'b00000000_00000100;

    #100 rst <= 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #1000 $finish();
end

wire tx;
wire [15:0] led;
top dut(
    .clk(clk),

    .rx(rx),
    .tx(tx),

    .sw(sw),
    .led(led)
);

always @(posedge clk) begin
    rx <= !rx;

    assert(tx == rx, tx);

    if (sw == 16'd9 || rst) begin
        sw <= 0;
    end else begin
        sw <= sw + 1;
    end

    if (rst) begin
        check_counter <= 4'd13;
    end else if (check_counter == 4'd9) begin
        check_counter <= 4'd0;
    end else begin
        check_counter <= check_counter + 1;
    end

    assert(check_counter != 4'd0 || led == ram[0], led);
    assert(check_counter != 4'd1 || led == ram[1], led);
    assert(check_counter != 4'd2 || led == ram[2], led);
    assert(check_counter != 4'd3 || led == ram[3], led);
    assert(check_counter != 4'd4 || led == ram[4], led);
    assert(check_counter != 4'd5 || led == ram[5], led);
    assert(check_counter != 4'd6 || led == ram[6], led);
    assert(check_counter != 4'd7 || led == ram[7], led);
    assert(check_counter != 4'd8 || led == ram[8], led);
    assert(check_counter != 4'd9 || led == ram[9], led);
end

endmodule
