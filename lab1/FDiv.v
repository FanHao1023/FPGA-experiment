module FDiv(fin, fout);
input fin;
output fout;
wire _fout;
wire [31:0] Divn;
reg fout0;
wire [31:0] _Divn, ncount;
reg [31:0] count;

assign Divn = 32'd50000000;
//assign Divn = 32'd6;
assign _Divn = {1'b0, Divn[31:1]};
assign ncount = (count >= Divn)? 32'd1 : count + 1'd1;
assign _fout = (count > _Divn)? 1'b1 : 1'b0;

always@(posedge fin)
begin
	count <= ncount;
	fout0 <= _fout;
end

assign fout = (Divn < 8'd2)? fin : fout0;

endmodule
