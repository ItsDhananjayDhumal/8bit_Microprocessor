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
/////////////////////////////////////////////////////////////////////////////////


module ALU_Control(ALUOp, func, operation);
input [1:0] ALUOp;
input [5:0] func;
output reg [3:0] operation;

parameter ADD = 4'b0010,    //Add
          SUB = 4'b0110,    //Subtract
          AND = 4'b0000,    //AND
          OR = 4'b0001,     //OR
          NOT = 4'b1111,    //NOT
          SLT = 4'b0111,    //Set on Less Than
          LS = 4'b0011,     //Left Shift
          URS = 4'b0101,    //Unsigned Right Shift
          SRS = 4'b0100,    //Signed Right Shift
          ROR = 4'b1000,    //Right Rotate
          ROL = 4'b1001;    //Left Rotate

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
        else if (func == 6'b111101)
            operation = LS;
        else if (func == 6'b111010)
            operation = SRS;
        else if (func == 6'b111001)
            operation = URS;
        else if (func == 6'b111011)
            operation = ROR;
        else if (func == 6'b111110)
            operation = ROL;
        else if (func == 6'b000001)
            operation = NOT;                                                
        end
    end
endmodule
