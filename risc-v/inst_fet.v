// Code your design here
module Instruction_fetch(input [31:0] instruction,
                         output reg [4:0]addR1,addR2,dest_reg, 
                         output reg [24:0] sign_ext,output reg [31:0] tot_inst);
  always @(*) begin
        
    addR1<=instruction[19:15];
    addR2<=instruction[24:20];
    dest_reg<=instruction[11:7];
    sign_ext<=instruction[31:7];
	tot_inst<=instruction;
    
  end
  
endmodule