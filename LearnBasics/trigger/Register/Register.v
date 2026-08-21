module Register # (
    parameter WIDTH = 8
) (
    input [WIDTH - 1:0] in,
    input CLK,
    input RST,
    input EN,
    output reg [WIDTH - 1:0] out
);

    // genvar i;
    // generate
    //     for (i = 0; i < 8; i = i + 1) begin
    //         trigger_D D (
    //             .in(in[i]),
    //             .clk(clk),
    //             .pre_rst(pre_rst),
    //             .rst(rst),
    //             .out(out[i]),
    //             .not_out(not_out[i])
    //         );
    //     end
    // endgenerate
    //

    always @ (posedge CLK, posedge RST) begin
        if (RST) begin
            out <= '0;
        end else begin
            if (EN) begin
                out <= in;
            end
        end
    end
    
endmodule