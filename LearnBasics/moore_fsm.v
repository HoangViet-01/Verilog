module moore_fsm (
    input clk,
    input in,
    input rst_n,
    output reg valid
) 

localparam IDLE = 2'b00;
localparam D0 = 2'b01;
localparam D00 = 2'b11;
localparam D001 = 2'b10;

reg [1:0] current_state;

always @ (posedge clk, negedge rst_n) begin
    if (rst_n == 0) current_state <= IDLE;
    else begin 
        case (current_state) 
                IDLE : begin 
                    if (in == 1'b0) current_state <= D0;
                    else current_state <= IDLE;
                end
                D0 : begin
                    if (in == 1'b0) current_state <= D00;
                    else current_state <= IDLE;
                end
                D00 : if (in == 1'b1) current_state <= D001;
                D001 : begin
                    if (in == 1'b0) current_state <= D0;
                    else current_state <= IDLE;
                end
                default current_state <= 2'bxx;
        endcase
    end
end   

always @ (posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) valid <= 1'b0;
    else begin
        if (current_state == D001) valid <= 1'b1;
        else valid <= 1'b0;
    end
end

endmodule