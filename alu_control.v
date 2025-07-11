module alu_control (
    input [1:0] ALUOp_in,
    input [31:0] instruction,
    output reg [3:0] ALUControl_out
);

wire [6:0] func7;
wire [2:0] func3;

assign func7 = instruction[31:25];
assign func3 = instruction[14:12];

always @(*) begin
    casex ({ALUOp_in, func7, func3})
        12'b00_xxxxxxx_xxx : ALUControl_out = 4'b0010;  // lw, sw → ADD
        12'bx1_xxxxxxx_xxx : ALUControl_out = 4'b0110;  // beq → SUBTRACT
        12'b1x_0000000_000 : ALUControl_out = 4'b0010;  // R-type ADD
        12'b1x_0100000_000 : ALUControl_out = 4'b0110;  // R-type SUB
        12'b1x_0000000_111 : ALUControl_out = 4'b0000;  // R-type AND
        12'b1x_0000000_110 : ALUControl_out = 4'b0001;  // R-type OR
        default: ALUControl_out = 4'b0000;
    endcase
end

endmodule
