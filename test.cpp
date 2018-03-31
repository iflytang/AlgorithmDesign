//
// Created by tsf on 18-3-26.
//


#include <iostream>
#include <vector>
#include <cstring>

using namespace std;

int a[8] = {0};

void gray(int n) {

    if(n == 1) {
        a[1] = 0;
        a[2] = 1;
        return;
    }

    gray(n-1);

    for(int k = 1 << n-1, i = k; i > 0; i--) {
        a[2*k-i+1] = a[i] + k;
//        cout << a[i] + k ;
    }

    for (int i = 1; i <= 8; i++) {
        cout << "a[" << i << "]:" << a[i] << "\t";
    }

    cout << endl;
}

int main() {

    gray(3);

    return 0;
}
