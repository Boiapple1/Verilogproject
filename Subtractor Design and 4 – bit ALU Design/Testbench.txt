`timescale 1ns / 1ps
module tbsalu(

    );
reg [3:0] A,B;
reg Cin;
wire [3:0] Out1;
wire Cout;
reg [2:0] Control;
alu t1(A,B, Cin,Out1,Cout,Control);

initial begin
#20;
A=4'b0101;
B=4'b1010;
Cin=0;
Control=3'b000;
#40;
Control=3'b001;
#40;
Control=3'b010;
#40;
Control=3'b011;
#40;
Control=3'b100;
#40;
Control=3'b101;
#40;
Control=3'b110;
#40;
Control=3'b111;
#40;
Cin=1;
Control=3'b000;
#40;
Control=3'b001;
#40;
Control=3'b010;
#40;
Control=3'b011;
#40;
Control=3'b100;
#40;
Control=3'b101;
#40;
Control=3'b110;
#40;
Control=3'b111;

#20;
A=4'b1101;
B=4'b1011;
Cin=0;
Control=3'b000;
#40;
Control=3'b001;
#40;
Control=3'b010;
#40;
Control=3'b011;
#40;
Control=3'b100;
#40;
Control=3'b101;
#40;
Control=3'b110;
#40;
Control=3'b111;
#40;
Cin=1;
Control=3'b000;
#40;
Control=3'b001;
#40;
Control=3'b010;
#40;
Control=3'b011;
#40;
Control=3'b100;
#40;
Control=3'b101;
#40;
Control=3'b110;
#40;
Control=3'b111;


end
endmodule
