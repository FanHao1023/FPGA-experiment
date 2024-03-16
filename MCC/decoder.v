module decoder(CS, A, _A, B, _B);
input [2:0] CS;           //根據current state決定輸出值       
output reg A, _A, B, _B;

always@(CS)
begin
	case(CS)
	3'd0 : begin           //如果current state為0
				A <= 1'd0;    //A=0、B=0、~A=0、~B=0
				_A <= 1'd0;
				B <= 1'd0;
				_B <= 1'd0;
			 end
	3'd1 : begin           //如果current state為1
				A <= 1'd1;    //A=1、B=1、~A=0、~B=0
				_A <= 1'd0;
				B <= 1'd1;
				_B <= 1'd0;
			 end
	3'd2 : begin           //如果current state為2
				A <= 1'd0;    //A=0、B=1、~A=1、~B=0
				_A <= 1'd1;
				B <= 1'd1;
				_B <= 1'd0;
			 end
	3'd3 : begin           //如果current state為3
				A <= 1'd0;    //A=0、B=0、~A=1、~B=1
				_A <= 1'd1;
				B <= 1'd0;
				_B <= 1'd1;
			 end
	3'd4 : begin           //如果current state為4
				A <= 1'd1;    //A=1、B=0、~A=0、~B=1
				_A <= 1'd0;
				B <= 1'd0;
				_B <= 1'd1;
			 end
	default : begin        //避免出現latch所寫的default
				A <= 1'd0;
				_A <= 1'd0;
				B <= 1'd0;
				_B <= 1'd0;
			 end
	endcase
end

endmodule
