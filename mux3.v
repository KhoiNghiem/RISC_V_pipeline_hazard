module mux3 (
    input  wire [1:0] sel,
    input  wire [31:0] A,   // Default input (from register file)
    input  wire [31:0] B,   // From MEM/WB stage
    input  wire [31:0] C,   // From EX/MEM stage
    output reg  [31:0] mux_out
);

    always @(*) begin
        case (sel)
            2'b00: mux_out = A;  
            2'b01: mux_out = B;  
            2'b10: mux_out = C;  
            default: mux_out = A;
        endcase
    end

endmodule
