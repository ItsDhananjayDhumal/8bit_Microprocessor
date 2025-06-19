`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2025 21:43:09
// Design Name: 
// Module Name: rotate_testbench
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


module rotate_testbench();
reg [7:0] in;
wire [7:0] out;

rotate_right DUT (.in(in), .out(out));

initial begin
    $monitor ($time, "in=%b, out=%b", in, out);
        #5 in = 8'b11001010;
        #5 in = 8'b00001111;
        #5 $finish;
    end

endmodule
