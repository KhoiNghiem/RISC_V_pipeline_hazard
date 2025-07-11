module mux (
    input sel,
    input [31:0] A, B,
    output [31:0] Mux_out
);

assign Mux_out = sel ? B : A;
    
endmodule