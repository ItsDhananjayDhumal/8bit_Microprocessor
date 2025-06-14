`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2025 00:52:18
// Design Name: 
// Module Name: tb_ram64K
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


module tb_ram64K;
reg        clk;
reg        we;
reg [15:0] addr;
reg [7:0]  wdata;
wire [7:0] rdata;
ram64K dut(.clk(clk),.we(we),.addr(addr),.wdata(wdata),.rdata(rdata));

always #5 clk=~clk;

initial begin
    $display("RAM test");
    //initial:
    clk=0;
    we=0;
    addr=0;
    wdata=0;
    
    #10;
    
    addr = 13'h1234;
    wdata = 8'hAB;
    we = 1;
    #10; //one clock edge
    
    we=0; //read
    #10;
    #10;
    
    addr = 13'h5678;
    wdata = 8'hBC;
    we = 1;
    #10; //one clock edge
    
    addr = 13'h5678;
    we=0; //read
    #10;
    $display("%h", rdata);
    $finish;
 end
 endmodule

