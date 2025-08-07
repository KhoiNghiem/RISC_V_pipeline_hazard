module mux (
    input sel,
    input signed [31:0] A, B,
    output signed [31:0] Mux_out
);

assign Mux_out = sel ? B : A;
    
endmodule