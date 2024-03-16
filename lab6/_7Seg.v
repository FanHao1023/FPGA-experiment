module _7Seg(A,Out);
input[3:0] A;
output[6:0] Out;
reg [6:0] Out;

always@(A)
case(A)
4'h0:Out<=7'b1000000;
4'h1:Out<=7'b1111001;
4'h2:Out<=7'b0100100;
4'h3:Out<=7'b0110000;
4'h4:Out<=7'b0011001;
4'h5:Out<=7'b0010010;
4'h6:Out<=7'b0000010;
4'h7:Out<=7'b1111000;
4'h8:Out<=7'b0000000;
4'h9:Out<=7'b0010000;
4'hA:Out<=7'b0001000;
4'hB:Out<=7'b0000011;
4'hC:Out<=7'b1000110;
4'hD:Out<=7'b0100001;
4'hE:Out<=7'b0000110;
4'hF:Out<=7'b0001110;
endcase

endmodule