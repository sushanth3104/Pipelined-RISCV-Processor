// Solving RAW Hazard by Fowarding

module HazardUnit(   
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdM,
    input [4:0] RdW,
    input RegWriteM,
    input RegWriteW, // Upto here :Forwarding

    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] RdE,
    input [1:0] ResultSrcE, // Upto here : Lw Hazard

    input PCSrcE, // Upto here : Control Hazard
    output FlushD, // Upto here output : Control Hazard

    output StallF,
    output StallD,
    output FlushE, // Upto here output : Lw Hazard
    

    output [1:0] ForwardAE,
    output [1:0]ForwardBE /// Upto here output :Forwarding
);


wire FlushElw;

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


lwStall lwStall(
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .RdE(RdE),
    .ResultSrcE(ResultSrcE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushE(FlushElw)
);


// Control Hazard 

assign FlushD = PCSrcE;
assign FlushE  =  FlushElw | PCSrcE; // FlushE is high when there is a control hazard or a lw hazard




endmodule




module lwStall(
    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] RdE,
    input [1:0]ResultSrcE,
    output StallF,StallD,FlushE
);

reg templw;

always @(*) begin
    
    if((ResultSrcE == 2'b01) && ((Rs1D == RdE) || (Rs2D == RdE))) begin
        templw = 1'b1;
    end 
    
    else begin
        templw = 1'b0;
    end
end

assign StallF = templw;
assign StallD = templw;
assign FlushE = templw;


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