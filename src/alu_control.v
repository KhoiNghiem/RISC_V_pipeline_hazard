module alu_control (
    input [1:0] ALUOp_in,
    input [31:0] instruction,
    output reg [3:0] ALUControl_out
);

wire [6:0] func7;
wire [2:0] func3;
wire [6:0] opcode;

assign func7 = instruction[31:25];
assign func3 = instruction[14:12];
assign opcode = instruction[6:0];

always @(*) begin
    casex ({ALUOp_in, func7, func3, opcode})

        // M Extension
        19'b1x_0000001_000_0110011 : ALUControl_out = 4'b0011;  // MUL - 3
        // 12'b1x_0000001_001 : ALUControl_out = 4'b0100;  // MUL_high - 4
        19'b1x_0000001_100_0110011 : ALUControl_out = 4'b0100;  // DIV - 4
        
        // RV32I Base Integer Instructions
        // R type
        19'b1x_0000000_000_0110011 : ALUControl_out = 4'b0010;  // ADD - 2
        19'b1x_0000010_000_0110011 : ALUControl_out = 4'b0110;  // SUB - 6
                                                        // XOR
        19'b1x_0000000_110_0110011 : ALUControl_out = 4'b0000;  // OR  - 0
        19'b1x_0000000_111_0110011 : ALUControl_out = 4'b0001;  // AND - 1
                                                        // Shift Left Logical
                                                        // Shift Right Logical
                                                        // Shift Right Arith* (msb-extends)
                                                        // Set Less Than
                                                        // Set Less Than (U) (zero-extends)

        // I type arithmetic
        19'b1x_xxxxxxx_000_0010011 : ALUControl_out = 4'b0010;  // ADDI - 1
                                                        // XORI
        19'b1x_xxxxxxx_110_0010011 : ALUControl_out = 4'b0000;  // ORI  - 0
        19'b1x_xxxxxxx_111_0010011 : ALUControl_out = 4'b0001;  // ANDI - 1
                                                        // Shift Left Logical Imm
                                                        // Shift Right Logical Imm
                                                        // ....
        
        // I type load
        19'b00_xxxxxxx_xxx_0000011 : ALUControl_out = 4'b0010;  // lw, sw → ADD - 1

        // S type Store
        19'b00_xxxxxxx_xxx_0100011 : ALUControl_out = 4'b0010;  // lw, sw → ADD - 1

        // B type
        19'bx1_xxxxxxx_xxx_1100011 : ALUControl_out = 4'b0110;  // beq → SUBTRACT - 6

        
        default: ALUControl_out = 4'b0000;
    endcase
end

endmodule
