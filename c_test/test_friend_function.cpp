/**
* @author tsf
* @date 18-4-29
* @desc
*/

#include <iostream>

using namespace std;

class A;

class B {    // should defined before class A

public:
    void set_show(int x, A &a);

};

class A {

public:
    friend void set_show(int x, A &a);      // this is global friend function
    friend void B::set_show(int x, A &a);   // this is class friend function

private:
    int data;

};


void set_show(int x, A &a) {
    a.data = x;       // directly access A's variable
    cout << "::set_show: " << a.data << endl;
}

void B::set_show(int x, A &a) {
    a.data = x;       // directly access A's variable
    cout << "B::set_show: " << a.data << endl;
}

int main() {

    A a;
    B b;
    set_show(13, a);
    b.set_show(14, a);

    return 0;
}