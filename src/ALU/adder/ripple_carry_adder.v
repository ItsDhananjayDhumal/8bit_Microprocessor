`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 12:01:05
// Design Name: 
// Module Name: ripple_carry_adder
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


module ripple_carry_adder(a, b, cin, out, cout);
input [7:0] a, b;
input cin;
output [7:0] out;
output cout;

wire [7:0] carries;

genvar i;

f_adder adder0 (a[0], b[0] ^ cin, cin, out[0], carries[0]); 
    generate
        for (i = 1; i < 8; i = i + 1) begin
            f_adder adder1 (.a(a[i]), .b(b[i] ^ cin), .cin(carries[i-1]), .sum(out[i]), .carry(carries[i]));
        end
    endgenerate
assign cout = carries[7];

endmodule

module f_adder (a, b, cin, sum, carry);
input a, b, cin;
output sum, carry;

assign sum = a ^ b ^ cin;
assign carry = (a & b)|(b & cin)|(cin & a);

endmodule
