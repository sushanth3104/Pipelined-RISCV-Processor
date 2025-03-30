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


module RISCV(
    input clk,reset
);

parameter WIDHT = 32 ;

wire [WIDHT-1:0]PCNext,PC,Inst,PCPlus4,ImmExt,SrcA,SrcB,ALUResult,WriteData,PCTarget,ReadData,Result;
wire PCSrc,MemWrite,ALUSrc,RegWrite,Zero;
wire [3:0]ALUCtl;
wire [1:0]ResultSrc,ImmSrc;

Mux2x1 MuxPC(PCPlus4,PCTarget,PCSrc,PCNext);


ProgramCounter ProgramCounter(clk,reset,PCNext,PC);

Adder AdderPC(PC,4,PCPlus4);

InstructionMemory InstructionMemory(
    .readAddr(PC),
    .inst(Inst)
);

ControlUnit ControlUnit(
    .opcode(Inst[6:0]),
    .func3(Inst[14:12]),
    .func7_5(Inst[30]),
    .Zero(Zero),
    .ALUCtl(ALUCtl),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .PCSrc(PCSrc)
);

RegisterFile RegisterFile(
    .A1(Inst[19:15]),
    .A2(Inst[24:20]),
    .A3(Inst[11:7]),
    .WD3(Result),
    .CLK(clk),
    .reset(reset),
    .WE3(RegWrite),
    .RD1(SrcA),
    .RD2(WriteData)
);

ImmExtnd ImmExtnd(
    .Instr(Inst[31:7]),
    .InstType(ImmSrc),
    .ImmExt(ImmExt)
);

Mux2x1 MuxALU(WriteData,ImmExt,ALUSrc,SrcB);

ALU ALU(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUCtl(ALUCtl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

Adder AdderPCTarget(PC,ImmExt,PCTarget);

DataMemory DataMemory(ALUResult,WriteData,clk,MemWrite,ReadData);

Mux3x1 MuxWriteData(ALUResult,ReadData,PCPlus4,ResultSrc,Result);






endmodule