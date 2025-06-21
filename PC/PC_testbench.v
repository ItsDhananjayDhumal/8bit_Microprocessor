module pc_testbench;
  reg clk;
  reg ld;
  reg reset;
  reg pc_enable;
  reg [7:0]inp;
  wire [7:0]out;

  program_counter dut(
    .clk(clk),
    .ld(ld),
    .reset(reset),
    .pc_enable(pc_enable),
    .inp(inp),
    .out(out));

  always #5 clk=~clk;

  initial begin

    clk=0;
    ld=0;
    reset=1;
    pc_enable=0;
    inp=8'h00;

    $display("Time | Reset | PC_En | Load | Input | Output");
    $display("-----|-------|-------|---------|-------|-------");

    #10 reset=0;
    $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d", 
                 $time, reset, pc_enable, ld, inp, out);
  
    #10 pc_enable=1;
      repeat(5)begin
        #10 $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d",
                     $time,reset,pc_enable,ld,inp,out);
      end

    #10 ld = 1; inp = 8'h18; pc_enable = 0;
    #10 $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d", 
                 $time, reset, pc_enable, ld, inp, out); 

    #10 ld = 0; pc_enable = 1;
         repeat(3) begin
           #10 $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d", 
                       $time, reset, pc_enable, ld, inp, out);
         end

    #10 pc_enable = 0;
        repeat(2) begin
          #10 $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d", 
                      $time, reset, pc_enable, ld, inp, out);
        end

   #10 reset = 1;
    #10 $display("%4d |   %b   |   %b   |    %b    |  %02d   |   %02d", 
                $time, reset, pc_enable, ld, inp, out);

   #10 $finish;
 end
endmodule
        
  

             
  

  
