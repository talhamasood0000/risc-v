`include "next_pc.v"
`include "inst_mem.v"
`include "cont_unit.v"
`include "inst_fet.v"
`include "sign_extend.v"
`include "adr_gen.v"
`include "reg_fil.v"
`include "mux2.v"
`include "mux22.v"
`include "alu.v"
`include "dat_mem.v"
`include "pipe1.v"
`include "pipe2.v"
`include "pipe3.v"
`include "pipe4.v"
`include "hazard_unit.v"


module Top_Module(input clk,reset);
	
  reg [1:0]immsrc;
  reg [3:0]ALU_Sel;
  reg [1:0]Resultsrc;
  reg regWrite,PCSrc,ALUsrc,MemWrite,Branch,Jump;
  reg [31:0]pc;
  reg [31:0]PCnext;
  reg [31:0] instruction;
  reg [31:0]PCplus4;
  reg [24:0]sign_ext;
  reg [4:0]addR1,addR2,dest_reg;
  reg [31:0] tot_inst;
  reg [31:0]immext;
  reg [31:0]Din;
  reg [31:0]Port_A;
  reg [31:0]Port_B; 
  reg [31:0]y; 
  reg [31:0] ALU_Out;
  reg CarryOut,ZeroOut;
  reg [31:0] Data_Out;
  reg [31:0]PCTarget;
  
  
  
  reg StallD,StallF,FlushE,FlushD;
  
//First Part  
  

  assign PCnext = PCSrc ? PCTarget : PCplus4;
  
  //input [31:0] PCnext,clk,reset 
  //output pc
  next_pc m1(pc,PCnext ,clk, reset,StallF);
  
  
 
  //input PCSrc,input [31:0]immext,pc
  //output [31:0]PCnext,PCplus4
  
  assign PCplus4=pc+32'h4;
  //addr_gen m6(PCnext,PCplus4,PCSrc,immext,pc);
  
  
   
  //input pc,
  //output instruction
  Instruction_Memory m2(pc,instruction);
  
  //input reset,clk,PCplus4,PCnext,instruction
  //output PCplus41,PCnext1,instruction1;
  reg [31:0] PCplus41,PCnext1,instruction1;
  reg1 r1(PCplus41,PCnext1,instruction1,PCplus4,PCnext,instruction,reset,clk,StallD,FlushD); 
  
//Second Part

  
  //input [31:0] instruction
  //output[4:0]addR1,addR2,dest_reg,[24:0] sign_ext,[31:0] tot_inst
  Instruction_fetch m4(instruction1,addR1,addR2,dest_reg,sign_ext,tot_inst);
  
  
  //Control Unit
  //input instruction;
  //output RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUControl, Jump;
  control_unit m3(instruction1, regWrite, immsrc, ALUsrc, MemWrite, Resultsrc, Branch, ALU_Sel, Jump,reset);

     
  //input [31:0] Din,[4:0] Addr_A, Addr_B, Addr_Wr,
  //output [31:0] Port_A, Port_B
  
  reg [4:0]dest_reg4;
  reg regWrite4;//
  register_file m7(Port_A, Port_B, Din, addR1, addR2, dest_reg4, regWrite4,clk,reset);


  //input[31:7] instr,input [1:0] immsrc,
  //output reg [31:0] immext
  extend m5(sign_ext,immsrc,immext);
  
 
  //input PCplus41,PCnext1,immext,Port_A, Port_B, 
  //input dest_reg, 
  //input reset,clk, 
  //input regWrite, ALUsrc, MemWrite, Branch, Jump,
  //input ALU_Sel,
  //input Resultsrc);

  //output PCplus42,PCnext2,immext2,Port_A2, Port_B2; 
  //output dest_reg2;
  //output regWrite2, ALUsrc2, MemWrite2, Branch2, Jump2;
  //output ALU_Sel2;
  
  
  reg [31:0] PCplus42,PCnext2,immext2,Port_A2, Port_B2; 
  reg [4:0]dest_reg2;
  reg regWrite2, ALUsrc2, MemWrite2, Branch2, Jump2;
  reg [3:0]ALU_Sel2;
  reg [1:0]Resultsrc2;
  reg [4:0]Rs1E,Rs2E;
  
  reg2 r2(PCplus42,PCnext2,immext2,Port_A2, Port_B2, 
          dest_reg2, 
          regWrite2, ALUsrc2, MemWrite2, Branch2, Jump2,
          ALU_Sel2, 
          Resultsrc2,
          Rs1E,Rs2E,
          
            
          PCplus41,PCnext1,immext,Port_A, Port_B, 
          dest_reg, 
          reset,clk, 
          regWrite, ALUsrc, MemWrite, Branch, Jump,
          ALU_Sel,
          Resultsrc,
         addR1,addR2,
         FlushE);
  
