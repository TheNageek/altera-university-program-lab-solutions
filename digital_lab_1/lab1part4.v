//
// ============================================================
// Laboratory: 	Lab 1 - Part 4 - Digital Logic
// Description:	Seven Segment Display, display 3 different outputs
//				from two select switch inputs.
// By:			K. walsh
// Date:	 	January 29, 2017
//

// SW  1  0    Displayed characters
//     0  0    d 
//     0  1    E
//     1  0    1
//     1  1    -		


// Top Level Module
module lab1part4 (
	input [1:0] SW,
	output [6:0] HEX0);
	
	assign HEX0[0] = (~SW[1] & ~SW[0]) | (SW[1] & ~SW[0]) | (SW[1] & SW[0]);
	assign HEX0[1] = (~SW[1] & SW[0]) | (SW[1] & SW[0]);
	assign HEX0[2] = (~SW[1] & SW[0]) | (SW[1] & SW[0]);
	assign HEX0[3] = (SW[1] & ~SW[0]) | (SW[1] & SW[0]);
	assign HEX0[4] = (SW[1] & ~SW[0]) | (SW[1] & SW[0]);
	assign HEX0[5] = (~SW[1] & ~SW[0]) | (SW[1] & ~SW[0]) | (SW[1] & SW[0]);
	assign HEX0[6] = (SW[1] & ~SW[0]) | (SW[1] & SW[0]);
	//HEX0[0] = (~c1&~c0)|(c1&~c0)|(c1&c0)
	//HEX0[1] = (~c1&c0)|(c1&c0)
	//HEX0[2] = (~c1&c0)|(c1&c0)
	//HEX0[3] = (c1&~c0)|(c1&c0)
	//HEX0[4] = (c1&~c0)|(c1&c0)
	//HEX0[5] = (~c1&~c0)|(c1&~c0)|(c1&c0)
	//HEX0[6] = (c1&~c0)|(c1&c0)
	//
	/*
	 *         0  
	 *      -------  
	 *     |       |
	 *    5|       |1
	 *     |   6   |
	 *      -------  
	 *     |       |
	 *    4|       |2
	 *     |       |
	 *      -------  
	 *         3  
	 */

endmodule
