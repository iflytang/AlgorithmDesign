/**
* @author tsf
* @stuId SA17006067
* @date 18-5-13
* @desc
*/

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

bool readFile(int &m, int &n);
bool writeFile(const int &result);
void init();
void out(const int &num);
bool ok(const int &row, const int &col);
void backTrace(int row, int col);

int m, n;                // m * n
int result = 0;              // latin matrix nums
vector<vector<int>> a;   // latin matrix

int main() {
    /* display how long the program runs. */
    clock_t start = clock();

    readFile(m, n);
    init();
    backTrace(0, 0);
    writeFile(result);

    cout << "input.txt: m=" << m << ", n=" << n << endl;
    cout << "output.txt: result=" << result << endl;

    clock_t end = clock();
    cout << "\nthis program runs " << 1000.0 * (end - start)/CLOCKS_PER_SEC << " ms." << endl;

    return 0;
}


/**
 * read data from input.txt
 * */
bool readFile(int &m, int &n) {
    string inputFileName = "input_5-9.txt";
    ifstream inputFile;

    inputFile.open(inputFileName, ios::in | ios::out);
    if (!inputFile.is_open()) {
        cout << "fail to open " << inputFileName << endl;
        return false;
    }

    inputFile >> m >> n;
    inputFile.close();

    return true;
}


/**
 * write result into output.txt
 * */
bool writeFile(const int &result) {
    string outputFileName = "output_5-9.txt";
    ofstream outputFile;

    outputFile.open(outputFileName, ios::in | ios::out);
    if (!outputFile.is_open()){
        cout << "fail to open " << outputFileName << endl;
        return false;
    }

    outputFile << result;
    outputFile.close();

    return true;
}

/**
 * init a[m][n].
 */
void init() {
    vector<vector<int> > temp(m, vector<int>(n, 0));
    a = temp;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            a[i][j] = j+1;
        }
    }

     /* print the init value */
     /*cout << "init: " << endl;
     for (int i = 0; i < m; i++) {
         for (int j = 0; j < n; j++) {
             cout << a[i][j] << "\t";
         }
         cout << endl;
     }*/

    cout << endl;
}

/**
 * print the available arrangement result.
 */
void out(const int &num) {
    cout << "result[" << num << "]: " << endl;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cout << a[i][j] << "\t";
        }
        cout << endl;
    }
}

/**
 * check that no same number in raw or col.
 */
bool ok(const int &row, const int &col) {
    /* check row */
    for (int i = 0; i < row; i++) {
        if (a[i][col] == a[row][col]) {
            return false;
        }
    }

    /* check col */
    for (int j = 0; j < col; j++) {
        if (a[row][j] == a[row][col]) {
            return false;
        }
    }

    return true;
}

/**
 * back trace algorithm to search max num of latin matrix.
 * @param row <= m
 * @param col <= n
 */
void backTrace(int row, int col) {
    for (int j = col; j < n; j++) {
        swap(a[row][col], a[row][j]);

        if (ok(row, col)) {
            if ((row == m-1) && (col == n-1)) {  // the end, output
                result++;
                // out(result);     // print the available result set
                return;
            } else if ((row == m-1) && (col != n-1)) {  // the end of row, search next column
                backTrace(row, col+1);
            } else if ((row != m-1) && (col == n-1)) {  // the end of col, search next raw
                backTrace(row+1, 0);
            } else {
                backTrace(row, col+1);    // search next (row, col)
            }
        }

        swap(a[row][col], a[row][j]);
    }
}