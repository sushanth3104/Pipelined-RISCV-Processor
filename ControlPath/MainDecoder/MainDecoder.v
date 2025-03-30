module MainDecoder(
    input [6:0] opcode,
    output reg [1:0]ResultSrc,ImmSrc,ALUOp,
    output reg Branch,Jump,MemWrite,ALUSrc,RegWrite
);

// For ALUOp
parameter Load_Store_Type = 0;
parameter Branch_Type = 1;
parameter IR_Type = 2;

// For Immediate Extender

parameter I_Type = 0;
parameter S_Type = 1;
parameter B_Type = 2;
parameter J_Type = 3;


// Opcodes
parameter LoadInst = 3;
parameter StoreInst = 35;
parameter BranchInst = 99;
parameter I_TypeInst = 19;
parameter R_TypeInst = 51;
parameter J_TypeInst = 111;

always@(*)begin

    case(opcode)

        LoadInst:begin

            ResultSrc = 2'b01;
            ImmSrc = I_Type;
            ALUOp = Load_Store_Type;
            Branch = 0;
            Jump = 0;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;

        end

        StoreInst:begin
            
            ResultSrc = 2'b00;
            ImmSrc = S_Type;
            ALUOp = Load_Store_Type;
            Branch = 0;
            Jump = 0;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;

        end

        BranchInst:begin

            ResultSrc = 2'b00;
            ImmSrc = B_Type;
            ALUOp = Branch_Type;
            Branch = 1;
            Jump = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;

        end

        I_TypeInst:begin

            ResultSrc = 2'b00;
            ImmSrc = I_Type;
            ALUOp = IR_Type;
            Branch = 0;
            Jump = 0;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;

        end

        R_TypeInst:begin

            ResultSrc = 2'b00;
            ImmSrc = 0;
            ALUOp = IR_Type;
            Branch = 0;
            Jump = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;

        end

        J_TypeInst:begin

            ResultSrc = 2'b10;
            ImmSrc = J_Type;
            ALUOp = 0;
            Branch = 0;
            Jump = 1;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;

        end

        default : {ResultSrc,ImmSrc,ALUOp,Branch,Jump,MemWrite,ALUSrc,RegWrite} = 0;

    endcase

end


endmodule