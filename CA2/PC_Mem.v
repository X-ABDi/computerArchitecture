module PC_Mem (clk, reset, PC_Next, PC);
 input clk, reset;
 input [31:0] PC_Next;
 output reg [31:0] PC;
 
 always @(posedge clk or posedge reset) begin 
	if (reset) 
	  PC <= 32d'0;
	else
	  PC <= PC_Next;
 end

endmodule;
