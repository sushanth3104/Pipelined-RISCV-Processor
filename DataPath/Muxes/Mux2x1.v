module Mux2x1 #(parameter WIDTH = 32)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input S,
    output [WIDTH-1:0] Y
);

    assign Y = S ? B : A;

endmodule