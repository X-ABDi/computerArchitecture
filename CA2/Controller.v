`define BOPCODE 1100011
`define ROPCODE 0110011
`define IOPCODE 0010011
`define SOPCODE 0100011
`define UOPCODE 0110111
`define JOPCODE 1101111
`define LWOPCODE 0000011
`define JALROPCODE 1100111

`define FUNC3ADDSUB 000
`define FUNC3AND 111
`define FUNC3OR 110
`define FUNC3SLT 010

`define FUNC7ADD 0000000
`define FUNC7SUB 0100000
`define FUNC7OTHER 0000000

`define OP_ALU_ADD    6'b011001 // Add
`define OP_ALU_SUB    6'b011011 // Subtract
`define OP_ALU_AND    6'b011101 // Bitwise AND
`define OP_ALU_OR     6'b011111 // Bitwise OR
`define OP_ALU_XOR    6'b100001 // Bitwise XOR
`define OP_ALU_SLT    6'b100011 // Set Less Than (signed)
`define OP_ALU_SLTU   6'b100101 // Set Less Than (unsigned)
`define OP_ALU_SLL    6'b100111 // Shift Left Logical
`define OP_ALU_SRL    6'b101001 // Shift Right Logical
`define OP_ALU_SRA    6'b101011 // Shift Right Arithmetic


`define FUNC3ADDI_JALR 000
`define FUNC3SLTI_LW 010
`define FUNC3SLTIU 011
`define FUNC3XORI 100
`define FUNC3ORI 110
`define FUNC3ANDI 111
`define FUNC3SLLI 001
`define FUNC3SRLI_SRAI 101
        // SRLI: funct7 = 0000000
        // SRAI: funct7 = 0100000
`define FUNC3SW 010  

`define FUNC3BEQ 000
`define FUNC3BNQ 001

module Controller (
    input [31:0] instruction,
    input flag,
    output reg [5:0] ALUop,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump
);
reg [2:0] func3;
assign func3 = instruction[14:12];
always @(instruction) begin
    case (instruction[6:0])
        ROPCODE: begin
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Branch <= 0;
            Jump <= 0;
            case (func3)
                FUNC3ADDSUB: begin 
                    if (instruction[31:25] == FUNC7ADD) ALUop <= OP_ALU_ADD;
                    else if (instruction[31:25] == FUNC7SUB) ALUop <= OP_ALU_SUB; 
                    end
                FUNC3AND: ALUop <= OP_ALU_AND;                  
                FUNC3OR: ALUop <= OP_ALU_OR;
                FUNC3SLT: ALUop <= OP_ALU_SLT;
                default: 
            endcase
        end
        IOPCODE: begin
            RegWrite <= 1;
            ALUSrc <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            MemToReg <= 0;
            Branch <= 0;
            Jump <= 0;
            case (func3)
                FUNC3ADDI_JALR: ALUop <= OP_ALU_ADD;
                FUNC3ORI: ALUop <= OP_ALU_OR;
                FUNC3SLTI_LW: ALUop <= OP_ALU_SLT;
                default: 
            endcase
        end
        SOPCODE: begin
            if (func3 == FUNC3SW) begin
            RegWrite <= 0;
            ALUSrc <= 1;
            MemRead <= 0;
            MemWrite <= 1;
            MemToReg <= 0;
            Branch <= 0;
            Jump <= 0;
            ALUop <= 2'b0;
            end
        end
        BOPCODE: begin
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUOp <= 01; 
            Jump <= 0;
            case (func3)
                FUNC3BEQ: begin
                    if (flag) Branch <= 1;
                    else 
                        Branch <= 0;
                end
                FUNC3BNQ: begin
                    if (flag) Branch <= 0;
                    else
                        Branch <= 1;
                end
                default: 
            endcase
        end
        UOPCODE: begin
            RegWrite <= 1;
            ALUSrc <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            MemToReg <= 0;
            Branch <= 0;
            Jump <= 0;
            ALUop <= 2'b0;
        end

        JOPCODE: begin
            RegWrite <= 1;
            ALUSrc <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            MemToReg <= 0;
            Branch <= 0;
            Jump <= 1;
            ALUop <= 0;
        end
        LWOPCODE:
        begin
            RegWrite <= 1;
            ALUSrc <= 0;
            MemRead <= 1;
            MemWrite <= 0;
            MemToReg <= 1;
            Branch <= 0;
            Jump <= 0;
            ALUop <= 0;
        end
        JALROPCODE:
        begin
            RegWrite <= 1;
            ALUSrc <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            MemToReg <= 0;
            Branch <= 0;
            Jump <= 1;
            ALUop <= OP_ALU_ADD;
        end
        default: 
    endcase
end

endmodule