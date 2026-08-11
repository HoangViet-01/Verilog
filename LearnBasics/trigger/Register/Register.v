module Register # (
    parameter WIDTH 8
) (
    input [WIDTH - 1:0] in,
    input clk,
    input rst,
    input EN,
    output [WIDTH - 1:0] out,
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

    reg [WIDTH - 1:0] q;
    always @ (posedge clk, negedge rst, negedge pre_rst) begin
        if (rst) begin
            q <= WIDTH'd0;
        end else begin
            q <= in;
        end
    end

    assign out = (EN) ? q : 8'bzzzzzzzz;
    
endmodule