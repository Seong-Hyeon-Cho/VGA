`timescale 1ns / 1ps

module ImgROM (
    input  logic                       clk,
    // 전체 픽셀 수 만큼 주소 필요
    input  logic [$clog2(320*240)-1:0] addr,  //qv
    output logic [               15:0] data
);

    logic [15:0] mem[0:320*240-1];  // 전체 픽셀 수 만큼 메모리

    initial begin
        // $readmemh("Lenna.mem", mem);
        $readmemh("img.mem", mem);
    end

    // 주소 = 픽셀의 위치 좌표
    // addr = 640*y + x

    // assign data = mem[addr]; // 비동기식 회로 -> LUT회로 다수 차지

    always_ff @(posedge clk ) begin
        data <= mem[addr];
    end // 클럭 동기식 회로 -> BRAM 회로 생성
    // BRAM 생성 조건
    // clock 신호 동기화 되고, read/write를 clock동기 신호에 동작

    // 카메라로 들어오는 데이터가 계속 주기적으로 업데이트 되고 그것을 주기적으로 계속 출력하면 => 동영상
endmodule
