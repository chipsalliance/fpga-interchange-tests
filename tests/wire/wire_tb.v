`timescale 1 ns / 1 ps
`default_nettype none

module tb;

`include "utils.v"

reg reg_in;

initial reg_in <= 1'd0;

always #5 reg_in <= !reg_in;

initial begin
    $dumpfile(`STRINGIFY(`VCD));
    $dumpvars;
    #100 $finish();
end

wire wire_out;
top dut(
    .i(reg_in),
    .o(wire_out)
);

always @(posedge reg_in) begin
    assert(wire_out == reg_in, wire_out);
end

endmodule
