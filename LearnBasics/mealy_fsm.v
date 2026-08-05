module mealy_fsm (
    input in,
    input clk,
    input rst_n,
    output reg valid
)

localparam IDLE = 2'b00;
localparam D0 = 2'b01;
localparam D00 = 2'b11;
localparam D001 = 2'b10;

reg [1:0] current_state;

always @ (posedge clk, negedge rst_n) begin
    if (rst_n == 1'b0) begin
        valid <= 1'b0;
        current_state <= IDLE;
    end else begin
        case (current_state)
            IDLE : begin
                valid <= 1'b0;
                if (in == 1'b0) current_state <= D0;
                else current_state <= IDLE;
            end
            D0 : begin
                valid <= 1'b0;
                if (in == 1'b0) current_state <= D00;
                else current_state <= IDLE;
            end
            D00 : begin
                if (in == 1'b0) valid <= 1'b0;
                else begin
                    valid <= 1'b1;
                    current_state <= IDLE;
                end
            end
            default : begin 
                valid <= 1'bx;
                current_state <= 2'bxx;
            end
        endcase
    end
end

endmodule