`timescale 10ps / 1ps
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


module Control_Unit(opcode, RegDst, Jump, Branch, BranchFlip, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
input [5:0] opcode;
output reg Jump, Branch, MemRead, MemtoReg, MemWrite, RegWrite, BranchFlip;
output reg [1:0] ALUOp, RegDst, ALUSrc;



always @(*) begin
    case (opcode)
        // R Instruction
        6'b000000 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0100000;
                    ALUOp = 2'b10; // func field
                    RegDst = 2'b01;
                    ALUSrc = 2'b00;
                    end
        // Add Immediate
        6'b001000 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0100000;
                    ALUOp = 2'b00; // Add
                    RegDst = 2'b00;
                    ALUSrc = 2'b01;
                    end
        // Sub Immediate
        6'b001001 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0100000;
                    ALUOp = 2'b01; // Sub
                    RegDst = 2'b00;
                    ALUSrc = 2'b01;
                    end
        // Load Word Immediate
        6'b001010 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0100000;
                    ALUOp = 2'b00; // Add (with reg 31 (8d0))
                    RegDst = 2'b00;
                    ALUSrc = 2'b01;
                    end
        // BEQ
        6'b000100 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000100;
                    ALUOp = 2'b01; // Sub
                    RegDst = 2'b00;
                    ALUSrc = 2'b00;
                    end
 
        // BNE
        6'b000001 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000101;
                    ALUOp = 2'b01; // Sub
                    RegDst = 2'b00;
                    ALUSrc = 2'b00;
                    end
        // BLT
        6'b000011 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000101;
                    ALUOp = 2'b11; // SLT
                    RegDst = 2'b00;
                    ALUSrc = 2'b00;
                    end
        // BGE
        6'b000101 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000100;
                    ALUOp = 2'b11; // SLT
                    RegDst = 2'b00;
                    ALUSrc = 2'b00;
                    end
        // Jump            
        6'b000010 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000010;
                    ALUOp = 2'b00; // Don't Care
                    RegDst = 2'b00;
                    ALUSrc = 2'b00;
                    end
        // Load Word
        6'b100011 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b1110000;
                    ALUOp = 2'b00; // Add
                    RegDst = 2'b00;
                    ALUSrc = 2'b01;
                    end
        // Store Word
        6'b101011 : begin
                    {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 97'b0001000;
                    ALUOp = 2'b00;
                    RegDst = 2'b00;
                    ALUSrc = 2'b01;
                    end
        // nop
        6'b111111 : begin
                  {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000000;
                  ALUOp = 2'b00;
                  RegDst = 2'b00;
                  ALUSrc = 2'b00;
                  end
        // jal
        6'b000110 : begin
                  {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0100010;
                  ALUOp = 2'b11;
                  RegDst = 2'b10;
                  ALUSrc = 2'b10;                  
                  end
        // jr
        6'b000111 : begin
                  {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000010;
                  ALUOp = 2'b11;
                  RegDst = 2'b00;
                  ALUSrc = 2'b00;                  
                  end                  
        default : begin
                  {MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, BranchFlip} = 7'b0000000;
                  ALUOp = 2'b00;
                  RegDst = 2'b00;
                  ALUSrc = 2'b00;                  
                  end
        
        endcase
    end
                        
endmodule
