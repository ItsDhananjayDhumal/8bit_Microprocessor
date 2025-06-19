`timescale 10ns / 10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2025 14:44:09
// Design Name: 
// Module Name: LogicalUnit_tb
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


module LogicalUnit_tb;
    reg[7:0] a;
    reg[7:0] b;
    reg[2:0] sel;
    wire[7:0] out;
    
    LogicalUnit lu(a, b, sel, out);
    
    initial begin
       $monitor($time, "A=%b, B=%b, sel=%b, out=%b", a, b, sel, out);
       
       a = 8'b00110101;
       b = 8'b10101010;
       sel = 0;
       
       #5 sel = 0;
       #5 sel = 1;
       #5 sel = 2;
       #5 sel = 3;
       #5 sel = 4;
       #5 sel = 5;
       #5 sel = 6;
       #5 sel = 7;
       #5 $finish;
    end
endmodule
