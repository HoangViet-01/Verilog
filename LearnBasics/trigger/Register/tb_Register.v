`timescale 1ns/1ps

module tb_Register;

    reg [7:0] in;
    reg clk;
    reg rst;
    reg pre_rst;
    reg OC;
    wire [7:0] out;
    wire [7:0] not_out;

    Register uut (
        .in(in),
        .clk(clk),
        .rst(rst),
        .pre_rst(pre_rst),
        .OC(OC),
        .out(out),
        .not_out(not_out)
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
        $monitor("Time=%0t in=%b rst=%b pre_rst=%b OC=%b out=%b not_out=%b",
                $time, in, rst, pre_rst, OC, out, not_out);
            in = 8'd0;
            rst = 1'b1;
            pre_rst = 1'b1;
            OC = 1'b0;

            #3; 
            in = 8'd8;

            #15;
            OC = 1'b1;

            #20;
            rst = 1'b0;

            #25;
            rst = 1'b1;
            pre_rst = 1'b0;

            #30 $finish;
    end

endmodule