#! /bin/bash

# Regles Flush: buidar les regles actuals
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Establir la política per defecte ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# Permetre totes les pròpies connexions via localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Permetre tot el trafic de la pròpia adreça ip (192.168.1.34)
iptables -A INPUT  -s 192.168.2.58 -j ACCEPT
iptables -A OUTPUT -d 192.168.2.58 -j ACCEPT
# faltarien totes les altres ip!!!

# Regles de fer NAT
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 172.200.0.0/16 -o enp5s0 -j MASQUERADE











