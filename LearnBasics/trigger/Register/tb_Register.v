`timescale 1ns/1ps

module tb_Register;

    reg [7:0] in;
    reg clk;
    reg rst;
    reg EN;
    wire [7:0] out;

    Register uut (
        .*
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_Register);
    end

    initial begin
        $monitor("Time=%0t in=%b rst=%b EN=%b out=%b",
                $time, in, rst, EN, out);
            in = 8'd0;
            rst = 1'b0;
            EN = 1'b0;

            #3; 
            in = 8'd8;

            #12;
            EN = 1'b1;

            #5;
            rst = 1'b1;

            #5;
            rst = 1'b0;

            #5;
            EN = 1'b0;

            #10 $finish;
    end

endmodule