/**
 * @author tsf 
 * @date 19-3-25
 * @desc 
*/

#include <stdlib.h>
#include <stdio.h>
#include <zconf.h>


int main() {

    /* struct 和 class 在空的时候会自动加一个 char 或 int 变量进去.
     * 如果struct 或 class 为空,指向他们的指针将无法区分一个或多个同类的struct/class
     * 在实例化的时候会导致指针错乱
     * see https://bbs.csdn.net/topics/390214595
     */
    struct test_null {   // null struct

    };

    struct test_align {
        char a;
        int b;
        char c;
    };


    printf("struct size: %d\n", sizeof(struct test_null));    // sizeof = 1
    printf("struct size: %d\n", sizeof(struct test_align));   // sizeof = 12

    /* test_fork, if parent, ret is child pid;
     *            if child, ret is pid=0.
     **/
    int ret_pid = fork();
    printf("hello world, ret_pid:%d, pid:%d, ppid:%d, uid:%d \n", ret_pid, getpid(), getppid(), getuid());

    return 0;
}
