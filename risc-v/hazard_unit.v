module hazard(input [4:0]Rs1E,Rs2E,RdM,RdW,
              input RegWriteM,RegWriteW,
              input ResultSrcE0,
              input [4:0]Rs1D,Rs2D,RdE,
              input PCSrcE,reset,
              output reg StallD,StallF,FlushE,FlushD,
              output reg [1:0]ForwardAE,ForwardBE);
  
  reg lwStall=0;
  always@(*) begin	
  
    if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 32'b0)) begin
      ForwardAE = 32'b10;
    end
    else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 32'b0)) begin
      ForwardAE = 32'b01;
    end
    else begin
      ForwardAE = 32'b00;
    end
    
  
    if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 32'b0)) begin
      ForwardBE = 32'b10;
    end
    else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 0)) begin
      ForwardBE = 32'b01;
    end
    else begin
      ForwardBE = 32'b00;
    end
  end
  
  always@(*)begin

    lwStall = ResultSrcE0 && ((Rs1D == RdE) || (Rs2D == RdE));
    StallF = lwStall;
    StallD = lwStall;
    FlushD = PCSrcE;
    FlushE = lwStall || PCSrcE;

  end
  
endmodule