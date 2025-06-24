`timescale 1ns / 1ps

module tb_ALU_top;

  // Inputs
  reg [7:0] ina, inb;
  reg [4:0] shamt;
  reg [1:0] ALUOp;
  reg [5:0] func;

  // Outputs
  wire [7:0] out;
  wire cr, ov, ng, zr;
  wire [3:0] operation;

  // Connect ALU_Control
  ALU_Control control_unit (
    .ALUOp(ALUOp),
    .func(func),
    .operation(operation)
  );

  // Connect ALU
  ALU alu_core (
    .ina(ina),
    .inb(inb),
    .shamt(shamt),
    .operation(operation),
    .cr(cr),
    .ov(ov),
    .ng(ng),
    .zr(zr),
    .out(out)
  );

  initial begin
    $display("Time | ALUOp Func    | Operation | ina  inb  shamt | out  cr ov ng zr");
    $monitor("%4t | %b    %b |   %b   | %h  %h   %h   | %h   %b  %b ",
             $time, ALUOp, func, operation, ina, inb, shamt, out, cr, ov);

    // ----------- R-Type Tests -----------
    
    // Test: ADD (func = 000000)
    ALUOp = 2'b10; func = 6'b000000;
    ina = 8'd10; inb = 8'd20; shamt = 0; #10;

    // Test: SUB (func = 000010)
    func = 6'b000010;
    ina = 8'd30; inb = 8'd10; #10;

    // Test: AND (func = 000100)
    func = 6'b000100;
    ina = 8'b10101010; inb = 8'b11001100; #10;

    // Test: OR (func = 000101)
    func = 6'b000101; #10;

    // Test: SLT (func = 001010)
    func = 6'b001010;
    ina = 8'd5; inb = 8'd10; #10;

    // Test: NOT (func = 000001)
    func = 6'b000001;
    ina = 8'b00001111; inb = 8'b0; #10;

    // Test: Left Shift (func = 111101)
    func = 6'b111101;
    ina = 8'b00001111; shamt = 2; #10;

    // Test: Rotate Right (func = 111011)
    func = 6'b111011;
    ina = 8'b10000001; shamt = 1; #10;

    // ----------- I-Type Style Tests -----------

    // Test: Direct ADD (ALUOp = 00, func ignored)
    ALUOp = 2'b00; func = 6'bxxxxxx;
    ina = 8'h81; inb = 8'h99; #10;

    // Test: Direct SUB (ALUOp = 01, func ignored)
    ALUOp = 2'b01;
    ina = 8'h99; inb = 8'h81; #10;
    
    ALUOp = 2'b01;
    ina = 8'h81; inb = 8'h99; #10;
    $finish;
  end

endmodule
