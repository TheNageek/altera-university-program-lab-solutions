//
// ============================================================
// Laboratory: 		Lab 2 - Part 4 - Digital Logic
// Description:		Implementation of BCD decimal inputs to be summed 
//							and then output onto HEX 7-segment displays.
// Board:				DE1-SoC, Rev F, 5CSEMA5F31C6
//
// By:					K. Walsh
// Date:				August 10, 2017
//

// ============================================================
// Top Level Module
module lab2part4 (SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [8:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX3, HEX5;
	
	wire [3:0] x, y, s, r, t, u, v;
	wire [2:0] c, z;
	wire ci, co, w;
	assign x = SW[7:4];
	assign y = SW[3:0];
	assign ci = SW[8];
	assign LEDR[8:0] = SW[8:0];			//light up LEDs when SWs are achtive
	assign LEDR[9] = (z[0] | z[1]);			//light up LEDR9 when X or Y comparator
															//signal are '1', i.e. >9
	
	// Instantiate Full Adder Module
	full_adder f0 (.x(x[0]),.y(y[0]),.ci(ci),.s(s[0]),.co(c[0]));
	full_adder f1 (.x(x[1]),.y(y[1]),.ci(c[0]),.s(s[1]),.co(c[1]));
	full_adder f2 (.x(x[2]),.y(y[2]),.ci(c[1]),.s(s[2]),.co(c[2]));
	full_adder f3 (.x(x[3]),.y(y[3]),.ci(c[2]),.s(s[3]),.co(co));
	// Note, in order to use the same wire/net names as the instantiated
	// full adder module ports, we must used .named port style connections.  
	// Also, ensure that the correct data widths (i.e. 1-bit) are being utilized.
	
	
	// Instantiate cmp_0_9 Module
	cmp_0_9 cmp0 (.cmp_in(x),.cmp_out(z[0]));
	cmp_0_9 cmp1 (.cmp_in(y),.cmp_out(z[1]));
	cmp_0_9 cmp2 (.cmp_in(s),.cmp_out(z[2]));
	
	
	// Instantiate crkt_A Module
	crkt_A ck0 (.crkt_A_in(s),.crkt_A_out(r));
	
	
	// Instantiate crkt_B Module
	crkt_B ck1 (.crkt_B_in(t),.crkt_B_out(u));
	
	
	// Instantiate MUX Module
	mux_4bit_2_to_1 mx0 (.m0(s),.m1(r),.sel(z[2]),.m_out(t));
	mux_4bit_2_to_1 mx1 (.m0(t),.m1(u),.sel(co),.m_out(v));
	mux_4bit_2_to_1 mx2 (.m0(z[2]),.m1(co),.sel(co),.m_out(w));
	
	
	// Instantiate Display Module
	seven_segment s0 (.c(v),.segment(HEX0));
	seven_segment s1 (.c(w),.segment(HEX1));
	seven_segment s2 (.c(x),.segment(HEX5));
	seven_segment s3 (.c(y),.segment(HEX3));
	
	
endmodule
//
//
//
// Full Adder Module
module full_adder (x, y, ci, s, co);
	input x, y, ci;
	output s, co;
	
	assign s = ((x ^ y) ^ ci);
	assign co = ((x ^ y) == 1'b1) ? ci : y;

endmodule
//
//
//
// Comparator Module
module cmp_0_9 (cmp_in, cmp_out);
	input [3:0] cmp_in;
	output cmp_out;

	// Comparator > 9, True = 1, False = 0
	assign cmp_out = (cmp_in > 4'b1001) ? 1'b1 : 1'b0; 
	
endmodule
//
//
//
// Circuit 'A' Module (Behavioral Modeling)
module crkt_A (crkt_A_in, crkt_A_out);
	input [3:0] crkt_A_in;
	output reg [3:0] crkt_A_out;
	
	always @ (crkt_A_in)
		begin
			case (crkt_A_in)
				4'b1010: crkt_A_out = 4'b0000;  	//10 in, 0 out
				4'b1011: crkt_A_out = 4'b0001;	//11 in, 1 out
				4'b1100: crkt_A_out = 4'b0010;	//12 in, 2 out
				4'b1101: crkt_A_out = 4'b0011;	//13 in, 3 out
				4'b1110: crkt_A_out = 4'b0100;	//14 in, 4 out
				4'b1111: crkt_A_out = 4'b0101;	//15 in, 5 out
				default: crkt_A_out = 4'bxxxx;	
			endcase
		end
endmodule
//
//
//
// Circuit 'B' Module (Behavioral Modeling)
module crkt_B (crkt_B_in, crkt_B_out);
	input [3:0] crkt_B_in;
	output reg [3:0] crkt_B_out;
	
	always @ (crkt_B_in)
		begin
			case (crkt_B_in)
				4'b0000: crkt_B_out = 4'b0110; 	//0 in, 6 out
				4'b0001: crkt_B_out = 4'b0111;	//1 in, 7 out
				4'b0010: crkt_B_out = 4'b1000;	//2 in, 8 out
				4'b0011: crkt_B_out = 4'b1001;	//3 in, 9 out
				default: crkt_B_out = 4'bxxxx;	
			endcase
		end
endmodule
//
//
//
// Multiplexer Module
module mux_4bit_2_to_1 (m0, m1, sel, m_out);
	input [3:0] m0, m1;
	input sel;
	output [3:0] m_out;
	
	// Conditional Statement
	assign m_out = (sel == 1'b1) ? m1 : m0; 
	
endmodule
//
//
//
// 7-Segment Display Module (digits 0-9)
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

