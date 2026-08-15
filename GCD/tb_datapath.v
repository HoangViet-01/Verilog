`timescale 1ns/1ps

module tb_datapath;

    parameter WIDTH  = 8;

    reg [WIDTH - 1:0] X_i, Y_i;
    reg RST, CLK, y_load, x_load, GCD_load, x_sel, y_sel;
    wire [WIDTH - 1:0] GCD_o;
    wire x_neq_y, x_lt_y;

    datapath uut (
        .*
    );

    //Clock.
    initial begin
        CLK = 0;
        forever #1 CLK = ~CLK;
    end

    // Waveform.
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_datapath);
    end

    // Monitor.
    initial begin
        $monitor ("Time=%0t X_i=%d Y_i=%d Q_x=%d Q_y=%d ne=%d lt=%d GCD=%d",
                    $time, X_i, Y_i, uut.Q_x, uut.Q_y, x_neq_y, x_lt_y, GCD_o);
    end

    // Simulator.
    initial begin

        // Nap du lieu.
        X_i = 8'd4;
        Y_i = 8'd2;
        RST = 1'b1;
        x_sel = 1'b0;
        y_sel = 1'b0;
        x_load = 1'b0;
        y_load = 1'b0;

        // Load du lieu.
        @(negedge CLK) //xung 1.
        RST = 1'b0;
        x_sel = 1'b1; 
        x_load = 1'b1; // Load x.
        y_sel = 1'b1;
        y_load = 1'b1; // Load y.

        @(negedge CLK) // Xung 2.
        x_sel = 1'b0;
        y_sel = 1'b0;
        y_load = 1'b0;

        @(negedge CLK) // Xung 3.
        GCD_load = 1'b1;

        @(negedge CLK) // Xung 4.
        x_load = 1'b0;
        GCD_load = 1'b0;

        @(negedge CLK)

        @(posedge CLK)

        @(negedge CLK)

        $finish;
    end

endmodule