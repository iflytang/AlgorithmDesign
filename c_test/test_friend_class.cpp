/**
* @author tsf
* @date 18-4-29
* @desc
*/

#include <iostream>

using namespace std;

class A {

public:
    friend class B;      // friend class, B can access all components of A
private:
    int data;
};

class B {

public:
    void set_show(int x, A &a);
};

void B::set_show(int x, A &a) {
    a.data = x;
    cout << "B::set_show:" << a.data << endl;
}

int main() {

    A a;
    B b;

    b.set_show(1314, a);

    return 0;
}