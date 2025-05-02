module four_bit_multiplier (
    output [7:0] P,    
    input [3:0] A,
    input [3:0] B 
);

    wire [3:0] pp0, pp1, pp2, pp3;

    assign pp0 = A & {4{B[0]}}; 
    assign pp1 = A & {4{B[1]}} << 1; 
    assign pp2 = A & {4{B[2]}} << 2; 
    assign pp3 = A & {4{B[3]}} << 3; 

    assign P = pp0 + pp1 + pp2 + pp3;

endmodule
