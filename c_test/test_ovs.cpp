//
// Created by tsf on 18-4-17.
//

#include <iostream>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <evutil.h>


using namespace std;

#define IMMEDIATE (0)
#define FIELD (1)

/* condition compile */
//#define TEST_ARRAY_COPY
//#define TEST_MOMMOVE
//#define TEST_UNION
//#define TEST_CONSOLE_PARA
#define TEST_STRUCT_INIT


int main(int argc, char * argv[]) {

    /* test array copy. */
#ifdef TEST_ARRAY_COPY
    int src_value[16];
    uint8_t dst_value[16];
    for (int i=0; i<8; i++) {
        dst_value[i] = i * 0x11;
    }
    for (int i=8; i<16; i++) {
        dst_value[i] = i * 0x11;
    }
    memcpy(src_value, dst_value, sizeof(dst_value));
    for (int i=0; i<16; i++) {
        cout << dst_value[i] << "\t";
    }
    cout << endl;

    struct match {
        uint32_t match_x;
    };
    struct match *match = (struct match *) dst_value;
    printf("match_x: %x\n", match->match_x);


    /* test print array once */
    uint64_t *s1 = (uint64_t *) dst_value;
    uint64_t *s2 = (uint64_t *) (dst_value + 8);
    printf("s1:%lx", *s2);
    printf("s2%lx\n", *s1);
#endif

#ifdef TEST_MOMMOVE
    /* test memmove */
    char str[] = "memmove can be very useful.";
    cout << "original str: " << str << endl << "memmoved str: ";
    memmove(str+8, str+15, 4);
    puts(str);
#endif

#ifdef TEST_UNION
    uint16_t len_type = 1;
    switch(len_type) {
        case IMMEDIATE :
            cout << "IMMEDIATE" << endl;
            break;
        case FIELD:
            cout << "FIELD" << endl;
            break;
    }

    printf("0x%04x 0x%04x\n", len_type, htons(len_type));

    char * len_type_str[2] = {"POFVT_IMMEDIATE_NUM", "POFVT_FIELD"};
    cout << len_type_str[0] << endl << len_type_str[1] << endl;

    union test {
        int a;
        char b;
    };
    cout << sizeof (test) << endl;

    uint32_t len_32 = 32;
    uint16_t len_16 = htons(len_32);
    cout << "len_32:" << len_32 << " len_16:" << ntohs(len_16) << endl;
#endif

#ifdef TEST_CONSOLE_PARA
    for (int i = 0; i < argc; i++)
        cout << "argv[" << i <<"]: " << argv[i] << endl;
#endif

#ifdef TEST_STRUCT_INIT
    struct test {
        int a;
        int b;
        char *c;
    };

    struct test test;
    test = {
            .a = 1,
            .b = 2,
            .c = "iflytang",
    };
    cout << test.a << "\t" << test.b << "\t" << test.c << endl;
#endif

    return 0;
}