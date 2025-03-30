
module ProgramCounter
       #( parameter WIDTH = 32)
       (
        input clk,reset,
        input [WIDTH-1:0] pc_in,
        output [WIDTH-1:0] pc_out
       );


    reg [WIDTH-1:0] temp;

    assign pc_out = temp;

    always @(posedge clk ) begin
        temp = reset ? 32'b0 : pc_in;
    end


endmodule
