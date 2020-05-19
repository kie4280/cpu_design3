//Author:張宸愷 0710018 何權祐 0710012

module ALU_Ctrl(
        funct_i,
        ALUOp_i,
        ALUCtrl_o,
        Sign_extend_o,
        Mux_ALU_src1
        );

//I/O ports
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;

//Internal Signals
reg        [4-1:0] ALUCtrl_o;
output reg Sign_extend_o;
output reg  Mux_ALU_src1;

//Select exact operation

//actual ALU control code
localparam [4-1:0] A_AND=0, A_OR=1, A_NAND=2, A_NOR=3, A_ADDU=4, A_SUBU=5, A_SLT=6, A_EQUAL=7,
                   A_SRA=8, A_SRAV=9, A_LUI=10, A_SLTU=11;

//ALUOP from decoder
localparam[4-1:0] R_TYPE=0, ADDI=1, SLTIU=2, BEQ=3, LUI=4, ORI=5, BNE=6;

//begin logic
always@(*) begin    

    Mux_ALU_src1 = (funct_i == 6'b000011 && ALUOp_i == R_TYPE);

    if(ALUOp_i == R_TYPE) begin
        case(funct_i) 
            6'b100001: begin //add unsigned
                ALUCtrl_o = A_ADDU;
            end
            6'b100011: begin //sub unsigned
                ALUCtrl_o = A_SUBU;
            end
            6'b100100: begin //bitwise and
                ALUCtrl_o = A_AND;
            end
            6'b100101: begin //bitwise or
                ALUCtrl_o = A_OR;
            end
            6'b101010: begin //slt
                ALUCtrl_o = A_SLT;
            end
            6'b000011: begin // shift right constant
                ALUCtrl_o = A_SRA;
            end
            6'b000111: begin //shift right variable
                ALUCtrl_o = A_SRAV;
            end


        endcase
        Sign_extend_o = 0;
    end

    else if(ALUOp_i == ADDI) begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_ADDU;

    end
    else if(ALUOp_i == SLTIU) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_SLTU;

    end
    else if(ALUOp_i == BEQ)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_SUBU;
    end
    else if (ALUOp_i == LUI) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_LUI;
    end
    else if (ALUOp_i == ORI) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_OR;
    end 
    else if(ALUOp_i == BNE)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_SUBU;
    end

    else begin
        Sign_extend_o = 0;
    end

end


endmodule
