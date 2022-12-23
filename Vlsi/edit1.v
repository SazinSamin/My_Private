module carry_save_adder(a,b, sum,cout);
 input [7:0] a, b;
output [7:0] sum;
output cout;
 
wire [7:0] s0,s1, s2, s3;
  wire [7:0] c0, c1, c2, c3;

//1st Statge
full_adder fa0( .a(a[0]), .b(b[0]), .cin(c[0]), .sum(s0[0]), .cout(c0[0]));
full_adder fa1( .a(a[1]), .b(b[1]), .cin(c[1]), .sum(s0[1]), .cout(c0[1]));
full_adder fa2( .a(a[2]), .b(b[2]), .cin(c[2]), .sum(s0[2]), .cout(c0[2]));
full_adder fa3( .a(a[3]), .b(b[3]), .cin(c[3]), .sum(s0[3]), .cout(c0[3]));
full_adder fa4( .a(a[4]), .b(b[4]), .cin(c[4]), .sum(s0[4]), .cout(c0[4]));
full_adder fa5( .a(a[5]), .b(b[5]), .cin(c[5]), .sum(s0[5]), .cout(c0[5]));
full_adder fa6( .a(a[6]), .b(b[6]), .cin(c[6]), .sum(s0[6]), .cout(c0[6]));
full_adder fa7( .a(a[7]), .b(b[7]), .cin(c[7]), .sum(s0[7]), .cout(c0[7]));

//2nd Stage
// full_adder fa4( .a(d[0]), .b(s0[0]), .cin(1'b0), .sum(sum[0]), .cout(c1[0]));
// full_adder fa5( .a(d[1]), .b(s0[1]), .cin(c0[0]), .sum(s1[0]), .cout(c1[1]));
// full_adder fa6( .a(d[2]), .b(s0[2]), .cin(c0[1]), .sum(s1[1]), .cout(c1[2]));
// full_adder fa7( .a(d[3]), .b(s0[3]), .cin(c0[2]), .sum(s1[2]), .cout(c1[3]));


 ripple_carry_4_bit rca1 (.a(s0[7:0]),.b(c0[7:0]), .cin(1'b0),.sum(sum[7:0]), .cout(cout));

endmodule

////////////////////////////////////
//4-bit Ripple Carry Adder
////////////////////////////////////
 
module ripple_carry_4_bit(a, b, cin, sum, cout);
input [7:0] a,b;
input cin;
wire c1,c2,c3, c4, c5, c6, c7;
output [7:0] sum;
output cout;
 
full_adder fa0(.a(a[0]), .b(b[0]),.cin(cin), .sum(sum[0]),.cout(c1));
full_adder fa1(.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]),.cout(c2));
full_adder fa2(.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]),.cout(c3));
full_adder fa2(.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]),.cout(c4));
full_adder fa2(.a(a[4]), .b(b[4]), .cin(c4), .sum(sum[4]),.cout(c5));
full_adder fa2(.a(a[5]), .b(b[5]), .cin(c5), .sum(sum[5]),.cout(c6));
full_adder fa2(.a(a[6]), .b(b[6]), .cin(c6), .sum(sum[6]),.cout(c7));
full_adder fa3(.a(a[7]), .b(b[7]), .cin(c7), .sum(sum[7]),.cout(cout));
endmodule
 

////////////////////////////////////////////
//1bit Full Adder
///////////////////////////////////////////
module full_adder(a,b,cin,sum, cout);
input a,b,cin;
output sum, cout;
wire x,y,z;
half_adder  h1(.a(a), .b(b), .sum(x), .cout(y));
half_adder  h2(.a(x), .b(cin), .sum(sum), .cout(z));
assign cout= y|z;
endmodule
///////////////////////////////////////////
// 1 bit Half Adder
////////////////////////////////////////////
module half_adder( a,b, sum, cout );
input a,b;
output sum,  cout;
assign sum= a^b;
assign cout= a & b;
endmodule
