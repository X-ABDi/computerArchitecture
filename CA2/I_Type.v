`define IOPCODE 00100111

module IType (
    input [31:0] instruction,
    output reg [4:0] A1,
    output reg [4:0] A3,
    output reg [31:0] immidiate
);

    always @(instruction) begin
        if (instruction[6:0] == IOPCODE) begin
            if (instruction[31] == 0)
                immidiate <= {20{1'b0},instruction[31:20]};
            else
                immidiate <= {20{1'b1},instruction[31:20]};     
            A1 <= instruction[19:15];
            A3 <= instruction[11:7];     
        end
    end
endmodule