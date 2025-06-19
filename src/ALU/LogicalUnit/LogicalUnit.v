`timescale 10ns / 10ns

module LogicalUnit(
    input wire[7:0] in1,
    input wire[7:0] in2,
    input wire [2:0] sel,
    output reg[7:0] out
);
    wire[7:0] a;
    wire[7:0] b;
    wire[7:0] c;
    wire[7:0] d;
    wire[7:0] e;
    wire[7:0] f;
    wire[7:0] g;

    assign a = in1 & in2;
    assign b = in1 | in2;
    assign c = ~in1;
    assign d = ~(in1 & in2);
    assign e = ~(in1 | in2);
    assign f = in1 ^ in2;
    assign g = in1 ~^ in2;
    
    always @(*) begin
        case(sel)
            0: out = a;
            1: out = b;
            2: out = c;
            3: out = d;
            4: out = e;
            5: out = f;
            6: out = g;
            7: out = 0;
        endcase
    end
endmodule
