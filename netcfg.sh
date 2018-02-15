#!/bin/bash

# run with sudo
IFACE=$1
echo "interface: $IFACE"
ifdown "$IFACE"
ifup "$IFACE"
ifconfig "$IFACE"
route add -net 10.0.0.0 netmask 255.255.255.0 gw 192.168.42.10 dev "$IFACE"
echo "$(date)" > /dev/kmsg
tcpdump -i "$IFACE" ip or ip6 or arp
