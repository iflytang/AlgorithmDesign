/**
* @author tsf
* @date 18-7-15
* @desc
*/

#include <iostream>
#include <cstring>
#include <cstddef>

using namespace std;

void testint(int arr[])
{
    printf("%d\n", sizeof(arr));
}

struct test {
    int a;       // is 4 bytes
    char b;      // will pad 3 zeros to 4 bytes
    int *c;      // pointer is 8 bytes
    char *d;     // pointer is 8 bytes
};

int main() {
    char str1[] = "hello";
    char str2[] = {'h', 'e', 'l', 'l', 'o', '\0'};
    char str3[] = {'h', 'e', 'l', 'l', 'o'};
    char str4[] = {'h', 'e', 'l', 'l', 'o', '\n'};
    char str5[] = {"ifly\0tang"};    // strlen ignores '\0'

    cout << "============str===========" << endl;
    printf("str1:%s\n", str1);
    printf("str2:%s\n", str2);
    printf("str3:%s\n", str3);
    printf("str4:%s\n", str4);
    printf("str5:%s\n", str5);

    cout << "============strlen & sizeof===========" << endl;
    printf("str1:%d, %d\n", strlen(str1), sizeof str1);
    printf("str2:%d, %d\n", strlen(str2), sizeof str2);
    printf("str3:%d, %d\n", strlen(str3), sizeof str3);
    printf("str4:%d, %d\n", strlen(str4), sizeof str4);
    printf("str5:%d, %d\n", strlen(str5), sizeof str5);

    cout << "============struct===========" << endl;
    struct test *test = (struct test *)malloc(sizeof (struct test));
    printf("struct.a(int):%d, %d\n", sizeof (test->a), offsetof(struct test, a));
    printf("struct.b(char):%d, %d\n", sizeof (test->b), offsetof(struct test, b));   // have 3 padding zeros
    printf("struct.c(int*):%d, %d\n", sizeof (test->c), offsetof(struct test, c));
    printf("struct.d(char*):%d, %d\n", sizeof (test->d), offsetof(struct test, d));
    printf("struct:%d\n", sizeof (struct test));


    cout << "============test array===========" << endl;
    char *cat = "wangwang\0miaomiao";
    printf("%d %d\n", sizeof(cat), strlen(cat)); //8 8

    char str_[] = "abc";
    printf("%d %d\n", sizeof(str_), strlen(str_)); //4 3

    char str_1[10] = "abc";
    printf("%d %d\n", sizeof(str_1), strlen(str_1)); //10 3

    char dog[] = "wangwang\0miao";
    printf("%d %d\n", sizeof(dog), strlen(dog)); //14 8

    int arr[10] = { 0 };
    printf("%d %d\n", sizeof(arr), sizeof(arr[11])); //40 4
    testint(arr); //8

    cout << "============test little_endian===========" << endl;
    union test_uinon {
        int t;
        char val[4];
    };
    union test_uinon test_uinon1;
    test_uinon1.t = 0x12345678;
    test_uinon1.val[1] = 0x00;
    printf("val: %x %d\n", test_uinon1.t, sizeof(test_uinon1));

    return 0;
}