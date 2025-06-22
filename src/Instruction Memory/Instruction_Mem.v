`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2025 14:07:15
// Design Name: 
// Module Name: Instruction_Mem
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


module Instruction_Mem(address, instruction);
input [31:0] address;
output [31:0] instruction;

reg [7:0] mem [4294967295:0];

initial begin
    mem[0] = 8'b00000000; // instruction 0
    mem[1] = 8'b11111111;
    mem[2] = 8'b01010101;
    mem[3] = 8'b00001111;
    mem[4] = 8'b11001100; // instruction 1
    mem[5] = 8'b00110011;
    mem[6] = 8'b11110000;
    mem[7] = 8'b10010010;
end

assign instruction = {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]};

endmodule
