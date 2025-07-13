`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 14:55:40
// Design Name: 
// Module Name: IFID
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


module IFID(IF_instruction, IF_pcplus4, ID_instruction, ID_pcplus4, clk);

input clk;
input [31:0] IF_instruction, IF_pcplus4;
output reg [31:0] ID_instruction, ID_pcplus4;

reg [31:0] instruction, pcplus4;

always @(posedge clk) begin
    instruction <= IF_instruction;
    pcplus4 <= IF_pcplus4;
    
    ID_instruction <= instruction;
    ID_pcplus4 <= pcplus4;
    
    end    

endmodule
