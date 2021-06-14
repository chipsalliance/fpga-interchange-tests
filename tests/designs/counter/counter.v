// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top (
    input clk,
    input rst,
    output [7:4] io_led
);

reg [31:0] counter = 32'b0;

assign io_led = counter[5:2];

always @(posedge clk)
begin
    if(rst)
        counter <= 32'b0;
    else
        counter <= counter + 1;
end

endmodule
