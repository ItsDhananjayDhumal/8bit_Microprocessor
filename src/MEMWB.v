`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 14:56:14
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(clk, MEM_mem_data, MEM_aluout, MEM_reg_write_addr, MEM_RegWrite, MEM_MemtoReg, WB_mem_data, WB_aluout, WB_reg_write_addr, WB_RegWrite, WB_MemtoReg);

input clk;
input [7:0] MEM_mem_data, MEM_aluout, MEM_reg_write_addr;
input MEM_RegWrite, MEM_MemtoReg;

output reg [7:0] WB_mem_data, WB_aluout, WB_reg_write_addr;
output reg WB_RegWrite, WB_MemtoReg;

reg [7:0] mem_data, aluout, reg_write_addr;
reg RegWrite, MemtoReg;

always @(posedge clk) begin
    {mem_data, aluout, reg_write_addr} <= {MEM_mem_data, MEM_aluout, MEM_reg_write_addr};
    {RegWrite, MemtoReg} <= {MEM_RegWrite, MEM_MemtoReg};
    
    {WB_mem_data, WB_aluout, WB_reg_write_addr} <= {mem_data, aluout, reg_write_addr};
    {WB_RegWrite, WB_MemtoReg} <= {RegWrite, MemtoReg};
end

endmodule
