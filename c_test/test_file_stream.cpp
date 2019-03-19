/**
* @author tsf
* @date 18-5-1
* @desc
*/

#include <iostream>
#include <fstream>

using namespace std;

int main() {

    string fileName = "test_file_stream.txt";
    fstream file;
    file.open(fileName, ios::in);
    if (!file.is_open()) {
        cout << "open error! create a new file!" << endl;
    }

    file.close();
    file.open(fileName, ios::in | ios::app | ios::out);

    int x = 5678;
    int y = 123;
    file << x << " ";
    file << y << " ";

    file.close();

    return 0;
}