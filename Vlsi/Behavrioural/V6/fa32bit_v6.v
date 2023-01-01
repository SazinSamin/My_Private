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
	reg cout1, cout2, cout3, cout4;
	reg f1, f2, f3, f4;

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
			
			{c1, s1} <= a1 + b1;
			{c2, s2} <= a2 + b2;
			{c3, s3} <= a3 + b3;
			{c4, s4} <= a4 + b4;
			
			/*
			{cout1, f1} = s1 + c1 + cin;
			{cout2, f2} = s2 + c2  + cout1;
			{cout3, f3} = s3 + c3  +cout2;
			{cout4, f4} = s4 + c4  + cout3;
			cout = cout4;
			*/
			
			/*
			{cout1, f1} = s2 + c1;
			{cout2, f2} = s3 + c2 + cout1;
			{cout3, f3} = s4 + c3 + cout2;
			{cout4, f4 } = c4 + cout3;
			*/
			
			
			f1 = s1;
			{cout1, f2} = s2 + c1;			
			{cout2, f3} = s3 + c2 + cout1;
			{cout3, f4} = s4 + c3 + cout2;
			cout = c4 + cout3;
			/*
			f1 = s2 + c1;
			f2 = s3 + c2;
			f3 = s4 + c3;
			f4 = c4;
			*/
		end
	
	assign s = {f4, f3, f2, f1};

endmodule
