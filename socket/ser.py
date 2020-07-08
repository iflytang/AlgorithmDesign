
import socket
import time
# 建立一个服务端
server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server.bind(('192.168.109.221', 2020)) #绑定要监听的端口
server.listen(5) #开始监听 表示可以使用五个链接排队
cnt = 0
while True:# conn就是客户端链接过来而在服务端为期生成的一个链接实例
    conn,addr = server.accept() #等待链接,多个链接的时候就会出现问题,其实返回了两个值
    print(conn,addr)
    while True:
        msg = '1.345986'
        cnt = cnt + 1
        conn.send(msg.encode('utf-8'))
        print('server send: ', cnt)
        data = conn.recv(1024)
        if data:
            print('ser_recv: ', data.decode())
        time.sleep(1)
        

        # data = conn.recv(1024)  #接收数据
        # if not data:
        #     continue
        # print('recive:',data.decode()) #打印接收到的数据
        # conn.send(data.upper()) #然后再发送数据
    conn.close()