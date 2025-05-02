`timescale 1ns/1ns
module path_process #(parameter int ADDR_WIDTH = 8, parameter int DEST_ADDR=2**8-1)(clk, rst, start, empty, dout,    
                                                                                    addr, push, pop, din, fail, done, direction, we)

input rst, start, clk;
input empty, dout;
output push, pop;
output din;
output fail, done;
reg push, pop, din, fail, done;
output direction;
reg [1:0] direction;
output [ADDR_WIDTH-1:0] add;
reg [ADDR_WIDTH-1:0] addr;
output we;

reg [3:0] u_row;
reg [3:0] u_colomn;
reg [3:0] row;
reg [3:0] colomn;
reg return_ornot;
reg [1:0]temp;
reg dout_=dout;
reg blocked;

four_bit_multiplier multiplier(addr, u_row, u_colomn);
return_check check(return_ornot, dout_, addr);
update_return update(u_row, u_colomn, blocked, return_ornot, row, colomn, temp, dout_);

always @(posedge clk)
begin
    if (rst) begin
        return_ornot <= 0;
        temp <= 2'd0;
        u_row <= 4'd0;
        u_colomn <= 4'd0;
        addr <= 8'd0;
        push <= 0;
        pop <= 0;end
    if (start)  begin
        push <= 1; 
        direction <= temp; 
        if(empty or blocked) begin
            fail <= 1;
            done <= 0;end
        else if (addr == DEST_ADDR) begin
            done <= 1;
            fail <= 0; end
        else if (return_ornot) begin
            fail <= 0;
            done <= 0;
            pop <= 1;
            push <= 0;
            temp <= temp + 1;
            we <= 0;end
        else if(!return_ornot) begin
            fail <= 0;
            done <= 0;
            push <= 1;
            pop <= 0;
            temp <= 2'd0;
            din <= 1;
            we <= 1; end
    end        
end    

assign direction = temp;
assign row = u_row;
assign colomn = u_colomn;
endmodule