module Serial_Out (clk, start, Din, D);
input clk, start;
input [15:0] Din;
output D;
reg [15:0] Buf;  //暫存值
wire [15:0] nBuf;  //下一個暫存值

assign nBuf = {Buf[14:0],Buf[15]};  //將現在的暫存值左移，因為要依序輸出最高位元

assign D = Buf[15];                 //輸出最高位元

always @ (posedge clk)
	if (start == 1'd1)               //start=1時讀取輸入並儲存到暫存器
		Buf <= Din; 
	else
		Buf <= nBuf;                  //start=0時將暫存器的最高位元依序輸出
		
endmodule
