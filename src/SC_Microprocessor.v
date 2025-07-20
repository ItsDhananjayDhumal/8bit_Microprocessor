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

wire [31:0] IF_pcplus4,
            IF_instruction;
            
wire [31:0] ID_instruction,
            ID_pcplus4;

wire [31:0] EX_instruction,
            EX_pcplus4,
            EX_branch_addr,
            EX_jump_addr;
wire [4:0]  EX_reg_write_addr;

wire [7:0] MEM_aluout,
           MEM_read_data2,
           MEM_mem_data;
wire [4:0] MEM_reg_write_addr;

wire [7:0] WB_mem_data,
           WB_aluout;
wire [4:0] WB_reg_write_addr;

wire [31:0] next_pc,
            pc;
wire [7:0] write_data,
           ina,
           alu_b_src;
           
wire [4:0] EX_rs, EX_rt,
           ID_rs, ID_rt;

wire [1:0] ForwardA, ForwardB;

wire [7:0] ID_read_data1, ID_read_data2, EX_read_data1, EX_read_data2, EX_aluout;

wire EX_cr, EX_ng, EX_ov, EX_zr,
     MEM_cr, MEM_ng, MEM_ov, MEM_zr;

wire [1:0] ID_ALUOp, 
           EX_ALUOp;
            
wire ID_ALUSrc, 
     ID_RegDst, 
     EX_ALUSrc, 
     EX_RegDst, 
     ID_Branch, 
     ID_BranchFlip, 
     ID_MemRead, 
     ID_MemWrite, 
     ID_Jump, 
     EX_Branch, 
     EX_BranchFlip, 
     EX_MemRead, 
     EX_MemWrite, 
     EX_Jump, 
     ID_RegWrite, 
     ID_MemtoReg, 
     EX_RegWrite, 
     EX_MemtoReg;

wire MEM_Branch, MEM_BranchFlip, MEM_MemRead, MEM_MemWrite, MEM_Jump, MEM_RegWrite, MEM_MemtoReg;

wire WB_RegWrite, WB_MemtoReg;

wire [7:0] inb;
wire [3:0] operation;


ProgramCounter PC (.clk(clk),
                   .reset(reset),
                   .pc_write(enable),
                   .next_pc(next_pc),
                   .pc(pc));
                 
assign IF_pcplus4 = pc + 32'd4;      

instruction_mem InstructionMemory (.address(pc),
                                   .instruction(IF_instruction));
                                                                      
IFID IFID_reg (.IF_instruction(IF_instruction),
               .IF_pcplus4(IF_pcplus4),
               .ID_instruction(ID_instruction),
               .ID_pcplus4(ID_pcplus4),
               .IFID_write(IFID_write),
               .clk(clk));
                          
RegisterFile RegFile (.rs(ID_instruction[25:21]),
                      .rt(ID_instruction[20:16]),
                      .rd(WB_reg_write_addr),
                      .write_data(write_data),
                      .RegWrite(WB_RegWrite),
                      .clk(clk),
                      .read_data1(ID_read_data1),
                      .read_data2(ID_read_data2));

assign write_data = (WB_MemtoReg) ? WB_mem_data : WB_aluout;

Control_Unit ControlUnit (.opcode(ID_instruction[31:26]),
                          .RegDst(temp_RegDst),
                          .Jump(temp_Jump),
                          .Branch(temp_Branch),
                          .MemRead(temp_MemRead),
                          .MemtoReg(temp_MemtoReg),
                          .ALUOp(temp_ALUOp),
                          .MemWrite(temp_MemWrite),
                          .ALUSrc(temp_ALUSrc),
                          .RegWrite(temp_RegWrite),
                          .BranchFlip(temp_BranchFlip));    

assign ID_rs = ID_instruction[25:21];
assign ID_rt = ID_instruction[20:16];
 
