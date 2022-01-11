// Code your design here
module Data_Memory(output reg [31:0] Data_Out, input [31:0] Data_In, input [31:0] D_Addr, input wr,reset,clk);
		reg [31:0] Mem [255:0];
  
  integer i;
  always @(*) begin
    
    Data_Out=Mem[D_Addr];
  end
  always@(negedge clk) begin
    if (reset) begin
      for(i=0;i<256;i++)
        Mem[i]=0;

    end else if (wr==1) begin
      Mem[D_Addr]=Data_In;
    end
  end
endmodule