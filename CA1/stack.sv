`timescale 1ns/1ns
module stack#(parameter int size=2**8)(clk, rst, start, push, pop, cur_move, size, empty, stack_);
    input clk, rst, start, run, push, pop;
    input [1:0] cur_move;
    input done;
    output empty;
    reg empty;
    output [7:0] size;
    reg [7:0]size;
    output [size:0] stack_;
    reg [size:0] stack_;
    reg [8:0] index;

    always@(posedge clk)
    begin
        if (rst) begin
            stack_ <= 0;
            index <= 0;
            empty <= -1;end
        if (start)begin
            if (push)begin
                stack[index] <= cur_move;
                index <= index + 1;end
            else if (pop)begin
                if (index == 0)
                    empty <= 1;
                else begin    
                stack[index-1] <= 0;
                index <= index - 1;end
            end    
        size <= index+1; end
    end    
endmodule