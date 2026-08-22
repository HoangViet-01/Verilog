module priority_encoder #(
    parameter WIDTH = 15
) (
    input [14:0] F,
    output [3:0] sub
);
    // 15 cong mux.
    assign sub = F[14] ? 4'b0000 :
                 F[13] ? 4'b0001 :
                 F[12] ? 4'b0010 :
                 F[11] ? 4'b0011 :
                 F[10] ? 4'b0100 :
                 F[9] ? 4'b0101 :
                 F[8] ? 4'b0110 :
                 F[7] ? 4'b0111 :
                 F[6] ? 4'b1000 :
                 F[5] ? 4'b1001 :
                 F[4] ? 4'b1010 :
                 F[3] ? 4'b1011 :
                 F[2] ? 4'b1100 :
                 F[1] ? 4'b1101 :
                 F[0] ? 4'b1110 : 4'bxxxx;
    
endmodule