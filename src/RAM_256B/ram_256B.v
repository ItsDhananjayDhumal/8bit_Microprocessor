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
    input       MemWrite,
    input       MemRead,
    input [7:0] addr, //8 bit address
    input [7:0] wdata, // write data to memory
    
    output reg [7:0] out  // output (at given address)
    );
    
reg [7:0]mem [255:0];


always @(posedge clk) begin
    if (MemWrite)
        mem[addr] <= wdata;
end

always @(*) begin
    if (MemRead)
        out = mem[addr];
end   
integer i, file, frame_count;

initial begin
    frame_count = 0;
end
initial begin
    for (i = 8'hC0; i <= 8'hFF; i = i + 1)
        mem[i] = "-"; // ASCII for dash
end
always @(posedge clk) begin
    if (frame_count % 100 == 0) begin  // every 100 cycles
        file = $fopen("C:\Vivado_Projects\iitisoc_8bitModules\iitisoc_8bitModules.srcs\sources_1\new\framebuffer.txt", "w");
        for (i = 8'hC0; i <= 8'hFF; i = i + 1) begin
            $fwrite(file, "%c", mem[i]);
            if (i[3:0] == 4'hF) $fwrite(file, "\n");  // new line every 16 chars
        end
        $fclose(file);
    end
    $display("Trying to write frame %0d", frame_count / 100);

    frame_count = frame_count + 1;
end
endmodule
