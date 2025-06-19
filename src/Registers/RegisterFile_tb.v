`timescale 1ns / 1ps

module Regisger_tb;
    reg clk;
    reg write_enable;
    reg [4:0] rs, rt, rd;
    reg [7:0] write_data;

    wire [7:0] read_data1;
    wire [7:0] read_data2;

    RegisterFile uut (
        .clk(clk),
        .write_enable(write_enable),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%t | rs=%d rd1=%h | rt=%d rd2=%h | rd=%d wd=%h we=%b",
                 $time, rs, read_data1, rt, read_data2, rd, write_data, write_enable);

        write_enable = 0;
        rs = 0; rt = 0; rd = 0; write_data = 0;

        #10;

        write_enable = 1;
        rd = 5;
        write_data = 8'hEF;
        #10;

        write_enable = 0;
        rs = 5;
        rt = 5;
        #10;

        write_enable = 1;
        rd = 0;
        write_data = 8'hFF;
        #10;

        write_enable = 0;
        rs = 0;
        rt = 0;
        #10;

        $finish;
    end

endmodule
