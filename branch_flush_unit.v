module flush_unit (
    input branch,                  // từ control_unit
    input [4:0] rs1, rs2, // dữ liệu từ thanh ghi
    input [2:0] funct3,            // phân biệt beq/bne
    output flush_IF                  // tín hiệu flush pipeline
);

assign branch_taken = (funct3 == 3'b000) ? (rs1 == rs2) :   // beq
                      (funct3 == 3'b001) ? (rs1 != rs2) :   // bne
                        1'b0;

assign flush_IF = branch & branch_taken;

endmodule
