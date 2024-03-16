module fDIV( fin, fout);
input fin;
wire [31:0] Divn;
output fout;
reg fout0;                                      //fout的暫存值
wire _fout;
wire[31:0] _Divn, ncount;
reg[31:0] count;

assign Divn = 32'd3750000;                      //將FPGA板的頻率(50MHz)轉換為最短音符長度(32分音符)
//assign Divn = 32'd4;                          //跑波型模擬用 
assign _Divn={1'b0,Divn[31:1]};                 //產生Divn/2的結果 

always@(posedge fin)
	begin
		count <= ncount;                          //update count value
		fout0 <= _fout;                           //update fout0 value
	end

assign ncount=(count>=Divn)?32'd1:count+1;      //確認計數值是否數超過除數的值，看是否要從一重新開始
assign _fout=(count>_Divn)?1'b1:1'b0;           //產生一半為1一半為0的波型
assign fout=(Divn<8'd2)?fin:fout0;              //防呆機制

endmodule