`timescale 1ns/1ps
`include "ProgramCounter.v"

module tb;

parameter WID = 32 ;

reg [WID-1:0] pc_in;
reg clk,reset;
wire [WID-1:0] pc_out;

ProgramCounter #(.WIDTH(32)) dut(
    .clk(clk),
    .reset(reset),
    .pc_in(pc_in),
    .pc_out(pc_out)
);

always #5clk =  ~clk;

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,tb);
end

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;

    pc_in = 32'b0;
    #10 pc_in = 32'b1;  
    #10 pc_in = 32'b10;
    #10 pc_in = 32'b11;
    #10 pc_in = 32'b100;
    #2 reset = 1;
    #10 reset = 0;
    #10 $finish;

end



endmodule