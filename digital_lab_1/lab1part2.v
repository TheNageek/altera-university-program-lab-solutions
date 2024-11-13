//
// ============================================================
// Laboratory: Lab 1 - Part 2 - Digital Logic
// Description: Switches, Lights and Multiplexers
//
// Top Level Module
module lab1part1 (
	input [9:0] SW,
	output [9:0] LEDR);
//
// SW		=	10x switch inputs
// LEDR	=	10x LED outputs

	assign LEDR[0] = (~SW[9] & SW[0]) | (SW[9] & SW[4]); //(~s&x0)|(s&y0)
	assign LEDR[1] = (~SW[9] & SW[1]) | (SW[9] & SW[5]); //(~s&x1)|(s&y1)
	assign LEDR[2] = (~SW[9] & SW[2]) | (SW[9] & SW[6]); //(~s&x2)|(s&y2)
	assign LEDR[3] = (~SW[9] & SW[3]) | (SW[9] & SW[7]); //(~s&x3)|(s&y3)
	assign LEDR[8:4] = 0;
	assign LEDR[9] = SW[9];
	
endmodule
