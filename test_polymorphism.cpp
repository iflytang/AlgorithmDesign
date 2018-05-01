/**
* @author tsf
* @date 18-4-30
* @desc use'virtual' key word to express polymorphism, and call it by Base_Pointer or Base_Reference
*/

#include <iostream>

using namespace std;

class A {
public:
    virtual void printInfo() {
        cout << "A::printInfo()" << endl;
    }
};

class B : public A {
public:
    virtual void printInfo() {
        cout << "B::printInfo()" << endl;
    }
};

class C : public A {
public:
    virtual void printInfo() {
        cout << "C::printInfo()" << endl;
    }
};

void printInfo(A &r) {
    r.printInfo();
}

int main() {

    A a;
    B b;
    C c;

    /* call virtual function dynamically by Base_Pointer */
    A *pa = &a;    pa->printInfo();      // print A
    pa = &b;       pa->printInfo();      // print B
    pa = &c;       pa->printInfo();      // print C

    cout << endl;

    /* call virtual function dynamically by Base_Reference */
    printInfo(a);
    printInfo(b);
    printInfo(c);

    return 0;
}