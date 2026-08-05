module Haft_Subtractor (
    input a,
    input b,
    output B,
    output D
);

    assign D = a ^ b;
    assign B = ~a & b;
    
endmodule