module fDIV( fin, Divn_in, fout);
input fin;                         //輸入頻率(clk)
input [1:0] Divn_in;               //輸入除數(還沒有解碼)
reg [31:0] Divn;                   //解碼後的除數
output fout;                       //輸出頻率
reg fout0;                         //暫存值
wire _fout;                        //為了產生一半為1一半為0的暫存值 
wire[31:0] _Divn, ncount;          //next state value
reg[31:0] count;                   //計數

always@(Divn_in)                   //此always block是用來解碼
begin
	case(Divn_in)
		2'b00 : Divn = 32'd512000;
		2'b01 : Divn = 32'd1024000;
		2'b10 : Divn = 32'd2048000;
		2'b11 : Divn = 32'd4096000;
	endcase
end

/* 為了波形模擬所寫的解碼器
always@(Divn_in)
begin
	case(Divn_in)
		2'b00 : Divn = 32'd2;
		2'b01 : Divn = 32'd4;
		2'b10 : Divn = 32'd8;
		2'b11 : Divn = 32'd16;
	endcase
end
*/

assign _Divn={1'b0,Divn[31:1]};    //利用右移來產生除以二的效果
                                   //為了判斷輸出要為1或是0
always@(posedge fin)               //assign next state value to 
begin                              //current state value 
count <= ncount;
fout0 <= _fout;
end

assign ncount=(count>=Divn)?32'd1:count+1;//判斷計數器何時要從1重新開始數
assign _fout=(count>_Divn)?1'b1:1'b0;     //產生一半為1一半為0的輸出 
assign fout=(Divn<8'd2)?fin:fout0;        //防呆機制

endmodule