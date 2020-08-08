/**
 * @author tsf
 * @date 20-7-22.
 */

#include<stdio.h>
#include<stdlib.h>
#include <stdint.h>
#include <zconf.h>

int main() {

    FILE *fp = fopen("/home/tsf/CLionProject/File/Traffic-test-001.txt", "r");
    if (fp == NULL) {
        printf("error");
        return 0;
    }

    float trace;
    long cnt = 0;

    while (fscanf(fp, "%f", &trace) != EOF) {
//        rewind(fp);
        printf("%ld, %f\n", cnt, trace);
        cnt++;
        sleep(1);
    }
    fclose(fp);

}