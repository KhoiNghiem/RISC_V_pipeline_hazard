module or_logic (
    input jump_IDEX,
    input and_out,
    output or_out
);

    assign or_out = jump_IDEX | and_out;
    
endmodule