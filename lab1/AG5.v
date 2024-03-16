module AG5(clk, addr, reset);
input clk, reset;
output reg [4:0] addr;
wire [4:0] naddr;

assign naddr = addr + 1'd1;

always@(posedge clk or posedge reset)
begin
	if(reset == 1'd1)
		addr <= 5'd0;
	else
		addr <= naddr;
end
endmodule