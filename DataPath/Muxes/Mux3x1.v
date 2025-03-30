module #(parameter WIDTH = 32) Mux3x1 (
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] C,
    input [2:0] S,
    output [WIDTH-1:0] Y
);

    reg [WIDTH-1:0] temp  ;

    assign Y = temp;

    always @(*) begin
        case(S)
            3'b000: temp = A;
            3'b001: temp = B;
            3'b010: temp = C;
            default: temp = 0;
        endcase
    end

endmodule