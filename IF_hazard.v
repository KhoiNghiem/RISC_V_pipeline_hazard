module IF_hazard (
    input clk,
    input rst_n,
    input PCSrc_IF,
    input signed [31:0] PCTarget_IF,
    input PCWrite,
    input Write_IFID,
    input flush_IF,
    output [31:0] Instruc_IFID,
    output signed [31:0] PC_IFID,
    output signed [31:0] PC_plus4_IFID
);
    wire signed [31:0] PC_next, PC_current, PC_plus4;
    wire [31:0] instruction_fetched;

    reg signed [31:0] IFID_PC;
    reg [31:0] IFID_PCPlus4;
    reg [31:0] IFID_Instruction;

    // Select PC + 4 or branch target
    mux pc_mux (
        .sel(PCSrc_IF),
        .A(PC_plus4),
        .B(PCTarget_IF),
        .Mux_out(PC_next)
    );

    // Program counter logic
    program_counter PC_counter (
        .clk(clk),
        .rst_n(rst_n),
        .PCWrite(PCWrite),
        .PC_in(PC_next),
        .PC_out(PC_current)
    );

    // Instruction fetch
    instruction_mem IMEM (
        .clk(clk),
        .rst_n(rst_n),
        .PC_in(PC_current),
        .instruction_out(instruction_fetched)
    );

    // PC + 4
    PCplus4 pc_add (
        .PC_in(PC_current),
        .PC_out(PC_plus4)
    );

    // IF/ID pipeline register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n || flush_IF) begin
            IFID_Instruction <= 32'b0;
            IFID_PC <= 32'b0;
            IFID_PCPlus4 <= 32'b0;
        end else begin
            if (Write_IFID) begin
                IFID_Instruction <= instruction_fetched;
                IFID_PC <= PC_current;
                IFID_PCPlus4 <= PC_plus4;
            end else begin
                IFID_Instruction <= IFID_Instruction;
                IFID_PC <= IFID_PC;
                IFID_PCPlus4 <= IFID_PCPlus4;
            end
        end
    end

    assign Instruc_IFID    = IFID_Instruction;
    assign PC_IFID         = IFID_PC;
    assign PC_plus4_IFID   = IFID_PCPlus4;

endmodule
