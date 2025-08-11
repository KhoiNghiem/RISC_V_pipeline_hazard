module riscv_top (
        input clk,
        input rst_n
);

        wire [31:0] PC_top;
        wire [31:0] PC_in_top;
        wire [31:0] PC_next_top;
        wire [31:0] instruction_top;
        wire [31:0] rd1_top, rd2_top;

        wire [31:0] immExt_top;
        wire [31:0] mux1_top;
        wire [31:0] sum_out_top;

        wire [31:0] address_top;
        wire [31:0] mem_data_top;
        wire [31:0] write_back_top;

        wire [1:0] ALUOp_top;

        wire regWrite_top;
        wire ALUSrc_top;
        wire zero_top;
        wire branch_top;
        wire Sel2_top;
        wire mem2reg_top;
        wire memWrite_top;
        wire memRead_top;

        wire [3:0] control_top;

        program_counter PC(.clk(clk), 
                        .rst_n(rst_n), 
                        .PC_in(PC_in_top), 
                        .PC_out(PC_top));

        PCplus4 PC_Adder(.PC_in(PC_top), 
                        .PC_out(PC_next_top));

        instruction_mem inst_mem(.clk(clk), 
                                .rst_n(rst_n), 
                                .PC_in(PC_top), 
                                .instruction_out(instruction_top));

        register_file reg_file(.clk(clk), 
                                .rst_n(rst_n), 
                                .regWrite(regWrite_top), 
                                .rs1(instruction_top[19:15]), 
                                .rs2(instruction_top[24:20]), 
                                .rd(instruction_top[11:7]), 
                                .write_Data(write_back_top), 
                                .read_data1(rd1_top), 
                                .read_data2(rd2_top));

        immediate_gen imm_gen(.instruction(instruction_top),
                                .ImmExt(immExt_top));

        control_unit control_u(.instruction(instruction_top[6:0]),
                                .branch(branch_top),
                                .memRead(memRead_top),
                                .memToReg(mem2reg_top),
                                .memWrite(memWrite_top),
                                .ALUSrc(ALUSrc_top),
                                .regWrite(regWrite_top),
                                .ALUOp(ALUOp_top));

        alu_control alu_c(.ALUOp_in(ALUOp_top),
                        .instruction(instruction_top),
                        .ALUControl_out(control_top));

        alu_unit alu_u(.A(rd1_top),
                        .B(mux1_top),
                        .control_in(control_top),
                        .ALU_result(address_top),
                        .zero(zero_top));

        mux mux1(.sel(ALUSrc_top),
                .A(rd2_top),
                .B(immExt_top),
                .Mux_out(mux1_top));

        adder add_1(.in_1(PC_top),
                .in_2(immExt_top),
                .sum_out(sum_out_top));

        and_logic and_l(.branch(branch_top),
                        .zero(zero_top),
                        .and_out(Sel2_top));

        mux mux2(.sel(Sel2_top),
                .A(PC_next_top),
                .B(sum_out_top),
                .Mux_out(PC_in_top));

        data_memory data_mem(.clk(clk),
                                .rst_n(rst_n),
                                .memWrite(memWrite_top),
                                .memRead(memRead_top),
                                .read_Address(address_top),
                                .write_Data(rd2_top),
                                .memData_Out(mem_data_top));

        mux mem_mux(.sel(mem2reg_top),
                        .A(address_top),
                        .B(mem_data_top),
                        .Mux_out(write_back_top));

endmodule