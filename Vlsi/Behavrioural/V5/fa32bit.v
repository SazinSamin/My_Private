module fa32bit(s, cout, a, b, cin, clk);
	parameter n = 4;
	input[n-1:0] a, b;
	input cin, clk;
	output reg cout;
	output [n-1:0] s;
	
	reg a1, a2, a3, a4;
	reg b1, b2, b3, b4;
	reg s1, s2, s3, s4;
	reg ci, c1, c2, c3, c4;

	always @ (posedge clk)
		begin
			a1 <= a[0];
			a2 <= a[1];
			a3 <= a[2];
			a4 <= a[3];
						
			b1 <= b[0];
			b2 <= b[1];
			b3 <= b[2];
			b4 <= b[3];
			ci <= cin;
		end

	always @ (posedge clk)
		begin
			{c1, s1} = a1 + b1 + ci;
		end

	always @ (posedge clk)
		begin
			{c2, s2} = a2 + b2 + c1;
		end

	always @ (posedge clk)
		begin
			{c3, s3} = a3 + b3 + c2;
		end

	always @ (posedge clk)
		begin
			{c4, s4} = a4 + b4 + c3;
		end
	
	assign s = {s4, s3, s2, s1};

endmodule
