`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2025 18:29:39
// Design Name: 
// Module Name: branch_prediction_forwarding_unit
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


module branch_prediction_forwarding_unit(
    input [4:0] ID_rs, ID_rt,
    input [4:0] EX_reg_write_addr, MEM_reg_write_addr,
    input EX_RegWrite, MEM_RegWrite,
    output reg [1:0] rd_srcA, rd_srcB
);

always @(*) begin

    if (EX_RegWrite && (EX_reg_write_addr != 5'd31) && (EX_reg_write_addr == ID_rs))
        rd_srcA = 2'b10;
    else if (MEM_RegWrite && (MEM_reg_write_addr != 5'd31) && (MEM_reg_write_addr == ID_rs))
        rd_srcA = 2'b01;
    else
        rd_srcA = 2'b00;

    if (EX_RegWrite && (EX_reg_write_addr != 5'd31) && (EX_reg_write_addr == ID_rt))
        rd_srcB = 2'b10;
    else if (MEM_RegWrite && (MEM_reg_write_addr != 5'd31) && (MEM_reg_write_addr == ID_rt))
        rd_srcB = 2'b01;
    else
        rd_srcB = 2'b00;
           
end

endmodule
