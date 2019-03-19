/**
* @author tsf
* @date 18-9-12
* @desc give two 20 digit numbers, let them multiply, and print the result. for example, input
*       "20000000000000000000 30000000000000000000", output "6000000000000000...0"
*/

#include <iostream>
#include <cstring>

using namespace std;

void big_num_multiply(char num1[], char num2[]) {

    int num1_len, num2_len, array_size;

    num1_len = strlen(num1);
    num2_len = strlen(num2);
    array_size = num1_len + num2_len;

    int ret[array_size];
    for (int i = 0; i < array_size; i++) {
        ret[i] = 0;
    }

  /* for (int i = 0; i < num1_len; i++) {
        for (int j = 0; j < num2_len; j++) {
            ret[i+j+1] = (num1[i]-'0') * (num2[j]-'0');
        }
    }*/

    for (int j = num2_len-1; j >= 0; j--) {
        for (int i = num1_len-1; i >= 0; i--) {
            ret[i+j+1] += (num1[i] - '0') * (num2[j] - '0');
         }
    }

    for (int i = num1_len+num2_len-1; i >= 0; i--) {
        if (ret[i] >= 10) {
            ret[i-1] += ret[i] / 10;
            ret[i] = ret[i] % 10;
        }
    }

    int i = 0;
    while (ret[i] == 0) {
        i++;
    }
    for (; i < num1_len+num2_len; i++) {
        cout << ret[i];
    }

}

int main() {

    char num1[30];
    char num2[30];
    cout << "input 2 20 num: ";
    cin.getline(num1, 30);
    cin.getline(num2, 30);
    big_num_multiply(num1, num2);

    return 0;
}