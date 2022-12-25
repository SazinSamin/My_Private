module fa32bit(sum, cout, cin, a, b);
	input [4:0] a, b;
	input cin;
	output reg cout;
	output reg [4:0] sum;
	reg s0, s1, s2, s3;
	reg c0, c1, c2, c3;
	
	always @ (a, b, cin)
		{c0, s0} = a[0] + b[0];
		{c1, s1} = a[1] + b[1];
		{c2, s2} = a[2] + b[2];
		{c3, s3} = a[3] + b[3];
	
endmodule
	
