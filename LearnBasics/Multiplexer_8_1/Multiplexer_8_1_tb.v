`timescale 1ns/1ps
module Multiplexer_8_1_tb;

    reg [7:0] in;
    reg [2:0] select;
    wire out;

    Multiplexer_8_1 mux (
        .in(in),
        .select(select),
        .out(out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, Multiplexer_8_1_tb);
    end

    initial begin
        $monitor ("Time=%0t in=%b select=%b out=%b",
                    $time, in, select, out);
            in = 8'b10101010;
            select = 0; #10;
            select = 1; #10;
            select = 2; #10;
            select = 3; #10;
            select = 4; #10;
            select = 5; #10;
            select = 6; #10;
            select = 7; #10;

        $finish;

    end

endmodule