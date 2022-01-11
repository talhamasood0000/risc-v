// Code your design here
module reg1(output reg [31:0] PCplus41,PCnext1,instruction1, input [31:0] PCplus4,PCnext,instruction, input reset,clk,StallD,FlushD);
  

    always@(posedge clk) begin
    if (reset || FlushD) begin
      PCplus41=0;
      PCnext1=0;
      instruction1=0;
    end
      if(StallD==0)begin
      	PCplus41=PCplus4;
      	PCnext1=PCnext;
      	instruction1=instruction;
      end
        
  end
  
endmodule