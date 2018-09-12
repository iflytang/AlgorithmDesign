/**
* @author tsf
* @date 18-9-12
* @desc Huawei interview: give a string with repeated char, find the last char which shows only once.
*       No result, then return NULL. for example, input "AABBCCXXSSSSEFFF", output "E"
*/

#include <iostream>
#include <cstring>

using namespace std;

char findChar(char * str) {

    int str_len = strlen(str);
    int char_num[100] = {0};
    int i;

    for (i = 0; i < str_len; i++) {
        char_num[str[i] - 'A']++;
    }

    for (i = str_len-1; i >= 0; i--) {
        if (char_num[str[i] - 'A'] == 1) {
            cout << str[i];
            return str[i];
        }
    }

    if (i == -1) {
        cout << "NULL";
        return NULL;
    }

}

int main() {

    char str[100];
    cout << "input a string: ";
    cin.getline(str, 100);

    findChar(str);

    return 0;
}

