`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 17:59:53
// Design Name: 
// Module Name: left_shift_testbench
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


module left_shift_testbench();
reg [7:0] in;
wire [7:0] out;

left_shift DUT (.in(in), .out(out));

initial begin
    $monitor ($time, "in=%b, out=%b", in, out);
        #5 in = 8'b11001010;
        #5 in = 8'b00001111;
        #5 $finish;
    end

endmodule
