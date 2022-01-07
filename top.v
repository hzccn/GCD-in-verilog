`timescale 1ns / 1ps
module top #(parameter width = 8)
(
	input 	[width-1:0] operand_A,
	input 	[width-1:0] operand_B,
	
	output 				result_rdy,
	output 	[width-1:0] result_data,
	input				sys_clk,
	input				input_ready,
	output				input_available,
	input				result_taken
);
	
wire			A_en;
wire			B_en;
wire	[1:0]	A_mux_sel;
wire			B_mux_sel;
wire			B_zero;
wire			A_lt_B;
//控制器
state_ctrl U_state_ctrl(
	.sys_clk		(sys_clk),
	.B_zero			(B_zero),	
	.A_lt_B			(A_lt_B),
	
	.input_available(input_available),
	.input_ready    (input_ready),
	.result_rdy		(result_rdy),
	.result_taken	(result_taken),
	
	.A_mux_sel		(A_mux_sel),
	.B_mux_sel		(B_mux_sel),
	.A_en		    (A_en),
	.B_en			(B_en)
);

calc U_calc(
	.operand_A		(operand_A),		
	.operand_B		(operand_B),			
	.A_en			(A_en),	
	.B_en			(B_en),	
	.A_mux_sel		(A_mux_sel),	
	.B_mux_sel		(B_mux_sel),
	
	.result_data	(result_data),
	.B_zero			(B_zero),	
	.A_lt_B         (A_lt_B)
);

endmodule
