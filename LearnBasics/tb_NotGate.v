`timescale 1ns/1ps
module tb_NotGate;
    reg in;
    wire out;
    NotGate uut (
        .in(in),
        .out(out)
    );

    initial begin 
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_NotGate);
    end

    initial begin
        in = 0;
        #10;

        in = 1;
        #10;

        $finish;
    end
endmodule