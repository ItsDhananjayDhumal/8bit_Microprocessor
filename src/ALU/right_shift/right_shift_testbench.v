`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 18:07:46
// Design Name: 
// Module Name: right_shift_testbench
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


module right_shift_testbench();
reg [7:0] in;
wire [7:0] sgn, un_sgn;

signed_right_shift DUT1 (.in(in), .out(sgn));
unsigned_right_shift DUT2 (.in(in), .out(un_sgn));

initial begin
    $monitor ($time, "in=%b, signed=%b, unsigned=%b", in, sgn, un_sgn);
        #5 in = 8'b11001010;
        #5 in = 8'b00001111;
        #5 $finish;
    end

endmodule
