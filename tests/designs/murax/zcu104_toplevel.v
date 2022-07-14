// Copyright (C) 2021  The Symbiflow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC

`timescale 1ns / 1ps

module toplevel(
    input   clk_p,
    input   clk_n,

    output [3:0] io_led,

    input   io_uart_rxd,
    output  io_uart_txd
  );

  wire [31:0] io_gpioA_write;
  wire [31:0] io_gpioA_writeEnable;
  wire io_mainClk;
  wire io_uart_txd;
  wire io_uart_rxd;

  assign io_led = io_gpioA_write[3: 0];

  wire clk;
  IBUFDS ibuf_ds (.I(clk_p), .IB(clk_n), .O(clk));

  wire clk_bufg;
  BUFGCE bufg (.I(clk), .CE(1'b1), .O(clk_bufg));

  Murax murax (
    .io_asyncReset(0),
    .io_mainClk (clk_bufg),
    .io_jtag_tck(1'b0),
    .io_jtag_tdi(1'b0),
    .io_jtag_tms(1'b0),
    .io_gpioA_read       (8'b0),
    .io_gpioA_write      (io_gpioA_write),
    .io_gpioA_writeEnable(io_gpioA_writeEnable),
    .io_uart_txd(io_uart_txd),
    .io_uart_rxd(io_uart_rxd)
  );
endmodule

