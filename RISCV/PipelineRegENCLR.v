module PipelineRegENCLR #(
    parameter WIDTH = 32
)(
    input wire clk,
    input wire rst,clr,Enable,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk) begin
        if (rst|clr) begin
            q <= 0;
        end else begin
            q <= ~Enable ? d : q;
        end
    end


endmodule