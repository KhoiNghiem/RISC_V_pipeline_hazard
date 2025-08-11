module EX_stage (
    input clk,
    input rst_n,
    input [31:0] read_data1_IDEX,
    input [31:0] read_data2_IDEX,
    input [31:0] PC_IDEX,
    input [31:0] imm_IDEX,
    input [31:0] instruc_IDEX,
    input [4:0]  rd_IDEX,
    input branch_IDEX,
    input memRead_IDEX,
    input mem2reg_IDEX,
    input memWrite_IDEX,
    input ALUSrc_IDEX,
    input RegWrite_IDEX,
    input [1:0] ALUOp_IDEX,

    output reg [31:0] PC_EXMEM,
    output reg [31:0] read_Address_EXMEM,
    output reg [31:0] write_Data_EXMEM,
    output reg [4:0] rd_EXMEM,
    output reg branch_EXMEM,
    output reg zero_EXMEM,
    output reg memRead_EXMEM,
    output reg memWrite_EXMEM,
    output reg mem2reg_EXMEM,
    output reg RegWrite_EXMEM 
);

    wire [31:0] alu_result_ex;
    wire [31:0] mux_ex;
    wire [3:0]  ALUControl_out;
    wire [31:0] pc_ex;
    wire        zero_ex;

    adder ex_add(.in_1(imm_IDEX),
                .in_2(PC_IDEX),
                .sum_out(pc_ex));

    mux ex_mux(.sel(ALUSrc_IDEX),
                .A(read_data2_IDEX),
                .B(imm_IDEX),
                .Mux_out(mux_ex));

    alu_control ex_alu_control(.ALUOp_in(ALUOp_IDEX),
                                .instruction(instruc_IDEX),
                                .ALUControl_out(ALUControl_out));

    alu_unit ex_alu_unit(.A(read_data1_IDEX),
                        .B(mux_ex),
                        .control_in(ALUControl_out),
                        .ALU_result(alu_result_ex),
                        .zero(zero_ex));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            zero_EXMEM <= 0;
            read_Address_EXMEM <= 0;
            write_Data_EXMEM <= 0;
            PC_EXMEM <= 0;
            rd_EXMEM <= 0;
            branch_EXMEM <= 0;
            memRead_EXMEM <= 0;
            memWrite_EXMEM <= 0;
            mem2reg_EXMEM <= 0;
            RegWrite_EXMEM <= 0;
        end else begin
            zero_EXMEM <= zero_ex;
            read_Address_EXMEM <= alu_result_ex;
            write_Data_EXMEM <= read_data2_IDEX;
            PC_EXMEM <= pc_ex;
            rd_EXMEM <= rd_IDEX;
            branch_EXMEM <= branch_IDEX;
            memRead_EXMEM <= memRead_IDEX;
            memWrite_EXMEM <= memWrite_IDEX;
            mem2reg_EXMEM <= mem2reg_IDEX;
            RegWrite_EXMEM <= RegWrite_IDEX;
        end
    end
    
endmodule