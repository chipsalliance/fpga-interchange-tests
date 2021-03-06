// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

module top (
    input  wire clk,

    input  wire rx,
    output wire tx,

    input  wire [15:0] sw,
    output wire [15:0] led
);
    RAM64M #(
        .INIT_A(64'b10),
        .INIT_B(64'b100),
        .INIT_C(64'b1000),
        .INIT_D(64'b10000)
    ) ram0 (
        .WCLK   (clk),
        .ADDRA  (sw[5:0]),
        .ADDRB  (sw[5:0]),
        .ADDRC  (sw[5:0]),
        .ADDRD  (sw[11:6]),
        .DIA    (sw[12]),
        .DIB    (sw[13]),
        .DIC    (sw[14]),
        .DID    (sw[14]),
        .DOA    (led[0]),
        .DOB    (led[1]),
        .DOC    (led[2]),
        .DOD    (led[3]),
        .WE     (sw[15])
    );

    RAM64M #(
        .INIT_A(64'b10),
        .INIT_B(64'b100),
        .INIT_C(64'b1000),
        .INIT_D(64'b10000)
    ) ram1 (
        .WCLK   (clk),
        .ADDRA  (sw[5:0]),
        .ADDRB  (sw[5:0]),
        .ADDRC  (sw[5:0]),
        .ADDRD  (sw[11:6]),
        .DIA    (sw[12]),
        .DIB    (sw[13]),
        .DIC    (sw[14]),
        .DID    (sw[14]),
        .DOA    (led[4]),
        .DOB    (led[5]),
        .DOC    (led[6]),
        .DOD    (led[7]),
        .WE     (sw[15])
    );

    assign led[15:8] = sw[15:8];
    assign tx = rx;

endmodule
