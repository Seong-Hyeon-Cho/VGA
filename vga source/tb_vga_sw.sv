`timescale 1ns / 1ps

module tb_vga_sw ();
    logic       clk;
    logic       reset;
    logic [3:0] sw_red;
    logic [3:0] sw_green;
    logic [3:0] sw_blue;
    logic [3:0] r_port;
    logic [3:0] g_port;
    logic [3:0] b_port;
    logic       h_sync;
    logic       v_sync;

    VGA_Display_Swtich dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #20;
        reset = 0;
        #10;
        sw_red   = 4'hf;
        sw_green = 4'hf;
        sw_blue  = 4'hf;
    end
endmodule
