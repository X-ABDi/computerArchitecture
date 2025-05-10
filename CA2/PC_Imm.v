module PC_Imm (PC, offset, PC_Targrt);
 input [31:0] PC;
 input [31:0] offset;
 output [31:0] PC_Target;
 wire out;
 assign {out, PC_Traget} = PC + offset;
endmodule;
