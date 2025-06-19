module ALU_Adder_tb;
reg [7:0] ina, inb;
reg cin;
wire outc, carry, overflow, ng, zr;
wire [7:0] out;

ALU_Adder DUT (ina, inb, cin, out, outc, carry, overflow, ng, zr);

    initial begin
        $monitor($time, "ina = %d, inb = %d, cin = %d, out = %d, crr = %b, over = %b, ng = %b, zr = %b", ina, inb, cin, out, carry, overflow, ng, zr);
        
        #5 ina = 8'b11111111; inb = 8'b00000001; cin = 1'b0;
        #5 ina = 8'b01111111; inb = 8'b00000001; cin = 1'b0;
        #5 ina = 8'b10000000; inb = 8'b11111111; cin = 1'b1;
        #5 ina = 8'b01100000; inb = 8'b01000000; cin = 1'b0;
        #5 ina = 8'b10001000; inb = 8'b11000000; cin = 1'b1;
        #5 ina = 8'b11001100; inb = 8'b11001100; cin = 1'b1;
        #5 $finish;
    end
    
endmodule
