`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input signed [32-1:0]   src1,          // 32 bits source 1          (input)
    input signed [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output               Zero          // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */
reg zero_reg;
assign Zero = zero_reg;

always @(*) begin
    if(~rst_n)
        result <= 32'b0;
    else begin
        case(ALU_control)
            4'b0010: result <= src1 + src2;
            4'b0110: result <= src1 - src2;
            4'b0111: result <= src1 < src2;
        endcase
    end
end

always @(*) begin
    if(~rst_n)
        zero_reg <= 32'b0;
    else
        zero_reg <= (result == 32'b0);
end

endmodule
