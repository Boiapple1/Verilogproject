`timescale 1ns / 1ps

module mux16(sel, res);  
  input [3:0] sel;  
  output [15:0] res;  
  reg [15:0] res;  
//Mux 16
  always @(sel or res)  
  begin  
    case (sel)  
      4'b0000 : res = 16'h0; 
      4'b0001 : res = 16'h1;
      4'b0010 : res = 16'h2;
      4'b0011 : res = 16'h3;  
      4'b0100 : res = 16'h4;  
      4'b0101 : res = 16'h5;  
      4'b0110 : res = 16'h6;  
      4'b0111 : res = 16'h7;
      4'b1000 : res = 16'h8; 
      4'b1001 : res = 16'h9;
      4'b1010 : res = 16'ha;
      4'b1011 : res = 16'hb;  
      4'b1100 : res = 16'hc;  
      4'b1101 : res = 16'hd;  
      4'b1110 : res = 16'he;  
      4'b1111 : res = 16'hf;
      default : res = 16'hx;  
    endcase  
    end
  endmodule
