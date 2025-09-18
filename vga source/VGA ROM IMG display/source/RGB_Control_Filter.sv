`timescale 1ns / 1ps

module RGB_Control_Filter (
    input  logic [3:0] r_port,
    input  logic [3:0] g_port,
    input  logic [3:0] b_port,
    input  logic       r_sw_mode,
    input  logic       g_sw_mode,
    input  logic       b_sw_mode,
    input  logic [3:0] r_sw,
    input  logic [3:0] g_sw,
    input  logic [3:0] b_sw,
    output logic [3:0] r_f_port,
    output logic [3:0] g_f_port,
    output logic [3:0] b_f_port
);

    always_comb begin
        case (r_sw_mode)
            1'b0: r_f_port = r_port;
            1'b1: r_f_port = r_sw;
        endcase
        case (g_sw_mode)
            1'b0: g_f_port = g_port;
            1'b1: g_f_port = g_sw;
        endcase
        case (b_sw_mode)
            1'b0: b_f_port = b_port;
            1'b1: b_f_port = b_sw;
        endcase
    end

endmodule
