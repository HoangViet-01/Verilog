`timescale 1ns/1ps

module tb_log_div;
    parameter WIDTH = 16;

    reg [15:0] F1;
    reg [15:0] F2;
    reg CLK, RST;
    wire [15:0] result;

    log_div uut (
        .F1(F1),
        .F2(F2),
        .CLK(CLK),
        .RST(RST),
        .result(result)
    );

    // Clock.
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Waveform.
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, uut);
    end

    // Monitor.
    initial begin
        $monitor("Time=%0t F1=%b F2=%b result=%b",
                  $time, F1, F2, result);
    end

    // Simulator.
    initial begin
        // Nap du lieu.
        RST = 1;
        F1 = 16'b0010001000000000;
        F2 = 16'b0001010000000000;

        #6;
        RST = 0;

        #50;
        $finish;
    end

endmodule