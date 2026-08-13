module datapath # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] X_i,
    input [WIDTH - 1:0] Y_i,
    input RST, CLK, 
            y_load, x_load, GCD_load, 
            x_sel, y_sel,
    output [WIDTH - 1:0] GCD_o,
    output x_neq_y, x_lt_y
);

    reg [WIDTH - 1:0] Q_x, Q_y, Q_gcd;
    wire [WIDTH - 1:0] x, y, x_sub_y, y_sub_x;

    // Khối chọn dữ liệu tính toán (Mux).
    assign x = x_sel ? X_i : x_sub_y;
    assign y = y_sel ? Y_i : y_sub_x;

    /**
    Khối trigger lưu trữ giá trị đầu vào và đầu ra trong từng phép tính.
    **/

    // Trigger D_x.
    Register # (
        .WIDTH(WIDTH)
    ) reg_x (
        .in(x),
        .clk(CLK),
        .rst(RST),
        .EN(x_load),
        .out(Q_x)
    );

    // Trigger D_y.
    Register # (
        .WIDTH(WIDTH)
    ) reg_y (
        .in(y),
        .clk(CLK),
        .rst(RST),
        .EN(y_load),
        .out(Q_y)
    );

    // Trigger D_gcd
    Register # (
        .WIDTH(WIDTH)
    ) reg_gcd (
        .in(Q_x),
        .clk(CLK),
        .rst(RST),
        .EN(GCD_load),
        .out(Q_gcd)
    );

    /**
    Khối tính toán và so sánh.
    **/

    // Bộ trừ x_sub_y.
    RBS # (
        .WIDTH(WIDTH)
    ) sub_x (
        .a(Q_x),
        .b(Q_y),
        .out(x_sub_y)
    );

    // Bộ trừ y_sub_x.
    RBS # (
        .WIDTH(WIDTH)
    ) sub_y (
        .a(Q_y),
        .b(Q_x),
        .out(y_sub_x)
    );

    // 2 bộ so sánh (comp).
    assign x_neq_y = (Q_x != Q_y);
    assign x_lt_y = (Q_x < Q_y);

    assign GCD_o = Q_gcd;

    // always @ (posedge CLK) begin
    //     // RST
    //     if (RST) begin
    //         Q_x <= (WIDTH - 1)'d0;
    //         Q_y <= (WIDTH - 1)'d0;
    //         Q_gcd <= (WIDTH - 1)'d0;

    //         // Khối trigger lưu trữ giá trị đầu vào và đầu ra trong từng phép tính.
    //         if (x_load) begin 
    //             Q_x <= x;
    //         end
    //         if (y_load) begin
    //             Q_y <= y;
    //         end

    //         // Khối tính toán và so sánh.
    //         if (Q_x != Q_y) begin
    //             if (Q_x > Q_y) x_i <= x_sub_y;
    //             else y_i <= y_sub_x;
    //         end else begin
    //             if (GCD_load) Q_gcd <= Q_x;
    //         end
    //     end
    // end

endmodule