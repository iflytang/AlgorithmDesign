/**
 * @author tsf 
 * @date 19-4-10
 * @desc 
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/ipc.h>
#include <errno.h>
#include <sys/shm.h>
#include <time.h>
#include <arpa/inet.h>
#include <stdbool.h>
#include <pthread.h>

#define SERVER_ADDR "192.168.109.211"
#define CLIENT_ADDR "192.168.109.214"
#define SOCKET_PORT 2019

#define MAXLINE 1024
#define PENDING_QUEUE 10

void accept_socket(int* sockfd);

int socket_num = 0;

int main() {

    printf("start\n");

    int sockfd, clientfd;

    struct sockaddr_in server, client;
    char buf_recv[MAXLINE] = {0};
    int recv_len = 0;

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        printf("create socket error.");
        exit(EXIT_FAILURE);
    }

    bzero(&server, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_port = htons(SOCKET_PORT);
    inet_pton(AF_INET, SERVER_ADDR, &server.sin_addr);

    if (bind(sockfd, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("bind socket error.");
        exit(EXIT_FAILURE);
    }

    if (listen(sockfd, PENDING_QUEUE) < 0) {
        printf("listen socket error.");
        exit(EXIT_FAILURE);
    }

    printf("listening port <%d>, waiting to be connected ...\n", SOCKET_PORT);

    pthread_t process_socket;
    pthread_create(&process_socket, NULL, (void *) &accept_socket, &sockfd);

    if (pthread_join(process_socket, NULL) == -1) {
        printf("socket_num: %d\n", socket_num);
        socket_num--;
    }

    close(sockfd);

    return 0;
}

void accept_socket(int* sockfd) {
    int clientfd;
    struct sockaddr_in client;
    char buf_recv[MAXLINE] = {0};
    printf("accept_socket start\n");

    socklen_t client_len = sizeof(struct sockaddr);
    if ((clientfd = accept(*sockfd, (struct sockaddr *) &client, &client_len)) > 0) {
        socket_num++;
        printf("socket_num: %d\n", socket_num);
    }

    printf("listening\n");
    while (true) {
        bzero(buf_recv, MAXLINE);
        if ((read(clientfd, buf_recv, MAXLINE)) <= 0) {
            break;
        }

        printf("server: %s\n", buf_recv);
    }

    printf("end\n");
    close(clientfd);
}

