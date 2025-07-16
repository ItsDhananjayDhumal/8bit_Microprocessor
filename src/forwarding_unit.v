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
    input [31:0] EX_rs, EX_rt,
    input [31:0] MEM_rd, WB_rd,
    input MEM_RegWrite, WB_RegWrite,
    output reg [1:0] ForwardA, ForwardB
);

always @(*) begin
    // Default
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    // EX hazard
    if (MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rs))
        ForwardA = 2'b10;
    if (MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rt))
        ForwardB = 2'b10;

    // MEM hazard (only if no EX hazard)
    if (WB_RegWrite && (WB_rd != 5'd31) && 
        !(MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rs)) &&
        (WB_rd == EX_rs))
        ForwardA = 2'b01;

    if (WB_RegWrite && (WB_rd != 5'd31) && 
        !(MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rt)) &&
        (WB_rd == EX_rt))
        ForwardB = 2'b01;
end

endmodule

