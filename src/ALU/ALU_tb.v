`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2025 18:33:23
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb_rtype();

reg [7:0] ina, inb;
reg [4:0] shamt;
reg [1:0] ALUOp;
reg [5:0] func;

wire [3:0] operation;
wire [7:0] out;
wire cr, zr, ng, ov;

ALU ALU_Module (.ina(ina),
                .inb(inb),
                .operation(operation),
                .shamt(shamt),
                .cr(cr),
                .zr(zr),
                .ng(ng),
                .ov(ov),
                .out(out));
ALU_Control Control_Module(.ALUOp(ALUOp),
                           .func(func),
                           .operation(operation));
// R TYPE:

// add
// sub
// and
// or
// not
// left shift
// unsigned right shift
// signed rignt shift
// rotate right
// rotate left
// strictly less than

initial begin

// add
#10 ina = 8'b11100000; inb = 8'b01000000; shamt = 5'd2; ALUOp = 2'b00; func = 6'b000010;


// sub
#10 ina = 8'b10001000; inb = 8'b11000000; shamt = 5'd3; ALUOp = 2'b01; func = 6'b000000;

// and
#10 ina = 8'b11110000; inb = 8'b01100010; shamt = 5'd4; ALUOp = 2'b10; func = 6'b000100;

// or
#10 ina = 8'b01100000; inb = 8'b00000110; shamt = 5'd9; ALUOp = 2'b10; func = 6'b000101;

// not
#10 ina = 8'b11110000; inb = 8'b00000000; shamt = 5'd5; ALUOp = 2'b10; func = 6'b000001; 

// not (with different inb)
#10 ina = 8'b11110000; inb = 8'b11001100; shamt = 5'd5; ALUOp = 2'b10; func = 6'b000001;

// left shift (without shamt)
#10 ina = 8'b00001111; inb = 8'b00000000; shamt = 5'd0; ALUOp = 2'b10; func = 6'b111101;

// left shift (with shamt)
#10 ina = 8'b00001111; inb = 8'b00000000; shamt = 5'd2; ALUOp = 2'b10; func = 6'b111101;

// unsigned right shift
#10 ina = 8'b10001000; inb = 8'b00000000; shamt = 5'd3; ALUOp = 2'b10; func = 6'b111001;

// signed right shift
#10 ina = 8'b10001000; inb = 8'b00000000; shamt = 5'd2; ALUOp = 2'b10; func = 6'b111010;

// rotate right
#10 ina = 8'b00000001; inb = 8'b00000000; shamt = 5'd4; ALUOp = 2'b10; func = 6'b111011;

// rotate left
#10 ina = 8'b00000001; inb = 8'b00000000; shamt = 5'd3; ALUOp = 2'b10; func = 6'b111110;

// strictly less than
#10 ina = 8'b10010010; inb = 8'b10010101; shamt = 5'd3; ALUOp = 2'b10; func = 6'b001010;

// strictly less than (again to be sure)
#10 ina = 8'b00101101; inb = 8'b00101100; shamt = 5'd5; ALUOp = 2'b10; func = 6'b001010;

#10 $finish;

end

endmodule
