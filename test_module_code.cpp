//
// Created by tsf on 18-4-25.
//

#include <iostream>
#include "Rectangle.h"

#define TEST_CLASS_RECTANGLE

using namespace std;

int main() {

#ifdef TEST_CLASS_RECTANGLE
    Rectangle r;
    int width, height;
    cout << "input two integer parameter of rectangle: " ;
    cin >> width >> height;
    r.init(width, height);
    int area = r.area();
    int perimeter = r.perimeter();
    cout << "Rectangle -> area: " << area << ", perimeter: " << perimeter << endl;
#endif

    return 0;
}