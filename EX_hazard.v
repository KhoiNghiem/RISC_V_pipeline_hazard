module EX_hazard (
    input clk,
    input rst_n,
    input signed [31:0] read_data1_IDEX,
    input signed [31:0] read_data2_IDEX,
    input signed [31:0] PC_IDEX,
    input signed [31:0] imm_IDEX,
    input [31:0] instruc_IDEX,
    input [4:0]  rd_IDEX,
    input branch_IDEX,
    input memRead_IDEX,
    input mem2reg_IDEX,
    input memWrite_IDEX,
    input ALUSrc_IDEX,
    input RegWrite_IDEX,
    input [1:0] ALUOp_IDEX,
    input signed [31:0] memData_Out_MEM,
    input signed [31:0] alu_result_EXMEM,
    input [1:0] ForwardA,
    input [1:0] ForwardB,

    output reg signed [31:0] PC_EXMEM,
    output reg signed [31:0] read_Address_EXMEM,
    output reg signed [31:0] write_Data_EXMEM,
    output reg [4:0] rd_EXMEM,
    output reg branch_EXMEM,
    output reg zero_EXMEM,
    output reg memRead_EXMEM,
    output reg memWrite_EXMEM,
    output reg mem2reg_EXMEM,
    output reg RegWrite_EXMEM 
);

    wire signed [31:0] alu_result_ex;
    wire signed [31:0] mux_ex;
    wire signed [31:0] mux3_1_ex;
    wire signed [31:0] mux3_2_ex;
    wire [3:0]  ALUControl_out;
    wire signed [31:0] pc_ex;
    wire        zero_ex;

    adder ex_add(.in_1(imm_IDEX),
                .in_2(PC_IDEX),
                .sum_out(pc_ex));

    mux3 ex_mux1(.sel(ForwardA),
                .A(read_data1_IDEX),
                .B(memData_Out_MEM),
                .C(alu_result_EXMEM),
                .mux_out(mux3_1_ex));

    mux3 ex_mux2(.sel(ForwardB),
                .A(read_data2_IDEX),
                .B(memData_Out_MEM),
                .C(alu_result_EXMEM),
                .mux_out(mux3_2_ex));

    mux ex_mux(.sel(ALUSrc_IDEX),
                .A(mux3_2_ex),
                .B(imm_IDEX),
                .Mux_out(mux_ex));

    alu_control ex_alu_control(.ALUOp_in(ALUOp_IDEX),
                                .instruction(instruc_IDEX),
                                .ALUControl_out(ALUControl_out));

    alu_unit ex_alu_unit(.A(mux3_1_ex),
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
            write_Data_EXMEM <= mux3_2_ex;
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