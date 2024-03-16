module AG (clk, reset, sel, addr);
input clk,reset,sel;
output wire [7:0] addr;
reg [6:0] count;

always @ (posedge clk or negedge reset)
begin
 if (reset == 1'd0)               //reset=0時觸發reset的功能，此時address generator歸零
	 count <= 0;
  else                      
    count <= count + 1;           //正常運作時，每逢clk正緣，count就會+1
 end
 

assign addr = {sel,count};        //將輸入的sel和計數結果併在一起
	                               //如果sel=0，計數會從零開始，代表第一首音樂
endmodule                         //如果sel=1，計數會從128開始，代表第二首音樂
 

 