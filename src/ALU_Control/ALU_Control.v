`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2025 13:20:44
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(ALUOp, func, operation);
input [1:0] ALUOp;
input [5:0] func;
output reg [3:0] operation;

parameter ADD = 4'b0010,
          SUB = 4'b0110,
          AND = 4'b0000,
          OR = 4'b0001,
          SLT = 4'b0111;

always @(*) begin
    if (ALUOp == 2'b00)
        operation = ADD;
    else if (ALUOp == 2'b01)
        operation = SUB;
    else if (ALUOp == 2'b10) begin
        if (func == 6'b000000)
            operation = ADD;
        else if (func == 6'b000010) 
            operation = SUB;
        else if (func == 6'b000100) 
            operation = AND;
        else if (func == 6'b000101) 
            operation = OR;
        else if (func == 6'b001010) 
            operation = SLT;
        end
    end
endmodule
