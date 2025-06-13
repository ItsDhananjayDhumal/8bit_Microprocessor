`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 16:59:36
// Design Name: 
// Module Name: CLA_testbench
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

look_ahead_adder DUT (ina, inb, inc, out, outc);

    initial begin
        $monitor($time, "ina = %d, inb = %d, inc = %d, out = %d, outc = %d", ina, inb, inc, out, outc);
        
        #5 ina = 8'd10; inb = 8'd15; inc = 1'b0;
        #5 ina = 8'd210; inb = 8'd199; inc = 1'b0;
        #5 inc = 1'b1;
        #5 $finish;
    end
    
endmodule
