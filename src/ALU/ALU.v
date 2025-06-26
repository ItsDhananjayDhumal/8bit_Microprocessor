`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2025 16:03:23
// Design Name: 
// Module Name: ALU
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


module ALU(ina, inb, operation, shamt, cr, ov, ng, zr, out);
input [7:0] ina, inb;
input [4:0] shamt;
input [3:0] operation;

output reg [7:0] out;
output cr, ov, zr, ng;

parameter ADD = 4'b0010,    //Add
          SUB = 4'b0110,    //Subtract
          AND = 4'b0000,    //AND
          OR = 4'b0001,     //OR
          NOT = 4'b1111,    //NOT
          SLT = 4'b0111,    //Set on Less Than
          LS = 4'b0011,     //Left Shift
          URS = 4'b0101,    //Unsigned Right Shift
          SRS = 4'b0100,    //Signed Right Shift
          RRO = 4'b1000,    //Right Rotate
          LRO = 4'b1001;    //Left Rotate

wire [7:0] LeftShift, 
           SignedRightShift, 
           UnsignedRightShift,
           RotateRight,
           RotateLeft,
           AndOut,
           OrOut,
           NotOut,
           AdderOut,
           SLTOut;
           
wire       adder_cout,
           adder_carry,
           adder_overflow;
           
reg SubControl; 

// Instantiation of modules

ALU_Adder Adder_Module (.a(ina),
                        .b(inb),
                        .cin(SubControl),
                        .out(AdderOut),
                        .cout(adder_cout),
                        .carry(adder_carry),
                        .overflow(adder_overflow));
                 
left_shift LS_Module (.in(ina),
                      .shamt(shamt),
                      .out(LeftShift));
                              
signed_right_shift SRS_Module (.in(ina),
                               .shamt(shamt),
                               .out(SignedRightShift));
                               
unsigned_right_shift URS_Module (.in(ina),
                                 .shamt(shamt),
                                 .out(UnsignedRightShift));
                                 
rotate_right RRO_Module (.in(ina),
                         .shamt(shamt),
                         .out(RotateRight));
                         
rotate_left LRO_Module (.in(ina),
                        .shamt(shamt),
                        .out(RotateLeft));
                        
assign AndOut = ina & inb;

assign OrOut = ina | inb;

assign NotOut = ~(ina);

assign SLTOut = (ina < inb) ? 8'b00000000 : 8'b00000001;

// setting output based on operation

always @(*) begin
    if (operation == ADD) begin
        SubControl = 1'b0;
        out = AdderOut;
    end
    else if (operation == SUB) begin
        SubControl = 1'b1;
        out = AdderOut;
    end
    else if (operation == AND)
        out = AndOut;
    else if (operation == OR)
        out = OrOut;
    else if (operation == LS)
        out = LeftShift;
    else if (operation == SRS)
        out = SignedRightShift;
    else if (operation == URS)
        out = UnsignedRightShift;
    else if (operation == RRO)
        out = RotateRight;
    else if (operation == LRO)
        out = RotateLeft;
    else if (operation == SLT)
        out = SLTOut;
    else if (operation == NOT)
        out = NotOut;
end

// the flags

assign cr = (operation == ADD || operation == SUB) ? adder_carry : 1'b0;
assign ov = (operation == ADD || operation == SUB) ? adder_overflow : 1'b0;
assign zr = ~|(out);
assign ng = out[7];

endmodule
