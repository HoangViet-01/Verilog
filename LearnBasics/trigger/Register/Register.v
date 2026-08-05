module Register (
    input [7:0] in,
    input clk,
    input rst,
    input pre_rst,
    input OC,
    output [7:0] out,
    output [7:0] not_out
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


    reg [7:0] q;
    always @ (posedge clk, negedge rst, negedge pre_rst) begin
        if (!rst) begin
            q <= 8'd0;
        end else if (!pre_rst) begin
            q <= 8'd255;
        end else begin
            q <= in;
        end
    end

    assign out = (!OC) ? q : 8'bzzzzzzzz;
    assign not_out = (!OC) ? ~q : 8'bzzzzzzzz;
    
endmodule