`timescale 1ns / 1ps

module MM(write_data,read_data,address, read_enable,write_enable,rst, clk

    );
    
    input [7:0]write_data;
    input [5:0]address;
    input write_enable, read_enable;
    input rst;
    input clk;
    output [7:0]read_data;
    reg[7:0] read_data;
    
integer out, i;


reg [7:0] memory_ram_d [7:0];
reg [7:0] memory_ram_q [7:0];



always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<8; i=i+1)
            memory_ram_q[i] <= 0;
    end
    else
    begin
        for (i=0;i<8; i=i+1)
             memory_ram_q[i] <= memory_ram_d[i];
    end
end


always @(*)
begin
    for (i=0;i<8; i=i+1)
        memory_ram_d[i] = memory_ram_q[i];
    if (write_enable && !read_enable)begin
        memory_ram_d[address] = write_data;end
    if (!write_enable && read_enable)begin
        read_data = memory_ram_q[address];end
        
    if (write_enable && read_enable)begin
        read_data <= memory_ram_q[address];
        memory_ram_d[address] <= write_data;
       end

end
 
endmodule