//Third Part
  
  reg [1:0]ForwardAE,ForwardBE;
  reg [31:0]ALU_inp1,ALU_inp2,ALU_Out3;
  
  mux22 m12(Port_A2,Din,ALU_Out3,ForwardAE,ALU_inp1);
  mux22 m18(Port_B2,Din,ALU_Out3,ForwardBE,ALU_inp2);
  
  
  //input [32-1:0] d0, d1,s,
  //output [32-1:0] y);
  mux2 m8(ALU_inp2,immext2,ALUsrc2,y);
  
  assign PCTarget=immext2+PCnext2;
  
  
  //input Port_A,y,ALU_Sel
  //output ALU_Out,CarryOut,ZeroOut
  alu m9(ALU_inp1,y,ALU_Sel2,ALU_Out,CarryOut,ZeroOut);
  
  //assign PCSrc=((ZeroOut || NegOut) && Branch) || Jump;
  assign PCSrc=(ZeroOut && Branch2) || Jump2;
  //assign PCSrc=0;
  
  
  
  
  
  //  input [31:0] PCplus4, Port_B, ALU_Out,
  //input [4:0]dest_reg, 
  //input reset,clk, 
  //input regWrite, MemWrite,
  //input [1:0]Resultsrc
  
  //output [31:0] PCplus43, Port_B3, ALU_Out3; 
  //output [4:0]dest_reg3;
  //output regWrite3, MemWrite3;
  //output [1:0]Resultsrc3; 

  
  reg [31:0] PCplus43, Port_B3; 
  reg [4:0]dest_reg3;
  reg regWrite3, MemWrite3;
  reg [1:0]Resultsrc3; 
            
  reg3 r3(PCplus43, Port_B3, ALU_Out3,
         dest_reg3,
         regWrite3, MemWrite3,
         Resultsrc3,
         PCplus42, Port_B2, ALU_Out,
         dest_reg2,
         reset,clk,
         regWrite2, MemWrite2,
         Resultsrc2);
  

  
  
//Fourth Part
  

  //input ALU_Out,Port_B,MemWrite,reset,clk
  //output Data_Out
  Data_Memory m10(Data_Out,ALU_Out3,Port_B3,MemWrite3,reset,clk);
  
  
  
  //output reg [31:0] PCplus41, Data_Out1, ALU_Out1, 
  //output reg [4:0]dest_reg1, 
  //output reg regWrite1,
  //output reg [1:0]Resultsrc1, 
            
  //input [31:0] PCplus4, Data_Out, ALU_Out,
  //input [4:0]dest_reg, 
  //input reset,clk, 
  //input regWrite,
  //input [1:0]Resultsrc
  
  
  reg [31:0] PCplus44, Data_Out4, ALU_Out4;
  
  
  reg [1:0]Resultsrc4;
  
  reg4 r4(PCplus44, Data_Out4, ALU_Out4, 	
          dest_reg4, 
          regWrite4,
          Resultsrc4,
          PCplus43, Data_Out, ALU_Out3,
          dest_reg3,
          reset,clk,
          regWrite3,
          Resultsrc3);
  
  
  
//Fifth Part
  
  
  //input d0, d1,s,
  //output y);
  mux22 m11(ALU_Out4,Data_Out4,PCplus44,Resultsrc4,Din);

  
  
  //StallD,StallF,FlushE,
  
  hazard h1(Rs1E,Rs2E,dest_reg3,dest_reg4, 
             regWrite3,regWrite4,
            Resultsrc2[0],
             addR1,addR2,dest_reg2,
             PCSrc,reset,
             StallD,StallF,FlushE,FlushD,
             ForwardAE,ForwardBE);
endmodule