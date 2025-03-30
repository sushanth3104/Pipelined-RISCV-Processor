
module DataMemory
    #(parameter Width = 32 )
    (input [Width-1:0]A,
     input [Width-1:0]WD,
     input CLK,WE,
     output [Width-1:0]RD
    );

    reg [7:0] mem[255:0]; // Little Endian - Less memory is chosen for simulation

    always @(posedge CLK)
    begin
        if(WE)
            {mem[A+3],mem[A+2],mem[A+1],mem[A]} <= WD;
    end

    assign RD =  A > 255 ? 0 : {mem[A+3],mem[A+2],mem[A+1],mem[A]};


endmodule