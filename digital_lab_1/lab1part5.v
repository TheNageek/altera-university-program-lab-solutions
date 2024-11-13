// ============================================================
// Laboratory: 	Lab 1 - Part 5 - Digital Logic
// Description:	3x 7-Seg Displays; multiplex to 3x displays 
// to output different combinations.
//

// Top Level Module
module lab1part5 (SW, LEDR, HEX0, HEX1, HEX2);
	input [9:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2;
	// SW		= 	[9:8] selects for HEX 
	//				[5:0] toggle to display 'd', 'E', '1' 
	//
	// Ch2 	SW[5:4]    0  0    	d  
	// Ch1 	SW[3:2]    0  1    	E 
	// Ch0 	SW[1:0]    1  0    	1 
	
	// SW  9  8    Displayed Characters
	//     0  0    dE1 
	//     0  1    E1d
	//     1  0    1dE
	
	assign LEDR = SW;
	
	wire [1:0] Ch_Sel, Ch2, Ch1, Ch0;
	wire [1:0] mux2_out, mux1_out, mux0_out;
	wire [6:0] hex2_out, hex1_out, hex0_out;
	assign Ch_Sel = SW[9:8];
	assign Ch2 = SW[5:4];	
	assign Ch1 = SW[3:2];	
	assign Ch0 = SW[1:0];
	assign HEX2[6:0] = hex2_out;
	assign HEX1[6:0] = hex1_out;
	assign HEX0[6:0] = hex0_out;
	

	// 3x Instantiations of Mux/Display Modules
	mux2bit_3_1 m0 (Ch_Sel,Ch0,Ch2,Ch1,mux0_out);
	mux2bit_3_1 m1 (Ch_Sel,Ch1,Ch0,Ch2,mux1_out);
	mux2bit_3_1 m2 (Ch_Sel,Ch2,Ch1,Ch0,mux2_out);
	segment7 s0 (mux0_out, hex0_out);
	segment7 s1 (mux1_out, hex1_out);
	segment7 s2 (mux2_out, hex2_out);
	
endmodule



// Mux Module
module mux2bit_3_1 (S, U, V, W, M);
	input [1:0] S, U, V, W;
	output [1:0] M;

	assign M[0] = (~S[1] & ~S[0] & U[0]) | (~S[1] & S[0] & V[0]) | (S[1] & ~S[0] & W[0]) | (S[1] & S[0] & W[0]); 
	assign M[1] = (~S[1] & ~S[1] & U[1]) | (~S[1] & S[1] & V[1]) | (S[1] & ~S[1] & W[1]) | (S[1] & S[1] & W[1]);

endmodule


// Display Module
module segment7 (C, Display);
	input [1:0] C;
	output [6:0] Display;
	
	assign Display[0] = (~C[1] & ~C[0]) | (C[1] & ~C[0]) | (C[1] & C[0]);
	assign Display[1] = (~C[1] & C[0]) | (C[1] & C[0]);
	assign Display[2] = (~C[1] & C[0]) | (C[1] & C[0]);
	assign Display[3] = (C[1] & ~C[0]) | (C[1] & C[0]);
	assign Display[4] = (C[1] & ~C[0]) | (C[1] & C[0]);
	assign Display[5] = (~C[1] & ~C[0]) | (C[1] & ~C[0]) | (C[1] & C[0]);
	assign Display[6] = (C[1] & ~C[0]) | (C[1] & C[0]);
	//Display[0] = (~c1&~c0)|(c1&~c0)|(c1&c0)
	//Display[1] = (~c1&c0)|(c1&c0)
	//Display[2] = (~c1&c0)|(c1&c0)
	//Display[3] = (c1&~c0)|(c1&c0)
	//Display[4] = (c1&~c0)|(c1&c0)
	//Display[5] = (~c1&~c0)|(c1&~c0)|(c1&c0)
	//Display[6] = (c1&~c0)|(c1&c0)

endmodule

