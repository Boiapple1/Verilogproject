`timescale 1ns / 1ps



module mux16tb();

  reg [3:0] sel;  
  reg [15:0] res;
  wire out1;
  mux16 u1(sel,res,out1);
   
  initial begin
  
  #20;
  res[15:8] =8'b11111111;
  res[7:0] =0;
  #20;
  
  sel = 4'h5;
  #10;
  
  sel =4'hb;
  #10;
  
  sel = 4'h2;
  #10;
  sel = 4'he;
  
  end
endmodule
