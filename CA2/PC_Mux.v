module PC_Mux(PCSrc, PC_four, PC_Imm, ALU_Res, PC_Next);
 input [1:0] PCSrc;
 input [31:0] PC_four, PC_Imm, ALU_Res;
 output reg [31:0] PCNext;
 always @(PCSrc, PC_four, PC_Imm, ALU_Res) begin
	case (PCSrc)
	  2'b00: PC_Next = PC_four;
	  2'b01: PC_Next = PC_Imm;
	  2'b10: PC_Next = ALU_Res;
	  default: PC_Next = 32'd0;
        endcase
 end
endmodule;
