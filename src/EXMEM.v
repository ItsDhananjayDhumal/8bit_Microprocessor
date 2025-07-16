`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 14:57:07
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(clk, EX_aluout, EX_read_data2, EX_reg_write_addr, EX_branch_addr, EX_jump_addr, EX_zr, EX_ng, EX_cr, EX_ov, MEM_aluout, MEM_read_data2, MEM_reg_write_addr, MEM_branch_addr, MEM_jump_addr, MEM_zr, MEM_ng, MEM_cr, MEM_ov, EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg, MEM_Branch, MEM_BranchFlip, MEM_MemRead, MEM_MemWrite, MEM_Jump, MEM_RegWrite, MEM_MemtoReg);

input clk;
input [7:0] EX_aluout, EX_read_data2;
input [31:0] EX_reg_write_addr, EX_branch_addr, EX_jump_addr;
input EX_zr, EX_ng, EX_cr, EX_ov;

input EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg;

output reg [7:0] MEM_aluout, MEM_read_data2;
output reg [31:0] MEM_reg_write_addr, MEM_branch_addr, MEM_jump_addr;
output reg MEM_zr, MEM_ng, MEM_cr, MEM_ov;

output reg MEM_Branch, MEM_BranchFlip, MEM_MemRead, MEM_MemWrite, MEM_Jump, MEM_RegWrite, MEM_MemtoReg;


always @(posedge clk) begin

    {MEM_aluout, MEM_read_data2, MEM_reg_write_addr, MEM_branch_addr, MEM_jump_addr} <= {EX_aluout, EX_read_data2, EX_reg_write_addr, EX_branch_addr, EX_jump_addr};
    MEM_ng <= EX_ng;
    MEM_zr <= EX_zr;
    MEM_ov <= EX_ov;
    MEM_cr <= EX_cr; 
    {MEM_Branch, MEM_BranchFlip, MEM_MemRead, MEM_MemWrite, MEM_Jump, MEM_RegWrite, MEM_MemtoReg} <= {EX_Branch, EX_BranchFlip, EX_MemRead, EX_MemWrite, EX_Jump, EX_RegWrite, EX_MemtoReg};

end

endmodule
