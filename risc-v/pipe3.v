// Code your design here
module reg3(output reg [31:0] PCplus41, Port_B1, ALU_Out1, 
            output reg [4:0]dest_reg1, 
            output reg regWrite1, MemWrite1,
            output reg [1:0]Resultsrc1, 
            
            input [31:0] PCplus4, Port_B, ALU_Out,
            input [4:0]dest_reg, 
            input reset,clk, 
            input regWrite, MemWrite,
            input [1:0]Resultsrc);
 

  
  always@(posedge clk) begin
      if (reset) begin
      PCplus41=0;
      Port_B1=0;
      ALU_Out1=0;
      dest_reg1=0;
      regWrite1=0;
      MemWrite1=0;
      Resultsrc1=0;
    end
      PCplus41=PCplus4;
	  ALU_Out1=ALU_Out;
      Port_B1=Port_B;
      dest_reg1=dest_reg;
      regWrite1=regWrite;
      MemWrite1=MemWrite;
      Resultsrc1=Resultsrc;
  end
  
endmodule