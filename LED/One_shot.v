module One_shot (clk, clk_i, s);
input clk, clk_i;
output reg s;
reg [1:0] cs, ns;
wire _s;

always @ (posedge clk)
	cs <= ns;                           //每逢clk正緣，將current state 推到 next state

//FSM
always @ (cs)
	case(cs)                            
	2'b00 : ns <= (clk_i)?2'b01:2'b00;  //如果clk_i為1，將狀態推進到state 0，否則留在現在的state
	2'b01 : ns <= 2'b10;                //到達state 1時，輸出拉起為1，並直接將狀態推進到state 2
	2'b10 : ns <= (clk_i)?2'b10:2'b00;  //如果clk_i為1，將狀態維持在state 2，否則回到state 0
	default : ns <= 2'b00;
	endcase
	
always @ (posedge clk)
	s <= _s;                            //更新輸出結果

assign _s = (cs==2'b01)?1'b1:1'b0;     //到達state 1時，輸出拉起為1，否則輸出為0
 
endmodule   