`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input signed [32-1:0]	src1,          // 32 bits source 1          (input)
	input signed [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire [32-1:0] carry;
wire [32-1:0] result_1bit;
wire set, tmpcarry;

assign {tmpcarry, set} = src1[31] + (~src2[31]) + carry[30];

genvar idx;
generate
	for(idx = 0; idx < 32; idx = idx + 1)
	begin
		if(idx == 0)
			alu_1bit a0(.src1(src1[0]), .src2(src2[0]), .less(set), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(result_1bit[0]), .cout(carry[0]));
		else
			alu_1bit a0(.src1(src1[idx]), .src2(src2[idx]), .less(1'b0), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .cin(carry[idx-1]), .operation(ALU_control[1:0]), .result(result_1bit[idx]), .cout(carry[idx]));
	end
endgenerate

always @(*) begin
	if (~rst_n)
	begin
		result <= 0;
	end
	
	else begin
		case(ALU_control)
			4'b0000,
			4'b0001,
			4'b0010,
			4'b0110,
			4'b0111: result <= result_1bit;
			4'b1000: result <= src1 ^ src2;
			4'b1100: result <= src1 >>> src2;
			4'b1110: result <= src1 << src2;
		endcase
	end
	
end

always @(*) begin
	if (~rst_n)
	begin
		zero <= 0;
		cout <= 0;
		overflow <= 0;
	end
	
	else begin
		zero <= ~(|result);

		if(ALU_control == 4'b0010) begin
			cout <= carry[31];
			overflow <= (~src1[31] & ~src2[31] & result[31]) || (src1[31] & src2[31] & ~result[31]);
		end

		else if(ALU_control == 4'b0110) begin
			cout <= carry[31];
			overflow <= (~src1[31] & src2[31] & result[31]) || (src1[31] & ~src2[31] & ~result[31]);
		end

		else begin
			cout <= 0;
			overflow <= 0;
		end
		
	end
	
end

endmodule
