module txshift(load, clk, din, en, txd);
input load, en, clk;
input [7:0]din;
output txd;

reg [7:0] data;
wire [7:0] ndata;

always@(posedge clk)
begin
	if(load)
		data <= din;      //load the input value when load=1
	else
		data <= ndata;    //update the value of data
end

assign ndata = (en)? {1'b0,data[7:1]} : data;  //right shift data to output the lowest bit of din when en=1
assign txd = data[0]; //output the lowest bit of din

endmodule		