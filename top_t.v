`timescale 1ns / 1ps
module top_t #(parameter width = 8);

reg              	sys_clk ;
reg [width-1:0]  	operand_A;
reg [width-1:0]  	operand_B;

wire	         	result_rdy;
reg					result_taken;
wire [width-1:0]	result_data;

reg					input_ready;
wire				input_available;

reg [width*4-1:0]	A_line={8'd24,8'd105,8'd894,8'd679850};	//循环求四组数据的公约数
reg [width*4-1:0]	B_line={8'd18,8'd99,8'd18,8'd66};		//循环求四组数据的公约数
reg [width*4-1:0]	result_line;							//存储四组数据的计算结果

top  top_u    
(
	.operand_A(operand_A),
	.operand_B(operand_B),
	.result_rdy(result_rdy),
	.result_data(result_data),
	
    .sys_clk(sys_clk),
	
    .input_ready(input_ready),
	.input_available(input_available),
	.result_taken(result_taken)
);

always #10 sys_clk = !sys_clk;

initial 
	begin
	sys_clk = 1;
	#20000;
	$stop;
	end
	
//当接收到计算完成标志后，将result_data存储进result_line，
//并在一定延时后拉高result_taken，使状态机进入READY状态
always@(posedge result_rdy)
	begin
	result_line[7:0]=result_data;
	result_line<={result_line[23:0],result_line[31:24]};
	#10
	result_taken=1;
	#1
	result_taken=0;
	end

//当接收到输入可接受标志后，将operand送入line，
//并在一定延时后拉高input_ready，使状态机进入CALC状态
//同时将line向后移位，准备下次的数据送入
always@(posedge input_available)
	begin
	operand_A<=A_line[7:0];
	operand_B<=B_line[7:0];
	#1000
	input_ready=1;
	#1
	input_ready=0;
	A_line<={A_line[7:0],A_line[31:8]};
	B_line<={B_line[7:0],B_line[31:8]};
	end	
	
endmodule