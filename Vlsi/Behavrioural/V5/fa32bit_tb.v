// Code your testbench here
// or browse Examples
module fa32bit_tb;
	parameter n = 4;
  	wire [n-1:0] s;//output
	wire cout;//output
	reg [n-1:0] a,b;
	reg cin;//input
	reg clk;
	

	fa32bit inst(
      	.s(s),
		.cout(cout),
		.cin(cin),
		.a(a),
      	.b(b),
      	.clk(clk)
	);

initial begin
  	$dumpfile("dump.vcd");
  	$dumpvars(1);
	a = 4'b0000;
	b = 4'b0000;
  	clk = 0;
	cin = 0;
	end
	always #35 a = a+1;
	always #35 b = b+1;
  	always #1 clk = ~clk;
	//always #40 cin = ~cin;
	initial #1500 $finish;
endmodule
