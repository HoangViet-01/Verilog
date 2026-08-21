module priority_encoder #(
    parameters WIDTH = 15
) (
    input [14:0] F1,
    output [3:0] sub
);

    assign sub = F1[14] ? 4'b0000 :
                 F1[13] ? 4'b0001 :
                 F1[12] ? 4'b0010 :
                 F1[11] ? 4'b0011 :
                 F1[10] ? 4'b0100 :
                 F1[9] ? 4'b0101 :
                 F1[8] ? 4'b0110 :
                 F1[7] ? 4'b0111 :
                 F1[6] ? 4'b1000 :
                 F1[5] ? 4'b1001 :
                 F1[4] ? 4'b1010 :
                 F1[3] ? 4'b1011 :
                 F1[2] ? 4'b1100 :
                 F1[1] ? 4'b1101 :
                 F1[0] ? 4'b1110 : xxxx;
    
endmodule