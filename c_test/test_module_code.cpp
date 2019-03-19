//
// Created by tsf on 18-4-25.
//

#include <iostream>
#include "Rectangle.h"

#define TEST_CLASS_RECTANGLE

using namespace std;

int Rectangle::totalNum = 0;    // static variables should be initialized once

int main() {

#ifdef TEST_CLASS_RECTANGLE
    Rectangle r, r1, r2;
    int width, height;
    cout << "input two integer parameter of rectangle: " ;
    cin >> width >> height;
    r.init(width, height);
    int area = r.area();
    int perimeter = r.perimeter();
    cout << "Rectangle -> area: " << area << ", perimeter: " << perimeter << endl;

    /* two kinds of way to call static function */
    Rectangle::printTotalNum();   // class_name::static_func
    r.printTotalNum();            // object_name.static_func
#endif

    return 0;
}