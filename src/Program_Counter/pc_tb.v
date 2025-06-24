`timescale 1ns / 1ps


module pc_tb();

reg clk, reset, pc_write;
reg [31:0] next_pc;
wire [31:0] addr, instruction;

always begin
    #5 clk = ~clk;
end

ProgramCounter DUT (.clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .next_pc(next_pc),
        .pc(addr));

instruction_mem DUT1 (.address(addr),
                      .instruction(instruction)); 

initial begin
    clk = 0;
    reset = 0;
    pc_write = 1;
    
    #50 $finish;

end

always @(*)
    next_pc = addr + 32'd4;
      
endmodule
