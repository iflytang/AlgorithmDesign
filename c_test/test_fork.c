/**
 * @author tsf 
 * @date 19-3-26
 * @desc 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <zconf.h>
#include <wait.h>

void sig_int(int signal) {
    printf("interrupt");
    exit(0);
}

int main() {

    char buf[512];
    pid_t pid;
    int status;

    printf("%% ");

    signal(SIGINT, sig_int);

    while (fgets(buf, 512, stdin) != NULL) {
        if (buf[strlen(buf)-1] == '\n') {
            buf[strlen(buf)-1] = 0;
        }

//        printf("1 pid:%d, ppid:%d, uid:%d \n", getpid(), getppid(), getuid());
        if ((pid = fork()) < 0) {
            perror("fork error.\n");
        } else if (pid == 0) { /* child */
//            printf("2 pid:%d, ppid:%d, uid:%d \n", getpid(), getppid(), getuid());
            if (execlp(buf, buf, NULL) < 0) { // must NULL end
                printf("execute failed: %s, cannot contain paras.\n", buf);
            }
            exit(127);
        }

//        printf("3 pid:%d, ppid:%d, uid:%d \n", getpid(), getppid(), getuid());

        if ((pid = waitpid(pid, &status, 0)) < 0) { /* wait until child ends. */
            perror("waitpid error.\n");
        }
//        printf("4 pid:%d, ppid:%d, uid:%d \n", getpid(), getppid(), getuid());
        printf("%% ");
    }

    return 0;
}

