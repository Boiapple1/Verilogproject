module half_adder(
    input a, b, 
    output sum, c 
    );    
    
    xor U1(sum, a, b);
    and U2(c, a, b);
    
endmodule

//--------------------------------------------------------------------
module FA(
    input a, b, cin, 
    output sum, cout
    );

    wire w1, w2, w3;
    half_adder HF1(a, b, w1, w2);
    half_adder HF2(cin, w1, sum, w3);
    or U1(cout, w2, w3);
    
endmodule

//--------------------------------------------------------------------
//Full Adder
module FA_16bit(
    input [15:0] a, b, 
    input cin, 
    
    output [15:0] sum, 
    output cout
    );

    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;
    FA F0  (a[0], b[0], cin, sum[0], w1);
    FA F1  (a[1], b[1], w1, sum[1], w2);
    FA F2  (a[2], b[2], w2, sum[2], w3);
    FA F3  (a[3], b[3], w3, sum[3], w4);
    FA F4  (a[4], b[4], w4, sum[4], w5);
    FA F5  (a[5], b[5], w5, sum[5], w6);
    FA F6  (a[6], b[6], w6, sum[6], w7);
    FA F7  (a[7], b[7], w7, sum[7], w8);
    FA F8  (a[8], b[8], w8, sum[8], w9);
    FA F9  (a[9], b[9], w9, sum[9], w10);
    FA F10 (a[10], b[10], w10, sum[10], w11);
    FA F11 (a[11], b[11], w11, sum[11], w12);
    FA F12 (a[12], b[12], w12, sum[12], w13);
    FA F13 (a[13], b[13], w13, sum[13], w14);
    FA F14 (a[14], b[14], w14, sum[14], w15);
    FA F15 (a[15], b[15], w15, sum[15], cout);
        
endmodule 

//-----------------------------------------------------------------------
//multiplier
module multiplier(
    input [15:0] a, b, 
    output [31:0] product
    );

    reg [31:0] S0;
    reg [31:0] S1;

    integer i;
    always @(a,b) begin
        S0 ={16'b0, a[15:0]};     //S0=32'b0;
        S1 = 32'b0;
    for(i=0;i<16;i=i+1) begin
        if(b[i] == 1)
            S1=S1+S0;           //add based on multiplier bit
        else
            S1=S1;
            S0={S0[30:0],1'b0}; //shift in each iteration
        end
    end
    
    assign product=S1[31:0];

endmodule


//------------------------------------------------------------------------
module FS(
    input a, b, bin, 
    output diff, bout
    );

    wire an, w0, w0not, w1, w2;
    not n1(an, a);
    not n2(w0not, w0);
    xor x1(w0, a, b);
    and a1(w1, an, b);
    xor x2(diff, w0, bin);
    and a2(w2, w0not, bin);
    or  o1(bout, w2, w1);

endmodule 

//------------------------------------------------------------------------
//Full Subtractor
module FS_16bit(
    input [15:0]a, b, 
    input bin, 
    
    output [15:0] diff, 
    output bout    
    );
    
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15;
    FS F0  (a[0], b[0], bin, diff[0], w1);
    FS F1  (a[1], b[1], w1, diff[1], w2);
    FS F2  (a[2], b[2], w2, diff[2], w3);
    FS F3  (a[3], b[3], w3, diff[3], w4);
    FS F4  (a[4], b[4], w4, diff[4], w5);
    FS F5  (a[5], b[5], w5, diff[5], w6);
    FS F6  (a[6], b[6], w6, diff[6], w7);
    FS F7  (a[7], b[7], w7, diff[7], w8);
    FS F8  (a[8], b[8], w8, diff[8], w9);
    FS F9  (a[9], b[9], w9, diff[9], w10);
    FS F10 (a[10], b[10], w10, diff[10], w11);
    FS F11 (a[11], b[11], w11, diff[11], w12);
    FS F12 (a[12], b[12], w12, diff[12], w13);
    FS F13 (a[13], b[13], w13, diff[13], w14);
    FS F14 (a[14], b[14], w14, diff[14], w15);
    FS F15 (a[15], b[15], w15, diff[15], bout);    
    
endmodule

//-------------------------------------------------------------------------
//Shift Register
module shiftRegA
  (
    input [15:0] a,
    output [15:0] shift    
  );
  
    assign shift = a >> 1; 
  
endmodule
  
//---------------------------------------------------------------------------
/*
    S0 S1  ALU OP
    0  0   Addition
    0  1   Subtraction 
    1  0   Multiplication
    1  1   Shift Right 
    
    SW switches 1 and 2 should represent S0 and S1. Use SW switch 4 as reset.
    GPIO LEDs should be used to indicate the ALU Operation called.
  
    Store initial values in memory. Display answers in seven-segment display units.
    
*/

module ALU(
    input [15:0] SW,
    input [15:0] a, b,
    
    input cin, bin,
    
    output [6:0] a_to_g,
    output [7:0] an,
    output [8:0] LED,
    output reg caout,          //cout and bout connecting here.
    output reg [31:0] aluout   //wires of the modules connecting to this output reg.
    //input CLK100MHZ
    );
    
    wire cout, bout;
    wire [15:0] sum, diff, shift;
    wire [31:0] product;
    
    reg [15:0] result;
    
    
    FA_16bit   U1(a, b, cin, sum, cout);
    FS_16bit   U2(a, b, bin, diff, bout);
    shiftRegA  U3(a, shift);
    multiplier U4(a, b, product);
    
    assign LED[2:1] = SW[2:1];
    assign LED[4]   = SW[4]; 
        
    always @(SW[2:1], shift, product, sum, diff) begin
        case(SW[2:1])
            2'b00: begin aluout = sum;  caout = cout; end
            2'b01: begin aluout = diff; caout = bout; end
            2'b10: aluout = product;
            2'b11: aluout = shift;
        endcase
    end
    
    always @(SW[4]) begin
        case(SW[4])
            1'b1: aluout    = 16'h0000;
            default: aluout = 16'h0000;
        endcase
    end
     
    /*    
    assign an[0]   = 0;
    assign an[7:1] = 7'b1111111;
    assign a_to_g  = LED[6:0];
    */   
endmodule
