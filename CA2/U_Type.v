`define UOPCODE 0110111

module UType (
    input [31:0] instruction,
    output reg [4:0] A3,
    output reg [31:0] immidiate
);

    always @(instruction) begin
        if (instruction[6:0] == UOPCODE) begin
            if (instruction[31] == 0)
                immidiate <= {12{1'b0}, instruction[31:12]};
            else
                immidiate <= {12{1'b1}, instruction[31:12]};
            A3 <= instruction[11:7]; 
        end
    end
endmodule