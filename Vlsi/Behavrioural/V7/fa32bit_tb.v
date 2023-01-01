// Code your testbench here
// or browse Examples
module fa32bit_tb;
	parameter n = 16;
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
  	//a = 8'b00000000;
  	//b = 8'b00000000;
	a = 16'b0000000000000000;
	b = 16'b0000000000000000;
  	clk = 0;
	cin = 0;
	end
	always #20 a = a+100;
	always #20 b = b+100;
  	always #1 clk = ~clk;
	//always #40 cin = ~cin;
	initial #10000 $finish;
endmodule
