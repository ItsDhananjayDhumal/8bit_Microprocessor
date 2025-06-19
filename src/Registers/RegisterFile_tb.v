`timescale 10ns / 1ps

module RegisterFile_tb;
    reg [2:0] reg_addr1;
    reg [2:0] reg_addr2;
    reg [2:0] write_addr;
    reg [7:0] write_data;
    reg write_enable;
    reg clk;
    wire [7:0] out_1;
    wire [7:0] out_2;

    RegisterFile dut (
        .reg_addr1(reg_addr1),
        .reg_addr2(reg_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_enable(write_enable),
        .clk(clk),
        .out_1(out_1),
        .out_2(out_2)
    );

    initial clk = 1;
    always #1 clk = ~clk; // 20ns period

    initial begin
        $display("Time | WriteEn | WriteAddr | Data  | Read1Addr | Read2Addr | Out1 | Out2");
        $display("-------------------------------------------------------------------------");

        write_enable = 0;
        reg_addr1 = 0;
        reg_addr2 = 1;
        write_addr = 0;
        write_data = 8'h00;

        #2;

        // Write 0xAA to register A (addr 0)
        write_enable = 1;
        write_addr = 3'b000;
        write_data = 8'hAA;

        #2; // wait 1 clock

        // Write 0x55 to register X (addr 1)
        write_addr = 3'b001;
        write_data = 8'h55;

        #2;

        // Disable writing
        write_enable = 0;

        // Read from A and X
        reg_addr1 = 3'b000;
        reg_addr2 = 3'b001;
        #2;
        $display("%4t |   %b     |    %d      |  %h  |     %d     |     %d     |  %h | %h", 
                 $time, write_enable, write_addr, write_data, reg_addr1, reg_addr2, out_1, out_2);

        // Read from Y and Z (should be 0)
        reg_addr1 = 3'b010;
        reg_addr2 = 3'b011;
        #2;
        $display("%4t |   %b     |    %d      |  %h  |     %d     |     %d     |  %h | %h", 
                 $time, write_enable, write_addr, write_data, reg_addr1, reg_addr2, out_1, out_2);

        // Write 0x0F to SP (addr 4)
        write_enable = 1;
        write_addr = 3'b100;
        write_data = 8'h0F;
        #2;

        write_enable = 0;
        reg_addr1 = 3'b100;
        reg_addr2 = 3'b000;
        #2;
        $display("%4t |   %b     |    %d      |  %h  |     %d     |     %d     |  %h | %h", 
                 $time, write_enable, write_addr, write_data, reg_addr1, reg_addr2, out_1, out_2);

        $finish;
    end
endmodule
