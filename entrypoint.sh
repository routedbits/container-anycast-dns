#!/bin/bash

# Run CoreDNS
/usr/bin/coredns -conf /etc/coredns/Corefile &

# Run ExaBGP
/usr/bin/python3 /usr/sbin/exabgp /etc/exabgp/exabgp.conf &

wait -n

echo $?
