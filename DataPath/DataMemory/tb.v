`include "DataMemory.v"
`timescale 1ns/1ps

module tb;
    reg [31:0] A,WD;
    reg CLK,WE;
    wire [31:0] RD;
    integer i;

    DataMemory #(32) DM(.A(A),.WD(WD),.CLK(CLK),.WE(WE),.RD(RD));

    always #5 CLK = ~CLK;

    initial begin
        CLK = 0;
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
        #500 $finish;
    end

    initial
    begin
        #1 ;
        WE = 1;
        for(i = 0; i < 32 ; i = i + 1 )
        begin
            
            A = i*4;
            WD = $urandom;
            #10;
            $display("A = %d, WD = %d, Memory Value = %d",A,WD,{DM.mem[A+3],DM.mem[A+2],DM.mem[A+1],DM.mem[A]});
        end


        WE = 0;
        #1;
        for(i = 0; i < 36 ; i = i + 1 )
        begin
            
            A = i*4;
            #10;
        end
    end

endmodule