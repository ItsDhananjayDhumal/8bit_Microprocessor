`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2025 16:17:47
// Design Name: 
// Module Name: branch_prediction_unit
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


module branch_prediction_unit(ID_instruction, ID_pcplus4, ID_read_data1, ID_read_data2, pc_addr, IFID_flush, pcsrc);

input [31:0] ID_instruction, ID_pcplus4;
input [7:0] ID_read_data1, ID_read_data2;

output reg [31:0] pc_addr;
output reg IFID_flush, pcsrc;

wire [31:0] branch_addr;
wire [5:0] opcode;
wire [31:0] jump_addr;

parameter JUMP = 6'b000010,
          BEQ = 6'b000100,
          BNE = 6'b000001,
          BLT = 6'b000011,
          BGE = 6'b000101;

assign jump_addr = {ID_pcplus4[31:28], ID_instruction[25:0], 2'b00}; //jump addr
assign branch_addr = ID_pcplus4 + {{14{ID_instruction[15]}}, ID_instruction[15:0], 2'b00}; // branch addr
assign opcode = ID_instruction[31:26]; 

always @(*) begin

    if (opcode == JUMP) begin
        pc_addr =  jump_addr;
        pcsrc = 1'b1;
        IFID_flush = 1'b1;
    end
    else if (opcode == BEQ && (ID_read_data1 == ID_read_data2)) begin
        pc_addr = branch_addr;
        pcsrc = 1'b1;
        IFID_flush = 1'b1;
    end
    else if (opcode == BNE && (ID_read_data1 != ID_read_data2)) begin
        pc_addr = branch_addr;
        pcsrc = 1'b1;
        IFID_flush = 1'b1;
    end
    else if (opcode == BLT && (ID_read_data1 < ID_read_data2)) begin
        pc_addr = branch_addr;
        pcsrc = 1'b1;
        IFID_flush = 1'b1;
    end
    else if (opcode == BGE && !(ID_read_data1 < ID_read_data2)) begin
        pc_addr = branch_addr;
        pcsrc = 1'b1;
        IFID_flush = 1'b1;
    end
    else begin
        pc_addr = ID_pcplus4;
        pcsrc = 1'b0;
        IFID_flush = 1'b0;
    end
    
end

endmodule
