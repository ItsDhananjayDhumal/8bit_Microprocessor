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


module MEM_WB(
    input wire clk,
    input wire [1:0] WB,
    input wire [7:0] mem_out,
                     ALUOut,
    input wire [4:0] rd, //register to write in(rt/rd)
    output wire [1:0] WB_out,
    output wire [7:0] mem_out_out,
                     ALUOut_out,
    output wire [4:0] rd_out
    );
    parameter RegWrite = 0, //WB Control Signals
              MemtoReg = 1;
              
    // Internal pipeline registers
    reg [1:0] WB_reg = 0;
    reg [7:0] mem_out_reg = 0, ALUOut_reg = 0;
    reg [4:0] rd_reg = 0;
    
    // Clocked update
    always @(posedge clk) begin
        WB_reg <= WB;
        mem_out_reg <= mem_out;
        ALUOut_reg <= ALUOut;
        rd_reg <= rd;
    end
    
    // Continuous assignments
    assign WB_out = WB_reg;
    assign mem_out_out = mem_out_reg;
    assign ALUOut_out = ALUOut_reg;
    assign rd_out = rd_reg;
    
endmodule
