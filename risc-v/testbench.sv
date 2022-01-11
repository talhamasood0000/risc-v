module tb_Top_Module;
  
  reg clk,reset;

//   wire [31:0] ALU_Out;
//   wire CarryOut,ZeroOut;
  
  Top_Module t1(clk,reset);
  
  initial clk=0;
  always #5 clk=~clk;
  
  initial begin
    reset=1;
    #10
    reset=0;
    #20
    reset=0;
    #20
   	reset=0;
    #20
    reset=0;
    #200
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
