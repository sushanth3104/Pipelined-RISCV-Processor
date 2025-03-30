module InstructionMemory (
    input [31:0] readAddr,
    output [31:0] inst
);
    
    
    // For simplicty taking smaller memory
    integer i;
    reg [7:0] insts [255:0];
    
    assign inst = (readAddr > 255) ? 32'b0 : {insts[readAddr+3], insts[readAddr + 2], insts[readAddr + 1], insts[readAddr]};

    initial begin

            for(i = 0; i < 256; i = i + 1) begin
                insts[i] = 8'b0;
            end

            $readmemb("instructions.txt", insts);
    end


endmodule

