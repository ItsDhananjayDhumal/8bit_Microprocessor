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


module instruction_mem(address, instruction);
input [31:0] address;
output [31:0] instruction;

reg [7:0] mem [65535:0];
wire [31:0] aligned_addr = address & ~32'h00000003;

initial begin
  $readmemb("machinecode.mem", mem);
end

assign instruction = {mem[aligned_addr], mem[aligned_addr + 1], mem[aligned_addr + 2], mem[aligned_addr + 3]};

endmodule
