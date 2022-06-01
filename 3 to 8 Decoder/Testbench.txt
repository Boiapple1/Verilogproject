`timescale 1ns / 1ps

module dectb();
  reg [2:0] sel;  
  wire [7:0] res; 
  
  Decoder3to8 u1(sel,res);
  
  initial begin
  #10;
  sel=0;
  #20;
  sel=1;
  #20;
  sel=2;
  #20;
  sel=3;
  #20;
  sel=4;
  #20;
  sel=5;
  #20;
  sel=6;
  #20;
  sel=7;  
  end
endmodule
