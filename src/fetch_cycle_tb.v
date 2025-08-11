module fetch_cycle_tb ();
    reg clk, rst_n, PCSrcE;
    reg [31:0] PCTargetE;
    wire [31:0] InstrucD, PCD;

    IF_stage uut(.clk(clk),
                    .rst_n(rst_n),
                    .PCSrcE(PCSrcE),
                    .PCTargetE(PCTargetE),
                    .Instr_IFID(InstrucD),
                    .PC_IFID(PCD));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
        PCSrcE = 0;
        PCTargetE = 0;
        #500;
        $finish;

    end


endmodule