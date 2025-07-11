module ID_stage (
    input wire clk,
    input wire rst_n,
    input wire [31:0] Instruc_IFID,
    input wire [31:0] PC_IFID,
    input [31:0] write_Data,
    input [4:0] rd,
    input wire RegWrite,

    output reg [31:0] read_data1_IDEX,
    output reg [31:0] read_data2_IDEX,
    output reg [31:0] PC_IDEX,
    output reg [31:0] imm_IDEX,
    output reg [31:0] instruc_IDEX,
    output reg [4:0]  rd_IDEX,

    output reg        branch_IDEX,
    output reg        memRead_IDEX,
    output reg        mem2reg_IDEX,
    output reg        memWrite_IDEX,
    output reg        ALUSrc_IDEX,
    output reg        RegWrite_IDEX,
    output reg [1:0]  ALUOp_IDEX
); 

    wire [31:0] read_data1_IDEX_reg;
    wire [31:0] read_data2_IDEX_reg;
    wire [31:0] imm_IDEX_reg;

    wire [1:0] ALUOp_ID;
    wire regWrite_ID;
    wire ALUSrc_ID;
    wire branch_ID;
    wire mem2reg_ID;
    wire memWrite_ID;
    wire memRead_ID;

    register_file reg_file_ID(.clk(clk), 
                                .rst_n(rst_n), 
                                .regWrite(RegWrite), 
                                .rs1(Instruc_IFID[19:15]), 
                                .rs2(Instruc_IFID[24:20]), 
                                .rd(rd), 
                                .write_Data(write_Data), 
                                .read_data1(read_data1_IDEX_reg), 
                                .read_data2(read_data2_IDEX_reg));

    immediate_gen imm_gen_ID(.instruction(Instruc_IFID),
                                .ImmExt(imm_IDEX_reg));

    control_unit control_u(.instruction(Instruc_IFID[6:0]),
                                .branch(branch_ID),
                                .memRead(memRead_ID),
                                .memToReg(mem2reg_ID),
                                .memWrite(memWrite_ID),
                                .ALUSrc(ALUSrc_ID),
                                .regWrite(regWrite_ID),
                                .ALUOp(ALUOp_ID));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_data1_IDEX <= 0;
            read_data2_IDEX <= 0;
            imm_IDEX        <= 0;
            PC_IDEX         <= 0;
            instruc_IDEX    <= 0;
            rd_IDEX         <= 0;
            branch_IDEX     <= 0;
            memRead_IDEX    <= 0;
            mem2reg_IDEX    <= 0;
            memWrite_IDEX   <= 0;
            ALUSrc_IDEX     <= 0;
            RegWrite_IDEX   <= 0;
            ALUOp_IDEX      <= 0;
        end else begin
            read_data1_IDEX <= read_data1_IDEX_reg;
            read_data2_IDEX <= read_data2_IDEX_reg;
            imm_IDEX        <= imm_IDEX_reg;
            PC_IDEX         <= PC_IFID;
            instruc_IDEX    <= Instruc_IFID;
            rd_IDEX         <= Instruc_IFID[11:7];

            branch_IDEX     <= branch_ID;
            memRead_IDEX    <= memRead_ID;
            mem2reg_IDEX    <= mem2reg_ID;
            memWrite_IDEX   <= memWrite_ID;
            ALUSrc_IDEX     <= ALUSrc_ID;
            RegWrite_IDEX   <= regWrite_ID;
            ALUOp_IDEX      <= ALUOp_ID;
        end
    end
    
endmodule