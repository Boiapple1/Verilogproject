module risc(clk,reset,opcode,instr);
input clk,reset;
input [3:0]opcode;
input [11:0]instr;
wire [3:0]opcode;
wire [11:0]instr;
wire clk,reset;
wire D_addr_sel,rd,wr,RF_s1,RF_s0,W_wr,rp_rd,rq_rd,alu_s1,alu_s0;
wire [7:0]D_addr;
wire [7:0]RF_w_data;
wire [3:0]RF_rp_addr;
wire [3:0]RF_rq_addr;
wire [3:0]RF_w_addr;
wire [7:0]PC_addr;
control_unit controlpath(opcode,instr,PC_addr,D_addr_sel,D_addr,rd,wr,RF_w_data,RF_s1,RF_s0,RF_w_addr,RF_rp_addr,RF_rq_addr,W_wr,rp_rd,rq_rd,alu_s1,alu_s0);
data_path datapath(clk,reset,opcode,PC_addr,D_addr_sel,D_addr,rd,wr,RF_w_data,RF_s1,RF_s0,RF_w_addr,RF_rp_addr,RF_rq_addr,W_wr,rp_rd,rq_rd,alu_s1,alu_s0);
endmodule


// control unit
module control_unit(opcode,instr,PC_addr,D_addr_sel,D_addr,rd,wr,RF_w_data,RF_s1,RF_s0,RF_w_addr,RF_rp_addr,RF_rq_addr,W_wr,rp_rd,rq_rd,alu_s1,alu_s0);
input [3:0]opcode;
input [11:0]instr;
output [7:0]PC_addr;
output D_addr_sel,rd,wr,RF_s1,RF_s0,W_wr,rp_rd,rq_rd,alu_s1,alu_s0;
output [7:0]D_addr;
output [7:0]RF_w_data;
output [3:0]RF_rp_addr;
output [3:0]RF_rq_addr;
output [3:0]RF_w_addr;
reg D_addr_sel,rd,wr,RF_s1,RF_s0,W_wr,rp_rd,rq_rd,alu_s1,alu_s0;
reg [7:0]D_addr;
reg [7:0]RF_w_data;
reg [3:0]RF_rp_addr;
reg [3:0]RF_rq_addr;
reg [3:0]RF_w_addr;
reg [7:0]PC_addr;
always@(opcode)
begin
case(opcode)
4'b1000: begin //load word
D_addr={instr[7:0]};
PC_addr=0;
rd=1;
wr=0;
D_addr_sel=1;
RF_s1=1;
RF_s0=0;
RF_w_addr={instr[11:8]};
RF_w_data=0;
W_wr=1;
rp_rd=0;
rq_rd=0;
alu_s1=0;
alu_s0=0;
RF_rp_addr=0;
RF_rq_addr=0;
end
4'b1001: begin //add operation by alu
PC_addr=0;
D_addr=0;
rd=0;
wr=0;
D_addr_sel=0;
RF_s1=0;
RF_s0=0;
RF_w_addr={instr[11:8]};
RF_w_data=1;
W_wr=1;
rp_rd=1;
rq_rd=1;
alu_s1=1;
alu_s0=0;
RF_rp_addr={instr[3:0]};
RF_rq_addr={instr[7:4]};
end
4'b1010: begin //store word
PC_addr=0;
D_addr={instr[11:4]};
rd=0;
wr=1;
D_addr_sel=1;
RF_s1=0;
RF_s0=0;
RF_w_addr=0;
RF_w_data=0;
W_wr=0;
rp_rd=1;
rq_rd=0;
alu_s1=0;
alu_s0=1;
RF_rp_addr={instr[3:0]};
RF_rq_addr=0;
end
4'b1011: begin //simple jump
PC_addr={instr[7:0]};
D_addr=0;
rd=1;
wr=0;
D_addr_sel=0;
RF_s1=0;
RF_s0=0;
RF_w_addr=0;
RF_w_data=0;
W_wr=0;
rp_rd=0;
rq_rd=0;
alu_s1=0;
alu_s0=0;
RF_rp_addr=0;
RF_rq_addr=0;
end
endcase
end
endmodule



// Data Path
module data_path(clk,reset,opcode,PC_addr,D_addr_sel,D_addr,rd,wr,RF_w_data,RF_s1,RF_s0,RF_w_addr,RF_rp_addr,RF_rq_addr,W_wr,rp_rd,rq_rd,alu_s1,alu_s0);
input clk,reset;
input [3:0]opcode;
input D_addr_sel,rd,wr,RF_s1,RF_s0,W_wr,rp_rd,rq_rd,alu_s1,alu_s0;
input [7:0]D_addr;
input [7:0]PC_addr;
input [7:0]RF_w_data;
input [3:0]RF_rp_addr;
input [3:0]RF_rq_addr;
input [3:0]RF_w_addr;
wire clk,reset;
wire [3:0]opcode;
wire D_addr_sel,rd,wr,RF_s1,RF_s0,W_wr,alu_s1,alu_s0;
wire [7:0]D_addr;
wire [7:0]PC_addr;
wire [7:0]RF_w_data;
wire [3:0]RF_rp_addr;
wire [3:0]RF_rq_addr;
wire [3:0]RF_w_addr;
wire [7:0] addr;
reg [15:0] w_data;
wire [15:0] r_data;
wire [15:0] mux3_data;
wire [15:0] alu_out;
wire [15:0] rp_data;
wire [15:0] rq_data;
mux_2to1 m1(addr,PC_addr,D_addr,D_addr_sel);
ram r1(clk,addr,w_data,r_data,rd,wr);
mux_3to1 m2(mux3_data,alu_out,r_data,RF_w_data,RF_s0,RF_s1);
register_bank bank1(rp_data,rq_data,clk,mux3_data,W_wr,rp_rd,rq_rd,RF_w_addr,RF_rp_addr,RF_rq_addr);
alu16 a1(rp_data,rq_data,alu_s0,alu_s1,alu_out);
always@(opcode)
begin
case(opcode)
4'b1010: begin
w_data=0;
#25;
w_data=rp_data;
end
default: w_data=0;
endcase
end
mux_3to1 m3(mux3_data,alu_out,r_data,RF_w_data,RF_s0,RF_s1);
register_bank bank2(rp_data,rq_data,clk,mux3_data,W_wr,rp_rd,rq_rd,RF_w_addr,RF_rp_addr,RF_rq_addr);
ram r2(clk,addr,w_data,r_data,rd,wr);
endmodule


