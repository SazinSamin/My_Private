module fa32bit(s, cout, a, b, cin, clk);
		input [31:0] a,b;
		input cin, clk;
		output reg cout;
		output [31:0] s;


		reg [7:0] a1, a2, a22, a3,  a33, a44, a333, a444, a4444, a4;
		reg [7:0] b1, b2, b3, b4, b22, b33, b333, b44, b444, b4444;
		reg [7:0] s1, s11, s111, s1111, s2, s22, s222, s3, s33, s4;
		reg ci, c1, c2, c3, c4;



		always @ (posedge clk)
		        begin
		                a1<={a[7:0]};
		                a2<={a[15:8]};
		                a3<={a[23:16]};
		                a4<={a[31:24]};


		                b1<={b[7:0]};
		                b2<={b[15:8]};
		                b3<={b[23:16]};
		                b4<={b[31:24]};
		                ci<=cin;
		        end
		        
		        
		always @ (posedge clk)
		        begin
		          {c1,s1}<=a1+b1+ci;
		          a22<=a2;
			  b22<=b2;

		          a33<=a3;
		          a44<=a4;
		          b33<=b3;
		          b44<=b4;
		        end
		        
		        
		always @ (posedge clk)
		        begin
		          s11<=s1;
		          {c2,s2}<=a22+b22+c1;
		          a333<=a33;
		          a444<=a44;
		          b333<=b33;
		          b444<=b44;
		        end


		always @ (posedge clk)
		        begin
		          s111<=s11;
		          s22<=s2;
			 {c3,s3}<=a333+b333+c2;
		          a4444<=a444;
		          b4444<=b444;
		        end
		        
		always @ (posedge clk)
		        begin
		          s1111<=s111;
		          s222<=s22;
		          s33<=s3;
		          {cout,s4}<=a4444+b4444+c3;
		        end


			assign s={{s4[7:0]},{s33[7:0]},{s222[7:0]},{s1111[7:0]}};

	endmodule
