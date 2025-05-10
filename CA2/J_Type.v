`define JOPCODE 00100111

module JType (
    input [31:0] instruction,
    output reg [4:0] A3,
    output reg [31:0] immidiate
);

    always @(instruction) begin
        if (instruction[6:0] == JOPCODE) begin
            if (instruction[31] == 0)
                immidiate <= {13{1'b0}, instruction[19:12], instruction[20], instruction[30:21]};
            else
                immidiate <= {13{1'b1}, instruction[19:12], instruction[20], instruction[30:21]};;    
            A3 <= instruction[11:7];     
        end
    end
endmodule