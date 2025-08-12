`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2025 18:29:43
// Design Name: 
// Module Name: ram_256B
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


module ram_256B(
    input       clk,
    input       reset,
    input       MemWrite,
    input       MemRead,
    input [7:0] addr, //8 bit address
    input [7:0] wdata, // write data to memory
    
    output reg [7:0] out,  // output (at given address)
    output reg [7:0] fb
    );
    
reg [7:0]mem [255:0];


//always @(posedge clk) begin
//    if (MemRead)
//        out <= mem[addr];
//    else if (MemWrite)
//        mem[addr] <= wdata;
//end
    
always @(posedge clk) begin
    if (MemWrite)
        mem[addr] <= wdata;
        
    if (reset)
        mem[0] <= 8'd0;
end

always @(*) begin
    if (MemRead)
        out = mem[addr];
        
    fb = mem[0];
end  


//ila_1 inst1(.clk(clk),
//            .probe0(mem[0]),
//            .probe1(mem[1]),
//            .probe2(mem[2]),
//            .probe3(mem[3]),
//            .probe4(mem[4]),
//            .probe5(mem[5]),
//            .probe6(mem[6]),
//            .probe7(mem[7]),
//            .probe8(mem[255]),
//            .probe9(mem[254]),
//            .probe10(mem[253]),
//            .probe11(mem[252]),
//            .probe12(mem[251]),
//            .probe13(mem[250]),
//            .probe14(mem[249]),
//            .probe15(mem[248]));

endmodule

