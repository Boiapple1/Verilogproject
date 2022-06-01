`timescale 1ns / 1ps



module CLA4b(A,B,Cin,S,GG,PG,Cout);
input [3:0] A,B;
output [3:0] S;
input Cin;
output GG, PG, Cout;
wire C0,C1, C2;
wire G0,G1,G2,G3;
wire P0,P1,P2,P3;

 PFA t1(A[0], B[0],Cin,S[0], G0, P0);
 PFA t2(A[1], B[1],C0,S[1], G1, P1);
 PFA t3(A[2], B[2],C1,S[2], G2, P2);
 PFA t4(A[3], B[3],C2,S[3], G3, P3);
 assign C0= G0|(P0&Cin);
 assign C1 = G1|(P1&G0)|(P1&P0&Cin);
 assign C2 = G2|(P2&G1)|(P2&P1&G0)|(P2&P1&P0&Cin);
 assign Cout = G3|(P3&G2)|(P3&P2&G1)|(P3&P2&P1&G0)|(P3&P2&P1&Cin);
 assign PG = P3&P2&P1&P0;
 assign GG = G3|P3&G2|P3&P2&G1|P3&P2&P1&G0;

endmodule

module PFA(A, B, C, S, G, P);
input A,B,C;
output S,G,P;


xor u1(P,A,B);
and u2(G,A,B);
xor u3(S,P,C);

endmodule


module CLA8b(A,B,Cin,S,GG,PG,Cout);
input [15:0] A,B;
input Cin;
output [15:0] S;
output [3:0]GG,PG;
output Cout;
wire C1,C2,C3;

CLA4b t1(A[3:0],B[3:0],Cin,S[3:0],GG[0],PG[0],C1);
CLA4b t2(A[7:4],B[7:4],C1,S[7:4],GG[1],PG[1],C2);
CLA4b t3(A[11:8],B[11:8],C2,S[11:8],GG[2],PG[2],C3);
CLA4b t4(A[15:12],B[15:12],C3,S[15:12],GG[3],PG[3],Cout);


Endmodule
