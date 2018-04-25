//
// Created by tsf on 18-4-24.
//

#include <iostream>

using namespace std;

#ifndef RECTANGLE_H
#define RECTANGLE_H

class Rectangle {

private:
    int width;
    int height;

public:
    int init(int w, int h);
    int area();
    int perimeter();

};

#endif // RECTANGLE_H
