// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`timescale 1ns / 1ps

module toplevel(
    input   clk,
    input [7:0] sw,
    output [13:0] led,
    output  io_uart_txd,
    input   io_uart_rxd,
  );
  wire bufclk;
  DCC gbuf_i(.CLKI(clk), .CLKO(bufclk));

  wire [31:0] io_gpioA_read;
  wire [31:0] io_gpioA_write;
  wire [31:0] io_gpioA_writeEnable;
  wire io_mainClk;
  wire io_jtag_tck;
  wire io_jtag_tdi;
  wire io_jtag_tdo;
  wire io_jtag_tms;
  wire io_uart_txd;
  wire io_uart_rxd;

  assign led = ~io_gpioA_write[13: 0];
  assign io_gpioA_read[7:0] = ~sw;

  Murax murax (
    .io_asyncReset(0),
    .io_mainClk (bufclk),
    .io_jtag_tck(1'b0),
    .io_jtag_tdi(1'b0),
    .io_jtag_tms(1'b0),
    .io_gpioA_read       (io_gpioA_read),
    .io_gpioA_write      (io_gpioA_write),
    .io_gpioA_writeEnable(io_gpioA_writeEnable),
    .io_uart_txd(io_uart_txd),
    .io_uart_rxd(io_uart_rxd)
  );
endmodule
