// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`timescale 1ns / 1ps

module clkdivider (
    input wire clk,
    input wire rst,
    output wire clk_out
);
    parameter DOUBLE_DIVISOR = 1;

    reg counter = 4'b0;

    always @(posedge clk) begin
        if (rst)
            counter <= 4'b0;
        else begin
            if (counter == DOUBLE_DIVISOR)
                counter <= 4'b0;
            else
                counter <= 4'b1;
        end
    end

    assign clk_out = counter < (DOUBLE_DIVISOR / 2);
endmodule


module top (
    input wire clk_p,
    input wire clk_n,
    input wire rst,
    input wire [7:0] inputs,
    output wire out,
    output wire t_dat
);
    wire clk;
    wire clk_div;

    IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));
    
    clkdivider #(.DOUBLE_DIVISOR(4)) clkdiv1 (
        .clk       (clk),
        .rst       (rst),
        .clk_out   (clk_div)
    );

    OSERDESE3 #(
        .DATA_WIDTH   (8),
        .SIM_DEVICE   ("ULTRASCALE_PLUS")
    ) serializer (
        .CLK      (clk),
        .CLKDIV   (clk_div),
        .RST      (rst),
        .D        (inputs),
        .OQ       (out),
        .T        (1'b1),
        .T_OUT    (t_dat)
    );
    
endmodule
