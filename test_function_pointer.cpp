//
// Created by tsf on 18-4-21.
//


#include <iostream>

using namespace std;

typedef int (*Calculate) (int, int); // define a function pointer type

int plus_(int x, int y) {
    return x+y;
}

int minus_(int x, int y) {
    return x-y;
}

int time_(int x, int y) {
    return x*y;
}

int divide_(int x, int y) {
    return x/y;
}

int call_back(Calculate calculate, int x, int y) {   // call back function
    int value = calculate(x, y);  // execute the function pointer with its arguments
    cout << "value: " << value << endl;
}

int main() {
    long start = clock();
    cout << "please input two nums:";
    int x, y;
    cin >> x >> y;

    call_back(plus_, x, y);  // const function pointer as parameter to call back
    call_back(minus_, x, y);
    call_back(time_, x, y);
    call_back(divide_, x, y);

    long end = clock();

    cout << "the program runs " << end - start << " ms" << endl;

    return 0;
}