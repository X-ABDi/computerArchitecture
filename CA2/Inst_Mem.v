module Inst_Mem (PC, Inst);
 input [31:0] PC;
 output [31:0] Inst;
    
 reg [7:0] Inst_Mem [0:$pow(2, 16)-1]; 

 wire [31:0] adr;
 assign adr = {PC[31:2], 2'b00}; 

 initial $readmemh("Ins_Fin.mem", Inst_Mem);

 assign Inst = {Inst_Mem[adr + 3], Inst_Mem[adr + 2], Inst_Mem[adr + 1], Inst_Mem[adr]};
    
endmodule;

