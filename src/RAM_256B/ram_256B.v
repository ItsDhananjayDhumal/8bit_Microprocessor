`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 18:29:43
// Design Name: 
// Module Name: ram_256B
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


module ram_256B(
    input       clk,
    input       MemWrite,
    input       MemRead,
    input [7:0] addr, //8 bit address
    input [7:0] wdata, // write data to memory
    
    output reg [7:0] out  // output (at given address)
    );
    
reg [7:0]mem [255:0];


always @(posedge clk) begin
    if (MemRead)
        out <= mem[addr];
    else if (MemWrite)
        mem[addr] <= wdata;
end
    
    
endmodule
