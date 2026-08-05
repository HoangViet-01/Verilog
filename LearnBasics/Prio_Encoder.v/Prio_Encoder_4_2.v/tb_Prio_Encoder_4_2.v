`timescale 1ns/1ps

module tb_Prio_Encoder_4_2;

    reg [3:0] in;
    wire [1:0] out;

    Prio_Encoder_4_2 uut (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, uut);
    end

    integer i = 0;
    initial begin
        $monitor("Time=%0t in=%b out=%b",
                    $time, in, out);
            
            for (i = 0; i < 16; i = i + 1) begin
                in = i;
                #10;
            end

            $finish;
    end

endmodule