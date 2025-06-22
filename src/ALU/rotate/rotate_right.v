`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 21:37:00
// Design Name: 
// Module Name: rotate_right
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


module rotate_right(in, shamt, out);
input [7:0] in;
input [4:0] shamt;
output [7:0] out;

assign out = (in >> shamt) | (in << (8 - shamt));

endmodule
