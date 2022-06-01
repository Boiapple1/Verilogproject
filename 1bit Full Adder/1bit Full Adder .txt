`timescale 1ns / 1ps

module FADR(A, B, Cin,Cout,Sum);
input A,B,Cin;
output Cout, Sum;
reg Cout, Sum;
// Process for full adder
always@(*)begin
Sum= (~A&~B&Cin)+(~A&B&~Cin)+(A&~B&Cin)+(A&B&Cin);
Cout= B&Cin+A&Cin+A&B;
end
endmodule
