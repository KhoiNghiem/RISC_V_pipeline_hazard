module MEM_stage (
    input clk,
    input rst_n,
    input [31:0] read_Address_EXMEM,
    input [31:0] write_Data_EXMEM,
    input [4:0] rd_EXMEM,
    input branch_EXMEM,
    input zero_EXMEM,
    input memRead_EXMEM,
    input memWrite_EXMEM,
    input mem2reg_EXMEM,
    input RegWrite_EXMEM,

    output reg [31:0] memData_Out_MEMWB,
    output reg [31:0] read_Address_MEMWB,
    output reg [4:0] rd_MEMWB,
    output wire PCSrc,
    output reg mem2reg_MEMWB,
    output reg RegWrite_MEMWB
);
    
    wire [31:0] memData_Out;

    and_logic mem_and(.branch(branch_EXMEM),
                        .zero(zero_EXMEM),
                        .and_out(PCSrc));

    data_memory mem_data_mem(.clk(clk),
                            .rst_n(rst_n),
                            .memWrite(memWrite_EXMEM),
                            .memRead(memRead_EXMEM),
                            .read_Address(read_Address_EXMEM),
                            .write_Data(write_Data_EXMEM),
                            .memData_Out(memData_Out));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            memData_Out_MEMWB <= 0;
            read_Address_MEMWB <= 0;
            rd_MEMWB <= 0;
            mem2reg_MEMWB <= 0;
            RegWrite_MEMWB <= 0;
        end else begin
            memData_Out_MEMWB <= memData_Out;
            read_Address_MEMWB <= read_Address_EXMEM;
            rd_MEMWB <= rd_EXMEM;
            mem2reg_MEMWB <= mem2reg_EXMEM;
            RegWrite_MEMWB <= RegWrite_EXMEM;
        end
    end


endmodule