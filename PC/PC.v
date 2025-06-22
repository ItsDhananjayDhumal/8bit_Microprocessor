module program_counter (
  input wire clk,
  input wire ld,
  input wire reset,
  input wire pc_enable,
  input wire [31:0]inp,
  output reg [31:0]out
);

  always @(posedge clk)begin
//doubt check priority of load vs reset
    if(ld)begin
      out<=inp;
    end
    else if(reset)begin
      out<=32'h00000;
    end
    else if(pc_enable)begin
      out<=out+1;
    end
  end
endmodule
