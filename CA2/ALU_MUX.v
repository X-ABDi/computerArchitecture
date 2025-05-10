module ALU_MUX (
    input ALUSrc;
    input [31:0] register;
    input [31:0] immidiate;
    output reg [31:0] ALUent;
);

always@(*) begin
    case (ALUSrc)
        1'b0: ALUent <= register;
        1'b1: ALUent <= immidiate; 
    endcase
end

endmodule