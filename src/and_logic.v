module and_logic (
    input branch,
    input zero,
    output and_out
);

    assign and_out = branch & zero;
    
endmodule