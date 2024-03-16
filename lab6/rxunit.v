module rxunit(reset, clk, rx, RData, ready);
input reset, clk, rx;
output [7:0]RData;
output reg ready;//結報中的os訊號

reg [2:0]cs, ns;
wire rdc;
reg rst, shift_en;//en為結報中的en訊號

always@(posedge clk or negedge reset)
begin
	if(!reset)
		cs <= 1'd0;                    //when reset=0, go to state 0
	else
		cs <= ns;
end

//結報中圖(1-2)的狀態機/////////////////////////////////////////////
always@(*)begin
	case(cs)
	3'd0 : ns = 1'd1;
	3'd1 : ns = (rx)? 3'd1 : 3'd2;
	3'd2 : ns = (rdc)? 3'd3 : 3'd2;
	3'd3 : ns = (rx)? 3'd4 : 3'd1;
	3'd4 : ns = (rx)? 3'd1 : 3'd2;
	default: ns = 3'd0;
	endcase
end

always@(*)begin
	case(cs)
		3'd0 :begin
			rst	  <=1'd1;
			shift_en<=1'd0;
			ready	  <=1'd0;
		end
		
		3'd1 :begin
			rst	  <=1'd1;
			shift_en<=1'd0;
			ready	  <=1'd0;
		end
		
		3'd2 :begin
			rst	  <=1'd0;
			shift_en<=1'd1;
			ready	  <=1'd0;
		end
		
		3'd3 :begin
			rst	  <=1'd1;
			shift_en<=1'd0;
			ready	  <=1'd0;
		end
		
		3'd4 :begin
			rst	  <=1'd1;
			shift_en<=1'd0;
			ready	  <=1'd1;
		end
		
		default:begin
			rst	  <=1'd1;
			shift_en<=1'd0;
			ready	  <=1'd0;
		end
	endcase
end
////////////////////////////////////////////////////////////////

//the counter of rxunit
counter RX_counter(
.clk(clk),            //the clk pin of counter connect to clk signal
.rst(rst),            //the rst pin of counter connect to rst signal
.end_single(rdc)      //the end_single pin of counter connect to rdc signal
);

//the shift register of rxunit
rxshift rxshift(
.rst(rst),            //the rst pin of rxshift is connected to rst signal
.rxd(rx),             //the rxd pin of rxshift is connected to rx signal
.clk(clk),            //the clk pin of rxshift is connected to clk signal
.en(shift_en),        //the rst en of rxshift is connected to shift_en signal
.rdc(ready),          //the rdc pin of rxshift is connected to ready signal
.Dout(RData)          //the Dout pin of rxshift is connected to RData signal
);

endmodule


