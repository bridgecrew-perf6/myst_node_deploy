#!/bin/bash
# The purpose of this is to block common attacks coming from the node
iptables -A OUTPUT -p tcp --src 10.182.0.1/24 --tcp-flags ALL ALL -j DROP
iptables -A OUTPUT -p tcp --src 10.182.0.1/24 --tcp-flags ALL NONE -j DROP
iptables -A OUTPUT -p icmp --src 10.182.0.1/24 -m limit --limit 6/second --limit-burst 6 -j ACCEPT
iptables -A OUTPUT -p tcp --src 10.182.0.1/24  -m state --state NEW -m limit --limit 6/second --limit-burst 6 -j ACCEPT

# If possible limit ALL outputs
# iptables -A OUTPUT -p tcp --tcp-flags ALL ALL -j DROP
# iptables -A OUTPUT -p tcp  --tcp-flags ALL NONE -j DROP
# iptables -A OUTPUT -p icmp -m limit --limit 6/second --limit-burst 6 -j ACCEPT
# iptables -A OUTPUT -p tcp -m state --state NEW -m limit --limit 6/second --limit-burst 6 -j ACCEPT