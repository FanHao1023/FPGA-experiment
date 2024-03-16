module txunit(reset, clk, start, TData, tx);
input reset, clk, start;
input [7:0] TData;
output reg tx;

parameter WAITTING = 1'b1;       //將waiting, start_bit, stop_bit的數值透過parameter的方式assign來提高可讀性
parameter START_BIT = 1'b0;
parameter STOP_BIT = 1'b1;

reg [2:0] cs, ns;
wire tdc, txd, _tx;
reg [1:0] OS;
reg count_rst, shift_en;

always@(posedge clk or negedge reset)     //狀態轉移
begin
	if(!reset)
		cs <= 3'd0;
	else
		cs <= ns;
end

//結報中圖(1-1)的狀態機////////////////////////////////
always@(*)
begin
	case(cs)
		3'd0:   ns <= 3'd1;						
		3'd1:   ns <= (start) ? 3'd2:3'd1;	
		3'd2:   ns <= 3'd3;						
		3'd3:   ns <= (tdc) ? 3'd4:3'd3;	
		3'd4:   ns <= 3'd1;						
		default:ns <= 3'd0;
	endcase
end

always@(*)
begin
	case(cs)
	3'd0:begin
		OS <= 2'b00;
		count_rst <= 1'd1;
		shift_en <= 1'd0;
		end
		
	3'd1:begin
		OS <= 2'b00;
		count_rst <= 1'd1;
		shift_en <= 1'd0;
		end
		
	3'd2:begin
		OS <= 2'b01;
		count_rst <= 1'd1;
		shift_en <= 1'd0;
		end
		
	3'd3:begin
		OS <= 2'b10;
		count_rst <= 1'd0;
		shift_en <= 1'd1;
		end
		
	3'd4:begin
		OS <= 2'b11;
		count_rst <= 1'd1;
		shift_en <= 1'd0;
		end
		
	default:begin
		OS <= 2'b00;
		count_rst <= 1'd1;
		shift_en <= 1'd0;
		end
	endcase
end
//////////////////////////////////////////////////

//txunit中的counter
counter U0(
.clk(clk),          //counter's clk pin connect to clk signal
.rst(count_rst),    //counter's rst pin connect to count_rst signal
.end_single(tdc)    //counter's end_single pin connect to tdc siganl
);

//The shift_reg of txunit
txshift U1(
.load(start),      //txshift's load pin connect to start signal
.clk(clk),         //txshift's clk pin connect to clk signal
.din(TData),       //txshift's din pin connect to TData signal
.en(shift_en),     //txshift's en pin connect to shift_en signal
.txd(txd)          //txshift's txd pin connect to txd signal
);

assign _tx = (OS[1])?((OS[0])? STOP_BIT : txd):  //judging which bit to output
				 ((OS[0])?START_BIT : WAITTING);
				 
always@(posedge clk)
	tx <= _tx;          
	
endmodule
