// Code your design here
module register_file(Port_A, Port_B, Din, Addr_A, Addr_B, Addr_Wr, wr,clk,reset);
			output reg [31:0] Port_A, Port_B;			
			input [31:0] Din;						
			input [4:0] Addr_A, Addr_B, Addr_Wr;	
			input wr,reset,clk;								
			reg [31:0] Reg_File [31:0];				
  integer i;
  always @(*) begin
    Port_A=Reg_File[Addr_A];
    Port_B=Reg_File[Addr_B];
  end
  always @(negedge clk) begin
    if(reset)begin
      for(i=0;i<32;i=i+1)
        Reg_File[i]<=32'h0;
    end else if (wr) begin
      Reg_File[Addr_Wr]=Din;
    end
  end

endmodule