module RBS # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] a,
    input [WIDTH - 1:0] b, 
    output Bout,
    output [WIDTH - 1:0] D
);

    wire [WIDTH:0] B;
    assign B[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : FS
            Full_Subtractor F (
                .a(a[i]),
                .b(b[i]),
                .B(B[i]),
                .Bout(B[i + 1]),
                .D(D[i])
            );
        end
    endgenerate
    
    assign Bout = B[WIDTH];

endmodule