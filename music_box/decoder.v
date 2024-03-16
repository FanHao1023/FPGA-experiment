module decoder (s, out);
input [2:0] s;               //輸入為歌譜產生器的輸出的最高三個位元
output reg [5:0] out;

always @ (*)
	case(s)
	3'd0 : out <= 6'd1;       //當輸入為000，輸出為1
	3'd1 : out <= 6'd2;       //當輸入為001，輸出為2
	3'd2 : out <= 6'd4;       //當輸入為010，輸出為4
	3'd3 : out <= 6'd8;       //當輸入為011，輸出為8
	3'd4 : out <= 6'd16;      //當輸入為100，輸出為16 
	3'd5 : out <= 6'd24;      //當輸入為101，輸出為24
	3'd6 : out <= 6'd32;      //當輸入為110，輸出為32
	default : out <= 6'd1;    //default value，避免出現latch
	endcase
	
endmodule
	