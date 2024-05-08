//
// ============================================================
// Laboratory: 	Lab 2 - Part 5 - Digital Logic
// Description:	Implementation of BCD adder similar to part 4 
//				but instead of as robust of a design, utilize
//				more of the Verilog compiler to do the work.
//				The psuedo-code below is what we'll mirror.
//
// Board:		DE1-SoC, Rev F, 5CSEMA5F31C6
//
//						To = A+B+c0
//						if (T0 > 9) then
//							Z0 = 10;
//							c1 = 1;
//						else
//							Z0 = 0;
//							c1 = 0;
//						end if
//						S0 = T0 - Z0
//						S1 = c1
//
//
// By:			K. Walsh
// Date:		August 11, 2017
//

// =======================================
//
// Top Level Module
module lab2part5 (SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [8:0] SW;
	output [8:0] LEDR;
	output [6:0] HEX0, HEX1, HEX3, HEX5;
	
	wire [3:0] a,b,h0,h1;
	wire [4:0] sum;
	wire ci;
	reg [4:0] compare;
	reg co;
	
	assign LEDR = SW;
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign ci = SW[8];
	
	
	// Summation
	assign sum = a + b + ci;
	
	
	// Behavioral Comparison
	always @ (sum)
		begin
			if (sum > 9)
				begin
					compare = 5'd10;			//or 5'b01010
					co = 1'd1;						//or 1'b1
				end
			else
				begin
					compare = 5'd0;			//or 5'b00000
					co = 1'd0;						//or 1'b0
				end
		end
	
	
	// Assign HEX0 & HEX1 Nets
	assign h0 = sum - compare;
	assign h1 = co;
	
	
	// Instantiate Display Module
	seven_segment s0 (.ch(h0),.segment(HEX0));	//HEX0
	seven_segment s1 (.ch(h1),.segment(HEX1));	//HEX1
	seven_segment s2 (.ch(b),.segment(HEX3));		//HEX3
	seven_segment s3 (.ch(a),.segment(HEX5));		//HEX5
	
endmodule

// =======================================
//
// Display Module (digits 0-9)
module seven_segment (ch, segment);
	input [3:0] ch;
	output [6:0] segment;
	
	assign segment[0] = (~ch[3]&~ch[2]&~ch[1]&ch[0])|(~ch[3]&ch[2]&~ch[1]&~ch[0]);	//segment off, digits(1,4)
	//0001 OR 0100
	assign segment[1] = (~ch[3]&ch[2]&~ch[1]&ch[0])|(~ch[3]&ch[2]&ch[1]&~ch[0]);	//segment off, digits(5,6)
	//0101 OR 0110
	assign segment[2] = (~ch[3]&~ch[2]&ch[1]&~ch[0]);	//segment off, digits(2)
	//0010
	assign segment[3] = (~ch[3]&~ch[2]&~ch[1]&ch[0])|(~ch[3]&ch[2]&~ch[1]&~ch[0])|(~ch[3]&ch[2]&ch[1]&ch[0])|(ch[3]&~ch[2]&~ch[1]&ch[0]);	//segment off, digits(1,4,7,9)
	//0001 OR 0100 OR 0111 OR 1001
	assign segment[4] = (~ch[3]&~ch[2]&~ch[1]&ch[0])|(~ch[3]&~ch[2]&ch[1]&ch[0])|(~ch[3]&ch[2]&~ch[1]&~ch[0])|(~ch[3]&ch[2]&~ch[1]&ch[0])|(~ch[3]&ch[2]&ch[1]&ch[0])|(ch[3]&~ch[2]&~ch[1]&ch[0]);	//segment off, digits(1,3,4,5,7,9)
	//0001 OR 0011 OR 0100 OR 0101 OR 0111 OR 1001 
	assign segment[5] = (~ch[3]&~ch[2]&~ch[1]&ch[0])|(~ch[3]&~ch[2]&ch[1]&~ch[0])|(~ch[3]&~ch[2]&ch[1]&ch[0])|(~ch[3]&ch[2]&ch[1]&ch[0]);	//segment off, digits(1,2,3,7)
	//0001 OR 0010 OR 0011 OR 0111 
	assign segment[6] = (~ch[3]&~ch[2]&~ch[1]&~ch[0])|(~ch[3]&~ch[2]&~ch[1]&ch[0])|(~ch[3]&ch[2]&ch[1]&ch[0]);	//segment off, digits(0,1,7)
	//0000 OR 0001 OR 0111

endmodule


