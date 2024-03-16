module fDIV2( fin, fout, reset);
input fin, reset;
wire[31:0] Divn;
output fout;
reg fout0;
wire _fout;
wire[31:0] _Divn, ncount;
reg[31:0] count;

//assign Divn = 32'd4;                                  //波形模擬用
assign Divn = 32'd2000;                                 //要將50MHz變成25KHz就要將除數設為2000
assign _Divn={1'b0,Divn[31:1]};                         //利用位移來產生除以二的效果 

always@(posedge fin)                             
	begin 
		count <= ncount;                                  //每逢clk正緣更新計數值
		fout0 <= _fout;                                   //每逢clk正緣更新輸出波形
	end

assign ncount=(count>=Divn)?32'd1:count+1;              //計數
assign _fout=(count>_Divn)?1'b1:1'b0;                   //產生一半為1，一半為0之波形
assign fout=(reset == 1'b1)?1'b0:(Divn<8'd2)?fin:fout0; //防呆機制

endmodule