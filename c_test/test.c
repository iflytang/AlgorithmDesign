//
// Created by tsf on 18-3-19.
//

#include<stdio.h>
#include<stdlib.h>
#include <stdint.h>

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

    uint16_t controller_mapInfo = v0 << 8 + v1;
    printf("controller: %04x\n", controller_mapInfo);


    return 0;
}
