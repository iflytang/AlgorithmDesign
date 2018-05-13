/**
* @author tsf
* @date 18-5-13
* @desc no sum set problem, see https://blog.csdn.net/u012319493/article/details/50074527
*/

#include<iostream>
#include<fstream>
#include<algorithm>
#include <cstring>
#include "ctime"
using namespace std;

const int MAXN = 10;
const int MAX = 100;
int n;
int sum[MAXN][MAX];
bool s[MAXN][MAX];
int t[MAX];
int best[MAX];
int k;  // search depth in ascending

void out()
{
    for(int i=1; i<=n; i++)  // divide parts
    {
        for(int j=1; j<=k; j++)  // every num
            if(i == best[j])  // if num[j] belongs to part[i]
                cout << j << "\t";  // cout
        cout << endl;
    }
}

void record()
{
    for(int i=1; i<=n; i++)  // divide parts
    {
        for(int j=1; j<=k; j++)   // every num
            if(i == t[j])  // if num[j] belongs to part[i]
                best[j] =  i;
    }
}


clock_t start, finish;
double duration = 0;
bool backtrack(int dep)
{

    finish = clock();
    duration += (double) (finish-start)/CLOCKS_PER_SEC;
    start = finish;
    if(duration > 15.0)
    {
        cout << duration << endl;
        cout << "No Solution!\n";
        return false;
    }

    if(dep > k)
    {
        record();
        return true;
    }
    for(int i=1; i<=n; i++)  // the i_th part
        if(sum[i][dep] == 0)
        {
            t[dep] = i;  //depth chosen in part[i]
            s[i][dep] = true;
            for(int j=1; j<dep; j++)
                if(s[i][j])  // if num[j] has existed in part[i]
                    sum[i][dep+j]++;  //j+dep will be passed
            if(backtrack(dep+1))
                return true;
            for(int j=1; j<dep; j++)
                if(s[i][j])
                    sum[i][dep+j]--;
            s[i][dep] = false;
        }
    return false;
}

void search()
{
    k = n;
    while(true)
    {
        memset(sum, 0, sizeof(sum));
        memset(t, 0, sizeof(t));
        memset(s, 0, sizeof(s));

        if(backtrack(1))
            ++k;  // increase depth
        else
            break;
    }
    --k;
}

int main()
{
    cout << "input n: ";
    cin >> n;

    search();
    cout << "\nF(" << n << ") = " << k << "\n";
    out();  // print result
    cout << endl;
    return 0;
}