module control_unit (
    input [6:0] instruction,
    output reg branch, memRead, memWrite, ALUSrc, regWrite, jump,
    output reg [1:0] ALUOp, memToReg
);
// mem2Reg = ResultSrc
always @(*) begin
    case (instruction)
        7'b0110011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b0_00_1_0_0_0_0_10;     // R-type 
        7'b0010011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b1_00_1_0_0_0_0_10;     // I-type arithmetic
        7'b0000011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b1_01_1_1_0_0_0_00;     // I-type load
        7'b0100011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b1_00_0_0_1_0_0_00;     // S-type store
        7'b1100011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b0_00_0_0_0_1_0_01;     // B-type branch
        7'b1101111 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b0_10_1_0_0_0_1_00;     // J-type branch

        default: {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, jump, ALUOp} = 10'b0000000000;
    endcase
end
    
endmodule