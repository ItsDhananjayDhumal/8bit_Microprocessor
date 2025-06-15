`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 12:26:34
// Design Name: 
// Module Name: rca_tb
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


module rca_tb;
reg [7:0] ina, inb;
reg inc;
wire outc;
wire [7:0] out;

ripple_carry_adder DUT (ina, inb, inc, out, outc);

    initial begin
        $monitor($time, "ina = %b, inb = %b, inc = %b, out = %b, outc = %b", ina, inb, inc, out, outc);
        
        #5 ina = 8'd10; inb = 8'd15; inc = 1'b0;
        #5 ina = 8'd120; inb = 8'd111; inc = 1'b0;
        #5 inc = 1'b1;
        #5 $finish;
    end
    
endmodule
