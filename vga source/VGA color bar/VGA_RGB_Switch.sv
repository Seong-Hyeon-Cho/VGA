`timescale 1ns / 1ps

module VGA_RGB_Switch (
    input  logic [3:0] sw_red,
    input  logic [3:0] sw_green,
    input  logic [3:0] sw_blue,
    input  logic       DE,
    input  logic [9:0] x_pixel,
    input  logic [9:0] y_pixel,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
);

    // always_comb begin
    //     if (DE) begin
    //         if((x_pixel >= 0 & x_pixel < 92) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 255;
    //             g_port = 255;
    //             b_port = 255;
    //         end else if((x_pixel >= 92 & x_pixel < 184) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 255;
    //             g_port = 255;
    //             b_port = 0;
    //         end else if((x_pixel >= 184 & x_pixel < 276) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 0;
    //             g_port = 255;
    //             b_port = 255;
    //         end else if((x_pixel >= 276 & x_pixel < 368) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 0;
    //             g_port = 255;
    //             b_port = 0;
    //         end else if((x_pixel >= 368 & x_pixel < 460) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 255;
    //             g_port = 0;
    //             b_port = 255;
    //         end else if((x_pixel >= 460 & x_pixel < 552) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 255;
    //             g_port = 0;
    //             b_port = 0;
    //         end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 0 & y_pixel < 360)) begin
    //             r_port = 0;
    //             g_port = 0;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 0 & x_pixel < 92) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 0;
    //             g_port = 0;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 92 & x_pixel < 184) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 0;
    //             g_port = 0;
    //             b_port = 4'h0;
    //         end else if((x_pixel >= 184 & x_pixel < 276) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 4'hf;
    //             g_port = 0;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 276 & x_pixel < 368) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 0;
    //             g_port = 0;
    //             b_port = 0;
    //         end else if((x_pixel >= 368 & x_pixel < 460) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 0;
    //             g_port = 4'hf;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 460 & x_pixel < 552) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 0;
    //             g_port = 0;
    //             b_port = 0;
    //         end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 360 & y_pixel < 390)) begin
    //             r_port = 4'hf;
    //             g_port = 4'hf;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 0 & x_pixel < 115) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'h0;
    //             g_port = 4'h0;
    //             b_port = 4'd102;
    //         end else if((x_pixel >= 115 & x_pixel < 230) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'hf;
    //             g_port = 4'hf;
    //             b_port = 4'hf;
    //         end else if((x_pixel >= 230 & x_pixel < 345) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'd76;
    //             g_port = 4'h0;
    //             b_port = 4'd153;
    //         end else if((x_pixel >= 345 & x_pixel < 460) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'd33;
    //             g_port = 4'd33;
    //             b_port = 4'd33;
    //         end else if((x_pixel >= 460 & x_pixel < 491) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'h0;
    //             g_port = 4'h0;
    //             b_port = 4'h0;
    //         end else if((x_pixel >= 491 & x_pixel < 522) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'd40;
    //             g_port = 4'd40;
    //             b_port = 4'd40;
    //         end else if((x_pixel >= 522 & x_pixel < 552) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'd80;
    //             g_port = 4'd80;
    //             b_port = 4'd80;
    //         end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 390 & y_pixel < 480)) begin
    //             r_port = 4'h0;
    //             g_port = 4'h0;
    //             b_port = 4'h0;
    //         end else begin
    //             r_port = 4'h0;
    //             g_port = 4'h0;
    //             b_port = 4'h0;
    //         end
    //     end
    // end
    assign r_port = DE ? sw_red : 4'b0;
    assign g_port = DE ? sw_green : 4'b0;
    assign b_port = DE ? sw_blue : 4'b0;
endmodule
