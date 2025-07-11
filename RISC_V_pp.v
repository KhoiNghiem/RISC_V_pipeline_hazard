module RISC_V_pp (
    input clk,
    input rst_n
);

    wire [31:0] Instruc_IFID;
    wire [31:0] PC_IFID;

    wire [31:0] read_data1_IDEX;
    wire [31:0] read_data2_IDEX;
    wire [31:0] PC_IDEX;
    wire [31:0] imm_IDEX;
    wire [31:0] instruc_IDEX;
    wire [4:0]  rd_IDEX;
    wire        branch_IDEX;
    wire        memRead_IDEX;
    wire        mem2reg_IDEX;
    wire        memWrite_IDEX;
    wire        ALUSrc_IDEX;
    wire        RegWrite_IDEX;
    wire [1:0]  ALUOp_IDEX;

    wire [31:0] PC_EXMEM;
    wire [31:0] read_Address_EXMEM;
    wire [31:0] write_Data_EXMEM;
    wire [4:0]  rd_EXMEM;
    wire        branch_EXMEM;
    wire        zero_EXMEM;
    wire        memRead_EXMEM;
    wire        memWrite_EXMEM;
    wire        mem2reg_EXMEM;
    wire        RegWrite_EXMEM;

    wire [31:0] memData_Out_MEMWB;
    wire [31:0] ALU_result_MEMWB;
    wire [4:0]  rd_MEMWB;
    wire        PCSrc;
    wire        mem2reg_MEMWB;
    wire        RegWrite_MEMWB;

    wire [31:0] memData_Out_MEM;

    wire [31:0] alu_result_EXMEM;
    wire PCWrite;
    wire Write_IFID;
    wire control_mux_sel;

    wire [1:0] ForwardA;
    wire [1:0] ForwardB;

    wire [31:0] forward_data_MEMWB;

    IF_hazard instruction_fetch(.clk(clk),
                                .rst_n(rst_n),
                                .PCSrc_IF(PCSrc),
                                .PCWrite(PCWrite),
                                .Write_IFID(Write_IFID),
                                .PCTarget_IF(PC_EXMEM),
                                .Instruc_IFID(Instruc_IFID),
                                .PC_IFID(PC_IFID));

    hazard_detection_unit hazard_det_unit(.MemRead_IDEX(memRead_IDEX),
                                        .rs1_IFID(Instruc_IFID[19:15]),
                                        .rs2_IFID(Instruc_IFID[24:20]),
                                        .rd_IDEX(rd_IDEX),
                                        .PCWrite(PCWrite),
                                        .Write_IFID(Write_IFID),
                                        .control_mux_sel(control_mux_sel));

    ID_hazard instruction_decode(.clk(clk),
                                .rst_n(rst_n),
                                .Instruc_IFID(Instruc_IFID),
                                .PC_IFID(PC_IFID),
                                .write_Data(memData_Out_MEMWB),
                                .rd(rd_MEMWB),
                                .RegWrite(RegWrite_MEMWB),
                                .control_mux_sel(control_mux_sel),
                                .read_data1_IDEX(read_data1_IDEX),
                                .read_data2_IDEX(read_data2_IDEX),
                                .PC_IDEX(PC_IDEX),
                                .imm_IDEX(imm_IDEX),
                                .instruc_IDEX(instruc_IDEX),
                                .rd_IDEX(rd_IDEX),
                                .branch_IDEX(branch_IDEX),
                                .memRead_IDEX(memRead_IDEX),
                                .mem2reg_IDEX(mem2reg_IDEX),
                                .memWrite_IDEX(memWrite_IDEX),
                                .ALUSrc_IDEX(ALUSrc_IDEX),
                                .RegWrite_IDEX(RegWrite_IDEX),
                                .ALUOp_IDEX(ALUOp_IDEX));

    forwarding_unit forward(.rs1_IDEX(instruc_IDEX[19:15]),
                            .rs2_IDEX(instruc_IDEX[24:20]),
                            .rd_EXMEM(rd_EXMEM),
                            .rd_MEMWB(rd_MEMWB),
                            .RegWrite_EXMEM(RegWrite_EXMEM),
                            .RegWrite_MEMWB(RegWrite_MEMWB),
                            .ForwardA(ForwardA),
                            .ForwardB(ForwardB));

    assign forward_data_MEMWB = mem2reg_MEMWB ? memData_Out_MEMWB : ALU_result_MEMWB;

    EX_hazard execute(.clk(clk),
                    .rst_n(rst_n),
                    .read_data1_IDEX(read_data1_IDEX),
                    .read_data2_IDEX(read_data2_IDEX),
                    .PC_IDEX(PC_IDEX),
                    .imm_IDEX(imm_IDEX),
                    .instruc_IDEX(instruc_IDEX),
                    .rd_IDEX(rd_IDEX),
                    .branch_IDEX(branch_IDEX),
                    .memRead_IDEX(memRead_IDEX),
                    .mem2reg_IDEX(mem2reg_IDEX),
                    .memWrite_IDEX(memWrite_IDEX),
                    .ALUSrc_IDEX(ALUSrc_IDEX),
                    .RegWrite_IDEX(RegWrite_IDEX),
                    .ALUOp_IDEX(ALUOp_IDEX),
                    .memData_Out_MEMWB(forward_data_MEMWB),
                    .alu_result_EXMEM(alu_result_EXMEM),
                    .ForwardA(ForwardA),
                    .ForwardB(ForwardB),
                    .PC_EXMEM(PC_EXMEM),
                    .read_Address_EXMEM(read_Address_EXMEM),
                    .write_Data_EXMEM(write_Data_EXMEM),
                    .rd_EXMEM(rd_EXMEM),
                    .branch_EXMEM(branch_EXMEM),
                    .zero_EXMEM(zero_EXMEM),
                    .memRead_EXMEM(memRead_EXMEM),
                    .memWrite_EXMEM(memWrite_EXMEM),
                    .mem2reg_EXMEM(mem2reg_EXMEM),
                    .RegWrite_EXMEM(RegWrite_EXMEM));

    assign alu_result_EXMEM = read_Address_EXMEM;

    MEM_stage memory(.clk(clk),
                    .rst_n(rst_n),
                    .read_Address_EXMEM(read_Address_EXMEM),
                    .write_Data_EXMEM(write_Data_EXMEM),
                    .rd_EXMEM(rd_EXMEM),
                    .branch_EXMEM(branch_EXMEM),
                    .zero_EXMEM(zero_EXMEM),
                    .memRead_EXMEM(memRead_EXMEM),
                    .memWrite_EXMEM(memWrite_EXMEM),
                    .mem2reg_EXMEM(mem2reg_EXMEM),
                    .RegWrite_EXMEM(RegWrite_EXMEM),
                    .memData_Out_MEMWB(memData_Out_MEMWB),
                    .read_Address_MEMWB(ALU_result_MEMWB),
                    .rd_MEMWB(rd_MEMWB),
                    .PCSrc(PCSrc),
                    .mem2reg_MEMWB(mem2reg_MEMWB),
                    .RegWrite_MEMWB(RegWrite_MEMWB));

    WB_stage write_back(.memData_Out_MEMWB(memData_Out_MEMWB),
                        .read_Address_MEMWB(ALU_result_MEMWB),
                        .mem2reg_MEMWB(mem2reg_MEMWB),
                        .memData_Out_MEM(memData_Out_MEM));

endmodule