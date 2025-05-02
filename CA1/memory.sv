`timescale 1ns/1ns
module Memory #(
    parameter int DATA_WIDTH = 1, 
    parameter int ADDR_WIDTH = 8 
)(
    input reg clk,                  
    input reg [ADDR_WIDTH-1:0] addr, 
    input reg we,         
    input reg [DATA_WIDTH-1:0] din, 
    output reg [DATA_WIDTH-1:0] dout 
);

    reg [DATA_WIDTH-1:0] mem [0:2**ADDR_WIDTH-1];

    initial begin
        string filename = "memory_init.txt"; 
        int file;
        file = $fopen(filename, "r");
        if (file == 0) begin
            $display("Error: Could not open file %s", filename);
            $finish;
        end

        for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
            if (!$feof(file)) begin
                $fscanf(file, "%b
", mem[i]);
            end else begin
                mem[i] = '0;
            end
        end
        $fclose(file);
    end

    always_comb begin
        dout = mem[addr];
    end

    always_ff @(posedge clk or posedge rst) begin
        if (we) begin
            mem[addr] <= din; 
        end
    end

endmodule
