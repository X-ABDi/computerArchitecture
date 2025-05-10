`define SOPCODE 0100011

module SType (
    input [31:0] instruction,
    output reg [4:0] A1,
    output reg [4:0] A2,
    output reg [4:0] A3,
    output reg [31:0] immidiate
);

    always @(instruction) begin
        if (instruction[6:0] == SOPCODE) begin
            A1 <= instruction[19:15];
            A2 <= instruction[24:20];
            A3 <= instruction[11:7];
            if (instruction[31] == 0)  
                immidiate <= {24{1'b0}, instruction[31:25]}   
            else    
                immidiate <= {24{1'b1}, instruction[31:25]}
        end
    end
endmodule