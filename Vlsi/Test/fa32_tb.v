module fa32bit_tb;
	parameter n = 32;
	reg cin;
	reg [n-1:0] x, y;
	
	wire [n-1:0] s;
	fa32bit inst(
		.s(s),
		.cout(cout),
		.cin(cin),
		.x(x),
		.y(y)
	);

initial begin
	x = 32'b00000000000000000000000000000000;
	y = 32'b00000000000000000000000000000000;
	cin = 0;
	end
	always #10 x = x+1;
	always #10 y = y+1;
	always #40 cin = ~cin;
	initial #500 $finish;
endmodule
