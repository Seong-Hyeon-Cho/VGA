# VGA 
##  Video Graphics Array 
 - 비디토 출력 장치를 연결하는 표준 인터페이스
 - CRT의 주사 개념을 이용한 그래픽 표현 방식
 - 실제 표시되는 해상도 영역보다 더 큰 구역에 Porch 구간(Display 하지 않는 구간)을 두어 한 line 끝에서 왼쪽으로, 한 frame 끝에서 다시 맨 위로 되돌아오는 동안 화면이 안나오게 함    --> 화면을 안정화시키고 기준을 잡기 용이         

![Image](https://github.com/user-attachments/assets/7eadfa60-688f-4671-95fd-d9a456c667ef)
-----------------------------
---------------------------------
 - Sync의 위치를 조절함에 따라 Display의 위치를 조정할 수 있다.
![Image](https://github.com/user-attachments/assets/dd2baf99-c15b-429b-a120-e09dc0f994be)

 - 해상도: 640 x 480, 주사율: 60Hz 기준 Signal Timing
![Image](https://github.com/user-attachments/assets/985b3aea-9168-4652-885f-d9a8cebb1b61)
 - Synch : 1Line 또는 1Frame이 끝났음을 알리는 신호 -> retrace 시작
 - Blanking Interval : retrace 시간동안 display하지 않는 시간

----------------------------------------------------------------
### 기본 VGA 블럭 다이어그램
- 25MHz 클럭마다 픽셀을 카메라로 받는 rgb로 표현하게 됩니다.
![Image](https://github.com/user-attachments/assets/065ec26a-41a1-4b78-8200-f96c1127bb2c)
사용된 보드 : digilent Basys3, STM32 NUCLEO-F401RE 카메라 : OV7670   <br>
- Mux를 통해 display하는 화면을 전환합니다.
color bar 대신에 Filter를 넣게 된다면 Filter 처리된 화면이 출력하게 됩니다.
![Image](https://github.com/user-attachments/assets/3cbe97fd-ec57-484b-8c9f-9c76c6b04c23)
> 컬러바 실습 사진
![Image](https://github.com/user-attachments/assets/efa48fc2-aebb-4617-9a05-ec3437273e63)


- ROM에 사진의 BMP형식의 데이터를 저장하고 display할때 ROM의 사진 데이터를 가져옵니다.
<img width="966" height="581" alt="Image" src="https://github.com/user-attachments/assets/31909715-12e7-46d7-9adb-15e2eb9ca9b3" />
> 실습 사진
    - gray filter를 추가적으로 거친 이미지 출력

![Image](https://github.com/user-attachments/assets/005e8e92-8e78-446f-9c98-5a75af9d3844)
---------------------------------------
## 번외 : BMP
- 비트맵 디지털 그림을 저장하는 데 쓰이는 그림 파일 포맷
- 특징
    - 비압축, 비손실 형식: BMP 파일은 데이터를 압축하지 않아 이미지 품질이 높고 왜곡이 없으며, 편집이 용이 
    - 고품질 이미지: 정교한 컬러 사진과 같은 복잡한 이미지를 고품질로 저장하는 데 이상적 
    - 큰 파일 크기: 비압축 방식, JPEG나 GIF와 같은 다른 이미지 파일 형식에 비해 파일 크기가 매우 큼 
    - 넓은 호환성: Windows 운영체제에서 널리 사용되었으며, 다양한 이미지 편집 프로그램(Adobe Photoshop, Windows Photos 등)에서 지원 가능

### BMP의 헤더 구조(핵심 데이터만 표기)
| 오프셋(16진수) | 크기(바이트) | 설명 |
|--------|---------|----------|
|   BMP 헤더    |
|02|2|BMP 파일 크기(54bye 헤더 + 16byte 데이터)|
|0A|4|비트맵 데이터를 찾을 수 있는 오프셋|
|   DIB 헤더    |
|12|4|비트맵의 너비(픽셀 단위)|
|16|4|비트맵의 높이(픽셀 단위)|
|1C|2|픽셀당 비트 수|

-------------------------------------
## 실제 실시간 영상 Display
### Block Diagram
![Image](https://github.com/user-attachments/assets/a83b397d-6f4f-49b2-8a7d-107815cb872e)
- 1Frame씩 Buffer를 통과하여 화면에 Display 되는 구조

> 실습 사진
![Image](https://github.com/user-attachments/assets/877c3397-60b8-4752-a36e-3669dbbf7ac4)