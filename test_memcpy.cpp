/**
* @author tsf
* @date 18-8-29
* @desc
*/

#include <iostream>
#include <cstring>

using namespace std;

char * uint64_to_arr(uint64_t uint64) {
    char arr[8];
    char temp;
    printf("uint64: %lx\n", uint64);
    for (int i = 0; i < 8; i++) {
        temp = char (uint64 >> 8*i);
        arr[7-i] = char (temp & 0xff);
        printf("%d: %x\t %c\n", i, temp, arr[7-i]);
    }
    return arr;
}

int main() {


    uint16_t int_len = 0;
    uint8_t int_value[32];
    memset(int_value, 0x00, 32);

    uint64_t device_id = 0x6162636465666768;
    uint8_t device_id_arr[16];
    sprintf((char *) device_id_arr, "%lx", device_id);

    memcpy(int_value, device_id_arr, 16);
    printf("device_id_arr: %s\n", device_id_arr);
    printf("int_value: %s\n", int_value);


    printf("int_value2: %s\n", uint64_to_arr(device_id));


    return 0;
}