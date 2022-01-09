`timescale 1ns / 1ps
module state_ctrl(
	input	wire 		sys_clk,
	
	input	wire		B_zero,				//计算完成标志位
	input	wire		A_lt_B,				//A是否大于B，交换减数、被减数标志位
	
	output	reg			input_available=0,	//可接受数据标志位
	input   wire   		input_ready,		//输入数据有效标志位
		
	output	reg			result_rdy,			//计算结束标志位
	input   wire   		result_taken,		//输出数据已取走
		
	output 	reg	[1:0]	A_mux_sel,			//A选择器，片选信号
	output 	reg		 	B_mux_sel,			//B选择器，片选信号
	output 	reg			A_en=0,				//D触发器，使能信号
	output 	reg			B_en=0				//D触发器，使能信号

);
localparam READY	=2'b00;
localparam CALC		=2'b01;
localparam DONE		=2'b10;

parameter A_SEL_InA		=2'b00;
parameter A_SEL_InB		=2'b10;
parameter A_SEL_InSUB	=2'b01;
 
parameter B_SEL_InB		=1'b1;
parameter B_SEL_InA		=1'b0;

reg	[1:0]	state  		= READY;			//状态机初始状态为READY
reg	[1:0]	next_state  = READY;			//状态机初始状态为READY	

	always @(*)
		begin
		A_en=0;
		B_en=0;
		case(state)
			READY:
				begin
				input_available = 1'b1;				//可接收新数据标志位拉高
				A_mux_sel= A_SEL_InA;				//A_mux选择器选择进数端
				A_en=1;								//A_D触发器使能，将A_mux_InA送到A_mux_out
				B_mux_sel= B_SEL_InB;				//A_mux选择器选择进数端
				B_en=1;								//B_D触发器使能，将B_mux_InA送到B_mux_out
				end
			CALC:
				begin
				if (A_lt_B)							//判断B是否大于A，如果是则交换AB
					begin
					A_mux_sel 	=	A_SEL_InB;
					A_en=1;
					B_mux_sel 	= 	B_SEL_InA;
					B_en=1;
					end
				else if( !B_zero )					//判断计算是否完成
					begin
					A_mux_sel	=	A_SEL_InSUB;	//未完成则将A_mux_InSub送到A_mux_out
					A_en=1;
					end
				end
			DONE:
				begin
				result_rdy = 1'b1;					//拉高数据计算完成标志位
				end
		endcase
		end

always @(*)
	begin
	case(state)
		READY:
			begin
			result_rdy = 1'b0;
			if(input_ready)						//数据输入完成后，切换到CALC状态
				next_state<=CALC;
			end
		CALC:
			begin
			input_available = 1'b0;				//停止接收新的数据
			if(B_zero)							//数据计算完成后，切换到DONE状态
				next_state<=DONE;
			end
		DONE:
			begin
			result_rdy = 1'b1;
			if(result_taken)					//计算结果读取后，切换到READY状态
				next_state<=READY;
			end
	endcase
	end

always @(posedge sys_clk)
	begin
	state<=next_state;
	end


endmodule


 
