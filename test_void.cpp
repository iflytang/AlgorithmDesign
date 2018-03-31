//
// Created by tsf on 18-3-31.
//

#include <iostream>
#include <vector>
#include <cstring>

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

    return 0;
}