module pc_testbench;
  reg clk;
  reg ld;
  reg reset;
  reg pc_enable;
  reg [31:0]inp;
  wire [31:0]out;

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
    inp=32'h00000;

    $display("Time | Reset | PC_En |  Load   |  Input   |  Output  ");
    $display("-----|-------|-------|---------|----------|----------");

    //reset check
    #10 reset=0;
    $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d", 
                 $time, reset, pc_enable, ld, inp, out);

    //normal flow check
    #10 pc_enable=1;
      repeat(5)begin
        #10 $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d",
                     $time,reset,pc_enable,ld,inp,out);
      end

    //jump check
    #10 ld = 1; inp = 32'h00018; pc_enable = 0;
    #10 $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d", 
                 $time, reset, pc_enable, ld, inp, out); 

    //normal flow continue check
    #10 ld = 0; pc_enable = 1;
         repeat(3) begin
           #10 $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d", 
                       $time, reset, pc_enable, ld, inp, out);
         end

    //hold check
    #10 pc_enable = 0;
        repeat(2) begin
          #10 $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d", 
                      $time, reset, pc_enable, ld, inp, out);
        end

    //reset check
    #10 reset = 1;
    #10 $display("%4d |   %b   |   %b   |    %b    |  %05d   |   %05d", 
                $time, reset, pc_enable, ld, inp, out);

   #10 $finish;
 end
endmodule
        
  

             
  

  
