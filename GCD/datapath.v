module datapath # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] X_i,
    input [WIDTH - 1:0] Y_i,
    input RST, CLK, Start, 
            y_load, x_load, 
            GCD_load, x_sel, y_sel,
    output reg [WIDTH - 1:0] GCD_o,
    output Done_o, x_neq_y, x_lt_y
) 

    reg [WIDTH - 1:0] x, y, Q_x, Q_y, Q_gcd, x_sub_y, y_sub_x;

    RBS # (
        .WIDTH(WIDTH)
    ) sub_x (
        .a(x),
        .b(y),
        .out(x_sub_y)
    );

    RBS # (
        .WIDTH(WIDTH)
    ) sub_y (
        .a(y),
        .b(x),
        .out(y_sub_x)
    );

    always @ (posedge CLK) begin
            // RST
            if (RST == 1'b1) begin
                Q_x <= (WIDTH - 1)'d0;
                Q_y <= (WIDTH - 1)'d0;
                Q_gcd <= (WIDTH - 1)'d0;
                x <= (WIDTH - 1)'d0;
                y <= (WIDTH - 1)'d0;
                x_i <= (WIDTH - 1)'d0;
                y_i <= (WIDTH - 1)'d0;
            end else begin
                Done_o <= 1'b0;
                if (Start == 1'b1) begin
                    // Load x
                    if (x_load == 1'b1) begin
                        if (x_sel == 1'b1) begin
                            x <= X_i;
                        end else begin
                            x <= x_sub_y;
                        end
                    end
                    
                    // Load y
                    if (y_load == 1'b1) begin
                        if (y_sel == 1'b1) begin
                            y <= Y_i;
                        end else begin
                            y <= y_sub_x;
                        end
                    end
                    
                // if (x_load == 1'b1) Q_x <= x;
                // if (y_load == 1'b1) Q_y <= y;
                // if (GCD_load == 1'b1) Q_gcd <= x;
            end

            // Bo so sanh va bo tru
            if (x != y) begin
                if (x > y) begin
                    x_lt_y <= 1'b0;
                    x_i <= x_sub_y;
                end else begin
                    x_lt_y <= 1'b1;
                    y_i <= y_sub_x;
                end
            end else begin
                if (GCD_load == 1'b1) begin
                    GCD_o <= Q_x;
                    Done_o <= 1'b1;
                end
            end
        end
    end

endmodule