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

//_IDEX/_IFID, etc mean output from those pipeline registers
module SC_Microprocessor(clk, reset, enable);

input clk, reset, enable;


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
              
              
wire [31:0] instruction, 
            pc, 
            pcplus4, 
            next_pc, 
            jump_addr, 
            branch_addr;
            
            
wire [7:0] read_data1, 
           read_data2, 
           ALUOut, 
           mem_out, 
           write_data,
           inb;
           
wire [4:0] rd;
           
wire  Jump, pcsrc; 
     
     
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

wire [31:0] pcplus4_IFID,
            instruction_IFID;
            
IF_ID IFIDReg (.clk(clk),
               .pcplus4(pcplus4),
               .instruction(instruction),
               .pcplus4_out(pcplus4_IFID),
               .instruction_out(instruction_IFID));
                                   
RegisterFile RegFile (.rs(instruction_IFID[25:21]),
                      .rt(instruction_IFID[20:16]),
                      .rd(rd_MEMWB),
                      .write_data(write_data),
                      .RegWrite(WB_MEMWB[RegWrite]),
                      .clk(clk),
                      .read_data1(read_data1),
                      .read_data2(read_data2));
                      
wire [1:0] WB; 
wire [3:0] M, 
           EX;
                     



Control_Unit ControlUnit (.opcode(instruction[31:26]),
                          .RegDst(EX[RegDst]),
                          .Jump(Jump),
                          .Branch(M[Branch]),
                          .MemRead(M[MemRead]),
                          .MemtoReg(WB[MemtoReg]),
                          .ALUOp(EX[2:1]),//ALUOp
                          .MemWrite(M[MemWrite]),
                          .ALUSrc(EX[ALUSrc]),
                          .RegWrite(WB[RegWrite]),
                          .BranchFlip(M[BranchFlip]));
                
assign imm32 = {{16{instruction_IFID[15]}}, instruction_IFID[15:0]}; //sign extend imm

wire [31:0] imm32_IDEX,
            pcplus4_IDEX;
wire [7:0] read_data1_IDEX,
            read_data2_IDEX;
wire [1:0] WB_IDEX; 
wire [3:0] M_IDEX, 
           EX_IDEX;
wire [4:0] rt_IDEX,
           rd_IDEX;           
                                    
ID_EX IDEXReg (.clk(clk),
               .WB(WB),
               .EX(EX),
               .M(M),
               .pcplus4(pcplus4_IFID),
               .read_data1(read_data1),
               .read_data2(read_data2),
               .imm32(imm32),
               .rt(instruction_IFID[20:16]),
               .rd(instruction_IFID[15:11]),
               .WB_out(WB_IDEX),
               .M_out(M_IDEX),
               .EX_out(EX_IDEX),
               .pcplus4_out(pcplus4_IDEX),
               .read_data1_out(read_data1_IDEX),
               .read_data2_out(read_data2_IDEX),
               .imm32_out(imm32_IDEX),
               .rt_out(rt_IDEX),
               .rd_out(rd_IDEX)
               
);  
  
assign inb = (EX_IDEX[ALUSrc]) ? imm32_IDEX[7:0] : read_data2_IDEX;
    
                          
ALU_Control ALUControl (.func(imm32_IDEX[5:0]),
                        .ALUOp(EX_IDEX[2:1]),
                        .operation(operation));
                        
ALU ALU_Module (.ina(read_data1_IDEX),
                .inb(inb),
                .shamt(imm32_IDEX[10:6]),
                .cr(carry),
                .ov(overflow),
                .ng(negative),
                .zr(zero),
                .operation(operation),
                .out(ALUOut));
                
assign rd = (EX_IDEX[RegDst]) ? imm32_IDEX[15:11] : imm32_IDEX[20:16];


wire [1:0] WB_EXMEM;
wire [3:0] M_EXMEM;
wire [31:0] branch_addr_EXMEM;
wire zero_EXMEM;
wire [7:0] ALUOut_EXMEM, read_data2_EXMEM;
wire [4:0] rd_EXMEM;

assign branch_addr = pcplus4_IDEX + {imm32_IDEX[29:0], 2'b00};

EX_MEM EXMEMReg (
    .clk(clk),
    .WB(WB_IDEX),
    .M(M_IDEX),
    .branch_addr(branch_addr),
    .zero(zero),
    .ALUOut(ALUOut),
    .read_data2(read_data2_IDEX),
    .rd(rd),
    .WB_out(WB_EXMEM),
    .M_out(M_EXMEM),
    .branch_addr_out(branch_addr_EXMEM),
    .zero_out(zero_EXMEM),
    .ALUOut_out(ALUOut_EXMEM),
    .read_data2_out(read_data2_EXMEM),
    .rd_out(rd_EXMEM)
);


assign pcsrc = (zero_EXMEM ^ M_EXMEM[BranchFlip]) & M_EXMEM[Branch];
assign next_pc = (pcsrc) ? branch_addr_EXMEM : pcplus4;

ram_256B RAM (.clk(clk),
              .addr(ALUOut_EXMEM),
              .wdata(read_data2_EXMEM),
              .MemRead(M_EXMEM[MemRead]),
              .MemWrite(M_EXMEM[MemWrite]),
              .out(mem_out));

wire [1:0] WB_MEMWB;
wire [7:0] mem_out_MEMWB, ALUOut_MEMWB;
wire [4:0] rd_MEMWB;

MEM_WB MEMWBReg (
    .clk(clk),
    .WB(WB_EXMEM),
    .mem_out(mem_out),
    .ALUOut(ALUOut_EXMEM),
    .rd(rd_EXMEM),
    .WB_out(WB_MEMWB),
    .mem_out_out(mem_out_MEMWB),
    .ALUOut_out(ALUOut_MEMWB),
    .rd_out(rd_MEMWB)
);


assign write_data = (WB_MEMWB[MemtoReg]) ? mem_out_MEMWB : ALUOut_MEMWB;


//assign next_pc = (Jump) ? jump_addr : pcsrc;




endmodule
