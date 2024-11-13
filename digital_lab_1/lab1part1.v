//
// ============================================================
// Laboratory: Lab 1 - Part 1 - Digital Logic
// Description: Switches, Lights and Multiplexers
//
// Top Level Module
module sw_leds (
	input [9:0] SW,
	output [9:0] LEDR);
	
	assign LEDR = SW;

endmodule
