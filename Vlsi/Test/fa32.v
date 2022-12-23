module fa32bit(sum, cout, c, a, b) ;
	input c;
	input [31:0] a, b;
	output reg cout;
	output reg [31:0] sum;
	
	always @ (a, b, cin)
	begin 
		carry_save_adder csa0 (.a(a[7:0]), .b(b[7:0]), c(c), .sum(sum[7:0]), .cout(cout));
			// carry_save_adder csa1 (.a(sum[7:0]), .b(b[15:8]), .c(c), .sum(sum[15:8]), .cout(cout[15:8]));
			// carry_save_adder csa2 (.a(sum[15:8]), .b(b[23:16]), .c(c), .sum(sum[23:16]), .cout(cout[23:16]));
			// carry_save_adder csa3 (.a(sum[23:16]), .b(b31:24]), .c(c), .sum(sum[31:24]), .cout(cout[31:24]));
		end
endmodule
