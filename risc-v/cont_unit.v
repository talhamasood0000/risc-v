module control_unit(instruction,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUControl,Jump,reset);
	
	input reset;
  input [31:0]instruction;
  output reg RegWrite;
  output reg [1:0]ImmSrc;
  output reg ALUSrc;
  output reg MemWrite;
  output reg [1:0]ResultSrc;
  output reg Branch;

  output reg [3:0]ALUControl;
  output reg Jump;

  	reg [1:0]ALUOP;
	reg [6:0]Op;
  	reg [2:0]func3;
  	assign func3=instruction[14:12];
  	reg [1:0]conc;
  	assign conc={instruction[5],instruction[30]};

	reg [6:0]totalALU;
	
  	assign Op=instruction[6:0];
	
	assign totalALU={ALUOP,func3,conc};
  always@(*) begin
    if(reset) begin
      Jump=0;
      Branch=0;
    end

	case(Op)
      	//lw instruction
		7'b0000011: begin
			RegWrite=1'b1;
			ImmSrc=2'b00;
			ALUSrc=1'b1;
			MemWrite=1'b0;
			ResultSrc=2'b01;
			Branch=1'b0;
			ALUOP='b00;
          	Jump=1'b0;
			end
      	//sw instruction
		7'b0100011: begin
			RegWrite=1'b0;
			ImmSrc=2'b01;
			ALUSrc=1'b1;
			MemWrite=1'b1;
			ResultSrc=2'bxx;
			Branch=1'b0;
			ALUOP='b00;
          	Jump=1'b0;
			end
      	//R-type instruction
		7'b0110011: begin
			RegWrite=1'b1;
			ImmSrc=2'bxx;
			ALUSrc=1'b0;
			MemWrite=1'b0;
			ResultSrc=2'b00;
			Branch=1'b0;
			ALUOP=2'b10;
          	Jump=1'b0;
			end
      	//branch instruction
		7'b1100011: begin
			RegWrite=1'b0;
			ImmSrc=2'b10;
			ALUSrc=1'b0;
			MemWrite=1'b0;
			ResultSrc=2'bxx;
			Branch=1'b1;
			ALUOP='b01;
          	Jump=1'b0;
			end
      	//addi instruction
      	7'b0010011: begin
			RegWrite=1'b1;
			ImmSrc=2'b00;
			ALUSrc=1'b1;
			MemWrite=1'b0;
			ResultSrc=2'b00;
			Branch=1'b0;
			ALUOP='b10;
          	Jump=1'b0;
			end
        //jal instruction
      	7'b1101111: begin
			RegWrite=1'b1;
			ImmSrc=2'b11;
			ALUSrc=1'bx;
			MemWrite=1'b0;
			ResultSrc=2'b10;
			Branch=1'b0;
			ALUOP='bxx;
          	Jump=1'b1;
			end
      	default: begin
          RegWrite=1'b0;
			ImmSrc=2'b00;
			ALUSrc=1'b0;
			MemWrite=1'b0;
			ResultSrc=2'b00;
			Branch=1'b0;
			ALUOP='b10;
          	Jump=1'b0;
        end
	endcase
  end
  always@(*) begin
	casex(totalALU)
		7'b00xxxxx: begin
			ALUControl=4'b0000;
			end
		7'b01xxxxx: begin
			ALUControl=4'b0001;
			end
//       	7'b01000xx: begin
//           	ALUControl=4'b0001;
//         	end
//       	7'b01001xx: begin
//           	ALUControl=4'b0001;
//         	end
//       	7'b01100xx: begin
//           	ALUControl=4'b1110;
//         	end
//       	7'b01101xx: begin
//           	ALUControl=4'b11110;
//         	end
      	
      
		7'b1000000: begin
			ALUControl=4'b0000;
			end
		7'b1000001: begin
			ALUControl=4'b0000;
			end
		7'b1000010: begin
			ALUControl=4'b0000;
			end
		7'b1000011: begin
			ALUControl=4'b0001;
			end
		7'b10010xx: begin
			ALUControl=4'b0101;
			end
		7'b10110xx: begin
			ALUControl=4'b0011;
			end
		7'b10111xx: begin
			ALUControl=4'b0010;
			end
	endcase	
  end
	
endmodule