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

input F1,F2;

s1 = 4'b0010;
integer i;
integer sub = -1; 
for (i = 14; i >= 0; i = i - 1) {
    if(F1[i] == 1) {
        sub = sub + 1;
        break;
    } 
}

s1 = 2 - sub;

u1[14] // Thanh ghi 14 bit;
u1[13:sub+1] = F1[13-sub:0];
u1[sub-1:0] <= '0; // Tu dien 0 vao phan con lai cua u.

// Tim s2 va u2 tuong tu.

delta_s = s1 - s2; // Thanh ghi 19 bit : 1 bit dau | 4 bit nguyen | 14 bit thap phan.
delta_u = u1 - u2; // Thanh ghi 19 bit.

if (delta_u[18] == 1) { // Bit dau cua delta_u
    delta_u[17:14] = {1111};
} else {
    delta_u[17:14] = {0000};
}

D = delta_u + delta_s; // 19 bit;

k[4]; // Thanh ghi 4 bit.
k[3:0] = D[17:14]; // 4 bit nguyen cua D.
r[17]; // Thanh ghi 17 bit : 3 bit nguyen | 14 bit thap phan.
r[16:14] = {001}; // r + 1;
r[13:0] = D[13:0]; // 14 bit thap phan cua D.

// (1+r).2^k.
if (D[18] == 1) {
    r << k; // Dich trai k bit.
} else {
    r >> k; // Dich phai k bit.
}

result[16]; // Thanh ghi 16 bit : Q4.12;

result[15] = 0; // Bit dau.
result[14:12] = r[16:14]; // 3 bit nguyen cua r;
result[11:0] = r[13:2]; // 12 bit thap phan cua r, bo di 2 bit cuoi.