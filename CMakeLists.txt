cmake_minimum_required(VERSION 3.7)
project(CLionProject)

set(CMAKE_CXX_STANDARD 11)

#set(SOURCE_FILES socket/c_tcp_cli_sock.c)
set(SOURCE_FILES socket/socket_server_thread.c)
#set(SOURCE_FILES c_test/test.c)

add_executable(CLionProject ${SOURCE_FILES})

## link pthread way1
#target_link_libraries(CLionProject pthread)

## link pthread way2
find_package(Threads)
target_link_libraries(CLionProject ${CMAKE_THREAD_LIBS_INIT})