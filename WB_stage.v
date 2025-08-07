module WB_stage (
    input signed [31:0] memData_Out_MEMWB,
    input signed [31:0] read_Address_MEMWB,
    input        mem2reg_MEMWB,
    output signed [31:0] memData_Out_MEM
);

    mux wb_mux(.sel(mem2reg_MEMWB),
                .A(read_Address_MEMWB),
                .B(memData_Out_MEMWB),
                .Mux_out(memData_Out_MEM));

endmodule