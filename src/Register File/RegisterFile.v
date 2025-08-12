`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 18:43:47
// Design Name: 
// Module Name: RegisterFile
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


(*dont_touch = "true"*) module RegisterFile(
    input wire reset,
    input wire clk,
    input wire btn0, btn1, btn2, btn3,
    input wire RegWrite,
    input wire [4:0] rs,      // Read register 1
    input wire [4:0] rt,      // Read register 2
    input wire [4:0] rd,      // Write register
    input wire [7:0] write_data,
    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);

    reg [7:0] registers [31:0];


    assign read_data1 = (rs == 5'd31) ? 8'd0 : ((rs == rd) && RegWrite) ? write_data : registers[rs];
    assign read_data2 = (rt == 5'd31) ? 8'd0 : ((rt == rd) && RegWrite) ? write_data : registers[rt];

    always @(posedge clk) begin
        if (RegWrite)
            registers[rd] <= write_data;
        if (reset)
            registers[29] <= 8'b11111111; // stack pointer
            
        registers[0] <= {4'd0, btn0, btn1, btn2, btn3};
    end
    
//    ila_0 inst (.clk(clk),
//                .probe0(registers[0]),
//                .probe1(registers[1]),
//                .probe2(registers[2]),
//                .probe3(registers[3]),
//                .probe4(registers[4]),
//                .probe5(registers[5]),
//                .probe6(registers[6]),
//                .probe7(registers[7]));                                
endmodule

