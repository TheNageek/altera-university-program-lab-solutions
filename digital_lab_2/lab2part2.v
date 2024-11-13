//
// ============================================================
// Laboratory: 	Lab 2 - Part 2 - Digital Logic
// Description:	Using 2x 7-Seg displays, output 1x 4-bit number 
// combination from 4x switches.
// Board: DE1-SoC, Rev F, 5CSEMA5F31C6
//

// ============================================================
// Top Level Module
module lab2part2 (SW, LEDR, HEX0, HEX1);
	input [3:0] SW;
	input [5:0] SW2;
	output [3:0] LEDR;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] V, A, mux_out;
	wire [6:0] hex0, hex1;
	wire Z;
	
	assign V = SW[3:0]; 	//4'bxxxx to HEX0
	assign LEDR = SW; 		//activate LED when switch is high '1'
	assign HEX0 = hex0;		//output of seven_segment module to HEX0
	assign HEX1	= hex1;		//output of seven_segment module to HEX1
	
	// Instantiate Display/Comparator/CircuitA/MUX Modules
	comparator c0 (V, Z);
	crkt_A a0 (V, A);
	mux_4bit_2_to_1 m0 (V, A, Z, mux_out);
	seven_segment s0 (mux_out, hex0);
	seven_segment s1 (Z, hex1);
	
	
endmodule
//
//
//
// Comparator Module
module comparator (cmp_in, cmp_out);
	input [3:0] cmp_in;
	output cmp_out;

	assign cmp_out = (cmp_in > 4'b1001) ? 1'b1 : 1'b0; 
	
endmodule
//
//
//
// Circuit 'A' Module (gate level)
module crkt_A (crkt_in, crkt_out);
	input [3:0] crkt_in;
	output [3:0] crkt_out;
	
	assign crkt_out[3] = ~crkt_in[3];
	assign crkt_out[2] = crkt_in[2] & crkt_in[1];
	assign crkt_out[1] = ~crkt_in[1];
	assign crkt_out[0] = crkt_in[0];
	
endmodule
// //
// //
// //
// // Circuit 'A' Module (switch case)
// module crkt_A (crkt_in, crkt_out);
	// input [3:0] crkt_in;
	// output reg [3:0] crkt_out;
	
	// always @ (crkt_in)
	// begin
		// case (crkt_in)
		// 4'b1010: crkt_out = 4'b0000;
		// 4'b1011: crkt_out = 4'b0001;
		// 4'b1100: crkt_out = 4'b0010;
		// 4'b1101: crkt_out = 4'b0011;
		// 4'b1110: crkt_out = 4'b0100;
		// 4'b1111: crkt_out = 4'b0101;
		// default: crkt_out = 4'bxxxx;
		// endcase
	// end
// endmodule
//
//
//
// Multiplexer Module
module mux_4bit_2_to_1 (m0, m1, sel, m_out);
	input [3:0] m0, m1;
	input sel;
	output [3:0] m_out;

	assign m_out = (sel == 1'b1) ? m1 : m0; 
	
endmodule
//
//
//
// Display Module (digits 0-9)
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
