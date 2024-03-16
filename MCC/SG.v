module SG(inv, reset, clk, CS);
input inv, reset, clk;          
reg [2:0] NS;                   //next state暫存值
output reg [2:0] CS;            //current state暫存值

always@(posedge clk)            //DFF
begin
	CS <= NS;
end

always@(reset or CS or inv)    //FSM
begin
	if(reset == 1'd1)           //如果reset=1，next state回到S0
		NS <= 3'd0;
	else 
	begin
		case(CS)
		3'd0 : NS <= 3'd1;       //當reset=0，S0會到S1
		3'd1 : begin
					if(inv == 1'd0) //當inv=0，S1會到S2
						NS <= 3'd2;
					else
						NS <= 3'd4;  //當inv=1，S1會到S4
				 end
				 
		3'd2 : begin
					if(inv == 1'd0) //當inv=0，S2會到S3
						NS <= 3'd3;
					else
						NS <= 3'd1;  //當inv=1，S2會到S1
				 end
				 
		3'd3 : begin
					if(inv == 1'd0) //當inv=0，S3會到S4
						NS <= 3'd4;
					else
						NS <= 3'd2;  //當inv=1，S3會到S2
				 end
				 
		3'd4 : begin
					if(inv == 1'd0) //當inv=0，S4會到S1
						NS <= 3'd1;
					else
						NS <= 3'd3;  //當inv=1，S4會到S3
				 end
		default : NS <= 3'd0;    //以免產生latch而寫的default
		endcase
	end
end

endmodule
	
	
	