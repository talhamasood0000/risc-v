// Code your design here

module next_pc(output reg [31:0] pc, input [31:0] PCnext ,input clk,reset,StallF);
 
  
  always @(posedge clk) begin
    if(StallF==0) begin
      pc=PCnext;
    end
    if (reset==1) begin
    	pc=0;
    end
  end
  
endmodule