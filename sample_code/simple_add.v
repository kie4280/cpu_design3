`timescale 1ns/1ps
//Author:張宸愷 0710018 何權祐 0710012

module add(A, B, CIN, COUT, SUM);

	input A, B, CIN;
	output COUT, SUM;

	assign {COUT, SUM} = A + B + CIN;
	
endmodule