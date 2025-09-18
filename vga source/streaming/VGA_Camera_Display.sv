`timescale 1ns / 1ps

module VGA_Camera_Display (
    input  logic       clk,
    input  logic       reset,
    // ov7670 side
    input  logic       ov7670_pclk,
    input  logic       ov7670_href,
    input  logic       ov7670_vsync,
    input  logic [7:0] ov7670_data,
    output logic       ov7670_xclk,
    // external port
    input  logic       sw_mode,
    output logic       vga_h_sync,
    output logic       vga_v_sync,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);

    // wire list
    logic        we;
    logic [16:0] wAddr;
    logic [15:0] wData;
    logic        vga_pclk;
    logic [ 9:0] vga_x_pixel;
    logic [ 9:0] vga_y_pixel;
    logic        vga_DE;
    logic        ov7670_we;
    logic [16:0] ov7670_wAddr;
    logic [15:0] ov7670_wData;
    logic        vga_den;
    logic [16:0] vga_rAddr;
    logic [15:0] vga_rData;
    logic [3:0] vga_r, gray_r;
    logic [3:0] vga_g, gray_g;
    logic [3:0] vga_b, gray_b;

    assign ov7670_xclk = vga_pclk;

    VGA_Decoder u_VGA_Decoder (
        .*,
        .pclk   (vga_pclk),
        .h_sync (vga_h_sync),
        .v_sync (vga_v_sync),
        .x_pixel(vga_x_pixel),
        .y_pixel(vga_y_pixel),
        .DE     (vga_DE)
    );

    OV7670_MemController u_OV7670_MemController (
        .clk        (ov7670_pclk),
        .reset      (reset),
        .href       (ov7670_href),
        .vsync      (ov7670_vsync),
        .ov7670_data(ov7670_data),
        .we         (ov7670_we),
        .wAddr      (ov7670_wAddr),
        .wData      (ov7670_wData)
    );

    frame_buffer u_frame_buffer (
        //write side
        .wclk (ov7670_pclk),
        .we   (ov7670_we),
        .wAddr(ov7670_wAddr),
        .wData(ov7670_wData),
        // read side
        .rclk (vga_pclk),
        .oe   (vga_den),
        .rAddr(vga_rAddr),
        .rData(vga_rData)
    );

    VGA_MemController u_VGA_MemController (
        // VGA side
        .DE     (vga_DE),
        .x_pixel(vga_x_pixel),
        .y_pixel(vga_y_pixel),
        // frame buffer side
        .den    (vga_den),
        .rAddr  (vga_rAddr),
        .rData  (vga_rData),
        //export side
        .r_port (vga_r),
        .g_port (vga_g),
        .b_port (vga_b)
    );
    Grayscalefilter u_Grayscalefilter (
        .i_r(vga_r),
        .i_g(vga_g),
        .i_b(vga_b),
        .o_r(gray_r),
        .o_g(gray_g),
        .o_b(gray_b)
    );
    mux_2x1 u_mux_2x1 (
        .sel     (sw_mode),
        .vga_rgb ({vga_r, vga_g, vga_b}),
        .gray_rgb({gray_r, gray_g, gray_b}),
        .rgb     ({r_port, g_port, b_port})
    );
endmodule

module mux_2x1 (
    input logic sel,
    input logic [11:0] vga_rgb,
    input logic [11:0] gray_rgb,
    output logic [11:0] rgb
);

    always_comb begin
        case (sel)
            1'b0: rgb = vga_rgb;
            1'b1: rgb = gray_rgb;
        endcase
    end
endmodule
