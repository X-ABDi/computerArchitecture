`define ROPCODE 0110011

module RType (
    input [31:0] instruction,
    output reg [4:0] A1,
    output reg [4:0] A2,
    output reg [4:0] A3
);

    always @(instruction) begin
        if (instruction[6:0] == ROPCODE) begin
            A1 <= instruction[19:15];
            A2 <= instruction[24:20];
            A3 <= instruction[11:7];     
        end
    end
endmodule