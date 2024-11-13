//
// ============================================================
// Laboratory: 	Lab 2 - Part 1 - Digital Logic
// Description:	Using 2x 7-Seg displays, control each one to 
// output the values of 0-9 using 8x switches.  4x switches
// control one 7-seg and 4x switchs control another.
// The idea using BcDs, 4'bxxxx -> 1'd
//
// ============================================================
// Top Level Module
module lab2part1 (SW, LEDR, HEX0, HEX1);
	input [7:0] SW;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1;
	
	assign LEDR = SW; //activate LED when switch is high '1'
	
	wire [3:0] ch0, ch1;	
	wire [6:0] hex0, hex1;
	
	assign ch0 = SW[3:0]; 	//4'bxxxx to HEX0
	assign ch1 = SW[7:4]; 	//4'bxxxx to HEX1
	assign HEX0 = hex0;		//output of decoder to HEX0
	assign HEX1	= hex1;		//output of decoder to HEX1
	
	// Instantiate BCD/Display Module
	seven_segment s0 (ch0, hex0);
	seven_segment s1 (ch1, hex1);
	
endmodule


// Display BCD Module (digits 0-9)
module seven_segment (c, segment);
	input [3:0] c;
	output [6:0] segment;
	
	assign segment[0] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0]);	
	//segment off, digits(1,4)
	//0001 OR 0100
	assign segment[1] = (~c[3]&c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&~c[0]);	
	//segment off, digits(5,6)
	//0101 OR 0110
	assign segment[2] = (~c[3]&~c[2]&c[1]&~c[0]);	
	//segment off, digits(2)
	//0010
	assign segment[3] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(~c[3]&c[2]&c[1]&c[0])|(c[3]&~c[2]&~c[1]&c[0]);	
	//segment off, digits(1,4,7,9)
	//0001 OR 0100 OR 0111 OR 1001
	assign segment[4] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&~c[2]&c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(~c[3]&c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0])|(c[3]&~c[2]&~c[1]&c[0]);	
	//segment off, digits(1,3,4,5,7,9)
	//0001 OR 0011 OR 0100 OR 0101 OR 0111 OR 1001 
	assign segment[5] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&~c[2]&c[1]&~c[0])|(~c[3]&~c[2]&c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0]);	
	//segment off, digits(1,2,3,7)
	//0001 OR 0010 OR 0011 OR 0111 
	assign segment[6] = (~c[3]&~c[2]&~c[1]&~c[0])|(~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0]);	
	//segment off, digits(0,1,7)
	//0000 OR 0001 OR 0111

endmodule
