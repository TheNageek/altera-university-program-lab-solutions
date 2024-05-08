//
// ============================================================
// Laboratory: 	Lab 3 - Part 4 - Digital Logic
// Description:	Explore three different types of D-Flip Flops (DFF); 
//				gated DFF, edge triggered DFF, and negative edge triggered 
//				DFF. Further utilize behavioral style (e.g. "always @") 
//				Verilog as opposed to previous dataflow style (e.g "assign")
//					
//				We won't implement the design on the DE1 board, instead 
//				we'll verify the design via simulation. 
//
// By:			K. Walsh
// Date:		September 18, 2016
//

// ============================================================
//
//
//
// Top Level Module
module part4 (
	input D, Clk,
	output Qa, Qb, Qc);
	
	// Instantatiate DFFs
	DFF_gate dff0 (.D(D),.Clk(Clk),.Q(Qa));
	DFF_pos  dff1 (.D(D),.Clk(Clk),.Q(Qb));
	DFF_neg  dff2 (.D(D),.Clk(Clk),.Q(Qc));
	
endmodule
//
// ============================================================
//
//
//
// Gated DFF Module
module DFF_gate (
	input D, Clk,
	output reg Q);
	
	always @ (D, Clk)
		if (Clk)
			Q = D;
	
	// Standard gated DFF Truth Table
	//
	// D	Clk	Q
	//_____________
	//
	// 0	0		0	
	// 0	1		0
	// 1	0		0
	// 1	1		1
	
endmodule
//
//
//
// (+) Edge DFF Module
module DFF_pos (
	input D, Clk,
	output reg Q);
	
	always @ (posedge Clk)
		if (Clk)
			Q = D;
		
	// Positive Edge DFF
	// Q = D only on the rising edge of 'Clk'
	
endmodule
//
//
//
// (-) Edge DFF Module
module DFF_neg (
	input D, Clk,
	output reg Q);
	
	always @ (negedge Clk)
		if (~Clk)
			Q = D;
	
	// Negative Edge DFF
	// Q = D only on the falling edge of 'Clk'
	
endmodule
