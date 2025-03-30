module ControlUnit(
    input [6:0]opcode,
    input [2:0]func3,
    input func7_5,
    output [3:0]ALUCtl,
    output [1:0]ResultSrc,
    output [1:0]ImmSrc,
    output Branch,Jump,
    output MemWrite,ALUSrc,RegWrite
);


wire [1:0]ALUOp;


MainDecoder MainDecoder(
    .opcode(opcode),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp),
    .Branch(Branch),
    .Jump(Jump),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);

ALUDecoder ALUDecoder(
    .ALUOp(ALUOp),
    .func3(func3),
    .func7_5(func7_5),
    .opcode_5(opcode[5]),
    .ALUCtl(ALUCtl)
);



endmodule