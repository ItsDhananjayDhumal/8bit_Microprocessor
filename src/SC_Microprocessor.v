`timescale 10ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2025 17:55:05
// Design Name: 
// Module Name: SC_Microprocessor
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


module SC_Microprocessor(clk, reset, enable);

input clk, reset, enable;

wire [31:0] instruction, 
            pc, 
            pcplus4, 
            next_pc, 
            jump_addr, 
            branch_addr, 
            pcsrc;
            
wire [7:0] read_data1, 
           read_data2, 
           ALUOut, 
           mem_out, 
           write_data,
           inb;
           
wire [4:0] rd;
           
wire RegDst, 
     Jump, 
     Branch, 
     MemRead, 
     MemtoReg, 
     MemWrite, 
     ALUSrc, 
     RegWrite,
     BranchFlip;
     
wire carry,
     overflow,
     negative,
     zero;
     
wire [1:0] ALUOp;

wire [3:0] operation;

ProgramCounter PC (.clk(clk),
                   .reset(reset),
                   .pc_write(enable),
                   .next_pc(next_pc),
                   .pc(pc));
                   
assign pcplus4 = pc + 32'd4;
     
                   
instruction_mem InstructionMemory (.address(pc),
                                   .instruction(instruction));
                                   
RegisterFile RegFile (.rs(instruction[25:21]),
                      .rt(instruction[20:16]),
                      .rd(rd),
                      .write_data(write_data),
                      .RegWrite(RegWrite),
                      .clk(clk),
                      .read_data1(read_data1),
                      .read_data2(read_data2));
                      
assign rd = (RegDst) ? instruction[15:11] : instruction[20:16];
assign write_data = (MemtoReg) ? mem_out : ALUOut;


Control_Unit ControlUnit (.opcode(instruction[31:26]),
                          .RegDst(RegDst),
                          .Jump(Jump),
                          .Branch(Branch),
                          .MemRead(MemRead),
                          .MemtoReg(MemtoReg),
                          .ALUOp(ALUOp),
                          .MemWrite(MemWrite),
                          .ALUSrc(ALUSrc),
                          .RegWrite(RegWrite),
                          .BranchFlip(BranchFlip));
                          
ALU_Control ALUControl (.func(instruction[5:0]),
                        .ALUOp(ALUOp),
                        .operation(operation));
                        
ALU ALU_Module (.ina(read_data1),
                .inb(inb),
                .shamt(instruction[10:6]),
                .cr(carry),
                .ov(overflow),
                .ng(negative),
                .zr(zero),
                .operation(operation),
                .out(ALUOut));
                        
assign inb = (ALUSrc) ? instruction[7:0] : read_data2;

ram_256B RAM (.clk(clk),
              .addr(ALUOut),
              .wdata(read_data2),
              .MemRead(MemRead),
              .MemWrite(MemWrite),
              .out(mem_out));

assign jump_addr = {pcplus4[31:28], instruction[25:0], 2'b00};              
assign branch_addr = pcplus4 + {{14{instruction[15]}}, instruction[15:0], 2'b00};

assign pcsrc = ((zero ^ BranchFlip) & Branch) ? branch_addr : pcplus4;

assign next_pc = (Jump) ? jump_addr : pcsrc;

endmodule
