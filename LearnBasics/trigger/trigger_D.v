module trigger_D (
    input in, clk, rst,
    output reg out
);

    always @ (posedge clk, posedge rst) begin
        if (!rst) begin
            out <= 1'b0;
        end else begin
            out <= in;
        end
    end
    
endmodule