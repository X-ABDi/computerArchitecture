module PC_Plus4(PC,PC_four);
 input [31:0] PC;
 output reg [31:0] PC_four;
 wire out;
 assign {out,PC_four} = PC + 32'd4;
endmodule; 
