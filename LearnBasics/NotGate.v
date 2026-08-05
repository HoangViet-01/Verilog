module NotGate (
    input in, 
    output reg out
);

always (*) begin
    out = ~in;
end

endmodule