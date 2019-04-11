/**
 * @author tsf 
 * @date 19-4-10
 * @desc 
*/

#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
#include <netdb.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <arpa/inet.h>
#include <stdbool.h>

#define SERVER_ADDR "192.168.109.214"
#define CLIENT_ADDR "192.168.109.211"
#define SOCKET_PORT 2019

#define MAXLINE 1024

int main() {

    int clientfd, sockfd;
    char buf_input[MAXLINE] = {0};
    char buf_send[MAXLINE] = {0};

    struct sockaddr_in client;

    printf("start\n");

    if ((clientfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        printf("create socket failed.");
        exit(EXIT_FAILURE);
    }

    bzero(&client, sizeof(client));
    client.sin_family = AF_INET;
    client.sin_port = htons(SOCKET_PORT);
    inet_pton(AF_INET, SERVER_ADDR, &client.sin_addr);

    if ((sockfd = connect(clientfd, (struct sockaddr *) &client, sizeof(client))) > 0) {
        printf("connect socket failed.");
        exit(EXIT_FAILURE);
    }

    bool flag = true;
    size_t input_len = 0;
    while (true) {

        if (fgets(buf_input, MAXLINE, stdin) != NULL) {
            input_len = strlen(buf_input);
            strncat(buf_send, buf_input, input_len);
            send(clientfd, buf_send, input_len, 0);
            bzero(buf_input, MAXLINE);
            bzero(buf_send, MAXLINE);
        } else {
            break;
        }
    }

    close(clientfd);

    return 0;
}