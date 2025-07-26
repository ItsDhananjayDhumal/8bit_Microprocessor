`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2025 14:55:40
// Design Name: 
// Module Name: IFID
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


module IFID(IF_instruction, IF_pcplus4, ID_instruction, ID_pcplus4, clk, IFID_write, reset, IFID_flush);

input clk, reset;
input wire IFID_write, IFID_flush;
input [31:0] IF_instruction, IF_pcplus4;
output reg [31:0] ID_instruction, ID_pcplus4;

always @(posedge clk) begin
    if (~reset) begin
        if (IFID_flush == 1'b1) begin
            ID_instruction <= 32'b11111100000000000000000000000000;
        end
        else begin
            if (IFID_write) begin
                ID_instruction <= IF_instruction;
                ID_pcplus4 <= IF_pcplus4;    
            end
        end
    end
    else begin
        ID_instruction <= 0;
        ID_pcplus4 <= 0;  
    end
end    

endmodule
