`include "PipelineRISCV.v"
`timescale 1ns/1ps

module tb;

    reg clk,reset;


    wire [31:0]X0,ra,sp,gp,tp,t0,t1,t2,s0,s1,a0,a1,a2,a3,a4,a5,a6,a7,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,t3,t4,t5,t6;

    wire [31:0]min,max;


    assign X0 = riscv_DUT.RegisterFile.regfile[0];
    assign ra = riscv_DUT.RegisterFile.regfile[1];
    assign sp = riscv_DUT.RegisterFile.regfile[2];
    assign gp = riscv_DUT.RegisterFile.regfile[3];
    assign tp = riscv_DUT.RegisterFile.regfile[4];
    assign t0 = riscv_DUT.RegisterFile.regfile[5];
    assign t1 = riscv_DUT.RegisterFile.regfile[6];
    assign t2 = riscv_DUT.RegisterFile.regfile[7];
    assign s0 = riscv_DUT.RegisterFile.regfile[8];
    assign s1 = riscv_DUT.RegisterFile.regfile[9];
    assign a0 = riscv_DUT.RegisterFile.regfile[10];
    assign a1 = riscv_DUT.RegisterFile.regfile[11];
    assign a2 = riscv_DUT.RegisterFile.regfile[12];
    assign a3 = riscv_DUT.RegisterFile.regfile[13];
    assign a4 = riscv_DUT.RegisterFile.regfile[14];
    assign a5 = riscv_DUT.RegisterFile.regfile[15];
    assign a6 = riscv_DUT.RegisterFile.regfile[16];
    assign a7 = riscv_DUT.RegisterFile.regfile[17];
    assign s2 = riscv_DUT.RegisterFile.regfile[18];
    assign s3 = riscv_DUT.RegisterFile.regfile[19];
    assign s4 = riscv_DUT.RegisterFile.regfile[20];
    assign s5 = riscv_DUT.RegisterFile.regfile[21];
    assign s6 = riscv_DUT.RegisterFile.regfile[22];
    assign s7 = riscv_DUT.RegisterFile.regfile[23];
    assign s8 = riscv_DUT.RegisterFile.regfile[24];
    assign s9 = riscv_DUT.RegisterFile.regfile[25];
    assign s10 = riscv_DUT.RegisterFile.regfile[26];
    assign s11 = riscv_DUT.RegisterFile.regfile[27];
    assign t3 = riscv_DUT.RegisterFile.regfile[28];
    assign t4 = riscv_DUT.RegisterFile.regfile[29];
    assign t5 = riscv_DUT.RegisterFile.regfile[30];
    assign t6 = riscv_DUT.RegisterFile.regfile[31];


    //assign max = {riscv_DUT.DataMemory.mem[43],riscv_DUT.DataMemory.mem[42],riscv_DUT.DataMemory.mem[41],riscv_DUT.DataMemory.mem[40]};
    //assign min = {riscv_DUT.DataMemory.mem[47],riscv_DUT.DataMemory.mem[47],riscv_DUT.DataMemory.mem[45],riscv_DUT.DataMemory.mem[44]};


    PipelineRISCV riscv_DUT(clk,reset);




    initial begin

        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
        #500 $finish;
    end

    always #1 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        #5 reset = 0;



    end





endmodule