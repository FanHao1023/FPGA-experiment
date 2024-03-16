module fDIV( fin, sel, reset, fout);
input fin,reset;                                   
input[3:0] sel;
output fout;
reg fout0;
wire _fout;
wire[31:0] _Divn, ncount;
reg [31:0] Divn;
reg[31:0] count;


always @ (sel)                                       //透過sel訊號來選擇除數為多少
	case(sel)
	4'd0 : Divn <= 32'd25000000;
	4'd1 : Divn <= 32'd12500000;
	4'd2 : Divn <= 32'd6250000;
	4'd3 : Divn <= 32'd3125000;
	default : Divn <= 32'd1;
	endcase

/*	波型模擬用
always @ (sel)
	case(sel)
	4'd0 : Divn <= 32'd2;
	4'd1 : Divn <= 32'd4;
	4'd2 : Divn <= 32'd6;
	4'd3 : Divn <= 32'd8;
	default : Divn <= 32'd1;
	endcase
*/
	
assign _Divn={1'b0,Divn[31:1]};                        //利用位移的方式來產生除以二的效果

always@(posedge fin)                                   
begin
count <= ncount;                                       //每逢正緣要更新計數值
fout0 <= _fout;                                        //每逢正緣要更新波形
end

assign ncount=(count>=Divn)?32'd1:count+1;             //計數
assign _fout=(count>_Divn)?1'b1:1'b0;                  //用來產生一半為1，一半為0之波形
assign fout=(reset==1'b1)?1'b0:(Divn<8'd2)?fin:fout0;  //防呆機制

endmodule