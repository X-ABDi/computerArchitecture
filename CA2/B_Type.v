`define BOPCODE 1100011
`define BEQFUNC3 000
`define BNQFUNC3 001

module BType (
    input [31:0] instruction,
    output reg [4:0] A1,
    output reg [4:0] A2,
    output reg [31:0] Immidiate
);

    always @(instruction) begin
        if (instruction[6:0] == BOPCODE) begin
            if (instruction[31] == 0)
                Immidiate <= {19{1'b0},instruction[31], instruction[7], instruction[30:25], instruction[11:8], 0};
            else 
                Immidiate <= {19{1'b1},instruction[31], instruction[7], instruction[30:25], instruction[11:8], 0};    
            A1 <= instruction[19:15];
            A2 <= instruction[24:20];     
        end
    end
endmodule