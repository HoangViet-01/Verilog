module trigger_D (
    input in, clk, pre_rst, rst,
    output reg out, not_out
);

    always @ (posedge clk, negedge rst, negedge pre_rst) begin
        if (!rst) begin
            out <= 1'b0;
            not_out <= 1'b1;
        end else if (!pre_rst) begin
            out <= 1'b1;
            not_out <= 1'b0;
        end else begin
            out <= in;
            not_out <= ~in;
        end
    end
    
endmodule