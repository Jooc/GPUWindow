sudo iptables -I INPUT -p tcp --dport 31500 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 31500 -j ACCEPT

sudo python server.py
