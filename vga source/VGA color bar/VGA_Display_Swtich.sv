`timescale 1ns / 1ps

module VGA_Display_Swtich (
    input  logic       clk,
    input  logic       reset,
    input  logic       sw_mode,
    input  logic [3:0] sw_red,
    input  logic [3:0] sw_green,
    input  logic [3:0] sw_blue,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port,
    output logic       h_sync,
    output logic       v_sync
);
    //wire list
    logic DE;
    logic [9:0] x_pixel;
    logic [9:0] y_pixel;
    logic [3:0] sw_r, sw_g, sw_b;
    logic [3:0] bar_r, bar_g, bar_b;

    VGA_Decoder u_VGA_Decoder (.*);

    VGA_RGB_Switch u_VGA_RGB_Switch (
        .*,
        .r_port(sw_r),
        .g_port(sw_g),
        .b_port(sw_b)
    );

    VGA_ColorBar u_VGA_ColorBar (
        .*,
        .r_port(bar_r),
        .g_port(bar_g),
        .b_port(bar_b)
    );

    mux_2x1 u_mux_2x1 ( // 스위치로 원하는 화면 출력
        .sel  (sw_mode),
        .rgb_a({sw_r, sw_g, sw_b}),     // sw color
        .rgb_b({bar_r, bar_g, bar_b}),    //color bar
        .rgb  ({r_port, g_port, b_port})
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
