`timescale 1ns / 1ps


module alu(A,B, Cin,Out1,Cout,Control);
input [3:0] A,B;
input Cin;
output reg [3:0] Out1;
output reg Cout;
input [2:0] Control;

always@(Control)begin
case(Control)

3'b000 :begin Out1 <= A+B+Cin;
              Cout <= (A&B) | (A&Cin)|(B&Cin);end
3'b001 :begin Out1 <= A-B-Cin;
              Cout <=(~A&B)|(~(A^B)&Cin); end
3'b010 :begin Out1 <= A|B;end
3'b011 :begin Out1 <= A&B;end
3'b100 :begin Out1 <= A[2:0] & 0;end
3'b101 :begin Out1 <= 0&A[3:1];end
3'b110 :begin Out1 <= A[2:0]&A[3];end
3'b111 :begin Out1 <= A[0]&A[3:1];end


endcase
end


endmodule
 
module sub1(input A, B, Bin, output Diff,Bout);
assign Diff = A^B^Bin;
assign Bout =(~A&B)|(~(A^B)&Bin);


endmodule

module SUB4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  Bin,
    output [3:0] Diff,
    output Bout
    );
   
    wire [2:0] kBout;
   
    sub1 S1(A[0], B[0], Bin, Diff[0], kBout[0]);
    sub1 S2(A[1], B[1], kBout[0], Diff[1], kBout[1]);
    sub1 S3(A[2], B[2], kBout[1], Diff[2], kBout[2]);
    sub1 S4(A[3], B[3], kBout[2], Diff[3], Bout);
   
endmodule
