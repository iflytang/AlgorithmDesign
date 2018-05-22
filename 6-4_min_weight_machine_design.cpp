/**
* @author tsf
* @stuId SA17006067
* @date 18-5-22
* @desc
*/

#include <iostream>
#include <vector>
#include <fstream>
#include <climits>
#include <queue>
#include <algorithm>

using namespace std;

/**
 * parameters
 * */
int n, m, d;            // n: component parts, m: provider vendors, d: total weight
vector<int> result;
int minWeight;
int minValue;
int **c;
int **w;

struct Node {
    int weight;
    int value;
    int source;        // providers
    int level;
    Node *father;
};
Node *minLeaf = new Node;

bool readFile(int &n, int &m, int &d, int ** &c, int ** &w);
bool writeFile(const int &d, const vector<int> result);
bool operator < (Node a, Node b);
void minWeightMachine();
void getResult();

int main() {
    /* display how long the program runs. */
    clock_t start = clock();

    readFile(n, m, d, c, w);
    minWeightMachine();
    getResult();
    writeFile(d, result);

    cout << "input.txt: n=" << n << ", m=" << m << ", d= " << d << endl;
    cout << "output.txt: minWeight=" << minWeight << "; providers=";
    for (int i = 0; i < result.size(); i++)
        cout << result[i] << " ";
    cout << endl;

    clock_t end = clock();
    cout << "\nthis program runs " << 1000.0 * (end - start)/CLOCKS_PER_SEC << " ms." << endl;
}

/**
 * read data from input.txt
 * */
bool readFile(int &n, int &m, int &d, int** &c, int** &w) {
    string inputFileName = "input_6-4.txt";
    ifstream inputFile;

    inputFile.open(inputFileName, ios::in | ios::out);
    if (!inputFile.is_open()) {
        cout << "fail to open " << inputFileName << endl;
        return false;
    }

    inputFile >> n >> m >> d;

    w = new int*[n+1];
    c = new int*[m+1];
    for (int i = 1; i <= n; i++) {
        w[i] = new int[m+1];
        c[i] = new int[m+1];
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            inputFile >> c[i][j];
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            inputFile >> w[i][j];
        }
    }

    inputFile.close();

    return true;
}

/**
 * write result into output.txt
 * */
bool writeFile(const int &d, const vector<int> result) {
    string outputFileName = "output_6-4.txt";
    ofstream outputFile;

    outputFile.open(outputFileName, ios::in | ios::out);
    if (!outputFile.is_open()){
        cout << "fail to open " << outputFileName << endl;
        return false;
    }

    outputFile << d << endl;
    for (int i = 0; i < result.size(); i++) {
        outputFile << result[i] << " ";
    }

    /* delete memory allocation. */
    delete [] w;
    delete [] c;

    outputFile.close();

    return true;
}

bool operator < (Node a, Node b) {
    if (a.weight == b.weight)
        return a.level > b.level;   // descending level
    return a.weight < b.weight;
}

void minWeightMachine() {
    minWeight = INT_MAX;
    minValue = INT_MAX;

    Node initial = {
            .weight = 0,
            .value = 0,
            .source = 0,
            .level = 0,
            .father = NULL
    };

    priority_queue<Node> heap;
    heap.push(initial);

    while (!heap.empty()) {
        Node *fatherNode = new Node(heap.top());
        heap.pop();

        if (fatherNode->level == n) {
            if (fatherNode->weight < minWeight) {
                minWeight = fatherNode->weight;
                minValue = fatherNode->value;
                minLeaf = fatherNode;        // record which node is leaf node
            }
        } else {
            int min_w = INT_MAX;
            int min_c = INT_MAX;

            min_c = fatherNode->value;
            min_w = fatherNode->weight;

            for (int i =  fatherNode->level + 1; i <= n; i++) {
                int temp_min_w = INT_MAX;
                int temp_min_c = INT_MAX;

                for (int j = 1; j <= m; j++) {
                    temp_min_w = temp_min_w < w[i][j] ? temp_min_w:w[i][j];
                    temp_min_c = temp_min_c < c[i][j] ? temp_min_c:c[i][j];
                }
                min_w += temp_min_w;
                min_c += temp_min_c;
            }

            if (min_w > minWeight || min_c > d) {
                continue;
            }

            for (int i = 1; i <= m; i++) {
                if (fatherNode->value + c[fatherNode->level+1][i] <= d ||
                    fatherNode->weight + w[fatherNode->level+1][i] <= minWeight) {

                    Node *newNode = new Node;
                    newNode->level = fatherNode->level + 1;
                    newNode->father = fatherNode;
                    newNode->source = i;
                    newNode->value = fatherNode->value + c[newNode->level][i];
                    newNode->weight = fatherNode->weight + w[newNode->level][i];
                    heap.push(*newNode);
                }
            }

        }
    }
}

void getResult() {
    for (int i = n; i >= 1; i--) {
        result.push_back(minLeaf->source);
        minLeaf = minLeaf->father;
    }
    reverse(result.begin(), result.end());
}