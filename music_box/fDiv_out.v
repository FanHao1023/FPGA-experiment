module fDiv_out(reset, Divn, fin, fout);
input fin, reset;
input [31:0] Divn;                                          //除數由音高記憶體的輸出決定
output fout;                    
reg fout0;                                                  //fout的暫存值
wire _fout;
wire[31:0] _Divn, ncount;
reg[31:0] count;

assign _Divn={1'b0,Divn[31:1]};                             //產生Divn/2的值 

always@(posedge fin)
begin
	count <= ncount;                                         //update count value
	fout0 <= _fout;                                          //update fout vlaue
end

assign ncount=(count>=Divn)?32'd1:count+1;                  //確認計數值是否數超過除數的值，看是否要從一重新開始
assign _fout=(count>_Divn)?1'b1:1'b0;                       //產生一半為1一半為0的波型
assign fout=(reset == 1'd1)? 1'd0 : (Divn<8'd2)?fin:fout0;  //reset以及防呆機制，如果reset=1，代表音樂要停止，因此輸出頻率歸零

endmodule