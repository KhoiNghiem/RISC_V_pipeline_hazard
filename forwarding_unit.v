module forwarding_unit (
    input [4:0] rs1_IDEX,
    input [4:0] rs2_IDEX,
    input [4:0] rd_EXMEM,
    input [4:0] rd_MEMWB,
    input       RegWrite_EXMEM,
    input       RegWrite_MEMWB,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

    always @(*) begin
        // Default: no forwarding
        ForwardA = 2'b00;
        ForwardB = 2'b00;

        // EX hazard (most recent)
        if (RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs1_IDEX))
            ForwardA = 2'b10;
        if (RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs2_IDEX))
            ForwardB = 2'b10;

        // MEM hazard (only if EX hazard is NOT present)
        if (RegWrite_MEMWB && (rd_MEMWB != 0) &&
            !(RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs1_IDEX)) &&
            (rd_MEMWB == rs1_IDEX))
            ForwardA = 2'b01;

        if (RegWrite_MEMWB && (rd_MEMWB != 0) &&
            !(RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs2_IDEX)) &&
            (rd_MEMWB == rs2_IDEX))
            ForwardB = 2'b01;
    end

endmodule
