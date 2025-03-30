module RegisterFile
    #(parameter ADDR_WIDTH = 5,parameter DATA_WIDTH = 32)
    (input [ADDR_WIDTH-1:0]A1,A2,A3,
     input [DATA_WIDTH-1:0]WD3,
     input CLK,reset,
     input WE3,
     output [DATA_WIDTH-1:0]RD1,RD2 );
     integer i;

     reg [DATA_WIDTH-1:0] regfile[2**ADDR_WIDTH-1:0];


     // Ensures X0 = 0 
     assign RD1 = (A1 == 0)? 0 : regfile[A1];
     assign RD2 = (A2 == 0)? 0 :regfile[A2];



     always @(posedge CLK) begin  
               if(reset) 
              begin
                for(i=0;i<2**ADDR_WIDTH;i=i+1)
                 begin
                     regfile[i] <= 0;
                 end
              end
              
              else
              begin
                     if(WE3) regfile[A3] <= WD3;
              end

     end




endmodule