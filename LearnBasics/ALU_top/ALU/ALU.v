module ALU (
    input [3:0] a,
    input [3:0] b,
    input [2:0] op,
    output reg carry,
    output reg [3:0] out,
    output zero,
    output negative,
    output overflow
);

    wire [3:0] sum_out, sub_out;
    wire cout, bout;

    Ripple_Carry_Adder add (
        .a(a),
        .b(b),
        .s(sum_out),
        .cout(cout)
    );

    RBS sub (
        .a(a),
        .b(b),
        .D(sub_out),
        .Bout(bout)
    );

    always @ (*) begin
        case (op)
            3'b000 : begin // Add
                out = sum_out;
                carry = cout;
            end
            3'b001 : begin // Sub
                out = sub_out;
                carry = bout;
            end
            3'b011 : begin // Or.
                 out = a | b; 
                 carry = 1'b0;
            end
            3'b100 : begin // Xor.
                out = a ^ b; 
                carry = 1'b0;
            end
            3'b101 : begin// Not a.
                 out = ~a; 
                 carry = 1'b0;
            end
            3'b010 : begin // And.
                out = a & b; 
                carry = 1'b0;
            end
            3'b110 : begin// Dich trai a.
                carry = a[3];
                 out = a << 1; 
            end
            3'b111 : begin // Dich phai a.
                carry = a[0];
                out = a >> 1; 
            end
            default : begin 
                out = 4'bxxx;
                carry = 1'b0;
            end
        endcase
    end

    assign zero = (out == 4'b0000);
    assign negative = out[3];
    assign overflow =   
        (op == 3'b000) ? ((a[3] == b[3]) && (out[3] != a[3])) :
        (op == 3'b001) ? ((a[3] != b[3]) && (out[3] != a[3])) :
        1'b0;

endmodule