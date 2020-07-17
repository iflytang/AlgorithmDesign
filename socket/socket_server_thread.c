//
// Created by tsf on 20-7-15.
//


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
#include <pthread.h>
#include <semaphore.h>

#define SERVER_ADDR "192.168.109.221"
#define SOCKET_PORT 2020

#define MAXLINE 1024
#define PENDING_QUEUE 10
#define SLEEP_SECONDS 1

int clientfd;
int send_flag;    // 1: send; 0: not send.
pthread_t tid_sock_recv_thread, tid_sock_send_thread;
sem_t sem;

/* tsf: tcp sock thread to wait connect <one client at the same time>. */
static int sock_recv_thread() {
    char buf_recv[MAXLINE] = {0};
    char buf_send[MAXLINE] = {0};

    int serverfd;
    if ((serverfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        printf("create socket error.\n");
        return -1;
    }

    struct sockaddr_in server;
    bzero(&server, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_port = htons(SOCKET_PORT);
    inet_pton(AF_INET, SERVER_ADDR, &server.sin_addr);

    if (bind(serverfd, (struct sockaddr *) &server, sizeof(server)) < 0) {
        printf("bind socket error.\n");
        return -1;
    }

    if (listen(serverfd, PENDING_QUEUE) < 0) {
        printf("listen socket error.\n");
        return -1;
    }

    struct sockaddr_in client;
    socklen_t client_len = sizeof(struct sockaddr);
    while (true) {
        printf("server <%s> port <%d>, waiting to be connected ...\n", SERVER_ADDR, SOCKET_PORT);

        clientfd = accept(serverfd, (struct sockaddr *) &client, &client_len);
        if (clientfd < 0) {
            printf("accept error.\n");
            return -1;
        }
        printf("accept client connection from %s\n", inet_ntoa(client.sin_addr));

        /*int recv_flag = 1;
        while (recv_flag) {
            int ret = recv(clientfd, buf_recv, MAXLINE, 0);
            printf("recv: %s\n", buf_recv);
            if (ret <= 0) {
                recv_flag = 0;
                send_flag = 0;
                break;
            }

            if (strlen(buf_recv) > 2) {
                send_flag = 1;
            } else {
                send_flag = 0;
            }
            bzero(buf_recv, MAXLINE);
            printf("send_flag: %d\n", send_flag);
        }*/


        char buf_send[MAXLINE] = {0};
        send_flag = 1;
        int send_times = 0;
        while (send_flag) {
            double ber = 7.754045171636897e-05;
            memcpy(buf_send, &ber, sizeof(ber));
            if ((send(clientfd, buf_send, sizeof(ber), 0)) < 0) {
                send_flag = 0;
            }
            send_times++;
            sleep(1);
            bzero(buf_send, MAXLINE);
            printf("server send:%d,  %.16g\n", send_times, ber);
        }


    }
}

static void sock_send_thread() {
    char buf_send[MAXLINE] = {0};

    while (send_flag) {
        double ber = 7.754045171636897e-05;
        memcpy(buf_send, &ber, sizeof(ber));
        if ((send(clientfd, buf_send, sizeof(ber), 0)) < 0) {
//            send_flag = 0;
        }
        sleep(1);
        bzero(buf_send, MAXLINE);
        printf("server send: %.16g\n", ber);
    }
}

#define SOCK_SHOULD_BE_RUN 1
int main() {
    if (SOCK_SHOULD_BE_RUN) {
        int i;
        printf("sock should be run. start init sock thread ...\n");

        pthread_create(&tid_sock_recv_thread, NULL, (void *) &sock_recv_thread, NULL);
//        pthread_create(&tid_sock_send_thread, NULL, (void *) &sock_send_thread, NULL);

        pthread_join(tid_sock_recv_thread, NULL);
//        pthread_join(tid_sock_send_thread, NULL);
    }
}