hazard_detection_unit HDU(.EX_MemRead(EX_MemRead),
                           .EX_rt(EX_rt),
                           .ID_rs(ID_rs),
                           .ID_rt(ID_rt),
                           .pc_write(enable),
                           .IFID_write(IFID_write),
                           .nop_control(nop_control));
    
//assign { ID_RegDst, ID_Jump, ID_Branch, ID_MemRead, ID_MemtoReg, ID_ALUOp, ID_MemWrite, ID_ALUSrc, ID_RegWrite, ID_BranchFlip } = (nop_control ? 11'b0 : { temp_RegDst, temp_Jump, temp_Branch, temp_MemRead, temp_MemtoReg, temp_ALUOp, temp_MemWrite, temp_ALUSrc, temp_RegWrite, temp_BranchFlip }) ;
assign ID_RegDst     = nop_control ? 1'b0 : temp_RegDst;
assign ID_Jump       = nop_control ? 1'b0 : temp_Jump;
assign ID_Branch     = nop_control ? 1'b0 : temp_Branch;
assign ID_MemRead    = nop_control ? 1'b0 : temp_MemRead;
assign ID_MemtoReg   = nop_control ? 1'b0 : temp_MemtoReg;
assign ID_ALUOp      = nop_control ? 2'b00 : temp_ALUOp;
assign ID_MemWrite   = nop_control ? 1'b0 : temp_MemWrite;
assign ID_ALUSrc     = nop_control ? 1'b0 : temp_ALUSrc;
assign ID_RegWrite   = nop_control ? 1'b0 : temp_RegWrite;
assign ID_BranchFlip = nop_control ? 1'b0 : temp_BranchFlip;
                                          
IDEX IDEX_reg (.clk(clk),
               .ID_read_data1(ID_read_data1),
               .ID_read_data2(ID_read_data2),
               .EX_read_data1(EX_read_data1),
               .EX_read_data2(EX_read_data2),
               .ID_instruction(ID_instruction),
               .ID_pcplus4(ID_pcplus4),
               .EX_instruction(EX_instruction),
               .EX_pcplus4(EX_pcplus4),
               .ID_ALUOp(ID_ALUOp),
               .EX_ALUOp(EX_ALUOp),
               .ID_ALUSrc(ID_ALUSrc),
               .ID_RegDst(ID_RegDst),
               .EX_ALUSrc(EX_ALUSrc),
               .EX_RegDst(EX_RegDst),
               .ID_Branch(ID_Branch),
               .ID_BranchFlip(ID_BranchFlip),
               .ID_MemRead(ID_MemRead),
               .ID_MemWrite(ID_MemWrite),
               .ID_Jump(ID_Jump),
               .EX_Branch(EX_Branch),
               .EX_BranchFlip(EX_BranchFlip),
               .EX_MemRead(EX_MemRead),
               .EX_MemWrite(EX_MemWrite),
               .EX_Jump(EX_Jump),
               .ID_RegWrite(ID_RegWrite),
               .ID_MemtoReg(ID_MemtoReg),
               .EX_RegWrite(EX_RegWrite),
               .EX_MemtoReg(EX_MemtoReg));                      
                      
ALU_Control ALUControl (.func(EX_instruction[5:0]),
                        .ALUOp(EX_ALUOp),
                        .operation(operation));
                   
ALU ALU_Module (.ina(ina),
                .inb(inb),
                .shamt(EX_instruction[10:6]),
                .cr(EX_cr),
                .ov(EX_ov),
                .ng(EX_ng),
                .zr(EX_zr),
                .operation(operation),
                .out(EX_aluout));
                
