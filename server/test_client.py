import socket
import threading
import time

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 建立连接:
s.connect(('127.0.0.1', 31500))
# 接收欢迎消息:
print(s.recv(1024).decode('utf-8'))


def listen():
    for _ in range(10):
        print(s.recv(1024).decode('utf-8'))


def send(listen_thread):
    for data in [b'Michael', b'Tracy', b'Sarah']:
        s.send(data)
        print(s.recv(1024).decode('utf-8'))

    time.sleep(10)
    listen_thread.join()
    s.send(b'exit')
    s.close()


t_recv = threading.Thread(target=listen)
t_send = threading.Thread(target=send, args=(t_recv, ))

t_recv.start()
t_send.start()
