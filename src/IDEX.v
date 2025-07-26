`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 14:57:34
// Design Name: 
// Module Name: IDEX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IDEX(reset, clk, EX_ra, ID_read_data1, ID_read_data2, EX_read_data1, EX_read_data2, ID_instruction, ID_pcplus4, EX_instruction, EX_pcplus4, ID_ALUOp, EX_ALUOp, ID_ALUSrc, ID_RegDst, EX_ALUSrc, EX_RegDst, ID_Branch, ID_BranchFlip, ID_MemRead, ID_MemWrite, ID_Jump, EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, ID_RegWrite, ID_MemtoReg, EX_RegWrite, EX_MemtoReg);

input clk, reset;
input [7:0] ID_read_data1, ID_read_data2;
input [31:0] ID_instruction, ID_pcplus4;
input [1:0] ID_ALUOp;
input ID_Branch, ID_BranchFlip, ID_MemRead, ID_MemWrite, ID_Jump, ID_RegWrite, ID_MemtoReg;
input [1:0] ID_RegDst, ID_ALUSrc;

output reg [7:0] EX_read_data1, EX_read_data2, EX_ra;
output reg [31:0] EX_instruction, EX_pcplus4;
output reg [1:0] EX_ALUOp;
output reg EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg;
output reg [1:0] EX_RegDst, EX_ALUSrc;

always @(posedge clk) begin
    if (~reset) begin
    {EX_read_data1, EX_read_data2} <= {ID_read_data1, ID_read_data2};
    {EX_instruction, EX_pcplus4} <= {ID_instruction, ID_pcplus4};
    {EX_ALUOp, EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg} <= {ID_ALUOp, ID_Branch, ID_BranchFlip, ID_MemRead, ID_MemWrite, ID_Jump, ID_RegWrite, ID_MemtoReg};
    {EX_ALUSrc, EX_RegDst} <= {ID_ALUSrc, ID_RegDst};
    EX_ra <= ID_pcplus4[9:2];
    end
    else begin
    {EX_read_data1, EX_read_data2} <= 16'd0;
    {EX_instruction, EX_pcplus4} <= 64'd0;
    {EX_ALUOp, EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg} <= 9'd0;
    {EX_ALUSrc, EX_RegDst} <= 4'd0;
    EX_ra <= 8'd0;
    end
end

endmodule
