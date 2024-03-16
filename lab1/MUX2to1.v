module MUX2to1(A, B, S, out);
input [4:0] A, B;
input S;
output [4:0] out;

assign out = (S)? A : B;

endmodule
