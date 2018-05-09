/**
* @author tsf
* @date 18-5-9
* @desc override operator
*/

#include <iostream>

using namespace std;

class Complex {
public:
    double real, imag;

    Complex operator + (const Complex &other);    // member function
    Complex(double real, double imag);
    Complex();
};

Complex operator - (const Complex &other1, const Complex &other2) {  // global function
    double real = other1.real - other2.real;
    double imag = other1.imag - other2.imag;
    return Complex(real, imag);
}

Complex Complex::operator+(const Complex &other) {
    real += other.real;
    imag += other.imag;
    return *this;
}

Complex::Complex() {
    real = 0;
    imag = 0;
}

Complex::Complex(double real, double imag) {
    this->real = real;
    this->imag = imag;
}

int main() {

    Complex c1(4, 4);
    Complex c2(1, 1);
    Complex c;

    c = c1 - c2;
    cout << "c1-c2: " << c.real << " + " << c.imag << "i" << endl;

    c = c1 + c2;
    cout << "c1+c2: " << c.real << " + " << c.imag << "i" << endl;

    return 0;
}