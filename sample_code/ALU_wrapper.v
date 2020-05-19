//Author:張宸愷 0710018 何權祐 0710012

module ALU(
    rst_n,
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
    );

//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;
input rst_n;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals

wire          zero_o;

reg [32-1:0]  result_o;
wire          cout_out;
wire          overflow_out;
reg [3-1:0]   comp;
reg [4-1:0]   ALU_Ctrl;
wire [32-1:0] result_out;
wire [64-1:0] shift_src;


Sign_Extend2 e2(
    .data_i(src2_i),
    .data_o(shift_src)
);

alu alu(
	.rst_n(rst_n),
	.src1(src1_i),
	.src2(src2_i),
	.ALU_control(ALU_Ctrl),
	.comp(comp),
	.result(result_out),
	.zero(zero_o),
	.cout(cout_out),
	.overflow(overflow_out)
);



//actual ALU control code
localparam [4-1:0] AND=0, OR=1, NAND=2, NOR=3, ADDU=4, SUBU=5, SLT=6, EQUAL=7,
                   SRA=8, SRAV=9, LUI=10, SLTU=11;

always@(*) begin

    if(ctrl_i == SLT) comp = 3'b000;
    else comp = 3'b101; 

    case(ctrl_i) 
        AND: begin
            ALU_Ctrl = 4'b0000;
            result_o = result_out;
        end
        OR: begin
            ALU_Ctrl = 4'b0001;
            result_o = result_out;
        end
        ADDU: begin
            ALU_Ctrl = 4'b0010;
            result_o = result_out;
        end
        SUBU: begin
            ALU_Ctrl = 4'b0110;
            result_o = result_out;
        end
        SLT: begin
            ALU_Ctrl = 4'b0111; 
            result_o = result_out;
        end
        LUI: begin
            result_o = {src2_i[15:0], 16'b0};
        end
        SLTU: begin
            ALU_Ctrl = 4'b0111;
            result_o = result_out;
        end
        SRA: begin
            result_o = shift_src >> src1_i[10:6];

        end
        SRAV: begin
            result_o = shift_src >> src1_i;

        end

        default: begin


        end

    endcase


end


endmodule
