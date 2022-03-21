// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module counter (
    input wire clk,
    input wire rst,
    output reg [(WIDTH-1):0] cnt
);
    parameter WIDTH = 32;

    always @(posedge clk) begin
        if (rst)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
endmodule

module sig_fifo1 (
    input wire iclk,
    input wire oclk,
    input wire isig,
    output reg osig
);
    reg b = 0;

    always @(posedge iclk, posedge oclk) begin
        if (iclk)
            b <= isig;
        else if (oclk)
            osig <= b;
    end
        
endmodule
