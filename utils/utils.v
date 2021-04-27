// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`define STRINGIFY(x) `"x`"

task assert(input a, input reg [512:0] s);
begin
    if (a==0) begin
        $display("**********************************************************");
        $display("* ASSERT FAILURE (@%d): %-s", $time, s);
        $display("**********************************************************");
        $dumpflush;
        $finish_and_return(-1);
    end
end
endtask
