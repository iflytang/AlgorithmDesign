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
    static int totalNum;   // total num of objects

public:
    int init(int w, int h);
    int area();
    int perimeter();
    static void printTotalNum();
    Rectangle();      // constructor function
    ~Rectangle();     // destructor function

};

#endif // RECTANGLE_H
