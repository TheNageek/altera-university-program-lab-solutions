//
// ============================================================
// Laboratory: 	Lab 3 - Part 2 - Digital Logic
// Description:	Explore the D Latch at the gate level. Preserve 
//				internal signals (qa,qb,r_g,s_g) as separate logic 
//				elements so that they may be explored/understood.
//				Utilize the Quartus compiler directive "keep".
//					
//				Instantiate the D-latch and utilize switches and
//				LEDs to view the Q output.
//
// By:			K. Walsh
// Date:		September 18, 2016
//

// ============================================================
//
//
//
// Top Level Module
module part2 (
	input [1:0] SW,
	output [2:0] LEDR);
	
	assign LEDR[2] = SW[1];	//clock
	assign LEDR[1] = SW[0];	//D input
	
	// Instantiate D-Latch Module
	d_latch dl0 (.D(SW[0]),.Clk(SW[1]),.Q(LEDR[0]));
	
endmodule
//
//
//
// D-Latch Module
module d_latch (
	input D, Clk,
	output Q);
	
	//D	= latch input
	//R	= reset
	//S	= set
	//Clk	= clock
	//Q	= output
	
	wire S, R, S_g, R_g, Qa, Qb /* synthesis keep */;	
	
	assign S = D;
	assign R = ~D;
	assign S_g = ~(S & Clk);
	assign R_g = ~(R & Clk);
	assign Qa = ~(S_g & Qb);
	assign Qb = ~(R_g & Qa);
	
	assign Q = Qa;
	
endmodule
