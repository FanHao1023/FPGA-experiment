module cmp (a,b,out);
input [5:0] a,b;
output reg out;

always @ (*)
	out = (a >= b) ? 1'b1 : 1'b0;   //比較a是否大於b(是的話會輸出1)
	
endmodule