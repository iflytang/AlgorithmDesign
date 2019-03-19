/**
* @author tsf
* @date 18-4-26
* @desc kinds of way to get time in c
*/

#include <iostream>
#include <sys/time.h>

#define TEST_CLOCK
#define TEST_TIME_T
#define TEST_TIMEVAL

using namespace std;
#define LOOP_NUM 1000000000

/* declaration */
void test_clock();
void test_time_t();
void test_timeval();

int main () {

#ifdef TEST_CLOCK
    cout << "======== test clock ==========" << endl;
    test_clock();
#endif

#ifdef TEST_TIME_T
    cout << "\n======== test time_t =========" << endl;
    test_time_t();
#endif

#ifdef TEST_TIMEVAL
    cout << "\n======== test timeval =========" << endl;
    test_timeval();
#endif

    return 0;
}

/* implementation */
void test_clock() {   // clock() return time in ms (clocks of CPU), pay attention to CLOCK_PER_SEC
    clock_t start, end;

    start = clock();
    cout << "start time at " << start << " ms." << endl;
    for(int i = 0; i < LOOP_NUM; i++);
    end = clock();
    cout << "end time at " << end << " ms." << endl;
    cout << "the function runs " << end - start << " clocks, " << 1000 * difftime(end, start)/CLOCKS_PER_SEC << " ms." << endl;
}

void test_time_t() {   // time() return time in s
    time_t start, end;
    struct tm *now;

    start = time(&start);      // parameter is `&start` or `NULL`
    now = localtime(&start);   // translate `time_t` to `localtime`, can also use `ctime()` directly
    cout << "start time at " << start << " s." << " or " << asctime(now);  // `astime()` convert `struct tm` to string
    cout << "start time at " << ctime(&start);   // convert to current time, timezone differs
    cout << "start time at GMT " << asctime(gmtime(&start));  // GMT time, timezone = 0
    for(long i = 0; i < LOOP_NUM; i++);
    end = time(&end);
    now = localtime(&end);
    cout << "end time at " << end << " s." << " or " << asctime(now);

    cout << "the function runs " << end - start << "," << difftime(end, start) << " s." << endl;
}

void test_timeval() {  // return value time in us
    timeval start, end;
    long dif_sec, dif_usec;

    gettimeofday(&start, NULL);  // get the current time of day and timezone information.
    for(int i = 0; i < LOOP_NUM; i++);
    gettimeofday(&end, NULL);

    dif_sec = end.tv_sec - start.tv_sec;
    dif_usec = end.tv_usec - start.tv_usec;
    if (dif_usec < 0) {
        dif_usec += 1000000;
        dif_sec--;
    }
    cout << "start time: " << start.tv_sec << "s (" << start.tv_usec << "us)" << endl;
    cout << "start time: " << end.tv_sec << "s (" << end.tv_usec << "us)" << endl;
    printf("the function runs %ld sec and %ld us\n", dif_sec, dif_usec);
}