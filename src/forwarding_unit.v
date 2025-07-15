`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2025 23:34:42
// Design Name: 
// Module Name: forwarding_unit
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


module forward_unit(
    input [31:0] ID_EX_rs, ID_EX_rt,
    input [31:0] EX_MEM_rd, MEM_WB_rd,
    input EX_MEM_RegWrite, MEM_WB_RegWrite,
    output reg [1:0] ForwardA, ForwardB
);

always @(*) begin
    // Default
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    // EX hazard
    if (EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs))
        ForwardA = 2'b10;
    if (EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rt))
        ForwardB = 2'b10;

    // MEM hazard (only if no EX hazard)
    if (MEM_WB_RegWrite && (MEM_WB_rd != 0) && 
        !(EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs)) &&
        (MEM_WB_rd == ID_EX_rs))
        ForwardA = 2'b01;

    if (MEM_WB_RegWrite && (MEM_WB_rd != 0) && 
        !(EX_MEM_RegWrite && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rt)) &&
        (MEM_WB_rd == ID_EX_rt))
        ForwardB = 2'b01;
end

endmodule

