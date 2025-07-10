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


module ID_EX(
    input wire clk,
    input wire [1:0]WB, [3:0]M, [3:0]EX,
    input wire [31:0] pcplus4,
    input wire [7:0] read_data1,
                     read_data2,
    input wire [31:0] imm32, //instruction[15:0] ext to 32
    input wire [4:0] rt, //instruction[20:16]
                     rd, //instruction[15:11]
            
            
    output wire [1:0]WB_out, [3:0]M_out, [3:0]EX_out,
    output wire [31:0] pcplus4_out,
    output wire [7:0] read_data1_out,
                      read_data2_out,
    output wire [31:0] imm32_out,
    output wire [4:0] rt_out,
                      rd_out
    );
    parameter ALUSrc = 0, //EX Control Signals
              ALUOp_0 = 1,
              ALUOp_1 = 2,
              RegDst = 3;
    parameter MemWrite = 0, //M Control Singals
              MemRead = 1,
              BranchFlip = 2,
              Branch = 3;
    parameter RegWrite = 0, //WB Control Signals
              MemtoReg = 1;
         
    // Internal pipeline registers    
    reg [1:0] WB_reg = 0;
    reg [3:0] M_reg = 0, EX_reg = 0;
    reg [31:0] pcplus4_reg = 0, imm32_reg = 0;
    reg [7:0] read_data1_reg = 0, read_data2_reg = 0;
    reg [4:0] rt_reg = 0, rd_reg = 0;
    
    // Latching on rising edge of clock
    always @(posedge clk) begin
        WB_reg <= WB;
        M_reg <= M;
        EX_reg <= EX;
        pcplus4_reg <= pcplus4;
        read_data1_reg <= read_data1;
        read_data2_reg <= read_data2;
        imm32_reg <= imm32;
        rt_reg <= rt;
        rd_reg <= rd;
    end
    
    // Assign outputs from internal regs
    assign WB_out = WB_reg;
    assign M_out = M_reg;
    assign EX_out = EX_reg;
    assign pcplus4_out = pcplus4_reg;
    assign read_data1_out = read_data1_reg;
    assign read_data2_out = read_data2_reg;
    assign imm32_out = imm32_reg;
    assign rt_out = rt_reg;
    assign rd_out = rd_reg;
    
endmodule
