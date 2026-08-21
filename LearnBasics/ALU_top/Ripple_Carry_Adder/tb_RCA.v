`timescale 1ns/1ps

module tb_RCA;
    parameter WIDTH = 4;

    reg [WIDTH - 1:0] a;
    reg [WIDTH - 1:0] b;
    wire [WIDTH - 1:0] s;
    wire cout;
    //wire [WIDTH - 1:0] c;

    Ripple_Carry_Adder uut(
        .a(a),
        .b(b),
        //.c(c),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, uut);
    end

    integer i, j;
    initial begin
        $monitor("Time=%0t a=%b b=%b s=%b cout=%b",
                    $time, a, b, s, cout);
                    
            // for (i = 0; i < 16; i = i + 1) begin
            //     for (j = 0; j < 16; j = j + 1) begin
            //         a = i;
            //         b = j;
            //         #10;
            //     end
            // end

            #10;
            a = 4'b1011;
            b = 4'b1001;

        $finish;

    end

endmodule