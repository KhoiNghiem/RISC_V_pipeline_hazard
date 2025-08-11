module instruction_mem (
    input clk,
    input rst_n,
    input signed [31:0] PC_in,
    output [31:0] instruction_out
);
    integer i;
    reg [31:0] I_mem [0:128];

    assign instruction_out = I_mem[PC_in[31:2]];

    initial begin
        $readmemh("D:/Learning/DSR_Lab/RISC_V/code/hazard/hex_data/adivb.hex", I_mem); // mỗi dòng 1 lệnh 32-bit
    end

    // initial begin
    //     $display("Reading program.hex...");
    //     $readmemh("D:/Learning/DSR_Lab/RISC_V/code/hazard/aplusb.hex", I_mem);
    //     $display("Loaded I_mem[0] = %h", I_mem[0]);
    //     $display("Loaded I_mem[1] = %h", I_mem[1]);
    //     $display("Loaded I_mem[2] = %h", I_mem[2]);
    //     $display("Loaded I_mem[3] = %h", I_mem[3]);
    // end

//     always @(posedge clk or negedge rst_n) begin
//         if (!rst_n) begin
//             begin
//                 for (i = 0; i < 128; i = i + 1) begin
//                     I_mem[i] <= 32'b00;
//                 end
//             end
            
//         end else begin
//             I_mem[0] <= 32'b0000000_00000_00000_000_00000_0000000;   // no operation
//             I_mem[4] <= 32'b0100000_00011_00001_000_00010_0110011;   // sub x2, x1, x3;
//             I_mem[8] <= 32'b0000000_00010_00101_111_01100_0110011;   // and x12, x2, x5;
//             I_mem[12] <= 32'b000000001010_00010_000_01101_0010011;  // addi x13, x2, 10;
//             I_mem[16] <= 32'b0000000_00010_00010_000_01110_0110011;  // add x14, x2, x2 ;
//             I_mem[20] <= 32'b0000000_00010_00010_000_00100_0110011;  // add x4, x2, x2 ;
//             // I_mem[20] <= 32'b0000000_01110_00010_010_01010_0100011;   // sw x14, 10(x2)
//             // I_mem[0] <= 32'b0000000_00000_00000_000_00000_0000000;   // no operation
//             // I_mem[4] <= 32'hfe010113;  
//             // I_mem[8] <= 32'h00112e23;   
//             // I_mem[12] <= 32'h00812c23;  
//             // I_mem[16] <= 32'h02010413;  
 
//             // I_mem[20] <= 32'h00400713;  
             
//             // I_mem[24] <= 32'hfef42623; 

//             // I_mem[28] <= 32'h00500793; 
            
//             // I_mem[32] <= 32'hfef42423; 
 

//             // I_mem[36] <= 32'hfec42703; 
//             // I_mem[40] <= 32'hfe842783; 
            
//             // I_mem[44] <= 32'h00000000;   // addi x0, x0, 0  -- NOP
//             // I_mem[48] <= 32'h00000000;   // addi x0, x0, 0
//             // I_mem[52] <= 32'h00000000;   // addi x0, x0, 0  -- NOP
//             // I_mem[56] <= 32'h00000000;   // addi x0, x0, 0
//             // I_mem[60] <= 32'h00000000;   // addi x0, x0, 0  -- NOP
//             // I_mem[64] <= 32'h00000000;   // addi x0, x0, 0

//             I_mem[44] <= 32'h00f707b3;   // add a5, a4, a5
//         end
//     end

endmodule