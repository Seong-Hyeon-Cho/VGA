`timescale 1ns / 1ps

module Grayscalefilter (
    input  logic [3:0] i_r,
    input  logic [3:0] i_g,
    input  logic [3:0] i_b,
    output logic [3:0] o_r,
    output logic [3:0] o_g,
    output logic [3:0] o_b
);

    logic [11:0] gray;
    assign gray = 77 * i_r + 154 * i_g + 25 * i_b; // fixed point 활용
    assign {o_r, o_g, o_b} = {gray[11:8], gray[11:8], gray[11:8]};
endmodule
