Testbench:
`timescale 1ns / 1ps

module tbRCA( );
reg [3:0] A,B;
wire Cout;
wire [3:0]S;
RCA w1 (A,B, S,Cout);

initial begin

#10;

A=4'b0001;
B=4'b1010;

#20;
A=4'b0011;
B=4'b1110;

#20;

A=4'b1101;
B=4'b1011;





end
endmodule
