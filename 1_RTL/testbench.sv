module SRAM_tb();
    // Inputs
    reg [3:0] dataIn;   // 4-bit data input
    reg [1:0] Addr;     // 2-bit address for 4 locations
    reg CS, WE, RD, Clk;

    // Outputs
    wire [3:0] Q;        // 4-bit output for all SRAM locations (q1, q2, q3, q4)

    // Instantiate the Unit Under Test (UUT)
    SRAM uut (
        .dataIn(dataIn),
        .Addr(Addr),
        .CS(CS),
        .WE(WE),
        .RD(RD),
        .Clk(Clk),
        .Q(Q)
    );

    initial begin
        // Initialize Inputs
        dataIn = 4'b0000;
        Addr = 2'b00;   // Start with address 00
        CS = 1'b0;
        WE = 1'b0;
        RD = 1'b0;
        Clk = 1'b0;

        // Create the VCD file and dump the variables
        $dumpfile("waveform.vcd");  // Name of the VCD file
        $dumpvars(0, SRAM_tb);      // Dump all variables in the testbench

        // Wait for global reset to finish
        #100;

        // Test Writing to the SRAM cells
        CS = 1'b1;
        WE = 1'b1;
        RD = 1'b0;
        
        // Write to different addresses
        Addr = 2'b00; dataIn = 4'b1111; #20;   // Write 1111 to location 00
        Addr = 2'b01; dataIn = 4'b0001; #20;   // Write 0001 to location 01
        Addr = 2'b10; dataIn = 4'b1100; #20;   // Write 1100 to location 10
        Addr = 2'b11; dataIn = 4'b1010; #20;   // Write 1010 to location 11

        // Test Reading from the SRAM cells
        WE = 1'b0;
        RD = 1'b1;
        Addr = 2'b00; #20;    // Read from location 00
        Addr = 2'b01; #20;    // Read from location 01
        Addr = 2'b10; #20;    // Read from location 10
        Addr = 2'b11; #20;    // Read from location 11

        // End simulation after some time
        #100;
        $finish;
    end

    // Clock generation
    always #10 Clk = ~Clk;

endmodule