module fa32bit(sum, cout, c, a, b) ;
	input c;
	input [32:0] a, b;
	output reg cout;
	output reg [32:0] sum;
	
	carry_save_adder csa0 (.a(a[7:0]), .b(b[7:0]), .c(c), .sum(sum[7:0]), .cout(cout));
	carry_save_adder csa1 (.a(a[15:8]), .b(b[15:8]), .c(c), .sum(sum[15:8]), .cout(cout));
	carry_save_adder csa2 (.a(a[23:16]), .b(b[23:16]), .c(c), .sum(sum[23:16]), .cout(cout));
	carry_save_adder csa3 (.a(a[31:24]), .b(b[31:24]), .c(c), .sum(sum[31:24]), .cout(cout));

endmodule
