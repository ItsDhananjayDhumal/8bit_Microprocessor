`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2025 17:09:54
// Design Name: 
// Module Name: hazard_detection_unit
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

module hazard_detection_unit(
    input reg EX_MemRead,
    input reg [4:0] EX_rt,
                     ID_rs,
                     ID_rt,
    output reg pc_write,
               IFID_write,
               nop_control
);
// NOTE: NOP INSERTED WHEN NOP_CONTROL HIGH
initial begin
    pc_write = 1;
    IFID_write = 1;
    nop_control = 0;
    EX_rt = 0;
    ID_rs = 0;
    ID_rt = 0;
    EX_MemRead = 0;
end
always @(*) begin
    pc_write = 1;
    IFID_write = 1;
    nop_control = 0;
    if (EX_MemRead && ((EX_rt == ID_rs) || (EX_rt == ID_rt))) begin
        pc_write = 0;
        IFID_write = 0;
        nop_control = 1;
    end
end

endmodule
