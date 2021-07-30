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

reg [11:0] check_counter;

reg rst;

reg [15:0] ram[0:2047];

always #5 clk <= !clk;

integer i;
initial begin
    clk = 1'b0;
    rx  = 1'b0;
    sw  = 16'b0;

    rst = 1'b1;

    // The RAM content is present on the output
    // after two clock cycles
    check_counter = 12'd4093;

    for ( i = 0; i < 2048; i = i + 1) begin
        if ( i % 10 == 0)
            ram[i] = 16'b00000000_00000001;
        else if ( i % 10 == 1)
            ram[i] = 16'b10101010_10101010;
        else if ( i % 10 == 2)
            ram[i] = 16'b01010101_01010101;
        else if ( i % 10 == 3)
            ram[i] = 16'b11111111_11111111;
        else if ( i % 10 == 4)
            ram[i] = 16'b11110000_11110000;
        else if ( i % 10 == 5)
            ram[i] = 16'b00001111_00001111;
        else if ( i % 10 == 6)
            ram[i] = 16'b11001100_11001100;
        else if ( i % 10 == 7)
            ram[i] = 16'b00110011_00110011;
        else if ( i % 10 == 8)
            ram[i] = 16'b00000000_00000010;
        else if ( i % 10 == 9)
            ram[i] = 16'b00000000_00000100;
    end

    #100 rst <= 1'b0;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #40000 $finish();
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

    if (sw == 16'd2047 || rst) begin
        sw <= 0;
    end else begin
        sw <= sw + 1;
    end

    if (rst) begin
        check_counter <= 12'd4093;
    end else if (check_counter == 12'd2047) begin
        check_counter <= 12'd0;
    end else begin
        check_counter <= check_counter + 1;
    end

    for ( i = 0; i < 2048; i = i + 1) begin
        assert(check_counter != i || led == ram[i], led);
    end
end

endmodule
