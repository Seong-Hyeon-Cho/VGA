`timescale 1ns / 1ps

module VGA_ColorBar(
    input  logic       DE,
    input  logic [9:0] x_pixel,
    input  logic [9:0] y_pixel,
    output logic [3:0] r_port,
    output logic [3:0] g_port,
    output logic [3:0] b_port
    );

    always_comb begin
        if (DE) begin
            if((x_pixel >= 0 & x_pixel < 92) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 255;
                g_port = 255;
                b_port = 255;
            end else if((x_pixel >= 92 & x_pixel < 184) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 255;
                g_port = 255;
                b_port = 0;
            end else if((x_pixel >= 184 & x_pixel < 276) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 0;
                g_port = 255;
                b_port = 255;
            end else if((x_pixel >= 276 & x_pixel < 368) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 0;
                g_port = 255;
                b_port = 0;
            end else if((x_pixel >= 368 & x_pixel < 460) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 255;
                g_port = 0;
                b_port = 255;
            end else if((x_pixel >= 460 & x_pixel < 552) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 255;
                g_port = 0;
                b_port = 0;
            end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 0 & y_pixel < 360)) begin
                r_port = 0;
                g_port = 0;
                b_port = 4'hf;
            end else if((x_pixel >= 0 & x_pixel < 92) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 0;
                g_port = 0;
                b_port = 4'hf;
            end else if((x_pixel >= 92 & x_pixel < 184) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 0;
                g_port = 0;
                b_port = 4'h0;
            end else if((x_pixel >= 184 & x_pixel < 276) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 4'hf;
                g_port = 0;
                b_port = 4'hf;
            end else if((x_pixel >= 276 & x_pixel < 368) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 0;
                g_port = 0;
                b_port = 0;
            end else if((x_pixel >= 368 & x_pixel < 460) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 0;
                g_port = 4'hf;
                b_port = 4'hf;
            end else if((x_pixel >= 460 & x_pixel < 552) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 0;
                g_port = 0;
                b_port = 0;
            end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 360 & y_pixel < 390)) begin
                r_port = 4'hf;
                g_port = 4'hf;
                b_port = 4'hf;
            end else if((x_pixel >= 0 & x_pixel < 115) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'h0;
                g_port = 4'h0;
                b_port = 4'd6;
            end else if((x_pixel >= 115 & x_pixel < 230) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'hf;
                g_port = 4'hf;
                b_port = 4'hf;
            end else if((x_pixel >= 230 & x_pixel < 345) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'd2;
                g_port = 4'h0;
                b_port = 4'd4;
            end else if((x_pixel >= 345 & x_pixel < 460) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'd3;
                g_port = 4'd3;
                b_port = 4'd3;
            end else if((x_pixel >= 460 & x_pixel < 491) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'h0;
                g_port = 4'h0;
                b_port = 4'h0;
            end else if((x_pixel >= 491 & x_pixel < 522) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'd4;
                g_port = 4'd4;
                b_port = 4'd4;
            end else if((x_pixel >= 522 & x_pixel < 552) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'd6;
                g_port = 4'd6;
                b_port = 4'd6;
            end else if((x_pixel >= 552 & x_pixel < 640) && (y_pixel >= 390 & y_pixel < 480)) begin
                r_port = 4'h0;
                g_port = 4'h0;
                b_port = 4'h0;
            end else begin
                r_port = 4'h0;
                g_port = 4'h0;
                b_port = 4'h0;
            end
        end
    end
endmodule
