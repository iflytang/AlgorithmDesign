//
// Created by tsf on 18-3-19.
//

#include<stdio.h>
#include<stdlib.h>

int main() {
    int a, b;

    a = 12;
    b = 1;

    if (a < b)
        goto test;

    printf("brefore test\n");

    test:
        printf("this is test\n");

    return 0;
}
