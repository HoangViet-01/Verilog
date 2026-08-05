`timescale 1ns/1ps
module tb_RBS;

    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] D;
    wire Bout;

    RBS uut(
        .a(a),
        .b(b),
        .D(D),
        .Bout(Bout)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_RBS);
    end

    integer i, j;
    initial begin
        $monitor("Time=%0t a=%b b=%b D=%b Bout=%b",
                    $time, a, b, D, Bout);
            for (i = 0; i < 16; i= i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    a = i;
                    b = j;
                    #10;
                end
            end

        $finish;
    end

endmodule