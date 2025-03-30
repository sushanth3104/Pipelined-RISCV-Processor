module PipelineReg #(
    parameter WIDTH = 32
)(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end


endmodule