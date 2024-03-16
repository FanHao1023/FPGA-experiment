module counter (clk,reset,out);
input clk,reset;
output reg [5:0] out;

always @ (posedge clk or posedge reset)
	if(reset == 1'b1)                    //當reset=0時，計數器輸出值歸零
		out <= 6'b0;
	else 
		out <= out + 6'd1;                //正常運作時，每逢clk正緣，計數值加一
		
endmodule