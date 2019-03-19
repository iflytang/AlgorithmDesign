/**
* @author tsf
* @date 18-7-2
* @desc
*/

#include <iostream>
#include <vector>
#include <cstring>
#include <netinet/in.h>

using namespace std;

int main() {

    uint8_t port_byte = 98;
    uint32_t port_int_1 = port_byte;
    uint32_t port_int_2 = ntohl(port_byte);

    cout << "port_byte: " << port_byte << endl;
    cout << "port_int_1: " << port_int_1 << endl;
    cout << "port_int_2: " << port_int_2 << endl;

    return 0;
}