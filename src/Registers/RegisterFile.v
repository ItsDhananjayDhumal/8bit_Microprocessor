`timescale 10ns / 1ps

module RegisterFile(
    input wire[2:0] reg_addr1,
    input wire[2:0] reg_addr2,
    input wire[2:0] write_addr,
    input wire[7:0] write_data,
    input wire write_enable,
    input wire clk,
    output reg[7:0] out_1,
    output reg[7:0] out_2
);
    reg[7:0] A;
    reg[7:0] X;
    reg[7:0] Y;
    reg[7:0] Z;
    reg[7:0] SP;
    reg[7:0] FP;

    initial begin
        A = 0;
        X = 0;
        Y = 0;
        Z = 0;
        SP = 0;
        FP = 0;
    end

    always @(*) begin
        case(reg_addr1)
            0: out_1 = A;
            1: out_1 = X;
            2: out_1 = Y;
            3: out_1 = Z;
            4: out_1 = SP;
            5: out_1 = FP;
            default: out_1 = 0;
        endcase

        case(reg_addr2)
            0: out_2 = A;
            1: out_2 = X;
            2: out_2 = Y;
            3: out_2 = Z;
            4: out_2 = SP;
            5: out_2 = FP;
            default: out_2 = 0;
        endcase
    end

    always @(posedge clk) begin
        if (write_enable) begin
        case(write_addr)
            0: A = write_data;
            1: X = write_data;
            2: Y = write_data;
            3: Z = write_data;
            4: SP = write_data;
            5: FP = write_data;
        endcase
        end
    end
endmodule
