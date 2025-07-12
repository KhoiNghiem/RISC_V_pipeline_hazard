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
        
            I_mem[24] <= 32'b0000000_00001_00000_000_00001_0110011; // add x1, x0, x1  // x1 = x0 + x1
            I_mem[28] <= 32'b0000000_00001_00000_000_00010_0110011; // add x2, x0, x1  // x2 = x0 + x1 (RAW on x1)

            I_mem[32] <= 32'b0000000_00010_00001_000_00011_0110011; // add x3, x1, x2
            I_mem[36] <= 32'b0000000_00011_00001_000_00100_0110011; // add x4, x1, x3

            I_mem[40] <= 32'b000000000100_00001_010_00101_0000011; // lw x5, 4(x1)    // x5 = Mem[x1 + 4]
            I_mem[44] <= 32'b0000000_00101_00010_000_00110_0110011; // add x6, x2, x5  // Use x5 right after load

            I_mem[48] <= 32'b000000000100_00001_010_00101_0000011; // lw x5, 4(x1)
            I_mem[52] <= 32'b0000000_00101_00010_010_00011_0100011; // sw x5, 3(x2)  // No data dependency in computation

            I_mem[56] <= 32'b0000000_00001_00000_000_00001_0110011; // add x1, x0, x1
            I_mem[60] <= 32'b0000000_00001_00000_010_00010_0100011; // sw x1, 0(x0)   // x1 used before being written back

            I_mem[64] <= 32'b0000000_00001_00000_000_00001_0110011; // add x1, x0, x1
            I_mem[68] <= 32'b0000000_00001_00010_000_00000_1100011; // beq x1, x2, 0  // compare with x1 not yet written back

            I_mem[72] <= 32'b0000000_00001_00010_000_00000_1100011; // beq x1, x2, label
            I_mem[76] <= 32'b0000000_00100_00101_000_00110_0110011; // add x6, x4, x5 // Should be flushed if branch taken

            I_mem[80] <= 32'b0000000_00001_00010_000_00011_0110011; // add x3, x1, x2
            I_mem[84] <= 32'b0000000_00011_00100_000_00101_0110011; // add x5, x3, x4

        end
    end

endmodule