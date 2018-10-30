/**
* @author tsf
* @date 18-10-9
* @desc
*/


#include <iostream>
#include <cstring>
#include <netinet/in.h>

using namespace std;

void test_double_to_byte_arr(double double_, int offset) {
    double src = double_;
    double dst;
    unsigned char s[32];

    printf("%lf\n", src);

    for (int i=0; i < sizeof(double); i++) {
        printf("%.2x\t", s[i]);
    }
    printf("\n");

    // convert to byte array
    memcpy(s+offset, &src, sizeof(double));

    for (int i=0; i < sizeof(double); i++) {
        printf("%x\t", s[offset+i]);
    }

    // convert back to double
    memcpy(&dst, s+offset, sizeof(double));
    printf("\n%lf", dst);
}

void test_int_to_byte_arr(int int_, int offset) {
    int src = int_;
    int dst;
    unsigned char s[32];

    printf("%d\n", src);

    for (int i=0; i < sizeof(int); i++) {
        printf("%.2x\t", s[i]);
    }
    printf("\n");

    // convert to byte array
    memcpy(s+offset, &src, sizeof(int));

    for (int i=0; i < sizeof(int); i++) {
        printf("%.2x\t", s[offset+i]);
    }

    // convert back to int
    memcpy(&dst, s+offset, sizeof(int));
    printf("\n%d", dst);
}

int sum = 0;
void Add(int para) {
    sum += para;
    printf("\n%d %d", para, sum);
}

int main() {

    double test_double = 97.988;
    int offset = 8;

//    printf("test_double_to_arr:\n");
//    test_double_to_byte_arr(test_double, offset);

    int test_int = 0x1234;

//    printf("\n\ntest_int_to_arr:\n");
//    test_int_to_byte_arr(test_int, offset);

    uint8_t test[4] = {0x52, 0x49, 0x9d, 0x3d};
    float dst;
    memcpy(&dst, test, 4);
    printf("\n%f %u\n", dst, 0xffff);

    uint8_t test_int_arr[8] ={0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x12};
    memcpy(test_int_arr, &test_int, sizeof(test_int));
    for(int i=0; i<8; i++) {
        printf("%x \t", test_int_arr[i]);
    }
    uint32_t *uint32 = (uint32_t *)(test_int_arr);
    printf("\nuint32: %x\n", ntohl(*(uint32+1)));
    uint16_t uint16 = 0x1122;
    *uint32 = uint16;
    *uint32 = htonl(*uint32);
    for(int i=0; i<8; i++) {
        printf("%x \t", test_int_arr[i]);
    }


    return 0;
}