// 2x1 MUX
module mux_2to1(z,a,b,s);
input [7:0]a;
input [7:0]b;
input s;
output [7:0]z;
wire [7:0]z;
assign z = s ? a : b ;
endmodule


// RAM
module ram(clk, addr,w_data,r_data,rd,wr);
input clk ;
input [15:0]w_data;//input port
input [7:0]addr;
input rd ;
input wr ;
output [15:0]r_data ;//inout port
//--------------Internal variables----------------
reg [15:0]data ;
reg [15:0] mem [255:0];
//--------------Code Starts Here------------------
assign r_data = (rd)?data:16'bz;
// Memory Write Block
// Write Operation : When wr = 1
always @ (posedge clk)
begin : MEM_WRITE
if ( wr ) begin
mem[addr] = w_data;
end
end
// Memory Read Block
// Read Operation : When rd = 1
always @ (addr or rd )
begin : MEM_READ
mem[1]=16'b0000000000000100;
mem[2]=16'b0000000000000110;
if (rd) begin
data = mem[addr];
end
end
endmodule


module mux_3to1(z,a,b,c,s0,s1);
input [15:0]a,b,c ;
input s0,s1;
output [15:0]z;
reg [15:0]z;
always@(a or b or c or s0 or s1)
begin
if(s0==1'b0 && s1==1'b0) z=a;
if(s0==1'b0 && s1==1'b1) z=b;
else z=c;
end
endmodule


// Register Bank
module register_bank(Rp_data,Rq_data,clk,W_data,W_wr,Rp_rd,Rq_rd,W_addr,Rp_addr,Rq_addr);
input [3:0] W_addr,Rp_addr,Rq_addr;
input clk,W_wr,Rp_rd,Rq_rd;
input [15:0] W_data;
output [15:0] Rp_data , Rq_data;
reg [15:0] Register [15:0];
reg [15:0] Rp_data , Rq_data;
always@(posedge clk)
begin
if(W_wr == 1)
Register[W_addr]= W_data;
else
Register[W_addr]=0;
end
always@(Rp_rd or Rq_rd)
begin
if(Rp_rd==1)
Rp_data = Register[Rp_addr];
else
Rp_data=0;
if(Rp_rd==1)
Rq_data = Register[Rq_addr];
else
Rq_data=0;
end
endmodule


// ALU
module alu16(a,b,s0,s1,c);
input [15:0]a;
input [15:0]b;
input s0,s1;
output [15:0]c;
reg [15:0] c;
always@(a or b)
begin
if(s0==1'b0 && s1==1'b1) c=a+b;
if(s0==1'b1 && s1==1'b0) c=a;
else c=0;
end
endmodule


// PC
module PC(clk,rst,pc_ld,pc_clr,pc_inc,k,pc);
input clk,rst,pc_clr;
input pc_inc,pc_ld;
input [7:0]k;
output [7:0]pc;
reg [7:0]pc;
always@(posedge clk or posedge rst)
if(rst)
pc <= 8'b0000_0000;
else if(pc_clr)
pc <=8'b0000_0000;
else
begin
if(pc_ld)
begin
if(pc_inc)
pc <= pc + 8'b0000_0001;
else
pc <= pc + k;
end
else
pc <= pc;
end
endmodule


// Instruction Register
module instruction_register(clk,ir_in,ir_id,ir_out);
input [15:0]ir_in;
input ir_id,clk;
output [15:0]ir_out;
reg [15:0]ir_out;
always@(posedge clk)
begin
if(ir_id) ir_out <= ir_in;
end
/*always@(ir_id or ir_in)
begin
if(ir_id) begin
ir_reg=ir_in;
end
else begin
ir_reg=16'bz;
end
end*/
endmodule


// Controller
module controller([11:0]instr_data,[3:0]RF_W_addr,[3:0]RF_Rp_addr,[3:0]RF_Rq_addr,[7:0]D_addr);
input [11:0] instr_data;
input clk;
output [3:0]RF_W_addr,RF_Rp_addr,RF_Rq_addr;
output [7:0]D_addr;
reg [3:0] RF_W_data,RF_Rp_addr,RF_Rq_addr;
reg [7:0]D_addr;
always@(posedge clk)
begin
RF_W_addr <= instr_data[11:8];
RF_Rp_addr <= instr_data[7:4];
RF_Rq_addr <= instr_data[3:0];
D_addr <= instr_data[7:0];
end
endmodule
