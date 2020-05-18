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

#define SERVER_ADDR "192.168.109.212"
#define CLIENT_ADDR "192.168.109.211"
#define SOCKET_PORT 2022

#define MAXLINE 1024

// when interrupted, call this method
void quit(int signal) {
    printf("Socket teardowns!\n");
    exit(EXIT_SUCCESS);
}

int main() {

    int clientfd, sockfd;
    char buf_input[MAXLINE] = {0};
    char buf_send[MAXLINE] = {0};
    char buf_recv[MAXLINE] = {0};

    size_t input_len = 0;
    size_t recv_len = 0;

    struct sockaddr_in client;

    printf("start to connect server <%s/%d> ...\n", SERVER_ADDR, SOCKET_PORT);

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


    while (true) {

        signal(SIGUSR1, quit);

        if (fgets(buf_input, MAXLINE, stdin) != NULL) {
            /* SEND DATA TO SERVER. */
            input_len = strlen(buf_input);
            strncat(buf_send, buf_input, input_len);
            send(clientfd, buf_send, input_len, 0);

            /* RECEIVE DATA FROM CLIENT. */
            recv_len = read(clientfd, buf_recv, MAXLINE);
            if (recv_len <= 0) {
                exit(EXIT_FAILURE);
            }
            printf("%s\n", buf_recv);

            bzero(buf_input, MAXLINE);
            bzero(buf_send, MAXLINE);
            bzero(buf_recv, MAXLINE);
        } else {
            break;
        }
    }

    close(clientfd);

    return 0;
}