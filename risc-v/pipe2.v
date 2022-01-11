// Code your design here
module reg2(output reg [31:0] PCplus41,PCnext1,immext1,Port_A1, Port_B1, 
            output reg [4:0]dest_reg1, 
            output reg regWrite1, ALUsrc1, MemWrite1, Branch1, Jump1,
            output reg [3:0]ALU_Sel1, 
            output reg [1:0]Resultsrc1,
            output reg [4:0]iptA1,iptB1,
            
            input [31:0] PCplus4,PCnext,immext,Port_A, Port_B, 
            input [4:0]dest_reg, 
            input reset,clk, 
            input regWrite, ALUsrc, MemWrite, Branch, Jump,
            input [3:0]ALU_Sel,
            input [1:0]Resultsrc,
            input [4:0] iptA,iptB,
           input FlushE);


always@(posedge clk) begin
    if (reset || FlushE) begin
      PCplus41=0;
      PCnext1=0;
      immext1=0;
      Port_A1=0;
      Port_B1=0;
      dest_reg1=0;
      regWrite1=0;
      ALUsrc1=0;
      MemWrite1=0;
      Branch1=0;
      Jump1=0;
      ALU_Sel1=0;
      Resultsrc1=0;
      iptA1=0;
      iptB1=0;
    end    else begin
      Branch1=Branch;
      Jump1=Jump;
      ALU_Sel1=ALU_Sel;
      Resultsrc1=Resultsrc;
      PCplus41=PCplus4;
      PCnext1=PCnext;
      immext1=immext;
      Port_A1=Port_A;
      Port_B1=Port_B;
      
      dest_reg1=dest_reg;
      
      regWrite1=regWrite;
      ALUsrc1=ALUsrc;
      MemWrite1=MemWrite;
  	  
      iptA1=iptA;
  	  iptB1=iptB;
    end
end
  
endmodule