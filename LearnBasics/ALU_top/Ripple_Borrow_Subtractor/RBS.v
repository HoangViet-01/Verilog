module RBS (
    input [3:0] a,
    input [3:0] b, 
    output Bout,
    output [3:0] D
);

    wire [4:0] B;
    assign B[0] = 1'b0;

    Full_Subtractor F0 (
        .a(a[0]),
        .b(b[0]),
        .B(B[0]),
        .Bout(B[1]),
        .D(D[0])
    );

    Full_Subtractor F1 (
        .a(a[1]),
        .b(b[1]),
        .B(B[1]),
        .Bout(B[2]),
        .D(D[1])
    );

    Full_Subtractor F2 (
        .a(a[2]),
        .b(b[2]),
        .B(B[2]),
        .Bout(B[3]),
        .D(D[2])
    );
    
    Full_Subtractor F3 (
        .a(a[3]),
        .b(b[3]),
        .B(B[3]),
        .Bout(B[4]),
        .D(D[3])
    );

    assign Bout = B[4];

endmodule