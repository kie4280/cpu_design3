//Author:張宸愷 0710018 何權祐 0710012

module ALU_Ctrl(
        funct_i,
        ALUOp_i,
        ALUCtrl_o,
        Sign_extend_o,
        Mux_ALU_src1,
        Jump_R
        );

//I/O ports
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;

//Internal Signals
reg        [4-1:0] ALUCtrl_o;
output reg Sign_extend_o;
output reg [2-1:0] Mux_ALU_src1;
output reg Jump_R;

//Select exact operation

//actual ALU control code
localparam [4-1:0] A_AND=0, A_OR=1, A_LW=2, A_SW=3, A_ADDU=4, A_SUBU=5, A_SLT=6, A_BLEZ=7,
                   A_SRA=8, A_SRAV=9, A_LUI=10, A_SLTU=11, A_SLL=12, A_SMUL=13, A_BGTZ=14;

//ALUOP from decoder
localparam[4-1:0] R_TYPE=0, ADDI=1, SLTIU=2, 
                  BEQ=3, LUI=4, ORI=5, BNE=6,
                  LW=7, SW=8, BLEZ=9, BGTZ=10,
                  JRS=11, J=12, JAL=13;

//begin logic
always@(*) begin  

    if(ALUOp_i == R_TYPE && (funct_i == 6'b000011 || funct_i == 6'b000000)) begin
        Mux_ALU_src1 = 1;
    end
    else begin
        Mux_ALU_src1 = 0;
    end

    

    if(ALUOp_i == R_TYPE) begin
        case(funct_i) 
            6'b100001: begin //add unsigned
                ALUCtrl_o = A_ADDU;
                Jump_R=0;
            end
            6'b100011: begin //sub unsigned
                ALUCtrl_o = A_SUBU;
                Jump_R=0;
            end
            6'b100100: begin //bitwise and
                ALUCtrl_o = A_AND;
                Jump_R=0;
            end
            6'b100101: begin //bitwise or
                ALUCtrl_o = A_OR;
                Jump_R=0;
            end
            6'b101010: begin //slt
                ALUCtrl_o = A_SLT;
                Jump_R=0;
            end
            6'b000011: begin // shift right constant
                ALUCtrl_o = A_SRA;
                Jump_R=0;
            end
            6'b000111: begin //shift right variable
                ALUCtrl_o = A_SRAV;
                Jump_R=0;
            end
            6'b001000: begin //jump register
                
                Jump_R=1;
            end
            6'b000000: begin //shift left logical
                ALUCtrl_o = A_SLL;
                Jump_R=0;
            end
            6'b011000: begin //signed multiplication
                ALUCtrl_o = A_SMUL;
                Jump_R=0;
            end

            default:;


        endcase
        Sign_extend_o = 0;
    end

    else if(ALUOp_i == ADDI) begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_ADDU;
        Jump_R=0;

    end
    else if(ALUOp_i == SLTIU) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_SLTU;
        Jump_R=0;

    end
    else if(ALUOp_i == BEQ)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_SUBU;
        Jump_R=0;
    end
    else if (ALUOp_i == LUI) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_LUI;
        Jump_R=0;
    end
    else if (ALUOp_i == ORI) begin
        Sign_extend_o = 0;
        ALUCtrl_o = A_OR;
        Jump_R=0;
    end 
    else if(ALUOp_i == BNE)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_SUBU;
        Jump_R=0;
    end
    else if(ALUOp_i == LW)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_LW;
        Jump_R=0;
    end
    else if(ALUOp_i == SW)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_SW;
        Jump_R=0;
    end
    else if(ALUOp_i == JRS)begin
        Sign_extend_o = 1;
        
        Jump_R=0;
    end
    else if(ALUOp_i == J)begin
        Sign_extend_o = 1;
        
        Jump_R=0;
    end
    else if(ALUOp_i == BLEZ)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_BLEZ;
        Jump_R=0;
    end
    else if(ALUOp_i == BGTZ)begin
        Sign_extend_o = 1;
        ALUCtrl_o = A_BGTZ;
        Jump_R=0;
    end

    else begin
        Sign_extend_o = 0;
    end

end


endmodule
