// module flush_unit (
//     input branch,                  // từ control_unit
//     input [4:0] rs1, rs2,          // dữ liệu từ thanh ghi
//     input [2:0] funct3,            // phân biệt beq/bne
//     output flush_IF                // tín hiệu flush pipeline
// );

// assign branch_taken = (funct3 == 3'b000) ? (rs1 == rs2) :   // beq
//                       (funct3 == 3'b001) ? (rs1 != rs2) :   // bne
//                         1'b0;

// assign flush_IF = branch & branch_taken;

// endmodule

module flush_unit (
    input branch,              // = 1 nếu lệnh là branch
    input jump,                // = 1 nếu lệnh là jal/jalr
    input [31:0] op1, op2,      // giá trị từ rs1 và rs2
    input [2:0] funct3,
    output flush_IF
    // output flush_ID
);

wire branch_taken;

assign branch_taken =
    (funct3 == 3'b000) ? (op1 == op2) :   // beq
    (funct3 == 3'b001) ? (op1 != op2) :   // bne
    (funct3 == 3'b100) ? ($signed(op1) <  $signed(op2)) : // blt
    (funct3 == 3'b101) ? ($signed(op1) >= $signed(op2)) : // bge
    (funct3 == 3'b110) ? (op1 <  op2) :   // bltu
    (funct3 == 3'b111) ? (op1 >= op2) :   // bgeu
    1'b0;

assign flush_IF = (branch & branch_taken) | jump;
// assign flush_ID = (branch & branch_taken) | jump;

endmodule
