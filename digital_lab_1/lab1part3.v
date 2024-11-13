//
// ============================================================
// Laboratory: 	Lab 1 - Part 3 - Digital Logic
// Description:	2 Select Multiplexer
// By:			K. walsh
// Date:		January 29, 2017
//

// Top Level Module
module lab1part3 (
	input [9:0] SW,
	output [9:0] LEDR);
//

	assign LEDR[9] = SW[9];	//s1
	assign LEDR[8] = SW[8];	//s0
	
	assign LEDR[0] = (~SW[9] & ~SW[8] & SW[4]) | (~SW[9] & SW[8] & SW[2]) | (SW[9] & ~SW[8] & SW[0]) | (SW[9] & SW[8] & SW[0]); 
	assign LEDR[1] = (~SW[9] & ~SW[8] & SW[5]) | (~SW[9] & SW[8] & SW[3]) | (SW[9] & ~SW[8] & SW[1]) | (SW[9] & SW[8] & SW[1]);
	//(~s1&~s0&u0)|(~s1&s0&v0)|(s1&~s0&w0)|(s1&s0&w0)
	//(~s1&~s0&u1)|(~s1&s0&v1)|(s1&~s0&w1)|(s1&s0&w1)

	assign LEDR[7:2] = 0; //turn off LEDs 7-2

endmodule
