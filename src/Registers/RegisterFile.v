`timescale 10ns / 1ps

module RegisterFile(
    input wire clk,
    input wire write_enable,
    input wire [4:0] rs,      // Read register 1
    input wire [4:0] rt,      // Read register 2
    input wire [4:0] rd,      // Write register
    input wire [7:0] write_data,
    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);
    reg [7:0] registers [31:0];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 7'b0;
    end

    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];

    always @(posedge clk) begin
        if (write_enable && rd != 5'd0) begin
            registers[rd] <= write_data;
        end
    end
endmodule
