module BCDadder(a,b,cin,s,cout);

input [7:0] a,b;
input cin;
output [7:0] s;
output cout;
wire c0;

BCDADD1 u0(a[3:0],b[3:0],cin,s[3:0],c0);
BCDADD1 u1(a[7:4],b[7:4],c0,s[7:4],cout);

endmodule


module BCDADD1(a,b,cin,s,cout);

input [3:0] a,b;
input cin;
output [3:0] s;
output cout;
wire c1,c0;
wire [3:0] s0,s1;

ADD4 u0(a,b,cin,s0,c0);
ADD6 u1(s0,s1,c1);

assign cout=c0|c1;
assign s=cout?s1:s0;

endmodule



module ADD6(a,c,cout);

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
