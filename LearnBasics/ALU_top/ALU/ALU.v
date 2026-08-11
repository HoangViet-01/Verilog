module ALU # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] a,
    input [WIDTH - 1:0] b,
    input [2:0] op,
    output reg car_bor,
    output reg [WIDTH - 1:0] out,
    output zero,
    output negative,
    output overflow
);

    wire [WIDTH - 1:0] sum_out, sub_out;
    wire cout, bout;

    Ripple_Carry_Adder # (
        .WIDTH(WIDTH)
    ) add (
        .a(a),
        .b(b),
        .s(sum_out),
        .cout(cout)
    );

    RBS # (
        .WIDTH(WIDTH)
    ) sub (
        .a(a),
        .b(b),
        .D(sub_out),
        .Bout(bout)
    );

    always @ (*) begin
        case (op)
            3'b000 : begin // Add
                out = sum_out;
                car_bor = cout;
            end
            3'b001 : begin // Sub
                out = sub_out;
                car_bor = bout;
            end
            3'b011 : begin // Or.
                 out = a | b; 
                 car_bor = 1'b0;
            end
            3'b100 : begin // Xor.
                out = a ^ b; 
                car_bor = 1'b0;
            end
            3'b101 : begin// Not a.
                 out = ~a; 
                 car_bor = 1'b0;
            end
            3'b010 : begin // And.
                out = a & b; 
                car_bor = 1'b0;
            end
            3'b110 : begin// Dich trai a.
                car_bor = a[3];
                 out = a << 1; 
            end
            3'b111 : begin // Dich phai a.
                car_bor = a[0];
                out = a >> 1; 
            end
            default : begin 
                out = 4'bxxx;
                car_bor = 1'b0;
            end
        endcase
    end

    assign zero = (out == (WIDTH - 1)'b0000);
    assign negative = out[WIDTH - 1];
    assign overflow =   
        (op == 3'b000) ? ((a[WIDTH - 1] == b[WIDTH - 1]) && (out[WIDTH - 1] != a[WIDTH - 1])) :
        (op == 3'b001) ? ((a[WIDTH - 1] != b[WIDTH - 1]) && (out[WIDTH - 1] != a[WIDTH - 1])) :
        1'b0;

endmodule