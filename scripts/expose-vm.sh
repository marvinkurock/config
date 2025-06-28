#! /bin/bash

cmd=$1

echo $cmd

if [[ $cmd == "up" ]]; then
  echo setting up firewall
  iptables -t nat -A PREROUTING -p tcp --dport 9001 -j DNAT --to 192.168.122.133:9001
  iptables -t nat -A POSTROUTING -s 192.168.122.0/24 -j MASQUERADE
  iptables -t nat -A OUTPUT -p tcp --dport 9001 -j DNAT --to-destination 192.168.122.133:9001
  nft insert rule ip libvirt_network guest_input oif virbr0 ip daddr 192.168.122.133 tcp dport 9001 accept
else 
  echo removing firewall rules
  iptables -t nat -D PREROUTING -p tcp --dport 9001 -j DNAT --to 192.168.122.133:9001
  iptables -t nat -D POSTROUTING -s 192.168.122.0/24 -j MASQUERADE
  iptables -t nat -D OUTPUT -p tcp --dport 9001 -j DNAT --to-destination 192.168.122.133:9001
fi
