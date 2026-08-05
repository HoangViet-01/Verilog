`timescale 1ns/1ps

module tb_ALU;

    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] op;
    wire carry;
    wire [3:0] out;

    ALU uut(
        .a(a),
        .b(b),
        .op(op),
        .carry(carry),
        .out(out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_ALU);
    end

    integer i;
    initial begin
        $monitor ("Time=%0t op=%b a=%b b=%b carry=%b out=%b",
                    $time, op, a, b, carry, out);
            a = 4'b1010;
            b = 4'b0110;
            for (i = 0; i < 8; i = i + 1) begin
                op = i;
                #10;
            end
            $finish;
    end

endmodule