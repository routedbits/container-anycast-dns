#!/bin/ash

# Run CoreDNS
if [ -f /etc/coredns/Corefile ]; then
    /usr/bin/coredns -conf /etc/coredns/Corefile &
fi

# Run ExaBGP
if [ -f /etc/exabgp/exabgp.conf ]; then
    # Create pipes
    if [ ! -p /run/exabgp.in ]; then mkfifo /run/exabgp.in; chmod 600 /run/exabgp.in; fi
    if [ ! -p /run/exabgp.out ]; then mkfifo /run/exabgp.out; chmod 600 /run/exabgp.out; fi

    # Configure ExaBGP through the environment rather than an env file. Any
    # setting can be given as exabgp_<section>_<key>, which avoids having to
    # locate the env file inside the virtualenv.
    #
    # Run as root, otherwise the healthcheck's ip commands fail and ExaBGP
    # cannot read the pipes created above.
    export exabgp_daemon_user='root'
    # Bind to all interfaces
    export exabgp_tcp_bind='0.0.0.0 ::'

    # run 
    /opt/venv/bin/exabgp /etc/exabgp/exabgp.conf &
fi

wait -n

echo $?
