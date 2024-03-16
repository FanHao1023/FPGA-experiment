module counter(clk,rst,end_single);
input 	 clk,rst;
output 	 end_single;

reg [2:0] count;

always@(posedge clk or posedge rst)begin   //When reset=0,count value until 3'b111
	count  <= (rst) ? 3'b0:count+3'd1;
end

assign end_single = &count;	//when count value = 3'b111, end_single = 1

endmodule
