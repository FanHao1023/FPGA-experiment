module AG (clk, reset, addr);
input clk,reset;
output reg [3:0] addr;


always @ (posedge clk or posedge reset)
begin
 if (reset == 1'd1)                     //當reset=1時，位址從0重新開始產生
	 addr <= 0;
  else                      
    addr <= addr + 1;                   //當reset=0時，每逢正緣將addr+1
 end       
	                               
endmodule                         
 