assign ina = (ForwardA == 2'b01) ? write_data :
             (ForwardA == 2'b10) ? MEM_aluout : EX_read_data1;
assign alu_b_src = (ForwardB == 2'b01) ? write_data :
                   (ForwardB == 2'b10) ? MEM_aluout : EX_read_data2;                        
assign inb = (EX_ALUSrc) ? EX_instruction[7:0] : alu_b_src;

assign EX_jump_addr = {EX_pcplus4[31:28], EX_instruction[25:0], 2'b00};              
assign EX_branch_addr = EX_pcplus4 + {{14{EX_instruction[15]}}, EX_instruction[15:0], 2'b00};
assign EX_reg_write_addr = (EX_RegDst) ? EX_instruction[15:11] : EX_instruction[20:16];

EXMEM EXMEM_reg (.clk(clk),
                 .EX_aluout(EX_aluout),
                 .EX_read_data2(alu_b_src),
                 .EX_reg_write_addr(EX_reg_write_addr),
                 .EX_branch_addr(EX_branch_addr),
                 .EX_jump_addr(EX_jump_addr),
                 .EX_zr(EX_zr),
                 .EX_ng(EX_ng),
                 .EX_cr(EX_cr),
                 .EX_ov(EX_ov),
                 .MEM_aluout(MEM_aluout),
                 .MEM_read_data2(MEM_read_data2),
                 .MEM_reg_write_addr(MEM_reg_write_addr),
                 .MEM_branch_addr(MEM_branch_addr),
                 .MEM_jump_addr(MEM_jump_addr),
                 .MEM_zr(MEM_zr),
                 .MEM_ng(MEM_ng),
                 .MEM_cr(MEM_cr),
                 .MEM_ov(MEM_ov),
                 .EX_Branch(EX_Branch),
                 .EX_BranchFlip(EX_BranchFlip),
                 .EX_MemRead(EX_MemRead),
                 .EX_MemWrite(EX_MemWrite),
                 .EX_Jump(EX_Jump),
                 .EX_RegWrite(EX_RegWrite),
                 .EX_MemtoReg(EX_MemtoReg),
                 .MEM_Branch(MEM_Branch),
                 .MEM_BranchFlip(MEM_BranchFlip),
                 .MEM_MemRead(MEM_MemRead),
                 .MEM_MemWrite(MEM_MemWrite),
                 .MEM_Jump(MEM_Jump),
                 .MEM_RegWrite(MEM_RegWrite),
                 .MEM_MemtoReg(MEM_MemtoReg));

ram_256B RAM (.clk(clk),
              .addr(MEM_aluout),
              .wdata(store_data),
              .MemRead(MEM_MemRead),
              .MemWrite(MEM_MemWrite),
              .out(MEM_mem_data));
wire [7:0] store_data;
assign store_data = (StoreDataForward) ? WB_aluout : MEM_data2;
              
MEMWB MEMWB_reg (.clk(clk),
                 .MEM_mem_data(MEM_mem_data),
                 .MEM_aluout(MEM_aluout),
                 .MEM_reg_write_addr(MEM_reg_write_addr),
                 .MEM_RegWrite(MEM_RegWrite),
                 .MEM_MemtoReg(MEM_MemtoReg),
                 .WB_mem_data(WB_mem_data),
                 .WB_aluout(WB_aluout),
                 .WB_reg_write_addr(WB_reg_write_addr),
                 .WB_RegWrite(WB_RegWrite),
                 .WB_MemtoReg(WB_MemtoReg));

assign EX_rs = EX_instruction[25:21];
assign EX_rt = EX_instruction[20:16];
          
forwarding_unit Forwarding_Unit (.EX_rs(EX_rs),
                              .EX_rt(EX_rt),
                              .MEM_rd(MEM_reg_write_addr),
                              .WB_rd(WB_reg_write_addr),
                              .MEM_RegWrite(MEM_RegWrite),
                              .WB_RegWrite(WB_RegWrite),
                              .ForwardA(ForwardA),
                              .ForwardB(ForwardB));

//assign pcsrc = ((zero ^ BranchFlip) & Branch) ? branch_addr : pcplus4;
assign next_pc = (((MEM_zr ^ MEM_BranchFlip) & MEM_Branch) === 1'b1) ? MEM_branch_addr : IF_pcplus4;


endmodule
