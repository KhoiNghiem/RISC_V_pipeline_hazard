module hazard_detection_unit (
    input  wire        MemRead_IDEX,
    input  wire [4:0]  rs1_IFID,
    input  wire [4:0]  rs2_IFID,
    input  wire [4:0]  rd_IDEX,

    output reg         PCWrite,
    output reg         Write_IFID,
    output reg         control_mux_sel
);
    always @(*) begin
        if (MemRead_IDEX && ((rd_IDEX == rs1_IFID) || (rd_IDEX == rs2_IFID))) begin
            PCWrite         = 0;  // stall PC update
            Write_IFID      = 0;  // stall IF/ID
            control_mux_sel = 1;  // insert NOP into control
        end else begin
            PCWrite         = 1;
            Write_IFID      = 1;
            control_mux_sel = 0;
        end
    end
endmodule