`timescale 1ns / 1ps
`include "Adder.v"

module tb;

    reg [31:0] A,B;
    wire [31:0] Sum;

    integer i;

    Adder #(.WIDTH(32)) dut(
        .SrcA(A),
        .SrcB(B),
        .Result(Sum)
    );

    initial begin

        $dumpfile("tb.vcd");
        $dumpvars(0, tb);


    end

    initial begin

        for(i = 0 ; i < 20 ; i = i +1)
        begin
            A = $random%300;
            B = $random%300;
            #5;
        end

    end


endmodule
