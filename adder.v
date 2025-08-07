module adder (
    input signed [31:0] in_1,
    input signed [31:0] in_2,
    output signed [31:0] sum_out
);

assign sum_out = in_1 + in_2;
    
endmodule