`timescale 1ns/1ns

module return_check(return_ornot, dout , row, colomn);
input dout;
input [7:0] row;
input [7:0] colomn;
output return_ornot;
reg return_ornot;

always @(dout or row or colomn) 
begin
    if (dout)
        return_ornot <= 1;
    else if (row > 4b'd15 or row < 0)
        return_ornot <= 1;
    else if (colomn > 4'bd15 or colomn < 0)
        return_ornot <= 1;
    else
        return_ornot <= 0;    
end    
endmodule