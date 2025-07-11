module RISC_V_pp_tb ();
    reg clk, rst_n;

    RISC_V_pp uut(.clk(clk),
            .rst_n(rst_n));

    initial begin
        clk = 0;
        rst_n = 0;
        #5;
        rst_n = 1;
        #400;
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
endmodule