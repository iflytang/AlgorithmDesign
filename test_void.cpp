//
// Created by tsf on 18-3-31.
//

#include <iostream>
#include <vector>
#include <cstring>
#include <netinet/in.h>

using namespace std;

int main() {

    int num = 1;
    char str = 'b';

    /* define two void pointer */
    void * void_pointer1;
    void * void_pointer2;

    /* void pointer points to different pointer */
    void_pointer1 = &num;
    void_pointer2 = &str;

    /* first type conversion, then pointer reference*/
    cout << "void_pointer1: value = " << *((int *) void_pointer1) << endl;
    cout << "void_pointer2: value = " << *((char *) void_pointer2) << endl;

    /* void pointer can point to any data type */
    void_pointer2 = &num;
    cout << "void_pointer1: value = " << *((int *) void_pointer2) << endl;

    uint32_t increment = 0x0fffffff;
    int inc = (int) increment;
    uint16_t a = 12;
    uint64_t b = 0x9922334455667788;
    a += increment;
    printf("a:0x%lx\n", b);
    cout << "a: " << a << ", increment: " << increment << ", inc: " << inc << endl;

    int value[8][16];
    memset(value[0], 0x00, sizeof(value[0]));
    cout << "size:" << sizeof(value[0]) << endl;
    value[0][0] = 65535;
    for (int i = 0; i < 16; i++) {
        cout << value[0][i] << "\t";
    }
    cout << endl;
    int *lowest_byte = value[0] + 1;
    *lowest_byte += 2;
    cout << "lowest_byte:" << *lowest_byte << endl;
    for (int i = 0; i < 16; i++) {
        cout << value[0][i] << "\t";
    }
    cout << endl;

    enum test {
        alice,
        bob,
        car
    };
    int enum_test = bob;
    cout << enum_test << endl;

    cout << htons(13) << endl;

    return 0;
}