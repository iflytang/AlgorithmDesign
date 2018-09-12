/**
* @author tsf
* @date 18-9-12
* @desc Huawei interview: give a string with segment " ", reverse the words and print.
*       for example, give "Yes sir", print "seY ris".
*/

#include <iostream>
#include <cstring>

using namespace std;

void reverse_words(char str[]) {
    char ret[100];
    int word_len;

    char *sub_str = strtok(str, " ");

    while (sub_str != NULL) {
        word_len = strlen(sub_str);
        for (int i = word_len-1 ; i >= 0; i--) {
            cout << sub_str[i];
        }
        cout << " ";

        sub_str = strtok(NULL, " ");
    }
}

int main() {

    char str[100];
    cout << "input a string: ";
    cin.getline(str, 100);

    reverse_words(str);

    return 0;
}
