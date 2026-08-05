module Full_Subtractor (
    input a,
    input b,
    input B,
    output Bout,
    output D
);

    assign D = a ^ b ^ B;
    assign Bout = (~a & b) | (~(a ^ b) & B);
    
endmodule