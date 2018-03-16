/**
* @Author tsf
* @StuId SA17007067
* @Date 2018/3/16
* @Problem 1-5.cpp
* */

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main() {

    int total = 0;          // first line
    vector<float> nums;     // second line
    float max = 0;          // result

    string inputFileName = "input.txt";
    string outputFileName = "output.txt";

    ifstream inputFile;
    ofstream outputFile;

    inputFile.open(inputFileName, ios::in | ios::out);
    if (!inputFile.is_open()) {
        cout << "fail to open " << inputFileName << endl;
    }

    outputFile.open(outputFileName, ios::in | ios::out);
    if (!outputFile.is_open()) {
        cout << "fail to open " << outputFileName << endl;
    }

    /* read total numbers. */
    inputFile >> total;
    cout << "input.txt:\n" << total << "\n";

    /* read numbers in second line. */
    float temp;
    while (total) {
        inputFile >> temp;
        nums.push_back(temp);
        total--;
    }

    vector<float>::iterator it;

    for (it = nums.begin();it != nums.end(); it++) {
        cout << *it << "\t";
    }

    /* find the max value. */
    for (long i = nums.size(); i - 3 >= 0; i--) {
        temp = nums[i] - nums[i-3];
        if (temp > max) {
            max = temp;
        }
    }

    /* store the result */
    outputFile << max;
    cout << "\noutput.txt:\n" << max << endl;

    inputFile.close();
    outputFile.close();
    return 0;
}