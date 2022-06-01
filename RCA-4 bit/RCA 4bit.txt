`timescale 1ns / 1ps

module RCA(A,B, S,Cout );

input [3:0] A,B;

output Cout;
output [3:0]S;
wire c1,c2,c3,c4;


FAD t1(A[0],B[0],1'b0,S[0],c1);
FAD t2(A[1],B[1],c1,S[1],c2);
FAD t3(A[2],B[2],c2,S[2],c3);
FAD t4(A[3],B[3],c3,S[3],Cout);

endmodule

module HAD(input A,B, output s,c);

xor  (s,A,B);
and  (c,A,B);

endmodule

module FAD(input A,B, Cin, output S,Cout);
wire s1;
wire c1,c2;

HAD u1(A,B,s1,c1);
HAD u2(Cin,s1,S,c2);
or (Cout,c2,c1);

endmodule
