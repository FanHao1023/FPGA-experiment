module fDiv_10Hz(fin, fout);
input fin;
output fout;
reg fout;
wire[31:0] Divn, _Divn;
reg[31:0] count;
assign _Divn={1'b0,Divn[31:1]};//除數的一半
assign Divn = 32'd5000000;//除數為5000000

always @(posedge fin)
begin
  count=(count>=Divn)?32'd1:count+1;//當count大於Divn，則ncount等於以1，反之等於count加1
  fout=(count>_Divn)?1'b1:1'b0;//當count大於_Divn，則_fout等於以1，反之等於0
end

endmodule 