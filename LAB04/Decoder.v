
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */

parameter [7-1:0] Rtype =  7'b0110011;
parameter [7-1:0] Itype =  7'b0010011;
parameter [7-1:0] load =   7'b0000011;
parameter [7-1:0] store =  7'b0100011;
parameter [7-1:0] branch = 7'b1100011;
parameter [7-1:0] jal =    7'b1101111;
parameter [7-1:0] jalr =   7'b1100111;

assign RegWrite = (instr_i == Rtype) || (instr_i == Itype) || (instr_i == load) || (instr_i == jal) || (instr_i == jalr);
assign Branch = (instr_i == branch);
assign Jump = (instr_i == jal) || (instr_i == jalr);
assign WriteBack0 = (instr_i == load);
assign WriteBack1 = (instr_i == jal) || (instr_i == jalr);
assign MemRead = (instr_i == load);
assign MemWrite = (instr_i == store);
assign ALUSrcA = (instr_i == jalr);
assign ALUSrcB = (instr_i == Itype) || (instr_i == load) || (instr_i == store);
assign ALUOp[1] = (instr_i == Rtype) || (instr_i == Itype);
assign ALUOp[0] = (instr_i == Itype) || (instr_i == branch);

endmodule

