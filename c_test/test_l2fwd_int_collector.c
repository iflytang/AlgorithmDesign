//
// Created by tsf on 20-6-22.
//

#include<stdio.h>
#include<stdlib.h>
#include <stdint.h>

int main() {


    uint32_t switch_id = 1;
    uint32_t x = 0xff000000 & switch_id;

    if (x == 0x00) {
        printf("%x\n", x);
    }

    switch_id = 0x8000008a;
    enum SWITCH_TYPE {
        OVS_POF = 0,
        TOFINO = 1
    };
    uint64_t bos_bit[2] = {0xffffffffffffffff, 0x000000007fffffff};
    x = switch_id & bos_bit[OVS_POF];
    printf("%x\n", x);
    x = switch_id & bos_bit[TOFINO];
    printf("%x\n", x);
    uint64_t n_packets = 0x1122334455667788;
    uint64_t x2 = n_packets & bos_bit[TOFINO];
    printf("%lx\n", x2);
//    float bandwidth = (0.234 & bos_bit[OVS_POF]);
//    printf("%f\n", bandwidth);

    uint32_t test = 0x00000001;
    test |= 0x00000040;
    printf("%08x\n", test);




    return 0;
}
