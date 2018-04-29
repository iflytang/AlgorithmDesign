/**
* @author tsf
* @date 18-4-29
* @desc
*/

#include <iostream>

using namespace std;

class Demo {

private:
    int value;

public:
    void getValue();
    void getValue() const;
    Demo();

};

int main() {

    Demo demo1;
    const Demo demo2;    // const object can only call const function.

    demo1.getValue();
    demo2.getValue();

    return 0;
}

void Demo::getValue() {
    cout << "getValue: " << this->value << endl;
}

void Demo::getValue() const {
    cout << "getValue const: " << this->value * 2 << endl;
}

Demo::Demo() {
    value = 1;
}