`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2025 13:39:01
// Design Name: 
// Module Name: ALU_Control_tb
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


module ALU_Control_tb();
reg [1:0] ALUOp;
reg [5:0] func;
wire [3:0] operation;

ALU_Control DUT (ALUOp, func, operation);

initial begin
    $monitor ($time, "ALUOp=%b, func=%b, operation=%b", ALUOp, func, operation);
        #5 ALUOp = 2'b00; func = 6'b000000;
        #5 ALUOp = 2'b01; func = 6'b000000;
        #5 ALUOp = 2'b10; func = 6'b001010;
        #5 ALUOp = 2'b10; func = 6'b000000;
        #5 ALUOp = 2'b10; func = 6'b000101;
        #5 ALUOp = 2'b10; func = 6'b000100;
        #5 $finish;
    end

endmodule
