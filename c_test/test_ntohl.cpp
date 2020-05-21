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

  /*  uint8_t port_byte = 98;
    uint32_t port_int_1 = port_byte;
    uint32_t port_int_2 = ntohl(port_byte);

    cout << "port_byte: " << port_byte << endl;
    cout << "port_int_1: " << port_int_1 << endl;
    cout << "port_int_2: " << port_int_2 << endl;*/

    /*float bandwidth = 0x3ad2c387;
    printf("bandwidth: %f Mbps\n", bandwidth);

    uint32_t value = 0x3ad2c387;
    memcpy(&bandwidth, &value, sizeof(uint32_t));
    printf("bandwidth: %f Mbps\n", bandwidth);

    bandwidth = ntohl(bandwidth);
    printf("bandwidth: %f Mbps\n", bandwidth);

    value = 0x87c3d23a;
    memcpy(&bandwidth, &value, sizeof(uint32_t));
    printf("bandwidth: %f Mbps\n", bandwidth);

    bandwidth = 0.001608;
    printf("bandwidth: %f Mbps\n", bandwidth);
    printf("bandwidth: %g Mbps\n", bandwidth);*/


    return 0;
}