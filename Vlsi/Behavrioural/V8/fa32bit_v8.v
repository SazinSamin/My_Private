module fa32bit(s, cout, a, b, cin, clk);
	parameter n = 32;
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
	
	reg s9, s10, s11, s12, s13, s14, s15;
	reg c9, c10, c11, c12, c13, c14, c15;
	reg cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	reg f9, f10, f11, f12, f13, f14, f15;
	reg coutL1;
	
	reg  s16, s17, s18, s19,s20, s21, s22, s23;
	reg  c16, c17, c18, c19, c20, c21, c22, c23;
	reg cout16, cout17, cout18,cout19, cout20, cout21, cout22, cout23, cout151;
	reg f16, f17, f18, f19, f20, f21, f22, f23;
	reg coutL2;
	
	reg  s24, s25, s26, s27,s28, s29, s30, s31;
	reg  c24, c25, c26, c27, c28, c29, c30, c31;
	reg cout24, cout25, cout26, cout27, cout28, cout29, cout30, cout31, cout231;
	reg f24, f25, f26, f27, f28, f29, f30, f31;
	reg coutL3;
	
	
	

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
			coutL2 = c15 + cout14;

			
			{c16, s16} <= a[16] + b[16];
			{c17, s17} <= a[17] + b[17];
			{c18, s18} <= a[18] + b[18];
			{c19, s19} <= a[19] + b[19];
			{c20, s20} <= a[20] + b[20];
			{c21, s21} <= a[21] + b[21];
			{c22, s22} <= a[22] + b[22];
			{c23, s23} <= a[23] + b[23];
			
			
			{cout151, f16} = s16 + coutL2;
			{cout16, f17} = s17 + c16 + cout151; 			
			{cout17, f18} = s18 + c17 + cout16;
			{cout18, f19} = s19 + c18 + cout17;
			{cout19, f20} = s20 + c19 + cout18;
			{cout20, f21} = s21 + c20 + cout19;
			{cout21, f22} = s22 + c21 + cout20;
			{cout22, f23} = s23 + c22 + cout21;
			coutL3 = c23 + cout22;
			
			
			{c24, s24} <= a[24] + b[24];
			{c25, s25} <= a[25] + b[25];
			{c26, s26} <= a[26] + b[26];
			{c27, s27} <= a[27] + b[27];
			{c28, s28} <= a[28] + b[28];
			{c29, s29} <= a[29] + b[29];
			{c30, s30} <= a[30] + b[30];
			{c31, s31} <= a[31] + b[31];
			
			
			{cout231, f24} = s24 + coutL3;
			{cout24, f25} = s25 + c24 + cout231; 			
			{cout25, f26} = s26 + c25 + cout24;
			{cout26, f27} = s27 + c26 + cout25;
			{cout27, f28} = s28 + c27 + cout26;
			{cout28, f29} = s29 + c28 + cout27;
			{cout29, f30} = s30 + c29 + cout28;
			{cout30, f31} = s31 + c30 + cout29;
			cout = c31 + cout30;

			
			
			
			
		end
		
		
		//assign s = {f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {s15, s14, s13, s12, s11, s10, s9, s8};
		//assign s = {s15, s14, s13, s12, s11, s10, s9, s8, f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {a[15], a[14], a[13], a[12], a[11], a[10], a[9], a[8], f7, f6, f5, f4, f3, f2, f1, f0};
		//assign s = {f23, f22, f21, f20, f19, f18, f17, f16, f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0};
		assign s = {f31, f30, f29, f28, f27, f26, f25, f24, f23, f22, f21, f20, f19, f18, f17, f16, f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0};
endmodule
