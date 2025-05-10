`timescale 1ns/1ns
module RF (clk, reset, Regwrite, A1, A2, A3, RD1, RD2, WD);
 input clk, reset;
 input Regwrite;
 input [4:0] A1;
 input [4:0] A2;
 input [4:0] A3;
 input [31:0] WD;
 output [31:0] RD1;
 output [31:0] RD2;
 reg [31:0] registers [31:0];
 assign RD1 = registers [A1];
 assign RD2 = registers [A2];

 always @(posedge clk or posedge reset) begin 
	if (reset) registers [0] <= 32'd0;
	else if (Regwrite) 
	  begin 
	    registers [A3] <= WD;
	end
 end
endmodule;