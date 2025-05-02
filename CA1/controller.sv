`timescale 1ns/1ns

`define s0 4'd0
`define s1 4'd1
`define s2 4'd2
`define s3 4'd3
`define s4 4'd4

module controller(clk, rst, start, run, fail_i, done_i, fail, done);

input clk, rst, start, run, fail_i, done_i;
output [1:0] move_run;
output fail, done;
reg [1:0] move_run;
reg fail, done;

reg [2:0] ps;
reg [2:0] ns;

always @(posedge clk)
begin
    if (rst)
        ps <= s0;
    else
        ps <= ns;    
end    

always @(ps or start or run or rst)
begin
    case (ps)
        `s0: ns=start ? `s1:`s0;
        `s1: ns=(~done_i & ~fail_i) ? `s1:`s2;
        `s2: ns=done_i ? `s3: `s4;
        `s3: ns=run ? `s5: `s3;
        `s4: ns=`s4;
        `s5: ns=run ? `s5: `s3;
    endcase    
end    

always @(ps)
begin
    case (ps)
        `s0: fail<=0;done<=0;
        `s1: fail<=0;done<=0;
        `s2: fail<=0;done<=0;
        `s3: fail<=0;done<=1;
        `s4: fail<=1;done<=0;
        `s5: fail<=0;done<=1;
    endcase    
end

endmodule