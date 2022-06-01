`timescale 1ns / 1ps

module FAtb();
reg A,B,Cin;
wire Sum,Cout;

FADR u1(A, B, Cin,Cout,Sum);


initial begin
#40;

A=1'b1;
B=1'b0;
Cin=1'b0;
#40;

A=1'b0;
B=1'b1;
Cin=1'b0;

#40;

A=1'b1;
B=1'b1;
Cin=1'b0;

#40;

A=1'b0;
B=1'b0;
Cin=1'b1;
#40;

A=1'b0;
B=1'b1;
Cin=1'b1;

end

endmodule
