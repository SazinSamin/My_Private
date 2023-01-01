module fa32bit(s, cout, a, b, cin, clk);
	parameter n = 16;
	input[n-1:0] a, b;
	input cin, clk;
	output reg cout;
	output [n-1:0] s;
	
	/*reg a1, a2, a3, a4;
	reg b1, b2, b3, b4;*/
	reg s0, s1, s2, s3, s4, s5, s6, s7, s8;
	reg c0, ci, c1, c2, c3, c4, c5, c6, c7, c8;
	reg cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout71;
	reg f0, f1, f2, f3, f4, f5, f6, f7, f8;
	
	reg s9, s10, s11, s12, s13, s14, s15, s16;
	reg c9, c10, c11, c12, c13, c14, c15, c16;
	reg cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15, cout16;
	reg f9, f10, f11, f12, f13, f14, f15, f16;
	reg coutL1;
	

	always @ (posedge clk)
		begin
			ci <= cin;
		end

	always @ (posedge clk)
		begin
			
			{c0, s0} <= a[0] + b[0];
			{c1, s1} <= a[1] + b[1];
			{c2, s2} <= a[2] + b[2];
			{c3, s3} <= a[3] + b[3];
			{c4, s4} <= a[4] + b[4];
			{c5, s5} <= a[5] + b[5];
			{c6, s6} <= a[6] + b[6];
			{c7, s7} <= a[7] + b[7];
					
			
			f0 = s0;
			{cout0, f1} = s1 + c0;			
			{cout1, f2} = s2 + c1 + cout0;
			{cout2, f3} = s3 + c2 + cout1;
			{cout3, f4} = s4 + c3 + cout2;
			{cout4, f5} = s5 + c4 + cout3;
			{cout5, f6} = s6 + c5 + cout4;
			{cout6, f7} = s7 + c6 + cout5;
			coutL1 = c7 + cout6;
			
			
			
			{c8, s8} <= a[8] + b[8];
			{c9, s9} <= a[9] + b[9];
			{c10, s10} <= a[10] + b[10];
			{c11, s11} <= a[11] + b[11];
			{c12, s12} <= a[12] + b[12];
			{c13, s13} <= a[13] + b[13];
			{c14, s14} <= a[14] + b[14];
			{c15, s15} <= a[15] + b[15];
			
			
			{cout71, f8} = s8 + coutL1;
			{cout8, f9} = s9 + c8 + cout71; 			
			{cout9, f10} = s10 + c9 + cout8;
			{cout10, f11} = s11 + c10 + cout9;
			{cout11, f12} = s12 + c11 + cout10;
			{cout12, f13} = s13 + c12 + cout11;
			{cout13, f14} = s14 + c13 + cout12;
			{cout14, f15} = s15 + c14 + cout13;
			cout = c15 + cout14;
			
			
			
			
		end
		
		
		//assign s = {f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {s15, s14, s13, s12, s11, s10, s9, s8};
		//assign s = {s15, s14, s13, s12, s11, s10, s9, s8, f7, f6, f5, f4, f3, f2, f1, f0};
		assign s = {f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {a[15], a[14], a[13], a[12], a[11], a[10], a[9], a[8], f7, f6, f5, f4, f3, f2, f1, f0};
endmodule
