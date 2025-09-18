`timescale 1ns / 1ps

module VGA_Display_ImgROM (
    input  logic       clk,
    input  logic       reset,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port,
    input  logic       filter_mode_sw,
    // input  logic       r_sw_mode,
    // input  logic       g_sw_mode,
    // input  logic       b_sw_mode,
    // input  logic [3:0] r_sw,
    // input  logic [3:0] g_sw,
    // input  logic [3:0] b_sw,
    output logic       h_sync,
    output logic       v_sync
);
    //wire list
    logic DE;
    logic [9:0] x_pixel;
    logic [9:0] y_pixel;
    logic [15:0] data;
    logic [16:0] addr;
    logic pclk;
    logic [3:0] r_port_i, g_port_i, b_port_i;
    logic [3:0] r_port_gray, g_port_gray, b_port_gray;

    VGA_Decoder u_VGA_Decoder (.*);

    ImgROM u_ImgROM (
        .clk(pclk),
        .*
    );

    imgReader u_imgReader (
        .*,
        .x     (x_pixel),
        .y     (y_pixel),
        .r_port(r_port_i),
        .g_port(g_port_i),
        .b_port(b_port_i)
    );

    // RGB_Control_Filter u_RGB_Control_Filter (
    //     .r_port  (r_port_i),
    //     .g_port  (g_port_i),
    //     .b_port  (b_port_i),
    //     .*,
    //     .r_f_port(r_port),
    //     .g_f_port(g_port),
    //     .b_f_port(b_port)
    // );

    mux_2x1 u_mux_2x1 (
        .sel  (filter_mode_sw),
        .rgb_a({r_port_i, g_port_i, b_port_i}),
        .rgb_b({r_port_gray, g_port_gray, b_port_gray}),
        .rgb  ({r_port, g_port, b_port})
    );

    Grayscalefilter u_Grayscalefilter (
        .i_r(r_port_i),
        .i_g(g_port_i),
        .i_b(b_port_i),
        .o_r(r_port_gray),
        .o_g(g_port_gray),
        .o_b(b_port_gray)
    );

endmodule

module mux_2x1 (
    input  logic        sel,
    input  logic [11:0] rgb_a,
    input  logic [11:0] rgb_b,
    output logic [11:0] rgb
);

    always_comb begin
        case (sel)
            1'b0: rgb = rgb_a;
            1'b1: rgb = rgb_b;
        endcase
    end
endmodule
