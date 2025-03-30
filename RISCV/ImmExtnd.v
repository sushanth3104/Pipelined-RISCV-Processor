module ImmExtnd(
    input [31:7]Instr,
    input [1:0]InstType,
    output reg [31:0]ImmExt
);

parameter I_Type = 0;
parameter S_Type = 1;
parameter B_Type = 2;
parameter J_Type = 3;


always@(*)begin

    case(InstType)

        I_Type : begin  // Since {srli and srli requires Unsigned Immediate}
            if(Instr[14:12] == 3'b101) ImmExt = {{27{1'b0}},Instr[24:20]}; // 5-Bit Unsigned Immediate in imm[4:0]
            else               ImmExt = {{20{Instr[31]}},Instr[31:20]}; // Signed Immediate
        end
        S_Type : ImmExt = {{20{Instr[31]}},Instr[31:25],Instr[11:7]};
        B_Type : ImmExt = {{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0};
        J_Type : ImmExt = {{12{Instr[31]}},Instr[19:12],Instr[20],Instr[30:21],1'b0};
        default : ImmExt = 32'b0;

    endcase

end


endmodule