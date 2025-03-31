// Solving RAW Hazard by Fowarding

module HazardUnit(   
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdM,
    input [4:0] RdW,
    input RegWriteM,
    input RegWriteW,
    output [1:0] ForwardAE,
    output [1:0]ForwardBE
);

ForwardingLogic ForwardingLogic(
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);


endmodule



module ForwardingLogic(
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdM,
    input [4:0] RdW,
    input RegWriteM,
    input RegWriteW,
    output [1:0] ForwardAE,
    output [1:0] ForwardBE
);

// Logic For Rs1E
reg [1:0]tempA,tempB;
assign ForwardAE = tempA;
assign ForwardBE = tempB;



always @(*) begin

    if((Rs1E == RdM) & (RegWriteM) & (Rs1E != 0)) begin
        tempA = 2'b10;
    end 
    
    else if((Rs1E == RdW) & (RegWriteW) & (Rs1E != 0)) begin
       tempA = 2'b01;
    end 
    
    else begin
        tempA = 2'b00;
    end
    
end

// Logic For Rs2E

always @(*) begin

    if((Rs2E == RdM) & (RegWriteM) & (Rs2E != 0)) begin
        tempB = 2'b10;
    end 
    
    else if((Rs2E == RdW) & (RegWriteW) & (Rs2E != 0)) begin
        tempB = 2'b01;
    end 
    
    else begin
        tempB = 2'b00;
    end
    
end


endmodule