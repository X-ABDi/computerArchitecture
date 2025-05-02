`timescale 1ns/1ns
module  qeue#(parameter int CAPACITY=2**8)(cur_move ,clk ,rst ,stack_ ,run ,done, size);
    input clk, rst, run, done;
    input [CAPACITY-1:0] stack_;
    input [7:0] size;
    output [1:0] cur_move;
    reg cur_move;

    reg [8:0] path;
    [8:0] index;

    always@(posedge clk)
    begin
        if (rst)begin
            path <= 0;
            index <= 0;end
        if (done)
            path <= stack;
        if (run & index != size)begin
            cur_move <= path[index]
            index <= index + 1
        end
    end
endmodule