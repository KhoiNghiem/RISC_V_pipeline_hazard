module PCplus4 (
    input signed [31:0] PC_in,
    output signed [31:0] PC_out
);

assign PC_out = PC_in + 4;
    
endmodule