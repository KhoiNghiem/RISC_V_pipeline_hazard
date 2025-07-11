module control_unit (
    input [6:0] instruction,
    output reg branch, memRead, memToReg, memWrite, ALUSrc, regWrite,
    output reg [1:0] ALUOp 
);

always @(*) begin
    case (instruction)
        7'b0110011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b001000_10;     // R-type 
        7'b0010011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b101000_10;     // I-type arithmetic
        7'b0000011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b111100_00;     // I-type load
        7'b0100011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b100010_00;     // S-type store
        7'b1100011 : {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b000001_01;     // B-type branch

        default: {ALUSrc, memToReg, regWrite, memRead, memWrite, branch, ALUOp} = 8'b000000_00;
    endcase
end
    
endmodule