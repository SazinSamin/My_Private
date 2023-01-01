// Code your testbench here
// or browse Examples
`include "fa32bit_v7.v"
module fa32bit_tb;
	parameter n = 32;
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
	a = 32'b00000000000000000000000000000000;
	b = 32'b00000000000000000000000000000000;
  	clk = 0;
	cin = 0;
	end
	always #40 a = a+1;
	always #40 b = b+1;
  	always #1 clk = ~clk;
	//always #40 cin = ~cin;
	initial #1500 $finish;
endmodule
