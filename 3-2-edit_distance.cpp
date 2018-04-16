/**
* @Author tsf
* @StuId SA17007067
* @Date 2018/4/16
* @Problem 3-2: edit distance problem.
* */

#include <iostream>
#include <fstream>
#include <cstring>

using namespace std;

int main() {

    string sa;       // first line
    string sb;       // second line

    /* read data from input.txt */
    string inputFileName = "input_3-2.txt";
    string outputFileName = "output_3-2.txt";
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

    inputFile >> sa;
    cout << "input_3-2.txt/sa: " << sa << endl;
    inputFile >> sb;
    cout << "input_3-2.txt/sb: " << sb << endl;

    int sa_size = sa.size();
    int sb_size = sb.size();
    int cost = 0;
    int distance[sa_size][sb_size];  // edit distance
    memset(distance, 0x00, sizeof(distance));

    /* edit distance */
    for (int i = 0; i <= sa_size; i++) {
        distance[i][0] = i;
    }
    for (int i = 0; i <= sb_size; i++) {
        distance[0][i] = i;
    }
    for (int i = 1; i <= sa_size; i++) {
        for (int j = 1; j <= sb_size; j++) {
            cost = (sa[i] != sb[j]);
            distance[i][j] = min(distance[i - 1][j] + 1, min(distance[i][j - 1] + 1, distance[i - 1][j - 1] + cost));
            /*cout << "distance[" << i << "][" << j << "]: " << distance[i][j] << "\t";
            if (j == sb_size) {
                cout << endl;
            }*/
        }
    }

    /* write the result to output.txt */
    cout << "output_3-2.txt/edit_distance: " << distance[sa_size][sb_size];
    outputFile << distance[sa_size][sb_size];

    inputFile.close();
    outputFile.close();

    return 0;
}