module WB_stage (
    input [31:0] memData_Out_MEMWB,
    input [31:0] read_Address_MEMWB,
    input        mem2reg_MEMWB,
    output [31:0] memData_Out_MEM
);

    mux wb_mux(.sel(mem2reg_MEMWB),
                .A(memData_Out_MEMWB),
                .B(read_Address_MEMWB),
                .Mux_out(memData_Out_MEM));

endmodule