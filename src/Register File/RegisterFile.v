`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 18:43:47
// Design Name: 
// Module Name: RegisterFile
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
/////////////////////////////////////////////////////////////////////////////////


module RegisterFile(
    input wire clk,
    input wire RegWrite,
    input wire [4:0] rs,      // Read register 1
    input wire [4:0] rt,      // Read register 2
    input wire [4:0] rd,      // Write register
    input wire [7:0] write_data,
    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);

    reg [7:0] registers [31:0];


    assign read_data1 = (rs == 5'd31) ? 8'd0 : registers[rs];
    assign read_data2 = (rt == 5'd31) ? 8'd0 : registers[rt];

    always @(posedge clk) begin
        if (RegWrite)
            registers[rd] <= write_data;
    end
endmodule

