`timescale 10ns/1ps

module ALU (
    input wire[7:0] A,
    input wire[7:0] B,
    input wire[2:0] operation,
    input wire sign,
    input wire[2:0] logic,
    output reg[7:0] out,
    output wire zero,
    output wire carry,
    output wire negative,
);

endmodule