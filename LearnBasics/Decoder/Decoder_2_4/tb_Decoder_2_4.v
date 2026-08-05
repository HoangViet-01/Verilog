`timescale 1ns/1ps

module tb_Decoder_2_4;

    reg [1:0] select;
    wire [3:0] out;

    Decoder_2_4 uut (
        .select(select),
        .out(out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $monitor ("Time=%0t select=%b out=%b",
                    $time, select, out);
            select = 2'b00; #10;
            select = 2'b01; #10;
            select = 2'b10; #10;
            select = 2'b11; #10;

            $finish;
    end

endmodule