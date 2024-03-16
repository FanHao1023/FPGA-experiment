module fDIV( fin, fout, reset);
input fin, reset;
wire[31:0] Divn;
output fout;
reg fout0;
wire _fout;
wire[31:0] _Divn, ncount;
reg[31:0] count;

assign Divn = 32'd4;
//assign Divn = 32'd434;            //to output a clk of frequency 115200
assign _Divn={1'b0,Divn[31:1]};   //產生除以二的效果

always@(posedge fin)
begin
count <= ncount;
fout0 <= _fout;
end

assign ncount=(count>=Divn)?32'd1:count+1;//counter 
assign _fout=(count>_Divn)?1'b1:1'b0;//make half of the output clk 1 and half of it 0
assign fout=(reset == 1'b0)?1'b0:(Divn<8'd2)?fin:fout0;//防呆機制和reset

endmodule