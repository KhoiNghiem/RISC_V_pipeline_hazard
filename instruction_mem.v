module instruction_mem (
    input clk,
    input rst_n,
    input [31:0] PC_in,
    output [31:0] instruction_out
);
    integer i;
    reg [31:0] I_mem [63:0];

    assign instruction_out = I_mem[PC_in];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            begin
                for (i = 0; i < 64; i = i + 1) begin
                    I_mem[i] <= 32'b00;
                end
            end
        end else begin
            // R-type
            I_mem[0] <= 32'b0000000_00000_00000_000_00000_0000000;   // no operation
            I_mem[4] <= 32'b0100000_00011_00001_000_00010_0110011;   // sub x2, x1, x3;
            I_mem[8] <= 32'b0000000_00010_00101_111_01100_0110011;   // and x12, x2, x5;
            I_mem[12] <= 32'b000000001010_00010_000_01101_0010011;  // addi x13, x2, 10;
            I_mem[16] <= 32'b0000000_00010_00010_000_01110_0110011;  // add x14, x2, x2 ;
            I_mem[20] <= 32'b0000000_01110_00010_010_01010_0100011;   // sw x14, 10(x2)
                   
        end
    end

endmodule