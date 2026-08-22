// input F1,F2;

// s1 = 4'b0010;
// integer i;
// integer sub = -1; 
// for (i = 14; i >= 0; i = i - 1) {
//     if(F1[i] == 1) {
//         sub = sub + 1;
//         break;
//     } 
// }

// s1 = 2 - sub;

// u1[14] // Thanh ghi 14 bit;
// u1[13:sub] = F1[13-sub:0];
// u1[sub-1:0] <= '0; // Tu dien 0 vao phan con lai cua u.

// // Tim s2 va u2 tuong tu.

// delta_s = s1 - s2; // Thanh ghi 19 bit : 1 bit dau | 4 bit nguyen | 14 bit thap phan.
// delta_u = u1 - u2; // Thanh ghi 19 bit.

// if (delta_u[18] == 1) { // Bit dau cua delta_u
//     delta_u[17:14] = {1111};
// } else {
//     delta_u[17:14] = {0000};
// }

// D = delta_u + delta_s; // 19 bit;

// k[4]; // Thanh ghi 4 bit.
// k[3:0] = D[17:14]; // 4 bit nguyen cua D.
// r[17]; // Thanh ghi 17 bit : 3 bit nguyen | 14 bit thap phan.
// r[16:14] = {001}; // r + 1;
// r[13:0] = D[13:0]; // 14 bit thap phan cua D.

// // (1+r).2^k.
// if (D[18] == 1) {
//     r << k; // Dich trai k bit.
// } else {
//     r >> k; // Dich phai k bit.
// }

// result[16]; // Thanh ghi 16 bit : Q4.12;

// result[15] = 0; // Bit dau.
// result[14:12] = r[16:14]; // 3 bit nguyen cua r;
// result[11:0] = r[13:2]; // 12 bit thap phan cua r, bo di 2 bit cuoi.

module log_div (
    input [15:0] F1,
    input [15:0] F2,
    input CLK, RST,
    output reg [15:0] result
);
    wire [3:0] sub1, sub2;
    // Tim sub1, sub2.
    priority_encoder # (
        .WIDTH(15)
    ) pri_1 (
        .F(F1[14:0]),
        .sub(sub1)
    );
    priority_encoder # (
        .WIDTH(15)
    ) pri_2 (
        .F(F2[14:0]),
        .sub(sub2)
    );

    // Tim s1, s2.
    wire borrow_1_old, borrow_2_old;
    wire [3:0] s1_old, s2_old;
    RBS # (
        .WIDTH(4)
    ) sub_s1 (
        .a(4'b0010),
        .b(sub1),
        .Bout(borrow_1_old),
        .D(s1_old)
    );
    RBS # (
        .WIDTH(4)
    ) sub_s2 (
        .a(4'b0010),
        .b(sub2),
        .Bout(borrow_2_old),
        .D(s2_old)
    );

    reg borrow_1_new, borrow_2_new;
    reg [3:0] s1_new, s2_new;

    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            borrow_1_new <= 1'b0;
            borrow_2_new <= 1'b0;
            s1_new <= 4'b0;
            s2_new <= 4'b0;
        end else begin
            borrow_1_new <= borrow_1_old;
            borrow_2_new <= borrow_2_old;
            s1_new <= s1_old;
            s2_new <= s2_old;
        end
    end

    // Tim u1, u2.
    //wire [3:0] control_1, control_2;
    reg [13:0] u1_old, u2_old;

    // Ripple_Carry_Adder # (
    //     .WIDTH(4)
    // ) add_1 (
    //     .a(sub1),
    //     .b(4'b0001),
    //     .s(control_1)
    // );
    // Ripple_Carry_Adder # (
    //     .WIDTH(4)
    // ) add_2 (
    //     .a(sub2),
    //     .b(4'b0001),
    //     .s(control_2)
    // );

    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            u1_old <= 14'b0;
            u2_old <= 14'b0;
        end else begin
            u1_old <= F1[13:0] << sub1; //control_1;
            u2_old <= F2[13:0] << sub2; //control_2;
        end
    end
    
    // Tao s1[18:0], s2[18:0], u1[18:0], u2[18:0].
    reg [18:0] s1, s2, u1, u2;
    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            s1 <= 19'b0;
            s2 <= 19'b0;
            u1 <= 19'b0;
            u2 <= 19'b0;
        end else begin
            s1[18] <= borrow_1_new;
            s1[17:14] <= s1_new;
            s1[13:0] <= 14'b0;

            s2[18] <= borrow_2_new;
            s2[17:14] <= s2_new;
            s2[13:0] <= 14'b0;

            u1[18:14] <= 5'b0;
            u1[13:0] <= u1_old;

            u2[18:14] <= 5'b0;
            u2[13:0] <= u2_old;
        end
    end

    // tinh delta_s, delta_u va Delta (D).
    wire [18:0] delta_s, delta_u;
    RBS # (
        .WIDTH(19)
    ) sub_s (
        .a(s1),
        .b(s2),
        .D(delta_s)
    );
    RBS # (
        .WIDTH(19)
    ) sub_u (
        .a(u1),
        .b(u2),
        .D(delta_u)
    );

    wire [18:0] Delta;
    Ripple_Carry_Adder # (
        .WIDTH(19)
    ) add_delta (
        .a(delta_s),
        .b(delta_u),
        .s(Delta)
    );

    // Tinh k va r.
    wire [3:0] k;
    assign k = Delta[17:14];
    reg [16:0] r_old, r;
    // Them 1 trigger de luu r_old.
    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            r_old <= 17'b0;
        end else begin
            r_old[16:14] <= 3'b001;
            r_old[13:0] <= Delta[13:0];
        end
    end

    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            r <= 17'b0;
        end else if (!Delta[18]) begin
            r <= r_old << k;
        end else begin
            r <= r_old >> k;
        end
    end

    // result Q4.12.
    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            result <= 16'b0;
        end else begin
            result[15] <= 1'b0;
            result[14:12] <= r[16:14];
            result[11:0] <= r[13:2];
        end
    end

endmodule