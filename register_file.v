module register_file (
    input clk,
    input rst_n,
    input regWrite,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_Data,
    output [31:0] read_data1, read_data2
);

    reg [31:0] registers [31:0];
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            begin
                registers[0] = 0;
                registers[1] = 4;
                registers[2] = 2;
                registers[3] = 2;
                registers[4] = 4;
                registers[5] = 1;
                registers[6] = 44;
                registers[7] = 4;
                registers[8] = 24;
                registers[9] = 12;
                registers[10] = 23;
                registers[11] = 4;
                registers[12] = 90;
                registers[13] = 10;
                registers[14] = 20;
                registers[15] = 30;
                registers[16] = 40;
                registers[17] = 50;
                registers[18] = 60;
                registers[19] = 70;
                registers[20] = 80;
                registers[21] = 80;
                registers[22] = 90;
                registers[23] = 70;
                registers[24] = 60;
                registers[25] = 65;
                registers[26] = 4;
                registers[27] = 32;
                registers[28] = 12;
                registers[29] = 34;
                registers[30] = 5;
                registers[31] = 10;
            end
        end else begin
            if (regWrite) begin
                registers[rd] <= write_Data;
            end
        end
    end

    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];
    
endmodule