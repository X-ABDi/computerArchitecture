`timescale 1ns/1ns

module maze #(parameter int DEST_ADDR=2**8-1, parameter int ADDR_WIDTH = 8)(rst, start, run, move, fail, done);
input rst, start, run;
input [1:0] move_stack;
output [1:0] move;
reg [1:0] move;
output fail, done;
reg fail, done;


datapath dp (clk, rst, start, run, move1, fail1, done1);
controller controll_unit(clk, rst, start, run, fail1, done1, fail, done);

endmodule