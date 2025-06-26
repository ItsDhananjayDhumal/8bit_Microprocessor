`timescale 10ns/1ps

module ProgramCounter(
    input wire clk,
    input wire reset,
    input wire pc_write,
    input wire [31:0] next_pc,
    output reg[31:0] pc
);
    initial begin
        pc <= 32'b0;
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
