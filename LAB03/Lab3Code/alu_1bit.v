`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */

	wire m1, m2, m3, carry, not_src1, not_src2;	
	wire and_result, or_result, add_result;	

	MUX2to1 M1(.src1(src1), .src2(not_src1), .select(Ainvert), .result(m1));
	MUX2to1 M2(.src1(src2), .src2(not_src2), .select(Binvert), .result(m2));

	assign not_src1 = ~src1;
	assign not_src2 = ~src2;
	assign and_result = m1 & m2;
	assign or_result = m1 | m2;
	assign {carry, add_result} = m1 + m2 + cin;

	MUX4to1 M3(.src1(and_result), .src2(or_result), .src3(add_result), .src4(less), .select(operation), .result(m3));

	always@(*) begin

		if(operation[1] == 1'b1)
			cout <= carry;
		else cout <= 1'b0;

		result = m3;
	end 

	
endmodule
