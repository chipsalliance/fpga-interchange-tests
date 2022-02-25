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
    input wire rd_en,
    input wire in,
    output wire [7:0] outputs,
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

    ISERDESE3 #(
        .DATA_WIDTH   (8),
        .SIM_DEVICE   ("ULTRASCALE_PLUS")
    ) deserializer (
        .CLK          (clk),
        .CLK_B        (~clk),
        .RST          (rst),
        .CLKDIV       (clk_div),
        .D            (in),
        .FIFO_RD_EN   (rd_en),
        .Q            (outputs)
    );
    
endmodule
