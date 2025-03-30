module Adder #(parameter WIDTH = 32)(
    
    input [WIDTH-1:0]SrcA,
    input [WIDTH-1:0]SrcB,
    output [WIDTH-1:0]Result

);

    assign Result = SrcA + SrcB;


endmodule