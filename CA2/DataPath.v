module DataPath (
    input [31:0] instruction;

);

Controller controller(
    .instruction,
    .flag,
    .ALUop,
    .ALUSrc,
    .MemtoReg,
    .RegWrite,
    .MemRead,
    .MemWrite,
    .Branch,
    .Jump
);
PC_Mux pcMux(
    .PCSrc, 
    .PC_four, 
    .ALU_Res, 
    .PC_Next
);
PC_Plus4(
    .PC,
    .PC_four
);
Inst_Mem instMem(
    .PC, 
    .Inst
);
IType Iinst(
    .instruction,
    .A1,
    .A3,
    .immidiate
);
JType Jinst(
    .instruction,
    .A3,
    .immidiate
);
RType Rinst(
    .instruction,
    .A1,
    .A2,
    .A3
);
SType Sinst(
    .instruction,
    .A1,
    .A2,
    .A3,
    .immidiate
);
UType Uinst(
    .instruction,
    .A3,
    .immidiate
);
ImmRegMux immMUX(
    .ImmSel;
    .Bimm;
    .Iimm;
    .Jimm;
    .Simm;
    .Uimm;
    .AluImm;
);
RF registerFile(
    .clk,
    .reset, 
    .Regwrite, 
    .A1, 
    .A2, 
    .A3, 
    .RD1, 
    .RD2, 
    .WD
);


endmodule