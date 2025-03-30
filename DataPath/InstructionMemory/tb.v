`timescale 1ns/1ps
`include "InstructionMemory.v"

module tb;

parameter WIDTH = 32;

reg [WIDTH-1:0] readAddr;
wire [WIDTH-1:0] inst;

InstructionMemory im (
    .readAddr(readAddr),
    .inst(inst)
);

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    readAddr = 0;
    #10;
    readAddr = 4;
    #10;
    readAddr = 8;
    #10;
    readAddr = 12;
    #10;
    readAddr = 16;
    #10;
    readAddr = 20;
    #10;    
    readAddr = 24;
    #10;
    $finish;

end


endmodule