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
        // Default
        ForwardA = 2'b00;
        ForwardB = 2'b00;
    
        // ForwardA logic
        if (RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs1_IDEX)) begin
            ForwardA = 2'b10;
        end else if (RegWrite_MEMWB && (rd_MEMWB != 0) && (rd_MEMWB == rs1_IDEX)) begin
            ForwardA = 2'b01;
        end
    
        // ForwardB logic
        if (RegWrite_EXMEM && (rd_EXMEM != 0) && (rd_EXMEM == rs2_IDEX)) begin
            ForwardB = 2'b10;
        end else if (RegWrite_MEMWB && (rd_MEMWB != 0) && (rd_MEMWB == rs2_IDEX)) begin
            ForwardB = 2'b01;
        end
    end
    

endmodule