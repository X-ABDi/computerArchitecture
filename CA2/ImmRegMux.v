`define BIS 0000
`define IIS 0001
`define JIS 0010
`define SIS 0011
`define UIS 0100

module ImmRegMux (
    input [3:0] ImmSel;
    input [31:0] Bimm;
    input [31:0] Iimm;
    input [31:0] Jimm;
    input [31:0] Simm;
    input [31:0] Uimm;
    output reg [31:0] AluImm;
);

always @(*) begin
    case (ImmSel)
        BIS: AluImm <= Bimm;
        IIS: AluImm <= Iimm;
        JIS: AluImm <= Jimm;
        SIS: AluImm <= Simm;
        UIS: AluImm <= Uimm;
        default: 
    endcase
end

endmodule