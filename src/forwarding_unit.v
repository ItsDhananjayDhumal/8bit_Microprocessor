`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 13:26:56
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


module forwarding_unit(
    input [4:0] EX_rs, EX_rt,
    input [4:0] MEM_rd, WB_rd,
    input MEM_RegWrite, WB_RegWrite,
    output reg [1:0] ForwardA, ForwardB
);

always @(*) begin

    // EX hazard
    if (MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rs))
        ForwardA = 2'b10;
    // MEM hazard (only if no EX hazard)
    else if (WB_RegWrite && (WB_rd != 5'd31) && !(MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rs)) && (WB_rd == EX_rs))
        ForwardA = 2'b01;
    else
        ForwardA = 2'b00;

    if (WB_RegWrite && (WB_rd != 5'd31) && !(MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rt)) && (WB_rd == EX_rt))
        ForwardB = 2'b01;    
    else if (MEM_RegWrite && (MEM_rd != 5'd31) && (MEM_rd == EX_rt))
        ForwardB = 2'b10;    
    else
        ForwardB = 2'b00; 
           
end

endmodule
