#!/bin/bash

# Run CoreDNS
if [ -f /etc/coredns/Corefile ]; then
    /usr/bin/coredns -conf /etc/coredns/Corefile &
fi

# Run ExaBGP
if [ -f /etc/exabgp/exabgp.conf ]; then
    env exabgp.daemon.user=root exabgp.tcp.bind=0.0.0.0 /usr/sbin/exabgp /etc/exabgp/exabgp.conf &
fi

wait -n

echo $?
