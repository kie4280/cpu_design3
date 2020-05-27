//Author:張宸愷 0710018 何權祐 0710012

module Decoder(
    rst_n,
    instr_op_i,
    RegWrite_o,
    memread_o,
    memwrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o,
    Branch_eq,
    Jump,
    Jump_Ctrl
    );

//I/O ports
input  [6-1:0] instr_op_i;
input rst_n;

output reg        RegWrite_o = 0;
output reg[4-1:0] ALU_op_o = 0;
output reg[2-1:0] ALUSrc_o = 0;
output reg        RegDst_o = 0;
output reg        Branch_o = 0;
output reg        Branch_eq = 0;
output reg        Jump = 0;
output reg[1:0]   Jump_Ctrl = 0;
output reg        memread_o = 0;
output reg        memwrite_o = 0;

//ALUOP for decoder
localparam[4-1:0] R_TYPE=0, ADDI=1, SLTIU=2, 
                  BEQ=3, LUI=4, ORI=5, BNE=6,
                  LW=7, SW=8, BLEZ=9, BGTZ=10,
                  JRS=11, J=12, JAL=13;


//begin logic

always@(*) begin

    if(rst_n) begin
        RegDst_o = (instr_op_i == 6'b000000);
        Branch_o = (instr_op_i == 6'b000100 || instr_op_i == 6'b000101);
        Branch_eq = (instr_op_i == 6'b000100);
        Jump = (instr_op_i == 6'b000010)||(instr_op_i == 6'b000011);//JUMP case都沒打
        memread_o = (instr_op_i == 6'b100011);
        memwrite_o = (instr_op_i == 6'b101011);
        case (instr_op_i)
            6'b000000: begin
                ALU_op_o = R_TYPE;
                ALUSrc_o = 0;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b001000: begin
                ALU_op_o = ADDI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b001011: begin
                ALU_op_o = SLTIU;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b000100: begin
                ALU_op_o = BEQ;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            end
            6'b001111: begin
                ALU_op_o = LUI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b001101: begin
                ALU_op_o = ORI;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = BNE;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = LW;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = SW;
                ALUSrc_o = 1;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = BLEZ;
                ALUSrc_o = 2;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = BGTZ;
                ALUSrc_o = 2;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            /*end
            6'b000101: begin
                ALU_op_o = JRS;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 1;
            */end
            6'b000101: begin
                ALU_op_o = J;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 0;
            end
            6'b000101: begin
                ALU_op_o = JAL;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 1;
            end
            6'b000101: begin
                ALU_op_o = JAL;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 1;
            end
            6'b000101: begin
                ALU_op_o = JAL;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                Jump_Ctrl = 1;
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
