`include "Adder.v"
`include "ALU.v"
`include "ALUDecoder.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "MainDecoder.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"
`include "ImmExtnd.v"
`include "InstructionMemory.v"
`include "Mux2x1.v"
`include "Mux3x1.v"
`include "PipelineReg.v"




module PipelineRISCV(
    input clk,reset
);

parameter WIDHT = 32 ;

wire [WIDHT-1:0] InstrF,PCFF,PCF,PCPlus4F,PCTargetE;
wire PCSrcE;

wire [WIDHT-1:0] InstrD,PCD,PCPlus4D;



// Fetch-Decode Signals

wire [WIDHT-1:0]ResultW,ImmExtD,RD1D,RD2D;
wire RegWriteD,MemWriteD,JumpD,BranchD,ALUSrcD,RegWriteW;
wire [1:0]ResultSrcD,ImmSrcD;
wire [3:0]ALUCtlD;

wire [4:0]RdD,RdE,RdW,RdM;

wire [WIDHT-1:0] RD1E,RD2E,PCE,ImmExtE,PCPlus4E;
wire RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
wire [1:0]ResultSrcE;
wire [3:0]ALUCtlE;


assign RdD = InstrD[11:7];

// Decode-Execute Signals

wire [WIDHT-1:0] SrcAE,SrcBE,WriteDataE,ALUResultE;
wire ZeroE,AndOut;

wire [WIDHT-1:0] ALUResultM,WriteDataM,PCPlus4M;
wire RegWriteM,MemWriteM;
wire [1:0]ResultSrcM;

assign WriteDataE = RD2E;


assign SrcAE = RD1E;

// Execute-Memory Signals

wire [1:0]ResultSrcW;
wire [WIDHT-1:0] ReadDataM,ReadDataW,ALUResultW,PCPlus4W;



// Pipeline Registe Signals : Control + Data

// Decode Signals

wire [95:0] DecodeInData,DecodeOutData;

assign DecodeInData = {InstrF,PCF,PCPlus4F};
assign  {InstrD,PCD,PCPlus4D} = DecodeOutData ;


// Execute Signals
wire [164:0] ExecuteInData,ExecuteOutData;
wire [10:0] ExecuteInControl,ExecuteOutControl;

assign ExecuteInData = {RD1D,RD2D,PCD,RdD,ImmExtD,PCPlus4D};
assign {RD1E,RD2E,PCE,RdE,ImmExtE,PCPlus4E} = ExecuteOutData ;

assign ExecuteInControl = {RegWriteD,ResultSrcD,MemWriteD,JumpD,BranchD,ALUCtlD,ALUSrcD};
assign {RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUCtlE,ALUSrcE} = ExecuteOutControl ;

// Memory Stages Signals

wire [100:0] MemoryInData,MemoryOutData;
wire [3:0] MemoryInControl,MemoryOutControl;

assign MemoryInData = {ALUResultE,WriteDataE,RdE,PCPlus4E};
assign  {ALUResultM,WriteDataM,RdM,PCPlus4M} = MemoryOutData ;

assign MemoryInControl = {RegWriteE,ResultSrcE,MemWriteE};
assign  {RegWriteM,ResultSrcM,MemWriteM} = MemoryOutControl ;


// Write Back Signals

wire [100:0] WriteBackInData,WriteBackOutData;
wire [2:0] WriteBackInControl,WriteBackOutControl;

assign WriteBackInData = {ALUResultM,ReadDataM,RdM,PCPlus4M};
assign  {ALUResultW,ReadDataW,RdW,PCPlus4W} = WriteBackOutData ;

assign WriteBackInControl = {RegWriteM,ResultSrcM};
assign  {RegWriteW,ResultSrcW} = WriteBackOutControl ;






//Fetch Logic 

Mux2x1 #(
    .WIDTH(WIDHT)
) Mux2x1_PC(
    .A(PCPlus4F),
    .B(PCTargetE),
    .S(PCSrcE),
    .Y(PCFF)
);

ProgramCounter ProgramCounter(
    .clk(clk),
    .reset(reset),
    .pc_in(PCFF),
    .pc_out(PCF)
);

InstructionMemory InstructionMemory(
    .readAddr(PCF),
    .inst(InstrF)
);

Adder #(
    .WIDTH(WIDHT)
) Adder_PCPlus4(
    .SrcA(PCF),
    .SrcB(32'd4),
    .Result(PCPlus4F)
);


PipelineReg #(
    .WIDTH(96)
) Decode(
    .clk(clk),
    .rst(reset),
    .d(DecodeInData),
    .q(DecodeOutData)
);

// Decode Logic



ControlUnit ControlUnit(
    .opcode(InstrD[6:0]),
    .func3(InstrD[14:12]),
    .func7_5(InstrD[30]),
    .ALUCtl(ALUCtlD),
    .ResultSrc(ResultSrcD),
    .ImmSrc(ImmSrcD),
    .MemWrite(MemWriteD),
    .ALUSrc(ALUSrcD),
    .RegWrite(RegWriteD),
    .Branch(BranchD),
    .Jump(JumpD)
);

RegisterFile RegisterFile(
    InstrD[19:15],
    InstrD[24:20],
    RdW,
    ResultW,
    ~clk,reset,
    RegWriteW,
    RD1D,RD2D
);

ImmExtnd ImmExtnd(
    InstrD[31:7],
    ImmSrcD,
    ImmExtD
);


PipelineReg #(
    .WIDTH(176)
) Execute(
    .clk(clk),
    .rst(reset),
    .d({ExecuteInControl,ExecuteInData}),
    .q({ExecuteOutControl,ExecuteOutData})
);


// Execute Logic

and AndGate(AndOut,BranchE,ZeroE);
or OrGate(PCSrcE,AndOut,JumpE);

Mux2x1 #(
    .WIDTH(WIDHT)
) Mux2x1_ALUSrc(
    .A(RD2E),
    .B(ImmExtE),
    .S(ALUSrcE),
    .Y(SrcBE)
);

Adder #(
    .WIDTH(WIDHT)
) Adder_PCPlus4E(
    .SrcA(PCE),
    .SrcB(ImmExtE),
    .Result(PCTargetE)
);


ALU #(
    .WIDTH(WIDHT)
) 
 ALU(
    .SrcA(SrcAE),
    .SrcB(SrcBE),
    .ALUCtl(ALUCtlE),
    .ALUResult(ALUResultE),
    .Zero(ZeroE)
);

PipelineReg #(
    .WIDTH(105)
) Memory(
    .clk(clk),
    .rst(reset),
    .d({MemoryInControl,MemoryInData}),
    .q({MemoryOutControl,MemoryOutData})
);


// Memory Logic

DataMemory DataMemory(
    .A(ALUResultM),
    .WD(WriteDataM),
    .WE(MemWriteM),
    .CLK(clk),
    .RD(ReadDataM)
);

// Write Back Logic

PipelineReg #(
    .WIDTH(104)
) WriteBack(
    .clk(clk),
    .rst(reset),
    .d({WriteBackInControl,WriteBackInData}),
    .q({WriteBackOutControl,WriteBackOutData})
);

Mux3x1 #(
    .WIDTH(WIDHT)
) Mux3x1_ResultSrc(
    .A(ALUResultW),
    .B(ReadDataW),
    .C(PCPlus4W),
    .S(ResultSrcW),
    .Y(ResultW)
);




endmodule