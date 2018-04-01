//
// Created by tsf on 18-4-1.
//

#include <iostream>

using namespace std;

int swap(int & a, int & b) {  // reference as parameter
    int tmp;
    tmp = a;
    a = b;
    b = tmp;

    return  0;
}

int main() {
    int n1 = 100;
    int n2 = 50;
    cout << "before swap -> n1:" << n1 << ", n2:" << n2 << endl;
    swap(n1, n2);
    cout << "after swap -> n1:" << n1 << ", n2:" << n2 << endl;
}