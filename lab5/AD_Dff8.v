module AD_Dff8(clk, en, data, _data);
input clk, en;
input [7:0] data;
output reg [7:0] _data;

always @(posedge clk) begin 
  if(en) begin
	 _data <= data;
  end else begin
    _data <= _data;
  end
end

endmodule 