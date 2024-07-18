/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_FIFO (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,  // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

always @(posedge clk) begin
    if (ena == 1'b1) begin
        uo_out <= ui_in;
    end
end

endmodule
