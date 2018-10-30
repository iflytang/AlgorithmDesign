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

// function to get Num of set bits in binary integer
unsigned int countSetBits(unsigned int n) {
    unsigned int count = 0;
    unsigned int temp = n;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    printf("countSetBits: 0x%x has %d set bits.\n", temp, count);
    return count;
}

static uint8_t get_set_bits_of_byte(uint8_t byte){
    uint8_t count = 0;
    uint8_t temp = byte;
    while (byte) {
        count += byte & 1;
        byte >>= 1;
    }
    printf("get_set_bits_of_byte: 0x%x has %d set bits.\n", temp, count);
    return count;
}

void test_time() {
    long long int time_usec = 0x5796e9a08e82f;
    struct timespec timespec1;
    timespec1.tv_sec = time_usec / (1000 * 1000);
    timespec1.tv_nsec = (time_usec % (1000 * 1000)) * 1000;
    printf("timespec.tv_sec=%lld, tv_nsec=%.9ld\n", timespec1.tv_sec, timespec1.tv_nsec);

    time_t time = (time_t) timespec1.tv_sec;
    printf("time: %s", ctime(&time));
}

int main() {


    uint16_t int_len = 0;
    uint8_t int_value[32];
    uint8_t int_map;
    memset(int_value, 0x00, 32);

    uint64_t device_id = 0x6162636465666768;
    uint8_t device_id_arr[16];
    sprintf((char *) device_id_arr, "%lx", device_id);

    memcpy(int_value, device_id_arr, 16);
//    printf("device_id_arr: %s\n", device_id_arr);
//    printf("int_value: %s\n", int_value);
//
//
//    printf("int_value2: %s\n", uint64_to_arr(device_id));


    uint8_t header[8] ={0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};

    memcpy(&int_map, header + 2, 1);
    printf("int_map: %x\n", int_map);

    countSetBits(15);

    get_set_bits_of_byte(0x12);

    test_time();

    return 0;
}