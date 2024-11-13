//
// ============================================================
// Laboratory: 	Lab 2 - Part 3 - Digital Logic
// Description:	Implementation of full adder (FA) into a 4-bit 
// ripple-carry adder circuit w/ carry in and carry out.
// Board: DE1-SoC, Rev F, 5CSEMA5F31C6
//

// ============================================================
// Top Level Module
module lab2part3 (SW, LEDR);
	input [8:0] SW;
	output [4:0] LEDR;
	
	wire [3:0] a, b, s;
	wire [2:0] c;
	wire ci, co;
	
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign ci = SW[8];
	assign LEDR[3:0] = s;
	assign LEDR[4] = co;
	// Note, in order to use the same wire/net names as the instantiated
	// full adder module ports, we must used .named port style connections.  
	// Also, ensure that the correct data widths (i.e. 1-bit) are being utilized.
	
	// Instantiate Full Adder Module
	full_adder f0 (.a(a[0]),.b(b[0]),.ci(ci),.s(s[0]),.co(c[0]));
	full_adder f1 (.a(a[1]),.b(b[1]),.ci(c[0]),.s(s[1]),.co(c[1]));
	full_adder f2 (.a(a[2]),.b(b[2]),.ci(c[1]),.s(s[2]),.co(c[2]));
	full_adder f3 (.a(a[3]),.b(b[3]),.ci(c[2]),.s(s[3]),.co(co));
	
endmodule
//
//
//
// Full Adder Module
module full_adder (a, b, ci, s, co);
	input a, b, ci;
	output s, co;
	
	assign s = ((a ^ b) ^ ci);
	assign co = ((a ^ b) == 1'b1) ? ci : b;

endmodule
	
	
	

