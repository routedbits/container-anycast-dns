#!/bin/bash

# Run CoreDNS
/usr/bin/coredns -conf /etc/coredns/Corefile &

# Run ExaBGP
env exabgp.daemon.user=root /usr/sbin/exabgp /etc/exabgp/exabgp.conf &

wait -n

echo $?
