`timescale 1ns/1ps

module Decoder(
	input	[32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[9-1:0]		Ctrl_o;

/* Write your code HERE */

assign opcode = instr_i[7-1:0];
assign funct3 = instr_i[14:12];

assign ALUSrc = opcode == 7'b0110011 ? 1'b0 : 1'b1;
assign RegWrite = opcode == 7'b0110011 ? 1'b1 : 1'b0;
assign Branch = opcode == 7'b0110011 ? 1'b0 : 1'b1;
assign ALUOp = opcode == 7'b0110011 ? 2'b10 : 2'b00;

endmodule





                    
                    
