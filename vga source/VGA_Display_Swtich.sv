`timescale 1ns / 1ps

module VGA_Display_Swtich (
    input  logic       clk,
    input  logic       reset,
    // input  logic [3:0] sw_red,
    // input  logic [3:0] sw_green,
    // input  logic [3:0] sw_blue,
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

    VGA_Decoder u_VGA_Decoder (
        .*
        // .sw_red  (),
        // .sw_green(),
        // .sw_blue ()
    );

    VGA_RGB_Switch u_VGA_RGB_Switch (.*);
endmodule
