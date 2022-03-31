import socket
import threading
import time
import os

sending = False

def watch_cpu_and_send(sock, addr):
    global sending

    print("sending...")
    sock.send(b"Welcome!")

    sending = True
    counter = 0
    for _ in range(20):
        time.sleep(1)
        ss = os.popen(
            "nvidia-smi --query-gpu=memory.total,memory.used,utilization.memory,utilization.gpu --format=csv,noheader,nounits").read().strip().replace(',', '')
        sock.send(ss.encode('utf-8'))
        print("message sent...")
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


address = ('', 31500)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(address)
s.listen(5)

while True:
    sock, addr = s.accept()
    t0 = threading.Thread(target=watch_cpu_and_send, args=(sock, addr))
    t1 = threading.Thread(target=listen_and_exit, args=(sock, addr, t0))
    t0.start()
    t1.start()
