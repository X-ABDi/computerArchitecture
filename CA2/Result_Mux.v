module Result_Mux (ResultSrc, ALU_Res, Read_Data, PC_four, Imm_Exit, Result);
 input [1:0]ResultSrc;
 input [31:0] ALU_Res, Read_Data, PC_four, Imm_Exit;
 output reg [31:0] Result;

 always @(ResultSrc, ALU_Res, Read_Data, PC_four, Imm_Exit) begin
	case (ResultSrc) 
		2'b00: Result = ALU_Res;
		2'b01: Result= Read_Data;
		2'b10: Result= PC_four;
		2'b11: Result= Imm_Exit;
		default: Result=32'd0;	
	endcase
 end
endmodule;	

