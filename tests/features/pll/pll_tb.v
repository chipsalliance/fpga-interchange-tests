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

parameter CLK_PULSE = 5;

// Time to power up the PLL
parameter WAIT_PWRUP = 405;

// Custom time when PLL is powered up
parameter PWRUP = CLK_PULSE * 4;

reg clk_in;
reg [5:0] clk_out;
reg pwrdwn, rst;

always #CLK_PULSE clk_in <= !clk_in;

initial begin
    clk_in = 1'b0;
    clk_out = 6'b0;
    rst = 1'b1;
    pwrdwn = 1'b1;

    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;

    #(CLK_PULSE * 2) rst = 1'b0;
    #PWRUP pwrdwn = 1'b0;

    #10000 $finish();
end

// Synchronize the clocks from the PLL
initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE);
    forever #CLK_PULSE clk_out[0] = !clk_out[0];
end

initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE);
    forever #CLK_PULSE clk_out[1] = !clk_out[1];
end

initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE * 2);
    forever #(CLK_PULSE * 2) clk_out[2] = !clk_out[2];
end

initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE * 2);
    forever #(CLK_PULSE * 2) clk_out[3] = !clk_out[3];
end

initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE * 4);
    forever #(CLK_PULSE * 4) clk_out[4] = !clk_out[4];
end

initial begin
    #(WAIT_PWRUP + PWRUP - CLK_PULSE * 8);
    forever #(CLK_PULSE * 8) clk_out[5] = !clk_out[5];
end

wire [6:0] out;
top dut (
    .clk(clk_in),
    .sw({pwrdwn, rst}),
    .led(out)
);

genvar i;
generate for (i=0; i<6; i=i+1) begin
    reg [23:0] counter;
    reg start = 1'b1;

    always @(posedge clk_out[i] or posedge out[6]) begin
        if (!out[6] || pwrdwn)
            counter <= 0;
        else
            counter <= counter + 1;

        assert(out[i] == counter[3], out[i]);
    end

end endgenerate

endmodule
