module Controller(clk, eoc, ale, start, g_d);
input clk, eoc;
output reg ale, start, g_d;
reg [3:0] cs, ns;

always @(posedge clk)
  cs <= ns;
  
always @(cs or eoc) begin
  case(cs)
    3'd0: ns <= 3'd1;
	 3'd1: ns <= 3'd2;
	 3'd2: ns <= 3'd3;
	 3'd3: ns <= (eoc)? 3'd3 : 3'd4;
	 3'd4: ns <= (eoc)? 3'd5 : 3'd4;
	 3'd5: ns <= 3'd0;
	 default: ns <= 3'd0;
  endcase
end

always @(cs) begin
  case(cs)
    3'd0: begin 
	         ale <= 0;
				start <= 0;
				g_d <= 0;
		    end
	 3'd1: begin 
	         ale <= 1;
				start <= 0;
				g_d <= 0;
		    end
	 3'd2: begin 
	         ale <= 0;
				start <= 1;
				g_d <= 0;
		    end 
	 3'd3: begin 
	         ale <= 0;
				start <= 0;
				g_d <= 0;
		    end 
	 3'd4: begin 
	         ale <= 0;
				start <= 0;
				g_d <= 0;
		    end
	 3'd5: begin 
	         ale <= 0;
				start <= 0;
				g_d <= 1;
		    end 
	 default: begin 
	            ale <= 0;
				   start <= 0;
				   g_d <= 0;
		       end
  endcase
end



endmodule 