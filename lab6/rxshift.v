module rxshift(
rst,
rxd,
clk,
en,
rdc,
Dout
);

input rst, rxd, clk, en, rdc;
output [7:0]Dout;

reg [7:0]Data;
wire [7:0]nData;

always@(posedge clk or posedge rst)
begin
	if(rst)
		Data <= Data;
	else 
		Data <= nData;         //when reset=0, update the value of Data
end

assign nData = (en)? {rxd,Data[7:1]}:Data;//when en=1, start to shift data
assign Dout = (rdc)? Data : Dout; //rdc=1 represents counting was finished

endmodule