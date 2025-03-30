`timescale 1ns/1ps
`include "RegisterFile.v"

module tb;

    parameter ADDR_WIDTH = 5;
    parameter DATA_WIDTH = 32;

    reg [ADDR_WIDTH-1:0] A1,A2,A3;
    reg [DATA_WIDTH-1:0] WD3;
    reg CLK,WE3;
    wire [DATA_WIDTH-1:0] RD1,RD2;

    integer i;

    RegisterFile #(ADDR_WIDTH,DATA_WIDTH) RF1(.A1(A1),.A2(A2),.A3(A3),.WD3(WD3),.CLK(CLK),.WE3(WE3),.RD1(RD1),.RD2(RD2));

    always #5 CLK = ~CLK;

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
        #1000 $finish;
    end

    initial begin   // Initialise Register File

        CLK = 0;
        WE3 = 1;

        for(i = 0 ; i < DATA_WIDTH ; i = i + 1) begin
            
            A3 = i;
            WD3 =i;
        #10;
        end
        WE3 = 0;

        for(i = 0 ; i < DATA_WIDTH ; i = i + 1) begin
        #4 A1 = $urandom%32;
        #4 A2 = $urandom%32;
      
        end

       


    end



endmodule