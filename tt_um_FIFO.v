module tt_um_FIFO #(parameter WIDTH = 1, DEPTH = 32)(
    input [WIDTH-1:0] data_in,
    input read_en,
    input write_en,
    input clk,
    input reset,
    output reg [WIDTH-1:0] data_out,
    output reg full,
    output reg empty,
    output reg [6:0] read_ptr,
    output reg [6:0] write_ptr
);

reg [WIDTH-1:0] fifo[0:DEPTH-1];

always @(posedge clk) begin
    if (reset == 1'b1) begin
        read_ptr <= 7'b0;
        write_ptr <= 7'b0;
        full <= 1'b0;
        empty <= 1'b1;
    end else begin
        if (read_en == 1'b1 && empty == 1'b0) begin
            data_out <= fifo[read_ptr];
            read_ptr <= read_ptr + 1;
            if (read_ptr == write_ptr) begin
                empty <= 1'b1;
            end
        end

        if (write_en == 1'b1 && full == 1'b0) begin
            fifo[write_ptr] <= data_in;
            write_ptr <= write_ptr + 1;
            if ((read_ptr[6] != write_ptr[6]) && (read_ptr[5:0] == write_ptr[5:0])) begin
                full <= 1'b1;
            end
            if (empty == 1'b1) begin
                empty <= 1'b0;
            end
        end
    end
end

endmodule
