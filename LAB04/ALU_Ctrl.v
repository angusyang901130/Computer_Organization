
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */

reg [4-1:0] alu_ctrl_reg;
assign ALU_Ctrl_o = alu_ctrl_reg;

always @(*) begin
    case(ALUOp)
        2'b00: alu_ctrl_reg <= 4'b0010;
        2'b01: alu_ctrl_reg <= 4'b0110;
        2'b10:
            begin
                if(instr == 4'b0000)
                    alu_ctrl_reg <= 4'b0010;
                else if(instr == 4'b0010)
                    alu_ctrl_reg <= 4'b0111;
            end
        2'b11: alu_ctrl_reg <= 4'b0010;
    endcase
end

endmodule