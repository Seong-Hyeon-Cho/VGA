`timescale 1ns / 1ps

module imgReader (
    input  logic        DE,
    input  logic [ 9:0] x,
    input  logic [ 9:0] y,
    output logic [16:0] addr,
    input  logic [15:0] data,
    output logic [ 3:0] r_port,
    output logic [ 3:0] g_port,
    output logic [ 3:0] b_port
);  // 좌표 값을 받고 계산후 주소값으로 출력, ROM의 데이터를 받고 rgb 분배 출력

logic img_show;
    // assign addr   = DE ? (640 * y + x) : 19'bz;
    // assign addr   = DE ? (320 * y + x) : 19'bz; // 너무 큰 사이즈라서 절반으로 나눔
    assign img_show = (DE && (x < 320) && (y < 240));
    assign addr   =  img_show ? (320*y + x) : 17'bz; // overflow 처리

    // rgb 565 format
    // assign r_port = DE ? data[15:12] : 4'b0;
    // assign g_port = DE ? data[10:7] : 4'b0;
    // assign b_port = DE ? data[4:1] : 4'b0;
    // rgb의 상위비트에 빛 정보가 더 많으므로 상위비트를 우선순위로 가져옴
    assign r_port = img_show ? data[15:12] : 4'b0;
    assign g_port = img_show ? data[10:7] : 4'b0;
    assign b_port = img_show ? data[4:1] : 4'b0;
endmodule
