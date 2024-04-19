//
// ============================================================
// Laboratory: 	Lab 3 - Part 3 - Digital Logic
// Description:	Explore the master slave D flip-flop, utilize previous 
//						D-latch modules to create this system.  View schematic, 
//						technology map.  Simulate prior to implementation.
//					
//						Instantiate the flip-flop and utilize switches and
//						LEDs to view the Q output.
//
// By:				K. Walsh
// Date:				September 18, 2016
//

// ============================================================
//
//
//
// Top Level Module
module part3 (
	input [1:0] SW,
	output [1:0] LEDR);
	//SW[0] D-input
	//SW[1] clock
	
	wire Qm, Qs /* synthesis keep */;
	
	assign LEDR[0] = Qs;
	
	// Instantiate D-Latch Module
	d_latch dl0 (.D(SW[0]),.Clk(~SW[1]),.Q(Qm));
	d_latch dl1 (.D(Qm),.Clk(SW[1]),.Q(Qs));
	
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
