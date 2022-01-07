`timescale 1ns / 1ps
module calc #(parameter  width = 8)
(
	input 	[width-1:0] operand_A,		//输入计算数A
	input 	[width-1:0] operand_B,		//输入计算数B
	input				A_en,			//A的触发器触发信号，上升沿触发
	input				B_en,			//B的触发器触发信号，上升沿触发
	input	[1:0]		A_mux_sel,		//A的触发器控制信号，用于选择数据的来源
	input				B_mux_sel,      //B的触发器控制信号，用于选择数据的来源
	output 	[width-1:0] result_data,	//A、B的最大公约数，在result_rdy为高时有效
	output				B_zero,			//计算完成标志位
	output				A_lt_B			//交换两数的标志位
	);
	
wire	[width-1:0] 	A_mux_InA;
wire	[width-1:0] 	A_mux_InSub;
wire	[width-1:0] 	A_mux_InB;
reg 	[width-1:0] 	A_mux_out;

wire	[width-1:0] 	B_mux_InA;
wire	[width-1:0] 	B_mux_InB;
reg 	[width-1:0] 	B_mux_out;

reg 	[width-1:0] 	DA_out;
wire	[width-1:0] 	DA_in;
 
reg 	[width-1:0] 	DB_out;
wire	[width-1:0] 	DB_in;

wire 	[width-1:0]		sub_out;

assign A_mux_InA	=operand_A;
assign A_mux_InSub	=sub_out;
assign A_mux_InB	=DB_out;

assign B_mux_InA	=DA_out;
assign B_mux_InB	=operand_B;

assign DA_in		=A_mux_out;
assign DB_in		=B_mux_out;

//A_mux选择器的代码
always@(*)
	begin
	case(A_mux_sel)
		2'b00:A_mux_out=A_mux_InA;
		2'b01:A_mux_out=A_mux_InSub;
		2'b10:A_mux_out=A_mux_InB;
		default:A_mux_out=8'b0;
	endcase
	end

//B_mux选择器的代码
always@(*)
	begin
	case(B_mux_sel)
		0:B_mux_out=B_mux_InA;
		1:B_mux_out=B_mux_InB;
		default:B_mux_out=8'b00;
	endcase
	end
	
//A_D触发器的代码
always@(posedge A_en)
	begin
    if(A_en)
		begin
		#1
		DA_out 			= DA_in;
		end
	else
		#1
		DA_out 			= DA_out;
	end
		
//B_D触发器的代码
always@(posedge B_en)
	begin
    if(B_en)
		begin
		#1
		DB_out			= DB_in;
		end
	else
		#1
		DB_out 			= DB_out;
	end
	
assign B_zero		=(DB_out==0) ;				//判断是否计算完成
assign A_lt_B		=(DA_out<DB_out)?1'b1:1'b0;	//判断B是否大于A
assign sub_out		=DA_out-DB_out;				//减法器的程序
assign result_data	=(B_zero)?DA_out:8'd0;		//结果输出位

endmodule
