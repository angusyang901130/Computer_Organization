`timescale 1ns/1ps

module Imm_Gen(
    input     [31:0] instr_i,
    output reg[31:0] Imm_Gen_o
);

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

/* Write your code HERE */

always@(*) begin
    case(opcode)
        7'b0010011,                                                                                         // addi
        7'b1100111,                                                                                         // jalr
        7'b0000011: Imm_Gen_o <= { {21{instr_i[31]}}, instr_i[30:20]};                                      // load
        7'b0100011: Imm_Gen_o <= { {21{instr_i[31]}}, instr_i[30:25], instr_i[11:7]};                       // sw
        7'b1100011: Imm_Gen_o <= { {21{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8]};           // branch
        7'b1101111: Imm_Gen_o <= { {13{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21]};         // jal
           default: Imm_Gen_o <= 0;
    endcase
end
endmodule
