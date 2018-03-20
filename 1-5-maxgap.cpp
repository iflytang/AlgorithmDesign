/**
* @Author tsf
* @StuId SA17007067
* @Date 2018/3/20
* @Problem 1-5: max gap problem with linear time algorithm.
* */

#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>

using namespace std;

int main() {

    int total = 0;          // first line
    vector<float> nums;     // second line
    float max = 0;          // result

    /* read data from input.txt */
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

    /* find the max and min */
    vector<float>::iterator it;
    float maxNum = -INFINITY;
    float minNum = INFINITY;
    for (it = nums.begin();it != nums.end(); it++) {
        cout << *it << "\t";
        maxNum = *it > maxNum? *it : maxNum;
        minNum = *it < minNum? *it : minNum;
    }
    // cout << "\nmax:" << maxNum << " min:" << minNum << endl;

    /* length and numbers of the bucket. */
    float lenOfBucket = (float) (maxNum - minNum) / (nums.size() - 1);
    int numOfBucket = (int) (maxNum - minNum) / lenOfBucket + 1;
    // cout << "lenOfBucket:" << lenOfBucket << " numOfBucket:" << numOfBucket << endl;

    /* find the max and min in the each bucket. */
    float *maxOfBucket = new float[nums.size() - 1];
    float *minOfBucket = new float[nums.size() - 1];
    int *count = new int[nums.size() - 1];
    for (int i = 0; i < nums.size() - 1; i++) {
        count[i] = 0;
        maxOfBucket[i] = maxNum;
        minOfBucket[i] = minNum;
    }
    for (int i = 0; i < nums.size(); i++) {
        int indexOfBucket = (nums[i] - minNum) / lenOfBucket;
        // cout << "nums[" << i << "]:" << nums[i] << " indexOfBucket: " << indexOfBucket << endl;
        count[indexOfBucket]++;
        if (nums[i] < maxOfBucket[indexOfBucket]) {
            maxOfBucket[indexOfBucket] = nums[i];
        }
        if (nums[i] > minOfBucket[indexOfBucket]) {
            minOfBucket[indexOfBucket] = nums[i];
        }
    }

    /* find the max gap. */
    float gap = 0;
    float left = minOfBucket[0];
    for (int i = 1; i < nums.size() - 1; i++) {
        if (count[i]) {
            if (maxOfBucket[i] - left > gap) {
                gap = maxOfBucket[i] - left;
                // cout << "gap:" << gap << endl;
            }
            left = minOfBucket[i];
        }
    }
    // cout << "max gap:" << gap << endl;

    outputFile << gap;
    cout << "\noutput.txt:\n" << gap << endl;

    /* free the memory */
    delete [] maxOfBucket;
    delete [] minOfBucket;
    delete [] count;

    /* close files */
    inputFile.close();
    outputFile.close();

    return 0;
}
