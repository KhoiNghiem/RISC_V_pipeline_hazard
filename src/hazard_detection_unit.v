module hazard_detection_unit (
    input  wire        MemRead_IDEX,
    input  wire [4:0]  rs1_IFID,
    input  wire [4:0]  rs2_IFID,
    input  wire [4:0]  rd_IDEX,

    output reg         PCWrite,
    output reg         Write_IFID,
    output reg         control_mux_sel,
    output wire        lwStall
);
    always @(*) begin
        if (MemRead_IDEX && ((rd_IDEX == rs1_IFID) || (rd_IDEX == rs2_IFID))) begin
            PCWrite         = 0;  // stall PC update
            Write_IFID      = 0;  // stall IF/ID
            control_mux_sel = 1;  // insert NOP into control
        end else begin
            PCWrite         = 1;
            Write_IFID      = 1;
            control_mux_sel = 0;
        end
    end

    assign lwStall = MemRead_IDEX && ((rd_IDEX == rs1_IFID) || (rd_IDEX == rs2_IFID));
endmodule

// ======================
// Hazard Detection Unit
// ======================
// module hazard_detection_unit (
//     input  wire [4:0] rs1_IFID, rs2_IFID,    // Source regs ở Decode stage
//     input  wire [4:0] rd_IDEX,           // Destination reg ở EX stage
//     input  wire       MemRead_IDEX,      // Lệnh ở EX stage là load
//     input  wire       PCSrcE,        // Branch/jump taken
//     output reg       control_mux_sel,
//     output reg        StallF,        // Stall IF stage
//     output reg        StallD,        // Stall ID stage
//     output reg        FlushE         // Flush EX stage
// );
//     wire lwStall;
//     // Load-Use hazard
//     assign lwStall = MemRead_IDEX && ((rd_IDEX == rs1_IFID) || (rd_IDEX == rs1_IFID));
//     always @(*) begin
//         // Default: không stall, không flush
//         StallF = 0;
//         StallD = 0;
//         FlushE = 0;
//         control_mux_sel = 1;
//         if (lwStall) begin
//             // Chèn bubble
//             StallF = 1;
//             StallD = 1;
//             FlushE = 1;
//             control_mux_sel = 0;
//         end
//         if (PCSrcE) begin
//             // Flush EX stage khi branch taken
//             FlushE = 1;
//         end
//     end

// endmodule
