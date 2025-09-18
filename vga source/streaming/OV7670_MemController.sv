`timescale 1ns / 1ps

module OV7670_MemController (
    input  logic        clk,
    input  logic        reset,
    input  logic        href,
    input  logic        vsync,
    input  logic [ 7:0] ov7670_data,
    output logic        we,
    output logic [16:0] wAddr,
    output logic [15:0] wData
);
    // 입력은 30hz, 출력은 60hz
    logic [15:0] pixel_data;
    logic [ 9:0] h_counter;  // 320 * 2 = 640 (320 pixel) 1픽셀당 2바이트 색정보 들어있음(RGB 565)
    logic [ 7:0] v_counter;  // 240 line

    assign wAddr = v_counter * 320 + h_counter[9:1]; // 주소 = 픽셀의 위치 좌표 정보
    // 2byte당 1픽셀의 정보이므로 2인덱스씩 묶음(절반만 가져온다 -> 나누기 2 == 최하위 비트 제거)
    assign wData = pixel_data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            h_counter  <= 0;
            pixel_data <= 0;
            we         <= 1'b0;
        end else begin
            if (href) begin // 1 line의 유효 데이터
                h_counter <= h_counter + 1;
                if (!h_counter[0]) begin
                    pixel_data[15:8] <= ov7670_data;
                    we <= 1'b0;
                end else begin
                    pixel_data[7:0] <= ov7670_data;
                    we <= 1'b1;
                end
            end else begin
                h_counter <= 0;
                we        <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            v_counter <= 0;
        end else begin
            if (vsync) begin
                v_counter <= 0;
            end else begin
                if (h_counter == 320*2 - 1) begin // 1 line 끝
                    v_counter <= v_counter + 1;
                end
            end
        end
    end
endmodule
