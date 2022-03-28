import socket
import threading
import time


sending = False

def watch_cpu_and_send(sock, addr):
    global sending

    print("sending...")
    sock.send(b"Welcome!")

    sending = True
    counter = 0
    while True:
        time.sleep(1)
        sock.send(('Hello, this is the %sth message!' % counter).encode('utf-8'))
        counter += 1


def listen_and_exit(sock, addr, sending_thread):
    global  sending

    while True:
        data = sock.recv(1024)
        if not data or data.decode('utf-8') == exit:
            sending = False
            sending_thread.join()
            break
        sock.send(('Hello, %s!' % data.decode('utf-8')).encode('utf-8'))

    sock.close()
    print("Connection from %s:%s closed." % addr)


address = ('127.0.0.1', 31500)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(address)
s.listen(5)

while True:
    sock, addr = s.accept()
    t0 = threading.Thread(target=watch_cpu_and_send, args=(sock, addr), daemon=True)
    t1 = threading.Thread(target=listen_and_exit, args=(sock, addr, t0), daemon=True)
    t0.start()
    t1.start()
