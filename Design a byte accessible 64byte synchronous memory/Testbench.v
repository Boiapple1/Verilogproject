`timescale 1ns / 1ps


module MMtb(

    );
    reg clk, rst; 
    reg      read_enable;
reg     write_enable;
reg[5:0] address;
reg[7:0] write_data;
wire[7:0] read_data;


MM t1(write_data,read_data,address, read_enable,write_enable,rst, clk);


initial 
begin
    clk = 0;
   forever #10 clk = ~clk;
end

initial begin 
    rst = 0;
    # 20 rst = 1;

    end

initial begin
#40
write_enable=1'b1;
read_enable=1'b0;
address =6'b000001;
write_data =7'b01010101;
#40;
write_enable=1'b1;
read_enable=1'b0;
address =6'b000011;
write_data =7'b01110101;
#40;
write_enable=1'b0;
read_enable=1'b1;
address =6'b000001;
#40;
write_enable=1'b0;
read_enable=1'b1;
address =6'b000011;
#40;
write_enable=1'b1;
read_enable=1'b1;
address =6'b000011;
write_data =7'b01111101;
#40;
write_enable=1'b0;
read_enable=1'b1;
address =6'b000011;
#20
rst=0;
end

endmodule
