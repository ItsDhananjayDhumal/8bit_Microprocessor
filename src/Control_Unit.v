`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 00:43:50
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(opcode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
input [5:0] opcode;
output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0] ALUOp;



always @(*) begin
    case (opcode)
        // R Instruction
        6'b000000 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b10010000;
                    ALUOp = 2'b10; // func filed
                    end
        // Add Immediate
        6'b001000 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b10010000;
                    ALUOp = 2'b00; // Add
                    end
        // Sub Immediate
        6'b001001 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b01010000;
                    ALUOp = 2'b01; // Sub
                    end
        // Load Word Immediate
        6'b001010 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b01010000;
                    ALUOp = 2'b00; // Add (with reg 31, 8d0)
                    end
        // BEQ
        6'b000100 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b00000010;
                    ALUOp = 2'b01; // Sub
                    end
        // Jump            
        6'b000010 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b00000001;
                    ALUOp = 2'b00; // Don't Care
                    end
        // Load Word
        6'b100011 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b01111000;
                    ALUOp = 2'b00; // Add
                    end
        // Store Word
        6'b101011 : begin
                    {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b01000100;
                    ALUOp = 2'b00;
                    end
        
        default : begin
                  {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump} = 8'b00000000;
                  ALUOp = 2'b00;
                  end
        
        endcase
    end
                        
endmodule
