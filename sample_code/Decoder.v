//Author:張宸愷 0710018 何權祐 0710012

module Decoder(
    rst_n,
    instr_op_i,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o,
    Branch_eq
    );

//I/O ports
input  [6-1:0] instr_op_i;
input rst_n;

output reg        RegWrite_o = 0;
output reg[4-1:0] ALU_op_o = 0;
output reg        ALUSrc_o = 0;
output reg        RegDst_o = 0;
output reg        Branch_o = 0;
output reg        Branch_eq = 0;


//ALUOP for decoder
localparam[4-1:0] R_TYPE=0, ADDI=1, SLTIU=2, BEQ=3, LUI=4, ORI=5, BNE=6;


//begin logic

always@(*) begin

    if(rst_n) begin
        RegDst_o = (instr_op_i == 6'b000000);
        Branch_o = (instr_op_i == 6'b000100 || instr_op_i == 6'b000101);
        Branch_eq = (instr_op_i == 6'b000100);

        case (instr_op_i)
            6'b000000: begin
                ALU_op_o = R_TYPE;
                ALUSrc_o = 0;
                RegWrite_o = 1;
            end
            6'b001000: begin
                ALU_op_o = ADDI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end
            6'b001011: begin
                ALU_op_o = SLTIU;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end
            6'b000100: begin
                ALU_op_o = BEQ;
                ALUSrc_o = 0;
                RegWrite_o = 0;
            end
            6'b001111: begin
                ALU_op_o = LUI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end
            6'b001101: begin
                ALU_op_o = ORI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end
            6'b000101: begin
                ALU_op_o = BNE;
                ALUSrc_o = 0;
                RegWrite_o = 0;
            end
            default: ;
        endcase
    


    end else begin
        RegWrite_o = 0;
        ALU_op_o = 0;
        ALUSrc_o = 0;
        RegDst_o = 0;
        Branch_o = 0;
        Branch_eq = 0;

    end

    
    

end

endmodule
