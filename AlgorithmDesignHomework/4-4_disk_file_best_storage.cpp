/**
* @author tsf
* @stuId SA17006067
* @date 18-4-28
* @problem 4-4 disk file best storage problem, using greedy algorithm.
* @desc 1. sort the files according to probability
*       2. f(n-1) stores in center, f(n-2) and f(n-3) lists aside f(n-1), and so on.
*/

#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>

using namespace std;

bool compare(int a, int b) {   // sort
    return a < b;
}

int cmp(const void *a, const void *b) {  // qsort
    return *(int *)a > *(int *) b;
}

int main() {

    /* display how long the program runs */
    clock_t start = clock();  // start time

    int num;         // first line
    vector<int> p;   // second line
    double except;   // expected value in output.txt

    /* read data from input.txt */
    string inputFileName = "input_4-4.txt";
    string outputFileName = "output_4-4.txt";
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

    cout << "======== input.txt =========" << endl;
    inputFile >> num;
    cout << num << endl;
    int temp;
    for (int i = 0; i < num; i++) {
        inputFile >> temp;
        cout << temp << "\t";
        p.push_back(temp);
    }
    cout << endl;

    cout << "======== output.txt =========" << endl;
    /* sort the file in ascending order */
//    sort(p.begin(), p.end(), compare);
    qsort(p.data(), p.size(), sizeof(int), cmp);
    for (int i=0; i < p.size(); i++)
        cout << p[i] << "\t";

    /* store the file in greedy */
    int k = (num - 1) / 2;       // center location
    vector<int> f(num, 0);       // stored location
    f[k] = p[num - 1];
    for (int i = k+1; i < num; i++) {
        f[i] = p[num - 2 * (i - k)];      // f(n-2), f(n-4)...
    }
    for (int i = k-1; i >= 0; i--) {
        f[i] = p[num - 2 * (k - i) - 1];  // f(n-3), f(n-5) ...
    }

    double sum = 0;
    int P = 0;
    for (int i = 0; i < num; i++) {
        P += p[i];
        for (int j = i+1; j < num; j++) {
            sum += f[i] * f[j] * (j - i);
        }
    }
    except = sum / P / P;

    cout << except << endl;
    outputFile << except;

    inputFile.close();
    outputFile.close();

    cout << "======= running time ========" << endl;
    clock_t end = clock();    // end time
    cout <<  1000.0 * (end - start)/CLOCKS_PER_SEC << " ms." << endl;

    return 0;
}