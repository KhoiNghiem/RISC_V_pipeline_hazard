module alu_unit (
    input signed [31:0] A, B, 
    input [3:0] control_in, 
    output reg signed [31:0] ALU_result, 
    output reg zero
);

always @(control_in or A or B) begin
    ALU_result = 32'b0;
    zero = 0;
    
    case (control_in)
        4'b0000: begin  // AND
            ALU_result = A & B;
        end
        4'b0001: begin  // OR
            ALU_result = A | B;
        end
        4'b0010: begin  // ADD
            ALU_result = A + B;
        end
        4'b0110: begin  // SUB & BEQ
            ALU_result = A - B;
            if (A == B)
                zero = 1;
        end
        default: begin
            ALU_result = 32'b0;
            zero = 0;
        end
    endcase
end

endmodule
