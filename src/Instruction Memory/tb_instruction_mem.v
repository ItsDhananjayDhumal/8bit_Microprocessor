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


module tb_instruction_mem();
reg [31:0] addr;
wire [31:0] out;

instruction_mem DUT (addr, out);

initial begin
    $monitor($time, "addr=%h, out=%b", addr, out);
        #5 addr = 32'h00000000;
        #5 addr = 32'h00000005;
        #5 addr = 32'h00000009;
        #5 addr = 32'h0000000D;
        #5 $finish;
    end
endmodule