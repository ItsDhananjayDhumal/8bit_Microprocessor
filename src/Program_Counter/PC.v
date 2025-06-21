`timescale 10ns/1ps

module ProgramCounter(
    input wire clk,
    input wire reset,
    input wire pc_write,
    input wire [9:0] next_pc,
    output reg[9:0] pc
);
    initial begin
        pc <= 10'b0000000000;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
        end
        else if (pc_write) begin
            pc <= next_pc;
        end
    end
endmodule