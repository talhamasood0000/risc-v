module addr_gen(output [31:0]PCnext,PCplus4,input PCSrc,input [31:0]immext,pc);
  
  reg [31:0]PCTarget;
  
  assign PCplus4= pc+32'h4;
  assign PCTarget=immext+pc;
  
  assign PCnext = PCSrc ? PCTarget : PCplus4;
  
  
endmodule