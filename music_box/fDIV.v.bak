module fDIV( fin, Divn, fout);
input fin;
input[31:0] Divn;
output fout;
reg fout0;
wire _fout;
wire[31:0] _Divn, ncount;
reg[31:0] count;

assign _Divn={1'b0,Divn[31:1]};

always@(posedge fin)
begin
count <= ncount;
fout0 <= _fout;
end

assign ncount=(count>=Divn)?32'd1:count+1;
assign _fout=(count>_Divn)?1'b1:1'b0;
assign fout=(Divn<8'd2)?fin:fout0;

endmodule