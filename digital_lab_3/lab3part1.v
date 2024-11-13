//
// ============================================================
// Laboratory: 	Lab 3 - Part 1 - Digital Logic
// Description:	Explore the SR Latch at the gate level. Preserve 
// internal signals (qa,qb,r_g,s_g) as separate logic 
// elements so that they may be explored/understood.
//
// Board: DE1-SoC, Rev F, 5CSEMA5F31C6
//
// ============================================================
//
// Top Level Module
module part1 (
	input R,Clk,S,
	output Q);
	//
	//R 	= reset
	//S 	= set
	//Clk = clock signal
	//Q 	= output value
	
	
	wire R_g,S_g,Qa,Qb/*synthesis keep*/;
	//R_g	= internal reset
	//S_g	= internal set
	//Qa	= output
	//Qb	= output compliment
	
	// Note, "synthesis keep" is a Quartus "compiler directive" that will 
	// preserve the interal wiring. Despite being commented out, the compiler 
	// will still recognize this and apply it.
	
	assign R_g = R & Clk;
	assign S_g = S & Clk;
	assign Qa = ~(R_g | Qb);
	assign Qb = ~(S_g | Qa);
	
	assign Q = Qa;
	
endmodule
