module Dff8(clk, data, _data);
input clk;
input [7:0] data;
output reg [7:0] _data;

always @(posedge clk)//當clk正緣觸發時，執行以下程式碼
  _data <= data;//將栓鎖進

endmodule 