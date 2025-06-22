`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 00:41:31
// Design Name: 
// Module Name: ram64K
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

//8 bit width R/W Byte Addressing (not word addressing)
module ram_256B(
    input       clk,
    input       we, //write enable (0 if read 1 if write)
    input [7:0]addr, //8 bit address
    input  [7:0]wdata, // read data from RAM
    output reg [7:0]rdata  //write data to RAM
    );
    
    reg [7:0]mem [255:0];
    
    always @(posedge clk) begin
        if (we)
            mem[addr] <= wdata;
        else
            rdata <= mem[addr];
    end
    
    
endmodule
