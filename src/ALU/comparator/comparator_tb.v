`timescale 10ns / 1ps

module comparator_tb;
    reg[7:0] A;
    reg[7:0] B;
    reg sign;
    wire eq;
    wire lt;
    wire gt;
    
    comparator cmp(A, B, sign, eq, lt, gt);
    
    initial begin
       $monitor($time, "A=%h, S=%h, eq=%b, lt=%b, gt=%b", A, B, eq, lt, gt);
       
       A = 8'b00010000; B = 8'b00010000; sign = 0;
       #5 A = 8'b10011100; B = 8'b10010111; sign = 0;
       #5 A = 8'b11000001; B = 8'b11000010; sign = 0;
       
       #5 A = 8'b11100010; B = 8'b11100010; sign = 1; // -30 == -30 ? eq=1
       #5 A = 8'b11100001; B = 8'b11100010; sign = 1; // -31 < -30 ? lt=1
       #5 A = 8'b10001000; B = 8'b00011110; sign = 1; // -120 < 30 ? lt=1
       #5 A = 8'b00011110; B = 8'b10001000; sign = 1; // 30 > -120 ? gt=1
       #5 A = 8'b01111111; B = 8'b10000000; sign = 1; // 127 > -128 ? gt=1
       #5 A = 8'b10000000; B = 8'b01111111; sign = 1; // -128 < 127 ? lt=1
       #5 $finish;
    end
endmodule