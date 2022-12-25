module fa32bit_tb;
	parameter n = 4;
	reg cin;
	reg [n-1:0] a, b;
	
	wire [n-1:0] s;
	fa32bit inst(
		.sum(s),
		.cout(cout),
		.cin(cin),
		.a(a),
		.b(b)
	);

initial begin
	x = 4'b0000;
	y = 4'b0000;
	cin = 0;
	end
	always #10 x = x+1;
	always #10 y = y+1;
	always #40 cin = ~cin;
	initial #500 $finish;
endmodule
