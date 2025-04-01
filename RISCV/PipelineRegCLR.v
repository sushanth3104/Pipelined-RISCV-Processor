module PipelineRegCLR #(
    parameter WIDTH = 32
)(
    input wire clk,
    input wire rst,clr,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk) begin
        if (rst|clr) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end


endmodule