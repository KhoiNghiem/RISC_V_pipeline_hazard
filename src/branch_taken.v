module branch_taken (
    input  [2:0] funct3,        // funct3 của lệnh branch
    input  [31:0] rs1,          // giá trị đọc từ thanh ghi rs1
    input  [31:0] rs2,          // giá trị đọc từ thanh ghi rs2
    output reg taken            // 1 nếu branch được thực hiện
);
    always @(*) begin
        case (funct3)
            3'b000: taken = (rs1 == rs2);                       // BEQ
            3'b001: taken = (rs1 != rs2);                       // BNE
            3'b100: taken = ($signed(rs1) < $signed(rs2));      // BLT
            3'b101: taken = ($signed(rs1) >= $signed(rs2));     // BGE
            3'b110: taken = (rs1 < rs2);                        // BLTU
            3'b111: taken = (rs1 >= rs2);                       // BGEU
            default: taken = 1'b0;                              // Không branch
        endcase
    end
endmodule
