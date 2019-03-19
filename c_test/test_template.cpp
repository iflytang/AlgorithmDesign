/**
* @author tsf
* @date 18-5-2
* @desc
*/

#include <iostream>
#include <map>
#include <vector>

using namespace std;

//#define TEST_TEMPLATE 1
#define TEST_VECTOR 1

template <class type>   // 'class' can also be 'typename'
void Swap(type &a, type &b) {
    type temp;
    temp = a;
    a = b;
    b = temp;
}

int main() {

#ifdef TEST_TEMPLATE
    int a = 13;
    int b = 14;

    cout << "before swap: " << a << " " << b << endl;
    Swap(a, b);
    cout << "after swap: " << a << " " << b << endl;
#endif

#ifdef TEST_VECTOR
    // one array
    vector<int> v1(2, 0);
    cout << endl << "capacity: " << v1.capacity() << endl;
    v1.push_back(12);
    v1.erase(v1.begin());     // delete v1[0]
    v1.insert(v1.begin() + 2, 2);
    vector<int>::iterator it;
    cout << "vec[]: ";
    for (it = v1.begin(); it != v1.end(); it++)
        cout << *it << "\t";

    cout << endl << "capacity: " << v1.capacity() << endl;
    cout << "vec.at(2): " << v1.at(2) << endl;
    cout << "vec.front(): " << v1.front() << endl;
    cout << "vec.back(): " << v1.back() << endl;

    // two dimension
    vector<vector<int>> v2(4, vector<int>(4, 0));
    for (int i = 0; i < 4; i++) {
        cout << "vec[" << i << "][]: ";
        for (int j = 0; j < 4; j++) {
            cout << v2[i][j] << "\t";
        }
        cout << endl;
    }

#endif

    return 0;
}