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
            I_mem[4] <= 32'b0000000_11001_10000_000_01101_0110011;   // add x13, x16, x25;
            I_mem[8] <= 32'b0100000_00011_01000_000_00101_0110011;   // sub x5, x8, x3;
            I_mem[12] <= 32'b0000000_00011_00010_111_00001_0110011;   // and x1, x2, x3;
            I_mem[16] <= 32'b0000000_00101_00011_110_00100_0110011;   // or x4, x3, x5;

            // I-type
            I_mem[20] <= 32'b000000000011_10101_000_10110_0010011;    // addi x22, x21, 3
            I_mem[24] <= 32'b000000000001_01000_110_01001_0010011;    // ori x9, x8, 1

            // L-type
            I_mem[28] <= 32'b000000001111_00010_010_01000_0000011;    // lw x8, 15(x2);
            I_mem[32] <= 32'b000000000011_00011_010_01001_0000011;    // lw x9, 3(x3);
        
            // S-type
            I_mem[36] <= 32'b0000000_01111_00011_010_01100_0100011;    // sw x15, 12(x3);
            I_mem[40] <= 32'b0000000_01110_00110_010_01010_0100011;    // sw x14, 10(x6);

            // SB-type
            I_mem[44] <= 32'b0_000001_01001_01001_000_0010_0_1100011;   // beq x9, x9, 36;
                            
        end
    end

endmodule