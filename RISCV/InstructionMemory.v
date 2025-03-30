module InstructionMemory (
    input [31:0] readAddr,
    output [31:0] inst
);
    
    
    // For simplicty taking smaller memory

    reg [7:0] insts [255:0];
    
    assign inst = (readAddr > 255) ? 32'b0 : {insts[readAddr+3], insts[readAddr + 2], insts[readAddr + 1], insts[readAddr]};

    initial begin
        $readmemb("instructions.txt", insts);
    end


endmodule

