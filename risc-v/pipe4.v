// Code your design here
module reg4(output reg [31:0] tb_PCplus4, tb_Data_Out, tb_ALU_Out, 
            output reg [4:0]tb_dest_reg, 
            output reg tb_regWrite,
            output reg [1:0]tb_Resultsrc, 
            
            input [31:0] PCplus4, Data_Out, ALU_Out,
            input [4:0]dest_reg, 
            input reset,clk, 
            input regWrite,
            input [1:0]Resultsrc
           );
  
  
  always@(*) begin
  if (reset) begin
      tb_PCplus4=0;
      tb_Data_Out=0;
      tb_ALU_Out=0;    
      tb_dest_reg=0;
      tb_regWrite=0;
      tb_Resultsrc=0;
  end
  end
  always@(posedge clk) begin
      tb_PCplus4=PCplus4;
	  tb_ALU_Out=ALU_Out;
      tb_Data_Out=Data_Out;
      tb_dest_reg=dest_reg;
      tb_regWrite=regWrite;
      tb_Resultsrc=Resultsrc;
  end
endmodule