`timescale 1ns / 1ps

class BMP_File;
    byte bmp_total[640*480*3+54];  // 이미지 size + 해더 size
    byte bmp_header[54];
    byte bmp_data[640*480*3];
    int SrcfileID, readSize, trgfileID;

    int bmp_size, bmp_data_offset, bmp_width, bmp_height, biBitCount;
    string sourceFileName = "csh_640x480.bmp";
    string targetFileName = "copy.bmp";

    function new();

    endfunction  //new()

    task readFileHeader();
        readSize = $fread(bmp_total, SrcfileID);
        $fclose(SrcfileID);
        $display("[%s] read size : %0d", sourceFileName, readSize);


        bmp_size = {
            bmp_total[5], bmp_total[4], bmp_total[3], bmp_total[2]
        };  // bmp의 size 정보
        $display("[%s] bmp size : %0d", sourceFileName, bmp_size);

        bmp_data_offset = {
            bmp_total[13], bmp_total[12], bmp_total[11], bmp_total[10]
        };  // 이미지 데이터 주소 오프셋
        $display("[%s] bmp image offset : %0d", sourceFileName,
                 bmp_data_offset);

        bmp_width = {
            bmp_total[21], bmp_total[20], bmp_total[19], bmp_total[18]
        };
        bmp_height = {
            bmp_total[25], bmp_total[24], bmp_total[23], bmp_total[22]
        };
        $display("[%s] bmp img %0d x %0d", sourceFileName, bmp_width,
                 bmp_height);

        biBitCount = {bmp_total[29], bmp_total[28]};  //픽셀당 비트 수
        $display("[%s] bmp bit %0d", sourceFileName, biBitCount);

        if (biBitCount != 24) begin
            $display("[%s] biBitCount need to be 24bit", sourceFileName);
            $finish;
        end

        if (bmp_width % 4) begin
            $display("[%s] bmp width %% 4 need to be zero!", sourceFileName);
            $finish;
        end
    endtask

    task OpenBMP();

        SrcfileID = $fopen(sourceFileName, "rb");

        if (!SrcfileID) begin
            $display("Open %s BMP File Error!", sourceFileName);
            $finish;
        end
    endtask

    task copyHeader();
        //copy header
        for (int i = 0; i < bmp_data_offset; i++) begin
            bmp_header[i] = bmp_total[i];
        end
    endtask

    task copyData();
        //copy image
        for (int i = bmp_data_offset; i < bmp_size; i++) begin
            bmp_data[i-bmp_data_offset] = bmp_total[i];
        end
    endtask


    task WriteBMP();
        trgfileID = $fopen(targetFileName, "wb");

        for (int i = 0; i < bmp_data_offset; i++) begin
            $fwrite(trgfileID, "%c", bmp_header[i]);
        end

        for (int i = 0; i < bmp_size - bmp_data_offset; i++) begin
            $fwrite(trgfileID, "%c", bmp_data[i]);
        end
        $fclose(trgfileID);
        $display("Write BMP File Done!");
    endtask
endclass  //BMP_File

module tb_VGA ();
    BMP_File bmp_img;

    initial begin
        bmp_img = new();

        bmp_img.OpenBMP();
        bmp_img.readFileHeader();
        bmp_img.copyHeader();
        bmp_img.copyData();
        bmp_img.WriteBMP();
        #50;
        $finish;
    end
endmodule
