// Code your design here
module Instruction_Memory(input [31:0] pc,output reg [31:0] instruction);
  reg [31:0] ex1_memory [0:30];
  
  initial begin
    $display("Loading rom.");
	$readmemh("ex1.mem", ex1_memory);
  end
  always @(pc) begin
    instruction <= ex1_memory[pc/4];
    
  end
  
endmodule