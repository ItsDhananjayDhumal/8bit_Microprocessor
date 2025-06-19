`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2025 15:07:47
// Design Name: 
// Module Name: Instruction_Mem_tb
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


module Instruction_Mem_tb();
reg [9:0] addr;
wire [31:0] out;

Instruction_Mem DUT (addr, out);

initial begin
    $monitor($time, "addr=%d, out=%b", addr, out);
        #5 addr = 10'd0;
        #5 addr = 10'd4;
        #5 $finish;
    end
endmodule
