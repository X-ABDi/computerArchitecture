`timescale 1ns/1ns
module datapath #(parameter int ADDR_WIDTH = 8, parameter int CAPACITY=2**8)(fail_i, done_i, move_run, clk, rst, start, run)

input clk, rst, start, run;
output [1:0] move_run;
output fail_i, done_i;
reg [1:0] move_run;
reg fail_i, done_i;
 
wire [7:0] addr;
wire we;
wire [1:0] cur_move;
wire push, pop;
wire din, dout;
wire [CAPACITY-1:0] stack_;
wire [7:0] size;

qeue path (move_run, clk, rst, stack_, run, size);
stack finding_path (clk, rst, start, push, pop, cur_move, done_i, size, empty, stack_);
Memory mem (clk, addr, we, din, dout);
path_process process (clk, rst, start, empty, dout, addr, push, pop, din, fail_i, done_i, cur_move, we);

endmodule