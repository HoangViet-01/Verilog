module Ripple_Carry_Adder # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] a,
    input [WIDTH - 1:0] b,
    output [WIDTH - 1:0] s,
    output cout
);
    wire [WIDTH:0] c;
    assign c[0] = 1'b0;

    genvar i;
    generate 
        for (i = 0; i < WIDTH; i = i + 1) begin : FA
            Full_adder F (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .s(s[i]),
                .cout(c[i + 1])
            );
        end
    endgenerate

    assign cout = c[WIDTH];

endmodule