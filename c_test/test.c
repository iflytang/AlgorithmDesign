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

static double dBm_to_Pmw(double dBm) {
    double Pmw = pow(10.0, dBm / 10.0);
    return Pmw;
}

static double Pmw_to_dBm(double Pmw) {
    double dBm = 10.0 * log10(Pmw);
    return dBm;
}

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

    int swid = 0xffffff01;
    printf("test_swid: %x\n", (0xff000000 & swid));

    double x = 12.12345;
    printf("x: %d\n", (int) (0.05/0.02));
    printf("ceil_x: %d\n", (int) ceil(0.05/0.02));

    double dBm_arr[4] = {-67.7, -68.3, -68.9, -69.3};
    double Pmw_sum = 0, dBm_sum = 0;
    int idx = 0;
    for (; idx < 4; idx++) {
        Pmw_sum += dBm_to_Pmw(dBm_arr[idx]);
    }
    dBm_sum = Pmw_to_dBm(Pmw_sum);
    printf("Pmw_sum: %lf, dBm_sum: %lf\n", Pmw_sum, dBm_sum);



    return 0;
}
