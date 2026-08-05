module trigger_JK (
    input j, k, clk, rst, pre_rst,
    output reg out, outNot
);

    always @ (posedge clk, negedge rst, negedge pre_rst) begin
        if (!rst) begin
            out <= 1'b0;
            outNot <= 1'b1;
        end else if (!pre_rst) begin
            out <= 1'b1;
            outNot <= 1'b0;
        end 
        case ({j, k}) 
            2'b00 : begin
                out <= out;
                outNot <= outNot;
            end
            2'b01 : begin
                out <= 1'b0;
                outNot <= 1'b1;
            end
            2'b10 : begin
                out <= 1'b1;
                outNot <= 1'b0;
            end
            2'b11 : begin
                out <= ~out;
                outNot <= ~outNot;
            end
        endcase
    end

endmodule