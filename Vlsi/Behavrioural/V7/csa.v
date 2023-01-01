module csa(s, cout, a, b, cin, clk);
	parameter n = 32;
	input[n-1:0] a, b;
	input clk, cin;
	output reg cout;
	output[n-1:0] s;
	
	fa32bit s1(s[7:0], cout, a[7:0], b[7:0], cin, clk);
	fa32bit s2(s[15:8], cout, a[15:8], b[15:8], cin, clk);
	fa32bit s3(s[23:16], cout, a[23:16], b[23:16], cin, clk);
	fa32bit s4(s[31:24], cout, a[31:24], b[31:24], cin, clk);

endmodule
