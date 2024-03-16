module BtoBCD(A,bcd1,bcd0);
input [7:0] A;
output [7:0] bcd0;
output [3:0] bcd1; 
wire [7:0] S1,S2,S3,S4_10,S5,_S2,_S3,_S4,_S5;
wire [3:0] S,S4_2,S51,_S51;
wire c1,c2,c3,c4,c5,c51;

Adjust BB0(A[3:0],S,c1);
assign S1={3'b000,c1,S};
BCDADD2 BB1(S1,8'h16,1'b0,_S2,c2);
assign S2=(A[4])? _S2:S1;
BCDADD2 BB2(S2,8'h32,1'b0,_S3,c3);
assign S3=(A[5])? _S3:S2;
BCDADD2 BB3(S3,8'h64,1'b0,_S4,c4);
assign S4_10=(A[6])? _S4:S3;
assign S4_2 = (A[6])?{3'd0,c4}:4'd0;
BCDADD2 BB4(S4_10,8'h28,1'b0,_S5,c5);
BCDADD1 BB5(S4_2,1'h1,c5,_S51,c51);
assign bcd0=(A[7])?_S5:S4_10;
assign bcd1=(A[7])?_S51:S4_2;


endmodule



module Adjust(a,c,cout);

input [3:0] a;
output [3:0] c;
output cout;

assign c[0]=a[0],
       c[1]=~a[1],
		 c[2]=~(a[1]^a[2]),
		 c[3]=(a[1]|a[2])^a[3],
		 cout=(a[1]|a[2])&a[3];

endmodule




module ADD4(a,b,cin,s,cout);

input [3:0] a,b;
input cin;
output [3:0] s;
output cout;
wire [3:0] p,g;
wire [3:0] c;

assign p[0]=a[0]^b[0],
       p[1]=a[1]^b[1],
		 p[2]=a[2]^b[2],
		 p[3]=a[3]^b[3];

assign g[0]=a[0]&b[0],
       g[1]=a[1]&b[1],
		 g[2]=a[2]&b[2],
		 g[3]=a[3]&b[3];

assign c[0]=g[0]|(p[0]&cin),
       c[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&cin),
		 c[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin),
		 c[3]=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&cin);
		 
assign s[0]=p[0]^cin,
       s[1]=p[1]^c[0],
		 s[2]=p[2]^c[1],
		 s[3]=p[3]^c[2];
assign cout=c[3];

endmodule



module BCDADD1(a,b,cin,s,cout);

input [3:0] a,b;
input cin;
output [3:0] s;
output cout;
wire c1,c0;
wire [3:0] s0,s1;

ADD4 u0(a,b,cin,s0,c0);
Adjust u1(s0,s1,c1);

assign cout=c0|c1;
assign s=cout?s1:s0;

endmodule




module BCDADD2(a,b,cin,s,cout);

input [7:0] a,b;
input cin;
output [7:0] s;
output cout;
wire c0;

BCDADD1 u0(a[3:0],b[3:0],cin,s[3:0],c0);
BCDADD1 u1(a[7:4],b[7:4],c0,s[7:4],cout);

endmodule