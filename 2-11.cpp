/**
* @Author tsf
* @StuId SA17007067
* @Date 2018/3/25
* @Problem 2-11: integer factorization problem with recursive method.
* */

#include <iostream>
#include <fstream>
#include <cmath>
#include <ctime>

using namespace std;
int factorSearch(int n);

int main() {
    long start = clock();

    int num;      // the num to be factorized in input_1-22.txt
    int count;    // the count to present how many factors of num to output_1-22.txt

    string inputFileName = "input_1-22.txt";
    string outputFileName = "output_1-22.txt";

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

    /* read data from file */
    inputFile >> num;
    cout << "num: " << num << endl;

    /* call method and write data to file */
    count = factorSearch(num);
    outputFile << count;
    cout << "count: " << count << endl;

    /* close the file */
    inputFile.close();
    outputFile.close();

    long end = clock();
    cout << "the running program costs " << end - start << " ms." << endl;

    return 0;

}

/* recursive method */
int factorSearch(int n) {

    int cnt = 0;

    if (n == 1) {
        cnt++;
    } else {
        for (int i = 2; i <= n; i++) {
            if (n % i == 0) {
                cnt += factorSearch(n/i);
                //cout << "cnt:" << cnt << ",factor:" << i << endl;
            }
        }
    }

    //cout << "cnt:" << cnt << endl;

    return cnt;
}

