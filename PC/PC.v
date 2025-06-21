module program_counter (
  input wire clk,
  input wire ld,
  input wire reset,
  input wire pc_enable,
  input wire [7:0]inp,
  output reg [7:0]out
);

  always @(posedge clk)begin
//doubt check priority of load vs reset
    if(ld)begin
      out<=inp;
    end
    else if(reset)begin
      out<=8'h000;
    end
    else if(pc_enable)begin
      out<=out+1;
    end
  end
endmodule
