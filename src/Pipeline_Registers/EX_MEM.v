`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2025 16:16:16
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    input wire clk,
    input wire [1:0]WB, [3:0]M,
    input wire [31:0] branch_addr,
    input wire zero,
    input wire [7:0] ALUOut,
                     read_data2, //to provide value to write in load instruction
    input wire [4:0] rd, //register to write in(rt/rd)
    
    output wire [1:0]WB_out, [3:0]M_out,
    output wire [31:0] branch_addr_out,
    output wire zero_out,
    output wire [7:0] ALUOut_out,
                     read_data2_out,
    output wire [4:0] rd_out //register to write in(rt/rd)
    );
    parameter MemWrite = 0, //M Control Singals
              MemRead = 1,
              BranchFlip = 2,
              Branch = 3;
    parameter RegWrite = 0, //WB Control Signals
              MemtoReg = 1;
              
    // Internal pipeline registers
    reg [1:0] WB_reg = 0;
    reg [3:0] M_reg = 0;
    reg [31:0] branch_addr_reg = 0;
    reg zero_reg = 0;
    reg [7:0] ALUOut_reg = 0;
    reg [7:0] read_data2_reg = 0;
    reg [4:0] rd_reg = 0;
    
    // Latching on rising edge of clock
    always @(posedge clk) begin
        WB_reg <= WB;
        M_reg <= M;
        branch_addr_reg <= branch_addr;
        zero_reg <= zero;
        ALUOut_reg <= ALUOut;
        read_data2_reg <= read_data2;
        rd_reg <= rd;
    end
    
    // Assign outputs from internal regs
    assign WB_out = WB_reg;
    assign M_out = M_reg;
    assign branch_addr_out = branch_addr_reg;
    assign zero_out = zero_reg;
    assign ALUOut_out = ALUOut_reg;
    assign read_data2_out = read_data2_reg;
    assign rd_out = rd_reg;
              
endmodule
