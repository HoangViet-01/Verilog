`timescale 1ns/1ps

module tb_datapath;

    parameter WIDTH  = 8;

    reg [WIDTH - 1:0] X_i, Y_i;
    reg RST, CLK, Start, y_load, x_load, GCD_load, x_neq_y, x_lt_y, x_sel, y_sel;
    wire [WIDTH - 1:0] GCD_o;
    wire Done_o;

    datapath uut (
        .*
    );

    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_datapath);
    end

    initial begin
        $monitor ("Time=%0t X_i=%d Y_i=%d GCD=%d",
                    $time, X_i, Y_i, GCD_o)
    end 

    X_i = 8'd125;
    Y_i = 8'd100;
    

endmodule