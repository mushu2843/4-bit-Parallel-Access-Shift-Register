module shift_register(
    input clk,
    input rst,
    input [1:0] mode,
    input [3:0] parallel_in,
    input serial_left,
    input serial_right,
    output reg [3:0] q
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        q <= 4'b0000;

    else
    begin
        case(mode)

            2'b00:
                q <= q;

            2'b01:
                q <= {serial_left, q[3:1]};

            2'b10:
                q <= {q[2:0], serial_right};

            2'b11:
                q <= parallel_in;

        endcase
    end
end

endmodule
