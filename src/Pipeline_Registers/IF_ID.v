`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2025 16:16:16
// Design Name: 
// Module Name: EX_MEM
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


module IF_ID(
    input wire clk,
    input wire [31:0]pcplus4,
                     instruction,
    output wire [31:0]pcplus4_out,
                      instruction_out
    );
    reg [31:0] pcplus4_reg = 0;
    reg [31:0] instruction_reg = 0;
    
    always @(posedge clk) begin
            pcplus4_reg <= pcplus4;
            instruction_reg <= instruction;
    end
    
    assign pcplus4_out = pcplus4_reg;
    assign instruction_out = instruction_reg;

endmodule
