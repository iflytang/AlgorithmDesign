/**
* @author tsf
* @date 18-10-9
* @desc
*/


#include <iostream>
#include <cstring>

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

int main() {

    double test_double = 97.988;
    int offset = 8;

    printf("test_double_to_arr:\n");
    test_double_to_byte_arr(test_double, offset);

    int test_int = 1234;

    printf("\n\ntest_int_to_arr:\n");
    test_int_to_byte_arr(test_int, offset);

    uint8_t test[8] = {0x99, 0x81, 0xca, 0xf8, 0xf7, 0x19, 0xb7, 0x3f};
    double dst;
    memcpy(&dst, test, 8);
    printf("\n%lf", dst);

    return 0;
}