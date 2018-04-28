//
// Created by tsf on 18-4-24.
//

#include "Rectangle.h"

using namespace std;

int Rectangle::init(int w, int h) {
    this->width = w;
    this->height = h;
}

int Rectangle::area() {
    return this->width * this->height;
}

int Rectangle::perimeter() {
    return 2 * (this->width + this->height);
}

void Rectangle::printTotalNum() {
    cout << "total object num: " << totalNum << endl;
}

Rectangle::Rectangle() {
    totalNum++;
}

Rectangle::~Rectangle() {
    totalNum--;
}