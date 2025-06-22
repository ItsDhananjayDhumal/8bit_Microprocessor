`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 17:08:02
// Design Name: 
// Module Name: signed_right_shift
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


module signed_right_shift (in, shamt, out);
input [7:0] in;
input [4:0] shamt;
output [7:0] out;

assign out = $signed(in) >>> shamt;

endmodule
