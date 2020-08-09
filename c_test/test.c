//
// Created by tsf on 18-3-19.
//

#include<stdio.h>
#include<stdlib.h>
#include <stdint.h>
#include <math.h>

#define ONE_SECOND_IN_US           1000000.0   // us
#define TIME_WRITE_THRESH          49999.0     // us, can be adjusted
#define BD_WIN_NUM   (int) ceil(ONE_SECOND_IN_US / TIME_WRITE_THRESH)

int main() {
   /* int a, b;

    a = 12;
    b = 1;

    if (a < b)
        goto test;

    printf("brefore test\n");

    test:
        printf("this is test\n");
*/


    uint8_t v0 = 0x0f;
    uint8_t v1 = 0xff;

    uint16_t controller_mapInfo = (v0 << 8) + v1;
    printf("controller: %04x\n", controller_mapInfo);

    float bd[BD_WIN_NUM];
    printf("bd_win: %d\n", BD_WIN_NUM);


    typedef struct struct_bd_to_dl_info {
        float bandwidth[3];
        int num;
    } bd_to_dl_info_t;
    bd_to_dl_info_t bd_to_dl_info = {0};

    printf("%f %f %f %d\n", bd_to_dl_info.bandwidth[0], bd_to_dl_info.bandwidth[1], bd_to_dl_info.bandwidth[2], bd_to_dl_info.num);

    float a1 = 1.12345678f, a;
    float i = 4;
    a = (int)(pow(10, i) * a1 + 0.5) / pow(10, i);
    printf("%f\n", a);
    a = (int)(1000.0 * a1 + 0.5) / 1000.0;
    printf("%f\n", a);
    a = round(a1 * 10000.0) / 10000.0;
    printf("%f\n", a);

    return 0;
}
