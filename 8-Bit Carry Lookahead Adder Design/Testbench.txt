TestBench:
`timescale 1ns / 1ps

module TbA2();

reg [15:0] A,B;
reg Cin;
wire [15:0] S;
wire [3:0]GG,PG;
wire Cout;

CLA8b t1 (A,B,Cin,S,GG,PG, Cout);



initial begin
#20;
A=16'b1111111101111001;
B=16'b1111010101111001;
Cin=0;
#50;
A=16'b0101010101111001;
B=16'b1111010101111001;
Cin=0;

end


endmodule
