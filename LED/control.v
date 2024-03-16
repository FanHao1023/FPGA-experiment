module control (clk, s, start, str);
input clk, s;
output reg start, str;
reg [3:0] count;
wire _str;
wire _start;
  
assign _str = &count;                           //當計數器數到4'b1111時，str拉起
assign _start = ~(|count);                      //當計數為0時，start拉起

always @ (posedge clk)
	count <= (s == 1'd1) ? 4'd0 : count + 1'b1;  //計數
		
always @ (negedge clk)                          //每逢負緣更新start和str
	begin
		start <= _start;
		str <= _str;
	end
		
endmodule
