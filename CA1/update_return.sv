`timescale 1ns/1ns
// update_return update(u_row, u_colomn, return_ornot, row, colomn, temp, dout_);
module update_return (u_row, u_colomn, blocked, return_ornot, row, colomn, temp, dout);

always @(temp)
begin
    if (~return_ornot)begin
        blocked = 0;
        case(temp)
        2'd0: u_colomn <= colomn+1; u_row = row; 
        2'd1: u_row <= row+1; u_colomn = colomn;
        2'd2: u_row <= row-1; u_colomn = colomn;
        2'd3: u_colomn <= colomn-1; u_row = row;
        endcase
    end
    else begin
        case(temp)
        2'd0: blocked <= 1;
        2'd1: u_colomn <= colomn-1; u_row <= row+1;
        2'd2: u_row <= row-2; u_colomn <= colomn;
        2'd3: u_row <= row+1; u_colomn <= colomn-1;
        endcase
    end
end    

endmodule