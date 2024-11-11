module SRAM(
    input [3:0] dataIn,  // 4-bit input data
    input [1:0] Addr,    // 2-bit address
    input CS, WE, RD, Clk,   // Chip Select, Write Enable, Read Enable, Clock
    output reg [3:0] Q   // 4-bit output for all SRAM locations (q1, q2, q3, q4)
);
    // 4 memory locations (4-bit each)
    reg [3:0] SRAMs [3:0];  // 4 memory locations (SRAM[0] to SRAM[3])

    // Initialize SRAM and outputs to 0 at startup
    initial begin
        SRAMs[0] = 4'b0000;
        SRAMs[1] = 4'b0000;
        SRAMs[2] = 4'b0000;
        SRAMs[3] = 4'b0000;
        Q = 4'b0000;  // All outputs start as 0
    end

    // Write/Read operation and update Q
    always @(posedge Clk) begin
        if (CS == 1'b1) begin
            if (WE == 1'b1 && RD == 1'b0) begin
                // Write to SRAM at the specified address
                SRAMs[Addr] <= dataIn;
                Q <= dataIn;  // Q reflects the value written to the SRAM
            end else if (RD == 1'b1 && WE == 1'b0) begin
                // Read from SRAM at the specified address
                Q <= SRAMs[Addr];  // Q reflects the current data at the address
            end
        end
    end

    // Always update the output Q to reflect the state of all SRAMs
    always @(*) begin
        Q = {SRAMs[3], SRAMs[2], SRAMs[1], SRAMs[0]};  // Concatenate SRAMs to form Q
    end
endmodule